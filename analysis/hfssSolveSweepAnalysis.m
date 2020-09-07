% ----------------------------------------------------------------------------
% function hfssSolveSweepAnalysis(fid, SetupName)
% 
% Description :
% -------------
% Creates the VB script to solve a given sweep analysis setup.
% 
% Parameters :
% ------------
% fid       - file identifier of the HFSS script file.
% SetupName - name of the sweep analysis to be solved.
%
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssSolveSweepAnalysis(fid, 'ParametricSetup');
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 07-Sep-2020: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 07 September 2020
% ----------------------------------------------------------------------------
function hfssSolveSweepAnalysis(fid, SetupName)

fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("Optimetrics")\n');
fprintf(fid, 'oModule.SolveSetup "%s"\n', SetupName);