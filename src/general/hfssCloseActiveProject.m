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
function hfssCloseActiveProject(fid)
	% Create the VB Script necessary to close the active project. The unsaved 
	% changes made so far will be IGNORED.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% 
	% @note To repeat, the unsaved changes will be ignored. Use hfssSaveProject() 
	% before this if you wish to retain all the changes that you did.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssCloseActiveProject(fid);
	% @endcode

	fprintf(fid, '\n');
	fprintf(fid, 'Set oProject = oDesktop.GetActiveProject()\n');
	fprintf(fid, 'oProject.Close\n');
