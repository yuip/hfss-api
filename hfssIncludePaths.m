% ----------------------------------------------------------------------------
% function hfssIncludePaths()
% 
% Description :
% -------------
% Includes all the paths to use all API functions.
%
% Parameters :
% ------------
% None
%
% Note :
% ------
% Call this function first before start using the API.
%
% Example :
% ---------
% hfssIncludePaths();
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 30-Sept-2012: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 29 September 2012
% ----------------------------------------------------------------------------
function hfssIncludePaths()

addpath('boundary/');
addpath('3dmodeler/');
addpath('analysis/');
addpath('general/');
addpath('radiation/');
addpath('reporter/');