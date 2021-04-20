% -------------------------------------------------------------------------- %
% function hfssPolyline(fid, Name, Points, Units, [Closed], [segmentType], ...
%                       [Color], [Transparency])
% Description:
% ------------
%
% Parameters:
% -----------
% Name   - Name Attribute for the PolyLine.
% Points - Points as 3-Tuples, ex: Points = [0, 0, 1; 0, 1, 0; 1, 0 1];
%          Note: size(Points) must give [nPoints, 3].
% Units  - units of the segments (specify using either 'in', 'mm', 'meter' 
%          or anything else defined in HFSS).
% Closed  - (Optional; bool) Closes the polyline to form a sheet. By
%           default is false.
% segmentType - (Optional) Defines the cross-section of the segment. Only
%               'Line' is supported. By default is 'Line'.
% Color       - (Optional) Defines the RGB color with a 3-tuple [R, G, B].
%               By default is set to [0, 0, 0] (black).
% Transparency - (Optional) Defines the transparency of the line. By
%                default is set to 0.8.
%
% Example:
% --------
% -------------------------------------------------------------------------- %

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

% ----------------------------------------------------------------------------
% CHANGELOG
%
% ??-???-????: *Initial release (VR).
% 07-Aug-2014: *Fix representation of polylines (DRP).
% 07-Aug-2014: *Added option for closed polyline (DRP).
% 01-Sep-2020: *Fixed closed polyline assignment (DRP).
% 20-Apr-2021: *Added missing documentation (DRP).
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Modified by Daniel Rodriguez Prado
% danysan@gmail.com
% 20 Apr 2021
% ----------------------------------------------------------------------------

function hfssPolyline(fid, Name, Points, Units, Closed, segmentType, ...
                      Color, Transparency)
if (nargin < 5)
    Closed = [];
	segmentType = [];
	Color = [];
	Transparency = [];
elseif (nargin < 6)
    segmentType = [];
	Color = [];
	Transparency = [];
elseif (nargin < 7)
    Color = [];
	Transparency = [];
elseif (nargin < 8)
    Transparency = [];
end

if isempty(Closed)
    Closed = 'false';
end
if isempty(segmentType)
	segmentType = 'Line';
end
if isempty(Color)
	Color = [0, 0, 0];
end
if isempty(Transparency)
	Transparency = 0.8;
end

nPoints = length(Points(:, 1));

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreatePolyline _\n');
fprintf(fid, '\tArray("NAME:PolylineParameters", ');
fprintf(fid, '"IsPolylineCovered:=", true, ');
if (Closed == true)
    fprintf(fid, '"IsPolylineClosed:=", true, _\n');
else
    fprintf(fid, '"IsPolylineClosed:=", false, _\n');
end

% Enter the Points.
fprintf(fid, '\t\tArray("NAME:PolylinePoints", _\n');
for iP = 1:nPoints-1
	fprintf(fid, '\t\t\tArray("NAME:PLPoint", ');
	fprintf(fid, '"X:=", "%.4f%s", ', Points(iP, 1), Units);
	fprintf(fid, '"Y:=", "%.4f%s", ', Points(iP, 2), Units);
	fprintf(fid, '"Z:=", "%.4f%s"), _\n', Points(iP, 3), Units);
end
fprintf(fid, '\t\t\tArray("NAME:PLPoint", ');
fprintf(fid, '"X:=", "%.4f%s",   ', Points(nPoints, 1), Units);
fprintf(fid, '"Y:=", "%.4f%s",   ', Points(nPoints, 2), Units);
fprintf(fid, '"Z:=", "%.4f%s")_\n', Points(nPoints, 3), Units);
fprintf(fid, '\t\t\t), _ \n');

% Create Segments.
fprintf(fid, '\t\tArray("NAME:PolylineSegments", _\n');
for iP = 1:nPoints-2
    fprintf(fid, '\t\t\tArray("NAME:PLSegment", ');
    fprintf(fid, '"SegmentType:=",  "%s", ', segmentType);
    fprintf(fid, '"StartIndex:=", %d, ', iP-1);
    fprintf(fid, '"NoOfPoints:=", 2), _\n');
end
fprintf(fid, '\t\t\tArray("NAME:PLSegment", ');
fprintf(fid, '"SegmentType:=",  "%s", ', segmentType);
fprintf(fid, '"StartIndex:=", %d, ', iP);
fprintf(fid, '"NoOfPoints:=", 2) _\n');
fprintf(fid, '\t\t\t) _\n');
fprintf(fid, '\t\t), _\n');

% Polyline Attributes.
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(%d %d %d)", _\n', Color(1), Color(2), Color(3));
fprintf(fid, '"Transparency:=", %f, _\n', Transparency);
fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
fprintf(fid, '"MaterialName:=", "vacuum", _\n');
fprintf(fid, '"SolveInside:=", true)\n');