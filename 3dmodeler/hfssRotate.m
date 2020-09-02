% ----------------------------------------------------------------------------
% function hfssRotate(fid, ObjList, Axis, Degrees)
% 
% Description :
% -------------
% Creates the VB Script necessary to rotate a given set of objects.
%
% Parameters :
% ------------
% fid     - file identifier of the HFSS script file.
% ObjList - a cell array of objects that need to be rotated.
% Axis    - axis of the rotation.
% Degrees - value of the rotation in degrees.
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... create some objects here ...
% hfssRotate(fid, {'Dipole1', 'Dipole2'}, 'X', -30);
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 23-Sept-2012: *Initial release.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 23 September 2012
% ----------------------------------------------------------------------------
function hfssRotate(fid, ObjectList, Axis, Degrees)

nObjects = length(ObjectList);

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.Rotate _\n');
fprintf(fid, 'Array("NAME:Selections", _\n');

% Object Selections.
fprintf(fid, '"Selections:=", "');
for iObj = 1:nObjects
	fprintf(fid, '%s', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
    end
end
fprintf(fid, '"), _\n');

% Transalation Vector.
fprintf(fid, 'Array("NAME:RotateParameters", _\n');
fprintf(fid, '"RotateAxis:=", "%s", _\n', upper(Axis));
fprintf(fid, '"RotateAngle:=", "%fdeg")\n', Degrees);