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
function hfssInsertDesign(fid, designName, designType)
	% Create the necessary VB Script to insert an HFSS Design into the Project 
	% and set it as the active design.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% designName:	name of the new design to be inserted.
	% designType:	(Optional String) choose from the following:
	%              1. 'driven modal' (default)
	%			   2. 'driven terminal'
	%			   3. 'eigenmode'
	% 
	% @note This function is usually called after a call to either hfssNewProject()
	% or hfssOpenProject(), but this is not necessary.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ...
	% hfssInsertDesign(fid, 'Dipole_SingleElement');
	% @endcode

	% arguments processor.
	if (nargin < 2)
		error('Insufficient number of arguments !');
	elseif (nargin < 3)
		designType = [];
	end;

	% default arguments.
	if isempty(designType)
		designType = 'driven modal';
	end;

	% create the necessary script.
	fprintf(fid, '\n');
	fprintf(fid, 'oProject.InsertDesign "HFSS", ');
	fprintf(fid, '"%s", ', designName);
	switch (lower(designType))
		case 'driven terminal', 
			fprintf(fid, '"DrivenTerminal", ""\n');
		case 'driven modal'
			fprintf(fid, '"DrivenModal", ""\n');
		case 'eigenmode'
			fprintf(fid, '"Eigenmode", ""\n');
	end;
	fprintf(fid, 'Set oDesign = oProject.SetActiveDesign("%s")\n', designName);
	fprintf(fid, 'Set oEditor = oDesign.SetActiveEditor("3D Modeler")\n');
