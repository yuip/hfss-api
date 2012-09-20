% ----------------------------------------------------------------------------
% hfssSubtract(fid, blankParts, toolParts)
%
% Description:
% ------------
% Creates the necessary VB script to subtract a set of tool parts from a set 
% of blank parts, a.k.a., will produce blank parts - tool parts.
%
% Parameters :
% ------------
% fid        - file identifier of the HFSS script file.
% blankParts - a cell array of strings that contain the blank parts.
% toolParts  - a cell array of strings that contain the tool parts.
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssSubtract(fid, {'BigPlate'}, {'SmallPlate'});
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
% Will result in blankParts - toolParts.
function hfssSubtract(fid, blankParts, toolParts)

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.Subtract _\n');
fprintf(fid, 'Array("NAME:Selections", _\n');

% Add the Blank Parts.
fprintf(fid, '"Blank Parts:=", _\n');
if (iscell(blankParts))
	nBlank = length(blankParts);
	fprintf(fid, '"');
	for iB = 1:nBlank-1,
		fprintf(fid, '%s,', blankParts{iB});
	end;
	fprintf(fid, '%s", _\n', blankParts{nBlank});
else
	fprintf(fid, '"%s", _\n', blankParts);
end;

% Add the Tool Parts.
fprintf(fid, '"Tool Parts:=", _\n');
if (iscell(toolParts))
	nTool = length(toolParts);
	fprintf(fid, '"');
	for iB = 1:nTool-1,
		fprintf(fid, '%s,', toolParts{iB});
	end;
	fprintf(fid, '%s"), _\n', toolParts{nTool});
else
	fprintf(fid, '"%s"), _\n', toolParts);
end;

% Post-Amble.
fprintf(fid, 'Array("NAME:SubtractParameters", _\n');
fprintf(fid, '"KeepOriginals:=", false) \n');
