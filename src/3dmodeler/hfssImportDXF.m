function hfssImportDXF(fid, fileName, modelName)
	% Imports a model from a .DXF file in HFSS
	%
	% Creates the VB Script necessary to import a model from a .DXF file
	%
	% Parameters:
	% fid:			file identifier of the HFSS script file.
	% fileName:		path to the .DXF file.
	% modelName		name of the model (appears in HFSS).
	% 
	%
	% Example:
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
    % hfssImportDXF(fid, 'C:\myModel.dxf', 'MyDXFModel');
	% @endcode
	
	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.ImportDXF _\n');

	% Box Parameters.
	fprintf(fid, '\tArray("NAME:options", _\n\t\t  ');
    fprintf(fid, '"FileName:=", "%s", _\n\t\t  ', fileName);
	fprintf(fid, '"Scale:=", 0.001, _\n\t\t  ');
	fprintf(fid, '"AutoDetectClosed:=", true, _\n\t\t  ');
	fprintf(fid, '"SelfStitch:=", true, _\n\t\t  ');
	fprintf(fid, '"DefeatureGeometry:=", false, _\n\t\t  ');
	fprintf(fid, '"DefeatureDistance:=", 0, _\n\t\t  ');
	fprintf(fid, '"RoundCoordinates:=", false, _\n\t\t  ');
    fprintf(fid, '"RoundNumDigits:=", 4, _\n\t\t  ');
    fprintf(fid, '"WritePolyWithWidthAsFilledPoly:=", false, _\n\t\t  ');
    fprintf(fid, '"ImportMethod:=", 0, _\n\t\t  ');
    fprintf(fid, '"2DSheetBodies:=", false, _\n\t\t  ');
    
    fprintf(fid, '\t\tArray("NAME:LayerInfo", _\n\t\t  ');
    fprintf(fid, '\t\t\tArray("NAME:0", _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"source:=", "0", _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"display_source:=", "%s", _\n\t\t\t\t\t\t  ', modelName);
    fprintf(fid, '"import:=", true, _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"dest:=", "0", _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"dest_selected:=", false, _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"layer_type:=", "signal") _\n\t\t\t\t  ');
    fprintf(fid, ') _\n\t\t)');