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
% 03-Octo-2012: *Add 'fieldsCalculator/' path.
% 04-Nove-2012: *Add 'mesh/' path.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 30 September 2012
% ----------------------------------------------------------------------------
function hfssIncludePaths()

addpath('boundary/');
addpath('3dmodeler/');
addpath('analysis/');
addpath('general/');
addpath('radiation/');
addpath('reporter/');
addpath('fieldsCalculator/');
addpath('mesh/');