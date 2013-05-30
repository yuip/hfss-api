% ----------------------------------------------------------------------------
% function hfssIncludePaths([relPath = ''])
% 
% Description :
% -------------
% Includes all the paths to use all API functions.
%
% Parameters :
% ------------
% relPath - Relative path from this function directory, in order to
%           include the rest of the API directories. It must end with
%			a slash ("/"). You must add first the API root directory
%           manually to the Matlab path with the addpath command.
%
% Note :
% ------
% Call this function first before start using the API using the apropriate
% relative path, in case your code is not in the root directory of the API
% (see examples)
%
% Example :
% ---------
% hfssIncludePaths();
% hfssIncludePaths('../../');
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 30-Sept-2012: *Initial release.
% 03-Octo-2012: *Add 'fieldsCalculator/' path.
% 04-Nove-2012: *Add 'mesh/' path.
% 30-May -2013: *Add relative path as an optional argument.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 30 September 2012
% ----------------------------------------------------------------------------
function hfssIncludePaths(relPath)

if (nargin < 1)
	relPath = '';
end

addpath([relPath, 'boundary/']);
addpath([relPath, '3dmodeler/']);
addpath([relPath, 'analysis/']);
addpath([relPath, 'general/']);
addpath([relPath, 'radiation/']);
addpath([relPath, 'reporter/']);
addpath([relPath, 'fieldsCalculator/']);
addpath([relPath, 'mesh/']);