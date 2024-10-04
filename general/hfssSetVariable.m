% ----------------------------------------------------------------------------
% function function hfssSetVariable(fid, variable, value, [units])
% 
% Description :
% -------------
% Create the VB Script necessary to create a new local variable in HFSS.
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% variable - The name of the variable to be created.
% value    - The value for the variable (DOUBLE or CHAR).
% units    - (Optional) units of the variable (specify using either 'in',
%            'mm', 'meter' or anything else defined in HFSS).
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssSetVariable(fid, 'radius', 5, 'cm');
% hfssSetVariable(fid, 'diameter', '2*radius');
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 28-Sep-2015: *Initial release (RS).
% 02-Sep-2020: *Allows to assign a variable as a function of other
%               variables (DRP).
% 04-Oct-2024: *Allow to have unitless variables.
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Rounak Singh
% rounaksingh17@gmail.com
% 28 September 2015
% ----------------------------------------------------------------------------
function hfssSetVariable(fid, variable, value, units)
    if nargin < 4
        units = '';
    end

	% Preamble.
	fprintf(fid, '\n');

	% Change the variable name
	fprintf(fid, 'oDesign.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:LocalVariableTab", _\n');
	fprintf(fid, 'Array("NAME:PropServers",  _\n');
	fprintf(fid, '"LocalVariables"), _\n');
	fprintf(fid, 'Array("NAME:NewProps", _\n');
	fprintf(fid, 'Array("NAME:%s", _\n', variable);
    fprintf(fid, '"PropType:=", "VariableProp", _\n');
    fprintf(fid, '"UserDef:=", true, _\n');
    if ischar(value)
        fprintf(fid, '"Value:=", "%s"))))\n', value);
    else
        fprintf(fid, '"Value:=", "%f%s"))))\n', value, units);
    end