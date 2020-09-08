% ----------------------------------------------------------------------------
% function hfssAssignPositionVariable(fid, Name, type, Axis, variable)
% 
% Description :
% -------------
% Create the VB Script necessary to assign a local variable in HFSS.
%
% Parameters :
% ------------
% fid      - File identifier of the HFSS script file.
% Name     - Name of the object to which the variable will be assigned.
% type     - Type of object.
% Axis     - Axis where the variable is assigned.
% variable - The name of the variable to be assigned.
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssAssignSizeVariable(fid, 'Patch', 'Rectangle', 'X', 'var1');
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 02-Sep-2020: *Initial release.
% 08-Sep-2020: *Added Box type.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 02 September 2020
% ----------------------------------------------------------------------------
function hfssAssignPositionVariable(fid, Name, type, variables)
	% Preamble.
	fprintf(fid, '\n');

	% Change the variable name
	fprintf(fid, 'oEditor.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:Geometry3DCmdTab", _\n');
	fprintf(fid, 'Array("NAME:PropServers",  _\n');
    
    switch type
        case 'Rectangle'
            fprintf(fid, '"%s:CreateRectangle:1"), _\n', Name);
        case 'Box'
            fprintf(fid, '"%s:CreateBox:1"), _\n', Name);
        otherwise
            error('Type not supported!');
    end
    
	fprintf(fid, 'Array("NAME:ChangedProps", _\n');
    fprintf(fid, 'Array("NAME:Position", _\n');
    fprintf(fid, '"X:=", "%s", _\n', variables{1});
    fprintf(fid, '"Y:=", "%s", _\n', variables{2});
    fprintf(fid, '"Z:=", "%s"))))\n', variables{3});