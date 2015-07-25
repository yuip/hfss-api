function hfssThickenSheet(fid,ObjectList,Thickness, Units)
	% Thickens a given set of sheets.
	%
	% Parameters:
	% fid: 			file identifier of the HFSS script file.
	% ObjectList: 	a cell array of objects that need get thickened.
	% Thickness:	a float that defines the thickness value
	% Units:		units for the thickness (use 'in', 'mm', 'meter' or anything else defined in HFSS).
	% 
	% Example:
	% @code
	% hfssThickenSheet(fid, {'Rectangle1', 'Rectangle2'}, 0.4, 'mm');
	% @endcode
	%
	% @author Franz Schroeder, franz.dude@gmail.com / franz.schroeder@tu-dresden.de
	%
	% @date 16 September 2013

	nObjects = length(ObjectList);

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.ThickenSheet _\n');
	fprintf(fid, 'Array("NAME:Selections", _\n');

	% Object Selections.
	fprintf(fid, '"Selections:=", "');
	for iObj = 1:nObjects,
		fprintf(fid, '%s', ObjectList{iObj});
		if (iObj ~= nObjects)
			fprintf(fid, ',');
		end;
	end;
	fprintf(fid, '", _\n');

	% set parameters
	fprintf(fid, '"NewPartsModelFlag:=", _\n');
	fprintf(fid, '"Model"), _\n');
	fprintf(fid, 'Array("NAME:SheetThickenParameters", _\n');
	fprintf(fid, '"Thickness:=", "%f%s", _\n', Thickness, Units);
	fprintf(fid, '"BothSides:=", false)\n');