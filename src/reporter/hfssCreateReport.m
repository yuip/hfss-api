function hfssCreateReport(fid, ReportName, Type, Display, Solution,...
                          Sweep, Context, Domain, VarObj, DataObj)
    % Creates a new report with a single trace and adds it to the Results
    % branch in the project tree.
    %
    % Parameters :
    % fid:          file identifier of the HFSS script file.
    % ReportName:   name of the report.
    % Type:         type of the report (integer 1-6). Possible values are:
    %                * 1: "Modal S Parameters"
    %                * 2: "Terminal S Parameters"
    %                * 3: "Eigenmode Parameters"
    %                * 4: "Fields"
    %                * 5: "Far Fields"
    %                * 6: "Near Fields"
    %                * 7: "Emission Test"
    % Display:      
    %               * if Type is 1-3, then Display's possible values are:
    %                   * 1: "Rectangular Plot"
    %                   * 2: "Polar Plot"
    %                   * 3: "Radiation Pattern"
    %                   * 4: "Smith Chart"
    %                   * 5: "Data Table"
    %                   * 6: "3D Rectangular Plot"
    %                   * 7: "3D Polar Plot"
    %               * if Type is 4, then the possible values are:
    %                   * 1: "Rectangular Plot"
    %                   * 2: "Polar Plot"
    %                   * 3: "Radiation Pattern"
    %                   * 5: "Data Table"
    %                   * 6: "3D Rectangular Plot"
    %               * if Type is 5-6, then the possible values are:
    %                   * 1: "Rectangular Plot"
    %                   * 3: "Radiation Pattern" (Polar)
    %                   * 5: "Data Table"
    %                   * 6: "3D Rectangular Plot"
    %                   * 7: "3D Polar Plot"
    %               * if Type is 7, then the possible values are:
    %                   * 1: "Rectangular Plot"
    %                   * 5: "Data Table"
    % Solution:     name of the solution given to hfssInsertSolution.
    % Sweep:        name of the frequency sweep given to hfssInterpolatingSweep.
    %              This can be an empty string, in which case it will be
    %              used LastAdaptive instead.
    % Context:      context for which the expression is being evaluated. This
    %              can be an empty string if there is no context.
    %              e.g. "Infinite Sphere", "Sphere", "Polyline"
    % Domain:       domain for which th expression is being evaluated. This
    %              can be an empty string if there is no context.
    %              e.g. "Sweep" or "Time"
    % VarObj:       cell array of names of the variables to be used as sweep
    %              definitions for the report, including the frequency/ies.
    %              The first one will be the primary sweep.
    % DataObj:      TODO.
    % 
    % @note This function has to be used AFTER a solution is inserted with
    % hfssInsertSolution.
    %
    % Example :
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... create some objects here ...
    % ... insert far field spheres ...
    % hfssInsertFarFieldSphereSetup(fid, 'EPlaneCutSphere', [0 180 1], [90 90 1]);
    % hfssInsertFarFieldSphereSetup(fid, 'HPlaneCutSphere', [90 90 1], [0 180 1]);
    %
    % hfssCreateReport(fid, 'E Plane Cut (cart.)', 5, 1, 'Solution', [],...
    %                  'EPlaceCutSphere', [], {'Theta', 'Phi', 'Freq'},...
    %                  {'Theta', 'dB(DirTotal)'});
    % hfssCreateReport(fid, 'E Place Cut (polar)', 5, 3, 'Solution', [],...
    %                  'EPlaneCutSphere', [], {'Theta', 'Phi', 'Freq'},...
    %                  {'Theta', 'dB(DirTotal)'});
    % hfssCreateReport(fid, 'H Plane Cut (cart.)', 5, 1, 'Solution', [],...
    %                  'HPlaneCutSphere', [], {'Phi', 'Theta', 'Freq'},...
    %                  {'Phi', 'dB(DirTotal)'});
    % hfssCreateReport(fid, '3D Diagram Cart.', 5, 6, 'Solution', [],...
    %                  'Diagram3D', [], {'Theta', 'Phi', 'Freq'},...
    %                  {'Theta', 'Phi', 'dB(DirTotal)'});
    % hfssCreateReport(fid, '3D Diagram Polar', 5, 7, 'Solution', [],...
    %                  'Diagram3D', [], {'Phi', 'Theta', 'Freq'},...
    %                  {'Phi', 'Theta', 'dB(DirTotal)'});
    % hfssCreateReport(fid, 'Return Loss', 1, 1, 'Solution1', 'Sweep1',...
    %                  [], 'Sweep', {'Freq'}, {'Freq',...
    %                  'db(S(LumpP1,LumpP1))'});
    % @endcode
    %
    % @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
    %
    % @date 23 September 2012
    

    % ----------------------------------------------------------------------------
    % CHANGELOG
    %
    % 25-Sept-2012: *Initial release.
    % 29-Sept-2012: *Added 3D Radiation Patterns.
    % 16-Janu-2013: *Fixed a bug when VarObj had only one item and wasn't
    %                added to the script.
    %               *Added Sweep param.
    %               *Updated examples and added a new one.
    % ----------------------------------------------------------------------------

    % Arguments processor.
    if (nargin < 10)
    	error('Insufficient # of arguments !');
    end

    % Select report type string.
    ReportType = {'Modal S Parameter', 'Terminal S Parameters',...
                  'Eigenmode Parameters', 'Fields', 'Far Fields',...
                  'Near Fields', 'Emission Test'};
    ReportType = ReportType{Type};

    % Check Sweep name, if empty it will be LastAdaptive
    if isempty(Sweep)
        Sweep = 'LastAdaptive';
    end

    % Check for type and display inconsistencies
    if Type == 4 && (Display == 4 || Display == 7)
        error('Error in hfssCreateReport 1');
    end
    if (Type == 5 || Type == 6) && (Display == 2 || Display == 4)
        error('Error in hfssCreateReport 2');
    end
    if Type == 7 && ~(Display == 1 || Display == 5)
        error('Error in hfssCreateReport 3');
    end

    % Select display type string.
    DisplayType = {'Rectangular Plot', 'Polar Plot', 'Radiation Pattern',...
                   'Smith Chart', 'Data Table', '3D Rectangular Plot',...
                   '3D Polar Plot'};
    DisplayType = DisplayType{Display};

    % Check for errors in VarObj
    if ~iscell(VarObj) || numel(VarObj) < 1
        error('Error in hfssCreateReport 4');
    end

    % Preamble.
    fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("ReportSetup")\n');
    fprintf(fid, 'oModule.CreateReport "%s", _\n', ReportName);
    fprintf(fid, '"%s", _\n', ReportType);
    fprintf(fid, '"%s", _\n', DisplayType);
    fprintf(fid, '"%s : %s", _\n', Solution, Sweep);

    % Context parameters
    fprintf(fid, 'Array(');
    flag = false;
    if ~isempty(Context)
        fprintf(fid, '"Context:=", "%s"', Context);
        flag = true;
    end
    if ~isempty(Domain)
        if flag
            fprintf(fid, ', ');
        end
        fprintf(fid, '"Domain:=", "%s"', Domain);
    end
    fprintf(fid, '), _\n');

    % Families array parameters
    fprintf(fid, 'Array('); % TODO: apart from "All", allow other values.
    if numel(VarObj) > 1
        for i = 1:numel(VarObj)-1
            fprintf(fid, '"%s:=", Array("All"), _\n', VarObj{i});
        end
        fprintf(fid, '"%s:=", Array("All")), _\n', VarObj{i+1});
    else
        fprintf(fid, '"%s:=", Array("All")), _\n', VarObj{1});
    end

    % Report data array parameters.
    % Depending on the Report Type, the syntax changes.
    fprintf(fid, 'Array(');
    if Display == 1 % Rectangular plot
        fprintf(fid, '"X Component:=", "%s", _\n', DataObj{1});
        fprintf(fid, '"Y Component:=", Array("%s")), _\n', DataObj{2});
    elseif Display == 2 % Polar Plot
        error('Error in hfssCreateReport: display not supported');
    elseif Display == 3 % Radiation Pattern
        fprintf(fid, '"Ang Component:=", "%s", _\n', DataObj{1});
        fprintf(fid, '"Mag Component:=", Array("%s")), _\n', DataObj{2});
    elseif Display == 4 % Smith Chart
        error('Error in hfssCreateReport: display not supported');
    elseif Display == 5 % Data Table
        error('Error in hfssCreateReport: display not supported');
    elseif Display == 6 % 3D Rectangular Plot
        fprintf(fid, '"X Component:=", "%s", _\n', DataObj{1});
        fprintf(fid, '"Y Component:=", "%s", _\n', DataObj{2});
        fprintf(fid, '"Z Component:=", Array("%s")), _\n', DataObj{3});
    elseif Display == 7 % 3D Polar Plot
        fprintf(fid, '"Phi Component:=", "%s", _\n', DataObj{1});
        fprintf(fid, '"Theta Component:=", "%s", _\n', DataObj{2});
        fprintf(fid, '"Mag Component:=", Array("%s")), _\n', DataObj{3});
    else
        error('Error in hfssCreateReport: Display = wrong value');
    end
    fprintf(fid, 'Array()\n');