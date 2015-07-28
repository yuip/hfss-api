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
function hfssInsertSolution(fid, Name, fGHz, maxDeltaS, maxPass, minPass,...
                            minConvPass, MaxRef)
    % Creates the VBScript necessary to insert a Solution Setup in HFSS. 
    %
    % Parameters :
    % fid:          file identifier of the HFSS script file.
    % Name:         name of the solution setup.
    % fGHz:         solution frequency (in GHz).
    % maxDeltaS:    (optional) maximum error that can be tolerated (should be between 0 and 1,
    %               default is 0.02).
    % maxPass:      (optional) max # of passes to be run before the simulation is declared
    %               as 'did not converge' (default is 25).
    % minPass:      (optional) min # of passes before finishing the simulation
    %               (default 1).
    % minConvPass:  (optional) min # of converged passes before finishing the simulation
    %               (default 1).
    % MaxRef:       (optional) Maximum refinement per pass in percentage to apply to the
    %               mesh (default 20[%]).
    % 
    % @note function hfssInsertSolution(fid, Name, fGHz, [maxDeltaS = 0.02], 
    %                             [maxPass = 25], [minPass = 1],
    %                             [minConvPass = 1], [MaxRef = 20])
    %
    % Example :
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... 
    % hfssInsertSolution(fid, 'Setup750MHz', 0.75, 0.01, 100, 3, 2, 33);
    % @endcode

    % ----------------------------------------------------------------------------
    % CHANGELOG
    % 
    % ??-????-????: *Initial release.
    % 22-Sept-2012: *Added a few optional parameters (minPass, minConvPass, MaxRef)
    % ----------------------------------------------------------------------------

    % arguments processor.
    if (nargin < 3)
    	error('Insufficient number of arguments !');
    elseif (nargin < 4)
    	maxDeltaS = [];
    	maxPass = [];
        minPass = [];
        minConvPass = [];
        MaxRef = [];
    elseif (nargin < 5)
    	maxPass = [];
        minPass = [];
        minConvPass = [];
        MaxRef = [];
    elseif (nargin < 6)
        minPass = [];
        minConvPass = [];
        MaxRef = [];
    elseif (nargin < 7)
        minConvPass = [];
        MaxRef = [];
    elseif (nargin < 8)
        MaxRef = [];
    end

    % defaults processing.
    if isempty(maxDeltaS)
    	maxDeltaS = 0.02;
    end
    if isempty(maxPass)
    	maxPass = 25;
    end
    if isempty(minPass)
        minPass = 1;
    end
    if isempty(minConvPass)
        minConvPass = 1;
    end
    if isempty(MaxRef)
        MaxRef = 20;
    end

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
    fprintf(fid, '"MinimumPasses:=", %d, _\n', minPass);
    fprintf(fid, '"MinimumConvergedPasses:=", %d, _\n', minConvPass);
    fprintf(fid, '"PercentRefinement:=", %d, _\n', MaxRef);
    fprintf(fid, '"ReducedSolutionBasis:=", false, _\n');
    fprintf(fid, '"DoLambdaRefine:=", true, _\n');
    fprintf(fid, '"DoMaterialLambda:=", true, _\n');
    fprintf(fid, '"Target:=", 0.3333, _\n');
    fprintf(fid, '"PortAccuracy:=", 2, _\n');
    fprintf(fid, '"SetPortMinMaxTri:=", false)\n');

