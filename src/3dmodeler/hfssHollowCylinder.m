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
function hfssHollowCylinder(fid, Name, Axis, Center, inRadius, outRadius, ...
			    Height, Units)
	% Creates VB Script necessary to generate a hollow cylinder in HFSS.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% Name:			name of the hollow cylinder (in HFSS).
	% Axis:			choose between 'X', 'Y' or 'Z' for the cylinder axis.
	% Center:		center of the cylinder (express as [x, y, z]).
	% inRadius:		inner radius of the cylinder.
	% outRadius:	outer radius of the cylinder.
	% Height:		cylinder height.
	% Units:		units for all the quantities (use either 'in', 'mm', 'meter' or anything else that is defined in HFSS).
	% 
	% @note This function creates an extra object that is a contatenation of the Name
	% with '_sub' that gets subtracted from the outer cylinder to get the hollow
	% structure.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssHollowCylinder(fid, 'Dipole', 'X', [-G/2, 0, 0], 0.95*R, R, L, 'in');
	% @endcode

	hfssCylinder(fid, Name, Axis, Center, outRadius, Height, Units)
	hfssCylinder(fid, strcat(Name, '_sub'), Axis, Center, inRadius, Height, ...
	             Units);
	hfssSubtract(fid, Name, strcat(Name, '_sub'));
