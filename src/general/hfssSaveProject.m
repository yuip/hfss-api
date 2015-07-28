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
function hfssSaveProject(fid, projectFile, Overwrite)
	% This function creates the necessary VB script to save the active HFSS 
	% project onto a disk file. 
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% projectFile:	full file name of the project file into which the active HFSS
	%               project will be saved.
	% Overwrite:	(boolean, optional) if set to true will overwrite any existing file with
	%               the same name as that specified by projectFile. Default is false.
	% 
	% 
	% @note The active HFSS project MUST be saved prior to solving it. This is slightly
	% disadvantageous because we cannot create and solve projects "on-the-fly" -
	% i.e., in memory without creating a project file on the disk. One workaround
	% is to write the project to a temporary file and then delete the temporary
	% file after the required solution is obtained.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssSaveProject(fid, tmpPrjFile)
	% @endcode
	% ----------------------------------------------------------------------------

	% arguments processor.
	if (nargin < 2)
		error('Insufficient # of arguments !');
	elseif (nargin < 3)
		Overwrite = [];
	end;

	% default arguments.
	if isempty(Overwrite)
		Overwrite = false;
	end;

	% create the script.
	fprintf(fid, '\n');
	fprintf(fid, 'oProject.SaveAs _\n');
	fprintf(fid, '    "%s", _\n', projectFile);
	if (Overwrite)
	    fprintf(fid, '    true\n');
	else
	    fprintf(fid, '    false\n');
	end;