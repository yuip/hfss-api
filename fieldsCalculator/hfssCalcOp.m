% ----------------------------------------------------------------------------
% function hfssCalcOp(fid, Op)
% 
% Description :
% -------------
% Performs a calculator operation.
%
% Parameters :
% ------------
% fid - file identifier of the HFSS script file.
% Op  - operation to be performed.
% 
% Note :
% ------
%
% Example :
% ---------
% hfssCalcOp(fid, 'Smooth');
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 06-Oct-2012: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 06 October 2012
% ----------------------------------------------------------------------------
function hfssCalcOp(fid, Op)

% Arguments processor.
if (nargin < 2)
	error('Insufficient # of arguments !');
end

% Preamble
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("FieldsReporter")\n');

% Command
fprintf(fid, 'oModule.CalcOp "%s"\n', Op);