function hfssSetSolveInside(fid, Object, solveInsideFlag)
	% Creates VBscript change the Solve Inside flag of an object.
	%
	% Parameters:
	% fid: 				file identifier of the HFSS script file.
	% Object: 			Name of the object
	% solveInsideFlag: 	Value of the Solve Inside flag (Boolean variable - true or false)
	%
	% Example :
	% To set the Solve Inside flag to true of an object 'name'.
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ...
	% hfssRotate(fid, 'name', true);
	% @endcode

	fprintf(fid, 'oEditor.ChangeProperty _\n');
	fprintf(fid, '\tArray("NAME:AllTabs",  _\n');
	fprintf(fid, '\t\tArray("NAME:Geometry3DAttributeTab", _\n');
	fprintf(fid, '\t\t\tArray("NAME:PropServers",  "%s"), _\n', Object);
	fprintf(fid, '\t\t\tArray("NAME:ChangedProps", _\n');
	if (solveInsideFlag)
		fprintf(fid, '\t\t\t\tArray("NAME:Solve Inside", "Value:=", true) _\n');
	else
		fprintf(fid, '\t\t\t\tArray("NAME:Solve Inside", "Value:=", false) _\n');
	end;
	fprintf(fid, '\t\t\t\t) _\n');
	fprintf(fid, '\t\t\t) _\n');
	fprintf(fid, '\t\t) \n');