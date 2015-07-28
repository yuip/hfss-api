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
function hfssInterpolatingSweep(fid, Name, SolutionName, fStartGHz, ...
                                fStopGHz, nPoints, nMaxSols, iTol)
	% Create the VB Script necessary to add an interpolating sweep to an existing
	% solution.
	% 
	% Parameters :
	% fid:			file identifier of the HFSS script file.
	% Name:			Name of the interpolating sweep. 
	% SolutionName:	Name of the solution to which this interpolating sweep needs
	%                to be added.
	% fStartGHz:	Starting frequency of sweep in GHz.
	% fStopGHz:		Stop frequency of sweep in GHz.
	% nPoints:		Number of output points (defaults to 1000).
	% nMaxSols:		Max # of interpolating points that need to be solved (more 
	%                points will guarentee convergence) - defaults to 101.
	% iTol:			Interpolation tolerance (defaults to 0.5).
	% 
	% @note function hfssInterpolatingSweep(fid, Name, SolutionName, fStartGHz, ...
	%                                fStopGHz, [nPoints = 1000], [nMaxSols = 101], 
	%                                [iTol = 0.5])
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssInterpolatingSweep(fid, 'Interp600to900MHz', 'Solve750MHz', 0.6, ...
	%                        0.9, 1000, 101, 0.5);
	% @endcode

	% arguments processor.
	if (nargin < 5)
		error('Insufficient # of arguments');
	elseif (nargin < 6)
		nPoints = [];
		nMaxSols = [];
		iTol = [];
	elseif (nargin < 7)
		nMaxSols = [];
		iTol = [];
	elseif (nargin < 8)
		iTol = [];
	end;

	% process default arguments.
	if isempty(nPoints)
		nPoints = 1000;
	end;
	if isempty(nMaxSols)
		nMaxSols = 101;
	end;
	if isempty(iTol)
		iTol = 0.5;
	end;

	% create script.
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("AnalysisSetup")\n');

	fprintf(fid, 'oModule.InsertDrivenSweep _\n');
	fprintf(fid, '"%s", _\n', SolutionName);
	fprintf(fid, 'Array("NAME:%s", _\n', Name);
	fprintf(fid, '"Type:=", "Interpolating", _\n');
	fprintf(fid, '"InterpTolerance:=", %f, _\n', iTol);
	fprintf(fid, '"InterpMaxSolns:=", %d, _\n', nMaxSols);
	fprintf(fid, '"SetupType:=", "LinearCount", _\n');
	fprintf(fid, '"StartFreq:=", "%fGHz", _\n', fStartGHz);
	fprintf(fid, '"StopFreq:=", "%fGHz", _\n', fStopGHz);
	fprintf(fid, '"Count:=", %d, _\n', nPoints);
	fprintf(fid, '"SaveFields:=", false, _\n');
	fprintf(fid, '"ExtrapToDC:=", false)\n');
