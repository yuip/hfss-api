% ----------------------------------------------------------------------------
% function hfssSetActiveDesign(fid, designName, [designType = 'driven modal'])
% 
% Written by:
% ----------
% James L. McDonald
% jlm88byu@gmail.com
% 26 March 2005
%
% Modified by:
% ------------
% Rounak Singh Narde (rounaksingh17@gmail.com or rn5949@rit.edu)
%
% Description :
% -------------
% Create the necessary VB Script to insert an HFSS Design into the Project 
% and set it as the active design.
%
% Parameters :
% ------------
% fid        - file identifier of the HFSS script file.
% designName - name of the new design to be inserted.
% designType - (Optional String) choose from the following:
%              1. 'driven modal' (default)
%			   2. 'driven terminal'
%			   3. 'eigenmode'
% 
% Note :
% ------
% This function is usually called after a call to hfssOpenProject(), but
% this is not necessary.
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ...
% hfssInsertDesign(fid, 'Dipole_SingleElement');
% ----------------------------------------------------------------------------

function hfssSetActiveDesign(fid, designName)

% arguments processor.
if (nargin < 2)
	error('Insufficient number of arguments !');
end;

% create the necessary script.
fprintf(fid, '\n');

fprintf(fid, 'Set oDesign = oProject.SetActiveDesign("%s")\n', designName);
fprintf(fid, 'Set oEditor = oDesign.SetActiveEditor("3D Modeler")\n');