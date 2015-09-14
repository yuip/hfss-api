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
function hfssAssignLumpedPort(fid, Name, ObjName, iLStart, iLEnd, Units, ...
                              Resistance, Reactance)
	% Create the necessary VB Script to assign a Lumped Port to a given Object.
	%
	% Parameters :
	% fid:				file identifier of the HFSS script file.
	% Name:				name of the lumped port (appears under 'Boundaries' in HFSS).
	% ObjName:			name of the (sheet-like) object to which the lumped port is to 
	%           		be assigned.
	% iLStart:			(vector) starting point of the integration line. Specify as
	%           		[x, y, z].
	% iLEnd:			(vector) ending point of the integration line. Specify as
	%           		[x, y, z].
	% Units:			specify as 'meter', 'in', 'cm' (defined in HFSS).
	% Resistance:		(scalar, optional) the port resistance (defaults to 
	%                	50.0 Ohms)
	% Reactance:		(scalar, optional) the port reactance (defaults to 
	%                	0.0 Ohms)
	% 
	% @note Integration Lines are mandatory in lumped ports.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssAssignLumpedPort(fid, 'LumpedPort', 'GapSource', [-gapL/2, 0, 0], ...
	%	                 [gapL/2, 0, 0], 'meter', 75, 0);
	% @endcode

	% arguments processor.
	if (nargin < 6)
		error('Not Enough Arguments !');
	elseif (nargin < 7)
		Resistance = [];
		Reactance = [];
	elseif (nargin < 8)
		Reactance = [];
	end;

	% Setup default arguments.
	if isempty(Resistance)
		Resistance = 50.0;
	end;

	if isempty(Reactance)
		Reactance = 0.0;
	end;

	% The usual fprintf stuff.
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');

	fprintf(fid, 'oModule.AssignLumpedPort _\n');
	fprintf(fid, 'Array("NAME:%s", _\n', Name);
	fprintf(fid, '      Array("NAME:Modes", _\n');
	fprintf(fid, '             Array("NAME:Mode1", _\n');
	fprintf(fid, '                   "ModeNum:=", 1, _\n');
	fprintf(fid, '                   "UseIntLine:=", true, _\n');
	fprintf(fid, '                   Array("NAME:IntLine", _\n');
	fprintf(fid, '                          "Start:=", Array("%f%s", "%f%s", "%f%s"), _\n', ...
	        iLStart(1), Units, iLStart(2), Units, iLStart(3), Units);
	fprintf(fid, '                          "End:=",   Array("%f%s", "%f%s", "%f%s") _\n', ...
	        iLEnd(1), Units, iLEnd(2), Units, iLEnd(3), Units);
	fprintf(fid, '                         ), _\n');
	fprintf(fid, '                   "CharImp:=", "Zpi" _\n');
	fprintf(fid, '                   ) _\n');
	fprintf(fid, '            ), _\n');
	fprintf(fid, '      "Resistance:=", "%fOhm", _\n', Resistance);
	fprintf(fid, '      "Reactance:=", "%fOhm", _\n', Reactance);
	fprintf(fid, '      "Objects:=", Array("%s") _\n', ObjName);
	fprintf(fid, '      )\n');