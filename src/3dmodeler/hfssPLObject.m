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
function hfssPLObject(fid, Name, Points, startP, endP, Axis, Units, varargin)
	% Creates the VB Script necessary to construct a 3D object based on a Polygon
	% in two dimensions. 

	% As an example, consider that we have a polygon defined in 
	% the X-Y plane (with z = z1). We can create a 3D object out of this polygon by 
	% creating an exact same polygon at a different height (say, z = z2) and 
	% connect these two polygons to-gether to create a 3D object that exists 
	% between z = z1 and z = z2 and is described in the X-Y plane by the polygon.
	%
	% This function also provides for (optional) cylindrical holes along the 
	% Z-axis on the object. This feature is extremely useful for modelling 
	% FR4 boards with vias, and microstrip traces that require pre-defined holes
	% to allow cables to reach the top microstrip trace from the bottom of the
	% board (as required in modelling Patch Antennas, Monopoles etc.,)
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		name of the PL object (in HFSS).
	% Points:	points that describe in the polygon in the plane perpendicular 
	%            to the polygon axis described using the Axis parameter. They are 
	%            specified as a M x 3 matrix where M is the # of points in the 
	%            polygon and 3 represents the [x, y, z] axes. Only the values in 
	%            two axes will be used and the values in the axis that corresponds 
	%            to the polygon Axis will be ignored.
	% startP:
	% endP:		these numbers describe the polygon in ITS axis (for example, 
	%            if Points represented the polygon in the X-Y plane then startP 
	%            and endP represent z = z1 and z = z2 respectively), i.e., the 
	%            height of the polygon object. 
	% Axis:		Axis of the polygon (the Points represent the polygon in a plane
	%            that is perpendicular to this Axis) - use either 'X','Y' or 'Z'
	% Units:	use either 'in', 'm', 'meter' or anything else defined in HFSS.
	% hCenter:	(Optional Point) represents a hole that needs to be punched into
	%            the polygon ALONG its axis (specify using [cx, cy, cz]).
	% hRadius:	(Optional Value) represents the radius of that hole.
	% 
	% @note If you specify a hole Center, then you MUST also provide its radius.
	% 
	% @note function hfssPLObject(fid, Name, Points, startP, endP, Axis, Units, ...
	%                       [hCenter1], [hRadius1], [hCenter2], [hRadius2], ....)
	% Example : In the below code, pA is a M x 3 matrix that represents the polygon in the
	% X-Y Plane and pltWidth is the polygon height (in the Z axis). cxCenterA is 
	% the center of a hole location and Radius is the radius of the hole.
	% 
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssPLObject(fid, 'BalunPlate1', pA, pltWidth/2, -pltWidth/2, 'Z', 'in', ...
	%             cxCenterA, Radius);
	% @endcode

	Axis = upper(Axis);

	switch(Axis)
		
		case 'X',
			Points(:, 1) = startP;
			hfssPolyline(fid, Name, Points, Units);
			Points(:, 1) = endP;
			hfssPolyline(fid, strcat(Name, '_end'), Points, Units);
			hfssConnect(fid, Name, strcat(Name, '_end'));
		
		case 'Y',
			Points(:, 2) = startP;
			hfssPolyline(fid, Name, Points, Units);
			Points(:, 2) = endP;
			hfssPolyline(fid, strcat(Name, '_end'), Points, Units);
			hfssConnect(fid, Name, strcat(Name, '_end'));
		
		case 'Z',
			Points(:, 3) = startP;
			hfssPolyline(fid, Name, Points, Units);
			Points(:, 3) = endP;
			hfssPolyline(fid, strcat(Name, '_end'), Points, Units);
			hfssConnect(fid, Name, strcat(Name, '_end'));
	end;

	% Put Holes in the required Spots.
	nHoles = length(varargin)/2;

	% For each hole request, create a cylinder and subtract it from the 
	% original object.
	for iH = 1:nHoles,
		Center = varargin{2*(iH-1) + 1};
		Radius = varargin{2*iH};
		switch(Axis)
			case 'X', Center(1) = startP;
			case 'Y', Center(2) = startP;
			case 'Z', Center(3) = startP;
		end;
		Height = endP - startP;
		hfssCylinder(fid, strcat(Name, '_holesub', num2str(iH)), Axis, ...
		             Center, Radius, Height, Units);
		hfssSubtract(fid, Name, strcat(Name, '_holesub', num2str(iH)));
	end;
