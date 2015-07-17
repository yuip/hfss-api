% ----------------------------------------------------------------------------
% function hfssSetWCS(fid, Name)
% 
% Description :
% -------------
% Sets the working coordinate system. It can be the 'Global' CS or
% another created by the user with the function hfssCreateRelativeCS.
%
% Parameters :
% ------------
% fid     - file identifier of the HFSS script file.
% Name    - name of the coordinate system to set as the WCS.
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ...
% hfssSetWCS(fid, 'Global')
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 21 September 2012
% ----------------------------------------------------------------------------

function hfssSetWCS(fid, Name)

% arguments processor.
if (nargin < 2)
	error('Insufficient number of arguments !');
end;

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.SetWCS _\n');

% WCS Parameters
fprintf(fid, 'Array("NAME:SetWCS Parameter", _\n');
fprintf(fid, '"Working Coordinate System:=", "%s")\n', Name);