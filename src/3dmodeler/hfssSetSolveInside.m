function hfssSetSolveInside(fid, Object, solveInsideFlag)

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
