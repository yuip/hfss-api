% ----------------------------------------------------------------------------
% function hfssEnableAutoSave(fid, enable)
% 
% Description :
% -------------
% Create the VB Script necessary to enable or disable auto save. Useful to
% increase speeds of drawing models in non-gui mode.
%
% Parameters :
% ------------
% fid      - File identifier of the HFSS script file.
% enable   - Logical true or false to enable or disable auto save.
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssEnableAutoSave(fid, false);
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 05-Jul-2024: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado.tsc@gmail.com
% 05 July 2024
% ----------------------------------------------------------------------------
function hfssEnableAutoSave(fid, enable)
    if ~islogical(enable)
        enable = logical(enable);
    end
    
	fprintf(fid, '\n');
    if enable
        fprintf(fid, 'oDesktop.EnableAutoSave True\n');
    else
        fprintf(fid, 'oDesktop.EnableAutoSave False\n');
    end