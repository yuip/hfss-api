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
function hfssCircle(fid, Name, Axis, Center, Radius, Units, coverLines)
	% Creates the VB Script necessary to create a circle in HFSS.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		name of the circle object (in HFSS).
	% Axis:		choose between 'X', 'Y', or 'Z' to represent the circle axis.
	% Center:	center of the circle (use the [x, y, z] format).
	% Radius:	radius of the circle.
	% Units:	units for all the above quantities (use either 'in', 'mm', 'meter' or anything else defined in HFSS).
	% coverLines: 
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssCircle(fid, 'C_Patch', 'Z', [10, 11, 12], 13, 'mm');
	% @endcode

	if (nargin < 7)
		coverLines = [];
	end;
	if isempty(coverLines)
		coverLines = true;
	end;

	% Preamble.
	fprintf(fid, 'oEditor.CreateCircle _\n');
	fprintf(fid, 'Array("NAME:CircleParameters", _\n');

	% Parameters.
	if (coverLines)
		fprintf(fid, '"IsCovered:=", true, _\n');
	else
		fprintf(fid, '"IsCovered:=", false, _\n');
	end;
	fprintf(fid, '"XCenter:=", "%f%s", _\n', Center(1), Units);
	fprintf(fid, '"YCenter:=", "%f%s", _\n', Center(2), Units);
	fprintf(fid, '"ZCenter:=", "%f%s", _\n', Center(3), Units);
	fprintf(fid, '"Radius:=", "%f%s", _\n', Radius, Units);
	fprintf(fid, '"WhichAxis:=", "%s"), _\n', upper(Axis));

	% Attributes.
	fprintf(fid, 'Array("NAME:Attributes", _\n');
	fprintf(fid, '"Name:=", "%s", _\n', Name);
	fprintf(fid, '"Flags:=", "", _\n');
	fprintf(fid, '"Color:=", "(132 132 193)", _\n');
	fprintf(fid, '"Transparency:=", 0, _\n');
	fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
	fprintf(fid, '"MaterialName:=", "vacuum", _\n');
	fprintf(fid, '"SolveInside:=", true)\n');
