function hfssVariableChange(fid, variable, value, units)
	% Create the VB Script necessary to change the value of an existing
	% variable.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% variable:	The name of the variable to be changed.
	% value:	The new value for the variable (DOUBLE).
	% units:	units of the variable (specify using either 'in', 'mm',
	%           'meter' or anything else defined in HFSS).
	%
	% Example :
	% Change the value of a variable.
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssVariableChange(fid, 'radius', 5, 'cm')
	% @endcode
	%
	% @author James L. McDonald, jlm88byu@gmail.com
	%
	% @date 26 March 2005

	% Preamble.
	fprintf(fid, '\n');

	% Change the variable name
	fprintf(fid, 'oDesign.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:LocalVariableTab", _\n');
	fprintf(fid, 'Array("NAME:PropServers",  _\n');
	fprintf(fid, '"LocalVariables"), _\n');
	fprintf(fid, 'Array("NAME:ChangedProps", _\n');
	fprintf(fid, 'Array("NAME:%s", _\n', variable);
	fprintf(fid, '"Value:=", "%f%s"))))\n', value, units);