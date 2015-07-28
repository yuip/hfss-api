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
function hfssAssignMaterial(fid, Name, Material)
	% Creates the VB Script necessary to assign a material selection to an 
	% existing HFSS object.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% Name:			name of the object to which the material is to assigned.
	% Material:		the material to be assigned to the Object. This is a string that should either be predefined in HFSS or defined using hfssAddMaterial(...)
	% 
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssAssignMaterial(fid, 'FR4Mount', 'FR4epoxy'); 
	% @endcode
	%
	% @note CHANGELOG
	% - ??-????-????: *Initial release.
	% - 22-Sept-2012: *Added warning and fix OR operator.
	% - 28-Nove-2014: *Fix uppercase bug with copper and pec.

	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.AssignMaterial _\n');
	fprintf(fid, '\tArray("NAME:Selections", _\n');
	fprintf(fid, '\t\t"Selections:=", "%s"), _\n', Name);  
	fprintf(fid, '\tArray("NAME:Attributes", _\n');
	fprintf(fid, '\t\t"MaterialName:=", "%s", _\n', Material);

	% if the material is copper, we should set solve inside to be false and for
	% other materials (in general) is should be true.
	if (strcmpi(Material, 'copper') || strcmpi(Material, 'pec'))
		fprintf(fid, '\t\t"SolveInside:=", false)\n');
	    msg = ['A warning might appear in HFSS due to material assignment ',...
	           'change for object ', Name];
	    warning('hfssAPI:hfssAssignMaterial', msg);
	    fprintf('\n');
	else
		fprintf(fid, '\t\t"SolveInside:=", true)\n');
	end