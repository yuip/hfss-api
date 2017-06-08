function hfssImportDXF(fid, fileName, modelName, varargin)
	% Imports a model from a .DXF file in HFSS
	%
	% Creates the VB Script necessary to import a model from a .DXF file
	%
	% Parameters:
	% fid:			file identifier of the HFSS script file.
	% fileName:		path to the .DXF file.
	% modelName:	name of the model (appears in HFSS).
    % varargin:     units, twoDim (both optional)
    %   twoDim:       specify whether to import the model as 2D or 3D
    %                       * true  --> import 2D
    %                       * false --> import 3D
    %   units:        specify the units of the imported model
    %                 (can be numeric, or a string supported by HFSS)
    % 
    % Supported units strings: 
    % 'cm', 'dm', 'fm', 'ft', 'in', 'km',
    % 'lightyear', 'meter', 'mil', 'mile', 
    % 'mileNaut', 'mileTerr', 'mm','nm', 
    % 'pm', 'uin', 'um', 'yd'
	% 
	%
	% Example:
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
    % hfssImportDXF(fid, 'C:\myModel.dxf', 'MyDXFModel');
	% @endcode
    
    if nargin < 4
        warning('No units specified. Defaulting to mm');
        scale = 0.001;
    else
        if isnumeric(varargin{1})
            scale = varargin{1};
        else
            switch varargin{1}
                case 'cm'
                    scale = 1e-2;
                case 'dm'
                    scale = 0.1;
                case 'fm'
                    scale = 1e-15;
                case 'ft'
                    scale = 0.3048;
                case 'in'
                    scale = 0.0254;
                case 'km'
                    scale = 1e3;
                case 'lightyear'
                    scale = 9.46073e15;
                case 'meter'
                    scale = 1;
                case 'mil'
                    scale = 2.54e-5;
                case 'mile'
                    scale = 1609.344;
                case 'mileNaut'
                    scale = 1852;
                case 'mileTerr'
                    scale = 1609.344;
                case 'mm'
                    scale = 1e-3;
                case 'nm'
                    scale = 1e-9;
                case 'pm'
                    scale = 1e-12;
                case 'uin'
                    scale = 2.54e-8;
                case 'um'
                    scale = 1e-6;
                case 'yd'
                    scale = 0.9144;
                otherwise
                    warning('Invalid units specified. Defaulting to mm');
                    scale = 1e-3;
            end
        end
    end
    
    if nargin < 5
        twoDim = 'false';
    else
        if varargin{2};
            twoDim = 'true';
        else
            twoDim = 'false'
        end
    end
    
	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oEditor.ImportDXF _\n');

	% Box Parameters.
	fprintf(fid, '\tArray("NAME:options", _\n\t\t  ');
    fprintf(fid, '"FileName:=", "%s", _\n\t\t  ', fileName);
	fprintf(fid, '"Scale:=", %f, _\n\t\t  ', scale);
	fprintf(fid, '"AutoDetectClosed:=", true, _\n\t\t  ');
	fprintf(fid, '"SelfStitch:=", true, _\n\t\t  ');
	fprintf(fid, '"DefeatureGeometry:=", false, _\n\t\t  ');
	fprintf(fid, '"DefeatureDistance:=", 0, _\n\t\t  ');
	fprintf(fid, '"RoundCoordinates:=", false, _\n\t\t  ');
    fprintf(fid, '"RoundNumDigits:=", 4, _\n\t\t  ');
    fprintf(fid, '"WritePolyWithWidthAsFilledPoly:=", false, _\n\t\t  ');
    fprintf(fid, '"ImportMethod:=", 0, _\n\t\t  ');
    fprintf(fid, '"2DSheetBodies:=", %s, _\n\t\t  ', twoDim);
    
    fprintf(fid, '\t\tArray("NAME:LayerInfo", _\n\t\t  ');
    fprintf(fid, '\t\t\tArray("NAME:0", _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"source:=", "0", _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"display_source:=", "%s", _\n\t\t\t\t\t\t  ', modelName);
    fprintf(fid, '"import:=", true, _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"dest:=", "0", _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"dest_selected:=", false, _\n\t\t\t\t\t\t  ');
    fprintf(fid, '"layer_type:=", "signal") _\n\t\t\t\t  ');
    fprintf(fid, ') _\n\t\t)');