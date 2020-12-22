% ----------------------------------------------------------------------------
% function hfssEditSlave(fid, Name, Master, variable, value, units)
% 
% Description :
% -------------
% Allows to modify an existing slave boundary.
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% Name     - name of the slave boundary.
% Master   - name of the master boundary assigned to the slave boundary.
% values   - (cell array) {Phi, Theta}. Can be char.
% variable - parameter that it is edited.
% units    - (Optional) units of the variable (specify using either 'deg',
%            'rad' or anything else defined in HFSS).
%
% Note :
% ------
% Currently, it only allows to edit the scan angle (theta and phi).
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssEditSlave(fid, 'Slave1', 'Master1', 'UseScanAngles', ...
%    [60, 35], {'deg', 'deg'});
% hfssSetVariable(fid, 'th', 20, 'deg');
% hfssEditSlave(fid, 'Slave1', 'Master1', 'UseScanAngles', ...
%     {36, 'th'}, {'deg', 'deg'});
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 08-Sep-2020: *Initial release (DRP).
% 22-Dec-2020: *Fix optional units argument (DRP).
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 08 September 2020
% ----------------------------------------------------------------------------
function hfssEditSlave(fid, Name, Master, variable, values, units)
    if (nargin < 6)
        units = [];
    end
    
    % Check some variables.
    if (~iscell(values))
        values = num2cell(values);
    end
    if (~isempty(units) && ~iscell(units))
        units = num2cell(units);
    end
    
    if (numel(values) ~= 2)
        error('Need to provide two values for (phi, theta)');
    end
    if (~isempty(units) && numel(units) ~= 2)
        error('Need to provide two units for (phi, theta)');
    end
    ph = values{1};
    th = values{2};
    
	% Preamble.
	fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');

	% Set the names of the slave and master boundaries.
	fprintf(fid, 'oModule.EditSlave "%s", _\n', Name);
	fprintf(fid, '\tArray("NAME:%s", _\n', Name);
    fprintf(fid, '\t\t"Master:=", "%s", _\n', Master);
    
    switch variable
        case 'UseScanAngles'
            fprintf(fid, '\t\t"UseScanAngles:=", true, _\n');
            if ischar(ph)
                fprintf(fid, '\t\t"Phi:=", "%s", _\n', ph);
            else
                fprintf(fid, '\t\t"Phi:=", "%f%s", _\n', ph, units{1});
            end
            if ischar(th)
                fprintf(fid, '\t\t"Theta:=", "%s")\n', th);
            else
                fprintf(fid, '\t\t"Theta:=", "%f%s")\n', th, units{2});
            end
        otherwise
            error('variable not supported!');
    end
end