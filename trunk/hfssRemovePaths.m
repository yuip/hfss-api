% ----------------------------------------------------------------------------
% function hfssRemovePaths([relPath = ''])
% 
% Description :
% -------------
% Removes all the paths used by all API functions.
%
% Parameters :
% ------------
% relPath - Relative path from this function directory, in order to
%           remove all API directories. It must end with
%			a slash ("/").
%
% Note :
% ------
% Call this function when you have finished using all the API functions
% if you want to remove all the paths included by the funcion
% hfssIncludePaths(...).
%
% Example :
% ---------
% hfssRemovePaths();
% hfssRemovePaths('../../');
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 30-May -2013: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 30 May 2013
% ----------------------------------------------------------------------------
function hfssRemovePaths(relPath)

if (nargin < 1)
	relPath = '';
end

rmpath([relPath, 'boundary/']);
rmpath([relPath, '3dmodeler/']);
rmpath([relPath, 'analysis/']);
rmpath([relPath, 'general/']);
rmpath([relPath, 'radiation/']);
rmpath([relPath, 'reporter/']);
rmpath([relPath, 'fieldsCalculator/']);
rmpath([relPath, 'mesh/']);