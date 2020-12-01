% ----------------------------------------------------------------------------
% function hfssEditFloquetPort(fid, Name, variable, value, units)
% 
% Description :
% -------------
% Allows to edit an existing Floquet port.
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% Name     - name of the floquet port (appears under 'Excitations' in HFSS).
% variable - parameter that it is edited. Possible values:
%                'Deembed': assigns new deembed value. Can be a variable.
%                'PolarizationState': establishes the order of the modes.
% value    - value assigned to the variable. Depending on the variable, it
%            may be:
%                For 'Deembed':
%                    (char) A string with the name of the variable.
%                    (real) A number with the numerical value. In this
%                           case, units must be specified.
%                For 'PolarizationState':
%                     (cell array) A cell array of two elements indicating
%                                  the order, either {'TE', 'TM'} or
%                                  {'TM','TE'}.
% units    - (Optional) units of the variable (specify using either 'in',
%            'mm', 'meter' or anything else defined in HFSS). Only for
%            'Deembed' option when it is a real number.
%
% Note :
% ------
% Currently, it only allows to edit the deembed parameter and change the
% polarization state of the modes.
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssEditFloquetPort(fid, 'MyFloquetPort', 'Deembed', 1, 'mm');
% hfssSetVariable(fid, 'varDeembed', l, 'mm');
% hfssEditFloquetPort(fid, 'MyFloquetPort', 'Deembed', 'varDeembed');
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 02-Sep-2020: *Initial release, supporting only deembedding (DRP).
% 01-Dec-2020: *Added option to change polarization state of modes (DRP).
%              *Completed documentation of the function (DRP).
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@uniovi.es
% 02 September 2020
% ----------------------------------------------------------------------------
function hfssEditFloquetPort(fid, Name, variable, value, units)
	% Preamble.
	fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');

	% Change the variable name
	fprintf(fid, 'oModule.EditFloquetPort "%s", _\n', Name);
	fprintf(fid, 'Array("NAME:%s", _\n', Name);
    
    switch variable
        case 'Deembed'
            fprintf(fid, '\t"DoDeembed:=", true, _\n');
            if ischar(value)
                fprintf(fid, '\t"DeembedDist:=", "%s")\n', value);
            else
                fprintf(fid, '\t"DeembedDist:=", "%f%s")\n', value, units);
            end
        case 'PolarizationState'
            fprintf(fid, '\tArray("NAME:ModesList", _\n');
            fprintf(fid, '\t\tArray("NAME:Mode", "ModeNumber:=",1, _\n');
            fprintf(fid, '\t\t\t"PolarizationState:=", "%s"), _\n', value{1});
            fprintf(fid, '\t\tArray("NAME:Mode", "ModeNumber:=",2, _\n');
            fprintf(fid, '\t\t\t"PolarizationState:=", "%s") _\n', value{2});
            fprintf(fid, '\t\t) _\n');
            fprintf(fid, '\t)\n');
        otherwise
            error('variable not supported!');
    end