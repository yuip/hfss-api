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
function hfssConnect(fid, Names)
	% Creates VB Script necessary to connect two HFSS objects using a surface.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Names:	a cell array of strings that represent the surface-like objects that need to be connected to form a solid structure.
	% 
	% Example:
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssConnect(fid, {'topLayer', 'bottomLayer'});
	% @endcode

	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.Connect _\n');
	fprintf(fid, 'Array("NAME:Selections", _\n');
	fprintf(fid, '"Selections:=", _\n');

	nObjects = length(Names);
	fprintf(fid, '"');
	for iO = 1:nObjects-1,
		fprintf(fid, '%s,', Names{iO});
	end;
	fprintf(fid, '%s")\n', Names{nObjects});