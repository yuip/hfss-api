% ----------------------------------------------------------------------------
% function hfssAssignPE(fid, Name, ObjectList, [infGND = false])
% 
% Description :
% -------------
% This function creates the VB Script necessary to assign a PEC boundary to 
% the given object(s).
%
% Parameters :
% ------------
% fid     - file identifier of the HFSS script file.
% Name    - name of the PEC boundary. This will appear under "Boundaries" 
%           in HFSS
% ObjList - a cell array of objects to which the PEC boundary condition will
%           be applied.
% infGND  - (boolean) specify as true to make the PEC represent an infinite
%           ground plane (default is false).
% 
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssAssignPE(fid, 'GNDplane', {'AntennaGND'}, true);
%
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

function hfssAssignPE(fid, Name, ObjectList, infGND)

% arguments processor.
if (nargin < 3)
	error('Insufficient # of arguments !');
elseif (nargin < 4)
	infGND = [];
end;

% default arguments.
if isempty(infGND)
	infGND = false;
end;

% # of objects.
nObjects = length(ObjectList);

% create the necessary script.
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');
fprintf(fid, 'oModule.AssignPerfectE _\n');
fprintf(fid, 'Array("NAME:%s", _\n', Name);

% is infinite GND ?
if (infGND)
	fprintf(fid, '"InfGroundPlane:=", true, _\n');
else
	fprintf(fid, '"InfGroundPlane:=", false, _\n');
end;

fprintf(fid, '"Objects:=", _\n'); 
fprintf(fid, 'Array(');
for iObj = 1:nObjects,
	fprintf(fid, '"%s"', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '))\n');
