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
function hfssRectangle(fid, Name, Axis, Start, Width, Height, Units)
	% Create the VB Script necessary to construct a rectangle using the HFSS
	% 3D Modeler.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		name of the rectangle object (appears in the HFSS objects tree).
	% Axis:		axis that is normal to the rectangle object.
	% Start:	starting location of the rectangle (one of its corners). Specify
	%           as [sx, sy, sz].
	% Width:	(scalar) the width of the rectangle. If the axis is 'X' then this 
	%           represents the Y-axis size of the rectangle, and so on.
	% Height:	(scalar) the height of the rectangle. If the axis is 'X', then 
	%           this represents the Z-axis size of the rectangle, and so on. 
	% Units:	specify as 'in', 'meter', 'mm', ... or anything else defined in 
	%           HFSS.
	%
	% @todo a feature to add automatic holes in the rectangle object.
	%
	% Example : in this example, Y-axis size is 10in and Z-axis size is 20in.
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssRectangle(fid, 'Rect1', 'X', [0,0,0], 10, 20, 'in');
	% @endcode
	%
	% @note Width and Height follow the right-hand rule. If the Axis is Z, then Width
	% represents X-direction size and Height represents the Y-direction size 
	% and so on ...
	
    if ~iscell(Start)
        Start=num2cell(Start);
    end
    
	Transparency = 0.75;

	% Preamble.
	hfssFprintf(fid, '\n');
	hfssFprintf(fid, 'oEditor.CreateRectangle _\n');

	% Rectangle Parameters.
	hfssFprintf(fid, 'Array("NAME:RectangleParameters", _\n');
	hfssFprintf(fid, '"IsCovered:=", true, _\n');
	hfssFprintf(fid, '"XStart:=", "%m", _\n', Start{1}, Units);
	hfssFprintf(fid, '"YStart:=", "%m", _\n', Start{2}, Units);
	hfssFprintf(fid, '"ZStart:=", "%m", _\n', Start{3}, Units);

	hfssFprintf(fid, '"Width:=", "%m", _\n', Width, Units);
	hfssFprintf(fid, '"Height:=", "%m", _\n', Height, Units);

	hfssFprintf(fid, '"WhichAxis:=", "%m"), _\n', upper(Axis));

	% Rectangle Attributes.
	hfssFprintf(fid, 'Array("NAME:Attributes", _\n');
	hfssFprintf(fid, '"Name:=", "%s", _\n', Name);
	hfssFprintf(fid, '"Flags:=", "", _\n');
	hfssFprintf(fid, '"Color:=", "(132 132 193)", _\n');
	hfssFprintf(fid, '"Transparency:=", %d, _\n', Transparency);
	hfssFprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
	hfssFprintf(fid, '"MaterialName:=", "vacuum", _\n');
	hfssFprintf(fid, '"SolveInside:=", true)\n');
