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
function hfssCoaxialCable(fid, Names, Axis, Center, Radii, Height, Units)
	% Creates a Coaxial Cable.
	%
	% This function creates the VBScript necessary to draw a Coaxial Cable in 
	% HFSS. The "Coaxial Cable" can have as many cylinders as you specify. This
	% function only creates the geometric structure and does not set any material
	% properties.
	%
	% Parameters :
	% fid:		file identifier of the HFSS VBScript File.
	% Names:		a cell of strings that contains the names of each cylinder that is a part of the co-axial cable (see example).
	% Axis:		axis of the Coaxial Cable (choose between 'X', 'Y' or 'Z').
	% Center:	Coordinates of the Center of the Coaxial Cable ([x, y, z]).
	% Radii:	an array of Radii of the Cylinders present in the Coaxial cable. Each radius corresponds to the respective name specfied in the 'Name' parameter.
	% Height:	length of the coaxial cable.
	% Units:	can be either 'in' or 'mm' or 'meter' or anything defined in HFSS.
	%
	% Example:
	% @code
	% ...
	% hfssCoaxialCable(fid, {'Cyl1_In', 'Cyl1_Er', 'Cyl1_Out'}, 'Z', [0, 0, 0], 
	%                  0.02, 0.03, 0.04], 10, 'in')
	% @endcode

	% Sort the Radii first in Ascending order.
	[Radii, iR] = sort(Radii);
	Names = cellstr(char(Names{iR}));

	% Get the # of Cylinders.
	nCylinders = length(Radii);

	% First create the N-1 hollow cylinders.
	for iR = nCylinders:-1:2,
		hfssHollowCylinder(fid, Names{iR}, Axis, Center, Radii(iR-1), ...
		                   Radii(iR), Height, Units);
	end;

	% Finally create the inner cylinder.
	hfssCylinder(fid, Names{1}, Axis, Center, Radii(1), Height, Units);