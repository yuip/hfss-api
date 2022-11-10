function hfssRename(fid, oldName, newName)
	% Create the VB Script necessary to rename a model component
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% oldName:	The name of the variable to be changed.
	% value:	The new name for the variable.
	%
	% Example :
	% Change the name of a variable.
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssRename(fid, 'stupidname', 'coolname')
	% @endcode

	% Preamble.
	fprintf(fid, '\n');

	% Change the variable name
	fprintf(fid, 'oDesign.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:Geometry3DAttributeTab", _\n');
	fprintf(fid, 'Array("NAME:PropServers", "%s"), _\n', oldName);
	fprintf(fid, 'Array("NAME:ChangedProps", _\n');
	fprintf(fid, 'Array("NAME:Name", "Value:=", "%s"))))\n', newName);