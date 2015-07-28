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
function hfssNewProject(fid)
	% This function creates the necessary VBScript to create a new HFSS project
	% file, set it as the active project.
	%
	% Parameters:
	% fid:		file identifier of the VBScript File.

	% Preamble.
	fprintf(fid, 'Dim oHfssApp\n');
	fprintf(fid, 'Dim oDesktop\n');
	fprintf(fid, 'Dim oProject\n');
	fprintf(fid, 'Dim oDesign\n');
	fprintf(fid, 'Dim oEditor\n');
	fprintf(fid, 'Dim oModule\n');
	fprintf(fid, '\n');

	% Create a New Project.
	fprintf(fid, 'Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")\n');
	fprintf(fid, 'Set oDesktop = oHfssApp.GetAppDesktop()\n');
	fprintf(fid, 'oDesktop.RestoreWindow\n');
	fprintf(fid, 'oDesktop.NewProject\n');

	% The new project created is the active project.
	fprintf(fid, 'Set oProject = oDesktop.GetActiveProject\n');
