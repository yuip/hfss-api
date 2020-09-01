% ----------------------------------------------------------------------------
% function hfssEnterQty(fid, Qty)
% 
% Description :
% -------------
% Adds a field quantity to the fields calculator's stack.
%
% Parameters :
% ------------
% fid - file identifier of the HFSS script file.
% Qty - field quantity to be entered onto the stack.
% 
% Note :
% ------
%
% Example :
% ---------
% hfssEnterQty(fid, 'E');
% hfssEnterQty(fid, 'H');
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
function hfssEnterQty(fid, Qty)

% Arguments processor.
if (nargin < 2)
	error('Insufficient # of arguments !');
end

% Preamble
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("FieldsReporter")\n');

% Command
fprintf(fid, 'oModule.EnterQty "%s"\n', Qty);