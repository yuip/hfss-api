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

function hfssAssignWavePort(fid, PortName, SheetObject, nModes, isLine, ...
			    intStart, intEnd, Units)
	% Creates the VB Script necessary to assign a waveport to a (sheet-like)
	% object.
	%
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% PortName:		name of the wave port (will appear under 'Boundaries').
	% SheetObject:	name of the (sheet-like) object to which the wave port is
	%               to be assigned.
	% nModes:		Number of modes.
	% isLine      	:a boolean array of length (nModes) that specifies whether the
	%               corresponding mode has an integration line or not.
	% intStart    	:(nModes x 3 matrix) an array of vectors that represent the
	%               starting points for the integration lines for the 
	%               respective modes (see note).
	% intEnd      	:(nModes x 3 matrix) an array of vectors that represent the
	%               ending points for the integration lines for the 
	%               respective modes (note note).
	% Units       	:specify as either 'in', 'meter', 'mm' or anything else
	%               defined in HFSS.
	%
	% @note * if an integration line is not required for a particular mode, then the
	%    corresponding entries in intStart and intEnd are ignored.
	% @note * mostly, we will be using a single-mode and a single integration line.
	%
	% Example :
	% single mode, no integration line specified.
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssAssignWavePort(fid, Name, ObjectName, 1, false, [0,0,0], ...
	%                  [0,0,0], Units);
	% @endcode
	% ----------------------------------------------------------------------------

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup") \n');
	fprintf(fid, '\n');
	fprintf(fid, 'oModule.AssignWavePort _\n');
	fprintf(fid, 'Array( _\n');
	fprintf(fid, '"NAME:%s", _\n', PortName);
	fprintf(fid, '"Faces:=", Array(%s), _\n', SheetObject);
	fprintf(fid, '"NumModes:=", %d, _\n', nModes); 
	fprintf(fid, '"PolarizeEField:=",  false, _\n');
	fprintf(fid, '"DoDeembed:=", false, _\n');
	fprintf(fid, '"DoRenorm:=", false, _\n');

	% Modes 
	fprintf(fid, 'Array("NAME:Modes", _\n');

	% Add the Mode-Lines One By One.
	for iM = 1:nModes,
		if (isLine(iM))
			fprintf(fid, 'Array("NAME:Mode1", _\n');
			fprintf(fid, '"ModeNum:=",  %d, _\n', iM);
			fprintf(fid, '"UseIntLine:=", true, _\n');
			fprintf(fid, 'Array("NAME:IntLine", _\n');
			fprintf(fid, '"Start:=", _\n');
			fprintf(fid, 'Array("%f%s", "%f%s", "%f%s"), _\n', ... 
			        intStart(1), Units, intStart(2), Units, ...
			        intStart(3), Units); 
			fprintf(fid, '"End:=", _\n');
			fprintf(fid, 'Array("%f%s", "%f%s", "%f%s") _\n', ...
			        intEnd(1), Units, intEnd(2), Units, ...
			        intEnd(3), Units);
			fprintf(fid, '), _\n');
			fprintf(fid, '"CharImp:=", "Zpi")');
		else
			fprintf(fid, 'Array("NAME:Mode1", _\n');
			fprintf(fid, '"ModeNum:=",  %d, _\n', iM);
			fprintf(fid, '"UseIntLine:=", false)');
		end;
		if (iM ~= nModes)
			fprintf(fid, ', _\n');
		end;
	end;

	% End Modes Array and Waveport Array
	fprintf(fid, '))\n');
	end