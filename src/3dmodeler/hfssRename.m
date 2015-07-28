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
function hfssRename(fid, oldName, newName)
	% Creates the VB Script necessary to rename a HFSS Object.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% oldName:	the object's previous name.
	% newName:	the object's new name.
	% 
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssRename(fid, 'dipole1', 'dipole_one');
	% @endcode

	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:Geometry3DAttributeTab", _\n'); 
	fprintf(fid, 'Array("NAME:PropServers", "%s"), _\n', oldName);
	fprintf(fid, 'Array("NAME:ChangedProps", _\n');
	fprintf(fid, 'Array("NAME:Name", _\n');
	fprintf(fid, '"Value:=", "%s"))))\n', newName);