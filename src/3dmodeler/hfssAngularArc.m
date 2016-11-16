% ----------------------------------------------------------------------------
% This file is part of HFSS-MATLAB-API.
%
% HFSS-MATLAB-API is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the Free 
% Software Foundation; either version 2 of the License, or (at your option) 
% any later version.
%
% HFSS-MATLAB-API is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
% or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
% for more details.
%
% You should have received a copy of the GNU General Public License along with
% Foobar; if not, write to the Free Software Foundation, Inc., 59 Temple 
% Place, Suite 330, Boston, MA  02111-1307  USA
%
% Copyright 2004, Vijay Ramasami (rvc@ku.edu)
% ----------------------------------------------------------------------------
function hfssAngularArc(fid, Name, CenterPoint, StartPoint, Angle, ArcPlane, Units, Closed,...
                     Color, Transparency)
	% Creates VBscript for generating a Angular Arc in HFSS.
	%
	% Parameters:
	% fid: 		file identifier of the HFSS script file.
	% Name:		Name of the Angular Arc.
	% CenterPoint:	Provide the center point to the Arc. Point should be a
    %               3-Tuple like [0, 0, 1]; or a cell of strings which are already
    %               defined as variables in HFSS.
    % StartPoint:	Provide the start point of the Arc. This point must be on arc. 
    %               Point should be a 3-Tuple like [0, 0, 1];or a cell of strings which are already
    %               defined as variables in HFSS.
	% Angle:        Provide the Arc Angle in degrees. Angle can be a positive or negative number, or a cell of string 
    %               which are already defined as variables in HFSS.
	% ArcPlane:     Plane in which Arc is defined. This variable is string.
	%               It can be 'XY', 'YZ' or 'XZ'.
	% Units:	can be either:
	%         'mm' - millimeter.
	%         'in' - inches.
	%         'mil' - mils.
	%         'meter' - meter (note: don't use 'm').
	%          or anything that ANSYS HFSS supports.
	% Closed: If the polyline is closed curve, then 'true' else 'false'.
	% 
	% Color:
	% Transparency:

	if (nargin < 8)
        Closed = [];
		Color = [];
		Transparency = [];
	elseif (nargin < 9)
		Color = [];
		Transparency = [];
	elseif (nargin < 10)
		Transparency = [];
    end

	if isempty(Closed)
	    Closed = 'false';
	end
	if isempty(Color)
		Color = [0, 0, 0];
	end
	if isempty(Transparency)
		Transparency = 0.8;
    end
    
    if ~iscell(CenterPoint)
        CenterPoint=num2cell(CenterPoint);
    end
    
    if ~iscell(StartPoint)
    StartPoint=num2cell(StartPoint);
    end

    if ~iscell(Angle)
        Angle=num2cell(Angle);
    end
        
	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.CreatePolyline _\n');
	fprintf(fid, 'Array("NAME:PolylineParameters", ');
	fprintf(fid, '"IsPolylineCovered:=", true, ');
	fprintf(fid, '"IsPolylineClosed:=", %s, _\n', Closed);

	% Enter the Points.
	fprintf(fid, 'Array("NAME:PolylinePoints", _\n');
	fprintf(fid, 'Array("NAME:PLPoint", ');
	hfssFprintf(fid, '"X:=", "%m", _\n', StartPoint{1}, Units);
	hfssFprintf(fid, '"Y:=", "%m", _\n', StartPoint{2}, Units);
	hfssFprintf(fid, '"Z:=", "%m")), _\n', StartPoint{3}, Units);

    
	% Create Segments.
	fprintf(fid, 'Array("NAME:PolylineSegments", _\n');
	fprintf(fid, 'Array("NAME:PLSegment", ');
	fprintf(fid, '"SegmentType:=",  "AngularArc", _\n');
	fprintf(fid, '"StartIndex:=", 0, ');
	fprintf(fid, '"NoOfPoints:=", 1, ');
	fprintf(fid, '"NoOfSegments:=", "0", _\n');
    hfssFprintf(fid, '"ArcAngle:=", "%m", _\n', Angle{1}, 'deg');
    hfssFprintf(fid, '"ArcCenterX:=", "%m", _\n', CenterPoint{1}, Units);
    hfssFprintf(fid, '"ArcCenterY:=", "%m", _\n', CenterPoint{2}, Units);
    hfssFprintf(fid, '"ArcCenterZ:=", "%m", _\n', CenterPoint{3}, Units);
    fprintf(fid, '"ArcPlane:=", "%s"))), _\n', ArcPlane);
    
	% Polyline Attributes.
	fprintf(fid, 'Array("NAME:Attributes", _\n');
	fprintf(fid, '"Name:=", "%s", _\n', Name);
	fprintf(fid, '"Flags:=", "", _\n');
	fprintf(fid, '"Color:=", "(%d %d %d)", _\n', Color(1), Color(2), Color(3));
	fprintf(fid, '"Transparency:=", %f, _\n', Transparency);
	fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
	fprintf(fid, '"MaterialName:=", "vacuum", _\n');
	fprintf(fid, '"SolveInside:=", true)\n');
