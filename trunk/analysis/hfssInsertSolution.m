% ----------------------------------------------------------------------------
% function hfssInsertSolution(fid, Name, fGHz, [maxDeltaS = 0.02], 
%                             [maxPass = 25])
% 
% Description :
% -------------
% Creates the VBScript necessary to insert a Solution Setup in HFSS. 
%
% Parameters :
% ------------
% fid       - file identifier of the HFSS script file.
% Name      - name of the solution setup.
% fGHz      - solution frequency (in GHz).
% maxError  - maximum error that can be tolerated (should be between 0 and 1,
%             default is 0.02).
% maxPasses - max # of passes to be run before the simulation is declared
%             as 'did not converge' (default is 25).
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssInsertSolution(fid, 'Setup750MHz', 0.75, 0.01, 100);
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
function hfssInsertSolution(fid, Name, fGHz, maxDeltaS, maxPass)

% arguments processor.
if (nargin < 3)
	error('Insufficient number of arguments !');
elseif (nargin < 4)
	maxDeltaS = [];
	maxPass = [];
elseif (nargin < 5)
	maxPass = [];
end;

% defaults processing.
if isempty(maxDeltaS)
	maxDeltaS = 0.02;
end;
if isempty(maxPass)
	maxPass = 25;
end;

% create the necessary script.
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("AnalysisSetup")\n');
fprintf(fid, 'oModule.InsertSetup "HfssDriven", _\n');
fprintf(fid, 'Array("NAME:%s", _\n', Name);
fprintf(fid, '"Frequency:=", "%fGHz", _\n', fGHz);
fprintf(fid, '"PortsOnly:=", false, _\n');
fprintf(fid, '"maxDeltaS:=", %f, _\n', maxDeltaS);
fprintf(fid, '"UseMatrixConv:=", false, _\n');
fprintf(fid, '"MaximumPasses:=", %d, _\n', maxPass);
fprintf(fid, '"MinimumPasses:=", 1, _\n');
fprintf(fid, '"MinimumConvergedPasses:=", 1, _\n');
fprintf(fid, '"PercentRefinement:=", 20, _\n');
fprintf(fid, '"ReducedSolutionBasis:=", false, _\n');
fprintf(fid, '"DoLambdaRefine:=", true, _\n');
fprintf(fid, '"DoMaterialLambda:=", true, _\n');
fprintf(fid, '"Target:=", 0.3333, _\n');
fprintf(fid, '"PortAccuracy:=", 2, _\n');
fprintf(fid, '"SetPortMinMaxTri:=", false)\n');

