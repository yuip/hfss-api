function hfssDuplicateMirror(fid, ObjectList, Base, Normal, Units, ...
                             dupBoundaries)

if (nargin < 6)
	dupBoundaries = [];
end;
if isempty(dupBoundaries)
	dupBoundaries = true;
end;

nObjects = length(ObjectList);

fprintf(fid, 'oEditor.DuplicateMirror _\n');
fprintf(fid, '\tArray("NAME:Selections", "Selections:=", "');

% Object Selections.
for iObj = 1:nObjects,
	fprintf(fid, '%s', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '"), _\n');

fprintf(fid, '\tArray("NAME:DuplicateToMirrorParameters", _\n');
fprintf(fid, '\t\t"DuplicateMirrorBaseX:=",  "%f%s", _\n', Base(1), Units);
fprintf(fid, '\t\t"DuplicateMirrorBaseY:=", "%f%s", _\n', Base(2), Units);
fprintf(fid, '\t\t"DuplicateMirrorBaseZ:=", "%f%s", _\n', Base(3), Units);
fprintf(fid, '\t\t"DuplicateMirrorNormalX:=",  "%f%s", _\n', Normal(1), Units);
fprintf(fid, '\t\t"DuplicateMirrorNormalY:=", "%f%s", _\n', Normal(2), Units);
fprintf(fid, '\t\t"DuplicateMirrorNormalZ:=", "%f%s" _\n', Normal(3), Units);
fprintf(fid, '\t\t), _\n');
if (dupBoundaries == true)
	fprintf(fid, '\tArray("NAME:Options", "DuplicateBoundaries:=", true) \n\n');
else
	fprintf(fid, '\tArray("NAME:Options", "DuplicateBoundaries:=", false) \n\n');
end;
