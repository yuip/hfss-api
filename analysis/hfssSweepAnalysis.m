% ----------------------------------------------------------------------------
% function hfssSweepAnalysis(fid, Name, Analysis, Type, Variables, Data,
%                            Units, [Sync])
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
% Type      - cell array with sweep types. Supported: 'LIN' and 'LINC'.
%                "LIN Start Stop Step" -> Start:Step:Stop
%                "LINC Start Stop Count" -> linspace(Start, Stop, Count)
% Variables - cell array with the name of the variable of which the sweep
%             will be performed.
% Data      - cell array containing numerical values of [Start, Stop,
%             Step] for each variable.
% Units     - for Data, can be 'mm', 'cm', 'meters', etc.
% Sync      - (optional, cell array) set to 1, 2, ... to sync variable 
%             sweeps in different groups. Default: 0.
% 
% Note :
% ------
%
% Examples :
% ---------
% hfssSweepAnalysis(fid, 'ParSetup1', 'MySetup', 'LIN', 'var', ...
%    [1, 9, 1], 'mm');
% hfssSweepAnalysis(fid, 'ParSetup2', 'MySetup', {'LIN', 'LIN'}, ...
%     {'pB', 'pA'}, {[0.1, 3.5, 0.2], [0.1, 3.5, 0.2]}, 'mm', {1, 1});
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 03-Sep-2020: *Initial release (only LIN sweep type supported).
% 09-Sep-2020: *LINC sweep type supported.
%              *Sync is now a cell array, allowing to syncronize variables
%               in different groups.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 03 September 2020
% ----------------------------------------------------------------------------
function hfssSweepAnalysis(fid, Name, Analysis, Type, Variables, Data, Units, ...
                           Sync)

% Arguments processor.
if (nargin < 7)
	error('Insufficient # of arguments !');
end
if (nargin == 7)
    Sync = zeros(numel(Variables), 1);
end

if (~iscell(Type))
    Type = {Type};
end
if (~iscell(Variables))
    Variables = {Variables};
end
if (~iscell(Data))
    Data = {Data};
end
if (~iscell(Sync))
    Sync = num2cell(Sync);
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
    switch Type{n}
        case 'LIN'
            fprintf(fid, '\t\t"Data:=", "LIN %f%s %f%s %f%s", _\n', ...
                Data{n}(1), Units, Data{n}(2), Units, Data{n}(3), Units);
        case 'LINC'
            fprintf(fid, '\t\t"Data:=", "LINC %f%s %f%s %i", _\n', ...
                Data{n}(1), Units, Data{n}(2), Units, Data{n}(3));
        otherwise
            error('Wrong type!');
    end
    fprintf(fid, '\t\t"OffsetF1:=", false, _\n');
    fprintf(fid, '\t\t"Synchronize:=", %i)', Sync{n});
    
    if (n < numel(Variables))
        fprintf(fid, ', _\n'); % Don't include comma in last item.
    end
end
fprintf(fid, '\t\t), _\n');
fprintf(fid, '\tArray("NAME:Sweep Operations"), _\n');
fprintf(fid, '\tArray("NAME:Goals"))\n');