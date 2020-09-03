% ----------------------------------------------------------------------------
% function hfssSweepAnalysis(fid, Name, Analysis, Variables, Data, Units,
%                            [Sync])
% 
% Description :
% -------------
% Generates a simple linear sweep analysis for a given variable.
%
% Parameters :
% ------------
% fid       - file identifier of the HFSS script file.
% Name      - name of the sweep analysis to be created.
% Analysis  - name of the associated analysis setup.
% Variables - cell array with the name of the variable of which the sweep
%             will be performed.
% Data      - cell array containing numerical values of [Start, Stop,
%             Step] for each variable.
% Units     - for Data, can be 'mm', 'cm', 'meters', etc.
% Sync      - (optional) set to 1 to sync variable sweeps. Default: 0.
% 
% Note :
% ------
%
% Examples :
% ---------
% hfssSweepAnalysis(fid, 'ParSetup1', 'MySetup', 'var', [1, 9, 1], 'mm');
% hfssSweepAnalysis(fid, 'ParSetup2', 'MySetup', {'pB', 'pA'}, ...
%    {[0.1, 3.5, 0.2], [0.1, 3.5, 0.2]}, 'mm', 1);
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 03-Sep-2020: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 03 September 2020
% ----------------------------------------------------------------------------
function hfssSweepAnalysis(fid, Name, Analysis, Variables, Data, Units, ...
                           Sync)

% Arguments processor.
if (nargin < 6)
	error('Insufficient # of arguments !');
end
if (nargin == 6)
    Sync = 0;
end

if (~iscell(Variables))
    Variables = {Variables};
end
if (~iscell(Data))
    Data = {Data};
end

% Preamble
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("Optimetrics")\n');

% Command
fprintf(fid, 'oModule.InsertSetup "OptiParametric", _\n');
fprintf(fid, '\tArray("NAME:%s", _\n', Name);
fprintf(fid, '\t"IsEnabled:=", true, _\n');
fprintf(fid, '\tArray("NAME:ProdOptiSetupDataV2", _\n');
fprintf(fid, '\t\t"SaveFields:=", false, _\n');
fprintf(fid, '\t\t"CopyMesh:=", false, _\n');
fprintf(fid, '\t\t"SolveWithCopiedMeshOnly:=", true), _\n');
fprintf(fid, '\tArray("NAME:StartingPoint"), _\n');
fprintf(fid, '\t"Sim. Setups:=", Array("%s"), _\n', Analysis);
fprintf(fid, '\tArray("NAME:Sweeps", _\n');

for n = 1:numel(Variables)
    fprintf(fid, '\t\tArray("NAME:SweepDefinition", _\n');
    fprintf(fid, '\t\t"Variable:=", "%s", _\n', Variables{n});
    fprintf(fid, '\t\t"Data:=", "LIN %f%s %f%s %f%s", _\n', ...
        Data{n}(1), Units, Data{n}(2), Units, Data{n}(3), Units);
    fprintf(fid, '\t\t"OffsetF1:=", false, _\n');
    fprintf(fid, '\t\t"Synchronize:=", %i)', Sync);
    
    if (n < numel(Variables))
        fprintf(fid, ', _\n'); % Don't include comma in last item.
    end
end
fprintf(fid, '\t\t), _\n');
fprintf(fid, '\tArray("NAME:Sweep Operations"), _\n');
fprintf(fid, '\tArray("NAME:Goals"))\n');