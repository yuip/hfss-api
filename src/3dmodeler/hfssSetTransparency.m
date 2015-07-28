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

function hfssSetTransparency(fid, ObjectList, Value)
	% Creates the VB Script necessary to set the transparency of the given set of
	% objects to a given value.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% ObjectList:	a cell-array of objects whose transparency needs to be set.
	% Value:		the value of the objects transparency (can be between 0 and 1).
	%
	% Example : 
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ...
	% hfssSetTransparency(fid, {'AirBox'}, 0.95);
	% @endcode

	% ----------------------------------------------------------------------------
	% CHANGELOG
	%
	% ??-????-????: *Initial release.
	% 15-May-2013 : *Fix a bug when setting transparency to multiple objects.
	% ----------------------------------------------------------------------------

	% arguments processing.
	if (nargin < 3)
		erro('non-enough arguments !');
	end;

	if ((Value < 0) || (Value > 1))
		error('transparency must be between 0 and 1!');
	end;

	if (~iscell(ObjectList))
		error('ObjectList must be a cell-array of objects !');
	end;

	nObj = length(ObjectList);

	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, '\tArray("NAME:Geometry3DAttributeTab", _\n');
	fprintf(fid, '\t\tArray("NAME:PropServers",');
	for iO = 1:nObj-1,
		fprintf(fid, '"%s", ', ObjectList{iO});
	end;
	fprintf(fid, '"%s"), _\n', ObjectList{nObj});
	fprintf(fid, '\t\tArray("NAME:ChangedProps", _\n');
	fprintf(fid, '\t\t\tArray("NAME:Transparent", "Value:=",  %f) _\n', Value);
	fprintf(fid, '\t\t\t) _\n');
	fprintf(fid, '\t\t) _\n');
	fprintf(fid, '\t)\n');