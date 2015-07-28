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
function hfssPolygon(fid, Name, Points, Units, varargin)
	% Create a closed polygon object in HFSS. This function also provides 
	% an option to punch a bunch of (circular) holes into the polygon object (so
	% as to make way for cables, wires, etc.,).
	%
	% Parameters:
	% fid:		file identifier of the HFSS script file.
	% Name:		Name Attribute for the PolyLine.
	% Points:	Points as 3-Tuples, ex: Points = [0, 0, 1; 0, 1, 0; 1, 0 1];
	%          Note: size(Points) must give [nPoints, 3]
	% Units:	can be either:
	%         'mm' - millimeter.
	%         'in' - inches.
	%         'mil' - mils.
	%         'meter' - meter (note: don't use 'm').
	%          or anything that Ansoft HFSS supports.
	% varargin: (optional) ([Circle], [Radius], [Axis]) Holes to be punched into the polyline. 
	%           Please specify as Center ([x, y, z]), Radius (scalar), Axis 
	%           ('X', 'Y' or 'Z') , ... etc., The script will create circles
	%           specified using the given parameters and subtract them from the 
	%           polyline object. 
	%
	% @note function hfssPolygon(fid, Name, Points, Units, [Circle], [Radius], [Axis], ...
	%
	% Example: sCube is a 1x3 vector, Radius, is a Scalar, cxCenter[A, B] is a 1x3 vector and hBalun is a scalar.
	% @code
	% hfssPolyline(fid, 'Short', sCube, 'in', ...
	%             [cxCenterA(1:2), -hBalun], Radius 'Z', ...
	%             [cxCenterB(1:2), -hBalun], Radius, 'Z');
	% @endcode

	nPoints = length(Points(:, 1));

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.CreatePolyline _\n');
	fprintf(fid, 'Array("NAME:PolylineParameters", ');
	fprintf(fid, '"IsPolylineCovered:=", true, ');
	fprintf(fid, '"IsPolylineClosed:=", true, _\n');

	% Enter the Points.
	fprintf(fid, 'Array("NAME:PolylinePoints", _\n');
	for iP = 1:nPoints-1,
		fprintf(fid, 'Array("NAME:PLPoint", ');
		fprintf(fid, '"X:=", "%.4f%s", ', Points(iP, 1), Units);
		fprintf(fid, '"Y:=", "%.4f%s", ', Points(iP, 2), Units);
		fprintf(fid, '"Z:=", "%.4f%s"), _\n', Points(iP, 3), Units);
	end
	fprintf(fid, 'Array("NAME:PLPoint", ');
	fprintf(fid, '"X:=", "%.4f%s", ', Points(nPoints, 1), Units);
	fprintf(fid, '"Y:=", "%.4f%s", ', Points(nPoints, 2), Units);
	fprintf(fid, '"Z:=", "%.4f%s")), _\n', Points(nPoints, 3), Units);

	% Create Segments.
	fprintf(fid, 'Array("NAME:PolylineSegments", _\n');
	for iP = 1:nPoints-2,
		fprintf(fid, 'Array("NAME:PLSegment", ');
		fprintf(fid, '"SegmentType:=", "Line", ');
		fprintf(fid, '"StartIndex:=", %d, ', iP-1);
		fprintf(fid, '"NoOfPoints:=", 2), _\n');
	end;
	fprintf(fid, 'Array("NAME:PLSegment", ');
	fprintf(fid, '"SegmentType:=", "Line", ');
	fprintf(fid, '"StartIndex:=", %d, ', (iP-1)+1);
	fprintf(fid, '"NoOfPoints:=", 2))), _\n');

	% Polyline Attributes.
	fprintf(fid, 'Array("NAME:Attributes", _\n');
	fprintf(fid, '"Name:=", "%s", _\n', Name);
	fprintf(fid, '"Flags:=", "", _\n');
	fprintf(fid, '"Color:=", "(132 132 193)", _\n');
	fprintf(fid, '"Transparency:=", 0.75, _\n');
	fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
	fprintf(fid, '"MaterialName:=", "vacuum", _\n');
	fprintf(fid, '"SolveInside:=", true)\n');

	% Put Holes in the required Spots.
	nHoles = length(varargin);
	if (mod(nHoles, 3) ~= 0)
		error('Error in # of arguments for specifying optional holes');
	end;
	nHoles = nHoles/3;

	% For each hole request, create a circle and subtract it from the 
	% original object.
	for iH = 1:nHoles,
		Center = varargin{3*(iH-1) + 1};
		Radius = varargin{3*(iH-1) + 2};
		hAxis  = varargin{3*(iH-1) + 3};
		
		hfssCircle(fid, strcat(Name, '_holesub', num2str(iH)), hAxis, ...
		             Center, Radius, Units);
		hfssSubtract(fid, Name, strcat(Name, '_holesub', num2str(iH)));
	end;
