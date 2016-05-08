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
function hfssDuplicateAlongLine(fid, ObjectList, dVector, nClones, Units, AttachToOriginalObject, dupBoundaries)
	% Creates the VB Script necessary to clone (duplicate) a list of objects 
	% along a line.
	%
	% Parameters :
	% fid:                      file identifier of the HFSS script file.
	% ObjectList:               a cell-array of strings that represent the objects to be cloned.
	% dVector:                  (vector) the translation vector for the duplication process (specified as [dx, dy, dz]).
	% nClones:                  Number of clones to be created.
	% Units:                    specified as either 'mm', 'meter', 'in' or anything else defined in HFSS.
    % AttachToOriginalObject:   (optional, boolean, default=false) To attach the duplicated objects with the original object.
	% dupBoundaries:            (optional, boolean, default=true) set to false if you wish NOT to duplicate boundaries along with the geometry.
	% 
	% @note If you have used this 3D modeler feature before, then you will probably
	% realize that if the original object (to be cloned) has the name 'Name',
	% then the cloned objects will have names 'Name1', 'Name2', ... This applies
	% to the cloned boundaries and excitations also.
	%
	% Example: Duplicate object name "polarization_grid" 322 times (including original) along x vector with distance 12 units apart
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssDuplicateAlongLine(fid,{'polarization_grid'},[12 0 0],322,units);
	% @endcode

	% arguments processor.
	if (nargin < 5)
		error('Insufficient number of arguments !');
	elseif (nargin < 6)
		AttachToOriginalObject = false;
        dupBoundaries = [];
    elseif (nargin < 7)
		dupBoundaries = [];
	end;

	% default arguments.
	if isempty(dupBoundaries)
		dupBoundaries = true;
	end;
	
    % String Variable for AttachToOriginalObject
   	CreateNewObjects = 'true';
	    
    if ~iscell(dVector)
         dVector=num2cell(dVector);
    end
    
    % AttachToOriginalObject & Number of clones(nclones)
    % If nclones is variable name(or string), then AttachToOriginalObject
    % should be true. Therefore, there should be a check for this
    % condition.
    if ~isnumeric(nClones) && ~AttachToOriginalObject
       error('Variable ''AttachToOriginalObject'' must be true, if number of clones are variable.');
    end
    
    % Change CreateNewObjects as per AttachToOriginalObject
    if AttachToOriginalObject
        CreateNewObjects='false';
    else
        CreateNewObjects='true';
    end
    
	nObjects = length(ObjectList);

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.DuplicateAlongLine _\n');
	fprintf(fid, 'Array("NAME:Selections", _\n');

	% Object Selections.
	fprintf(fid, '"Selections:=", "');
	for iObj = 1:nObjects,
		fprintf(fid, '%s', ObjectList{iObj});
		if (iObj ~= nObjects)
			fprintf(fid, ',');
		end;
	end;
	fprintf(fid, '"), _\n');

	% Duplication Vectors.
	fprintf(fid, 'Array("NAME:DuplicateToAlongLineParameters", _\n');
    fprintf(fid, '"CreateNewObjects:=", %s, _\n', CreateNewObjects);
	hfssFprintf(fid, '"XComponent:=", "%m", _\n', dVector{1}, Units);
	hfssFprintf(fid, '"YComponent:=", "%m", _\n', dVector{2}, Units);
	hfssFprintf(fid, '"ZComponent:=", "%m", _\n', dVector{3}, Units);
	hfssFprintf(fid, '"NumClones:=", "%m"), _\n', nClones);

	% Duplicate Boundaries with Geometry or not.
	fprintf(fid, 'Array("NAME:Options", _\n');
	if (dupBoundaries)
		fprintf(fid, '"DuplicateBoundaries:=", true)\n');
	else
		fprintf(fid, '"DuplicateBoundaries:=", false)\n');
	end;
