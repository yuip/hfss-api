% ----------------------------------------------------------------------------
% function hfssAssignMaterial(fid, Object, Material)
% 
% Description :
% -------------
% Creates the VB Script necessary to assign a material selection to an 
% existing HFSS object.
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% Object   - name of the object to which the material is to assigned.
% Material - the material to be assigned to the Object. This is a string that
%            should either be predefined in HFSS or defined using 
%            hfssAddMaterial(...)
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssAssignMaterial(fid, 'FR4Mount', 'FR4epoxy'); 
% ----------------------------------------------------------------------------

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

fprintf(fid, '\n');
fprintf(fid, 'oEditor.AssignMaterial _\n');
fprintf(fid, '\tArray("NAME:Selections", _\n');
fprintf(fid, '\t\t"Selections:=", "%s"), _\n', Name);  
fprintf(fid, '\tArray("NAME:Attributes", _\n');
fprintf(fid, '\t\t"MaterialName:=", "%s", _\n', Material);

% if the material is copper, we should set solve inside to be false and for
% other materials (in general) is should be true.
if (strcmp(Material, 'copper') | strcmp(Material, 'pec'))
	fprintf(fid, '\t\t"SolveInside:=", false)\n');
else	
	fprintf(fid, '\t\t"SolveInside:=", true)\n');
end;
