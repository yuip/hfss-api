% ----------------------------------------------------------------------------
% function hfssCalcStack(fid, Op)
% 
% Description :
% -------------
% Performs an operation on the stack.
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
% hfssCalcOp(fid, 'clear');
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 05-Nov-2012: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 05 November 2012
% ----------------------------------------------------------------------------
function hfssCalcStack(fid, Op)

% Arguments processor.
if (nargin < 2)
	error('Insufficient # of arguments !');
end

% Preamble
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("FieldsReporter")\n');

% Command
fprintf(fid, 'oModule.CalcStack "%s"\n', Op);