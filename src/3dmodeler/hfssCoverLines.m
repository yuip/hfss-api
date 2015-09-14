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
% Copyright 2015, Rounak Singh Narde (rounaksingh17@gmail.com)
% ----------------------------------------------------------------------------
function hfssCoverLines(fid, ObjectList)
	% Covers the 1D lines, which are forming closed loop, into 2D sheet in HFSS
	%
	% Creates the VB Script necessary to create a closed line loop into 2D
	% sheet. In other words, the function covers a closed loop into a
	% surface.
    %
	% Parameters:
	% fid:			file identifier of the HFSS script file.
	% ObjectList: 	a cell array of string object names that need to be
	%               covered into 2D face or sheet.
    % 
	% Example:
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
    % hfssCoverLines(fid, {'outline'});
    % @endcode
	
	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.CoverLines _\n');

  	fprintf(fid, 'Array("NAME:Selections", _\n');
    
	% Object Selections.
	fprintf(fid, '"Selections:=", "');
	nObjects = length(ObjectList);
    for iObj = 1:nObjects,
		fprintf(fid, '%s', ObjectList{iObj});
		if (iObj ~= nObjects)
			fprintf(fid, ',');
		end;
	end;
    
	fprintf(fid, '", _\n');
    fprintf(fid, '"NewPartsModelFlag:=", _\n');
	fprintf(fid, '"Model")');
    fprintf(fid, '\n');