% ----------------------------------------------------------------------------
% function hfssCleanUpModel(fid)
% 
% Description :
% -------------
% Clean up history tree operations in order to improve performance.
%
% Parameters :
% ------------
% fid - file identifier of the HFSS script file.
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ...
% hfssCleanUpModel(fid)
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado.tsc@gmail.com
% 15 August 2024
% ----------------------------------------------------------------------------

function hfssCleanUpModel(fid)

% arguments processor.
if (nargin < 1)
	error('Insufficient number of arguments !');
end

fprintf(fid, '\n');
fprintf(fid, 'oEditor.CleanUpModel\n');