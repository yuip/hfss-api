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
function hfssOpenProject(fid, hfssProjectFile)
	% This function creates the VB Script necessary to open a specified HFSS 
	% project file in HFSS. The FULL PATH of the HFSS project file must be 
	% provided for HFSS to properly open the file (and ofcourse, the file must 
	% already exist !)
	% 
	% Parameters :
	% fid:		file identifier for the VBScript file.
	% hfssProjectFile:	the (existing) HFSS project file to be opened. The file 
	%            specification must include the FULL FILE PATH and the file 
	%            extension.
	%
	% @note Use this function if you wish to open an already existing HFSS design and 
	% add some MATLAB-generated VB script components into it.
	%

	if verLessThan('matlab', '7.12')
	% Code for earlier versions of Matlab than Matlab 11a
	[Path, projectName, Ext, Ver] = fileparts(hfssProjectFile);
	else
	% Code for later versions of Matlab than Matlab 11a
	[Path, projectName, Ext] = fileparts(hfssProjectFile);
	end


	% Check extension.
	if (~strcmp(Ext, '.hfss'))
		warning('File Extension is not .hfss !');
	end;

	% Preamble.
	fprintf(fid, 'Dim oHfssApp\n');
	fprintf(fid, 'Dim oDesktop\n');
	fprintf(fid, 'Dim oProject\n');
	fprintf(fid, 'Dim oDesign\n');
	fprintf(fid, 'Dim oEditor\n');
	fprintf(fid, 'Dim oModule\n');
	fprintf(fid, '\n');
	fprintf(fid, 'Set oHfssApp  = CreateObject("AnsoftHfss.HfssScriptInterface")\n');
	fprintf(fid, 'Set oDesktop = oHfssApp.GetAppDesktop()\n');
	fprintf(fid, 'oDesktop.RestoreWindow\n');
	fprintf(fid, 'oDesktop.OpenProject "%s"\n', hfssProjectFile);
	fprintf(fid, 'Set oProject = oDesktop.SetActiveProject("%s")\n', projectName);