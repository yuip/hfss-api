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
% variable - parameter that it is edited.
% units    - (Optional) units of the variable (specify using either 'in',
%            'mm', 'meter' or anything else defined in HFSS).
%
% Note :
% ------
% Currently, it only allows to edit the deembed parameter.
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
% 02-Sep-2020: *Initial release (DRP).
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
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
            fprintf(fid, '"DoDeembed:=", true, _\n');
            if ischar(value)
                fprintf(fid, '"DeembedDist:=", "%s")\n', value);
            else
                fprintf(fid, '"DeembedDist:=", "%f%s")\n', value, units);
            end
        otherwise
            error('variable not supported!');
    end