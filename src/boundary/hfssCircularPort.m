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
function hfssCircularPort(fid, Name, ObjectName, Axis, Center, Radius, Units)
	% Creates the VB Script necessary to create a circular wave port. This 
	% function generates BOTH the circle object AND the wave port. This function
	% is useful to add ports at the end of co-axial cables.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% Name:			name of the wave port.
	% ObjectName:	name of the circle to which the wave port is assigned.
	% Axis:			axis of the circle. Specify as 'X', 'Y' or 'Z'.
	% Center:		the center of the circle.
	% Radius:		raduis of the circle.
	% Units:		specify as either 'mm', 'meter', 'in', ... or anything else
	%              defined in HFSS.
	% 
	% @note No integration lines are added and a single-mode solution is assumed.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssCircularPort(fid, 'Port1', 'CoaxSource', 'Z', [10, 0, 0], 0.1, 'in');
	% @endcode


	hfssCircle(fid, ObjectName, Axis, Center, Radius, Units);
	hfssAssignWavePort(fid, Name, ObjectName, 1, false, [0,0,0], ...
	                   [0,0,0], Units);
