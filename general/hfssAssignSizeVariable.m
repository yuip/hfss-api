% ----------------------------------------------------------------------------
% function hfssAssignSizeVariable(fid, Name, type, Axis, variable)
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
% variable - The name of the variable to be assigned..
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
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 02 September 2020
% ----------------------------------------------------------------------------
function hfssAssignSizeVariable(fid, Name, type, Axis, variable)
    if ~iscell(Axis)
        Axis = {Axis};
    end
    if ~iscell(variable)
        variable = {variable};
    end
    
	% Preamble.
	fprintf(fid, '\n');

	% Change the variable name
	fprintf(fid, 'oEditor.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:Geometry3DCmdTab", _\n');
	fprintf(fid, 'Array("NAME:PropServers",  _\n');
    fprintf(fid, '"%s:Create%s:1"), _\n', Name, type);
	fprintf(fid, 'Array("NAME:ChangedProps", _\n');
    for n = 1:numel(Axis)
        fprintf(fid, 'Array("NAME:%sSize", _\n', Axis{n});
        if (n < numel(Axis))
            fprintf(fid, '"Value:=", "%s"), _\n', variable{n});
        else
            fprintf(fid, '"Value:=", "%s") _\n', variable{n});
        end
    end
    fprintf(fid, ')))\n');