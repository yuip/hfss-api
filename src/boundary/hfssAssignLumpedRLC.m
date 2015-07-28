function hfssAssignLumpedRLC(fid, Name, ObjName, UseResist, UseInduct, UseCap, ...
                             Resist, Induct, Cap, iStart, iEnd, Units)
    % Creates the necessary VB Script to assign a Lumped LRC to a given Object.
    %
    % Parameters :
    % fid:          file identifier of the HFSS script file.
    % Name:         name of the lumped RLC (appears under 'Boundaries' in HFSS).
    % ObjName:      name of the (sheet-like) object to which the floquet port is to 
    %               be assigned.
    % UseResist:    (boolean) enables Lumped RLC boundary as Resistance
    % UseInduct:    (boolean) enables Lumped RLC boundary as Inductance
    % UseCap:       (boolean) enables Lumped RLC boundary as Capacitance
    % iStart:       (vector) starting point of the Current Flow Line. Specify as
    %               [x, y, z].
    % iEnd:         (vector) ending point of the Current Flow Line. Specify as
    %               [x, y, z].
    % Resist:       Resistance value
    % Induct:       Inductance value
    % Cap:          Capacitance value
    % Units:        (cell vector){resistance, inductance, capacitance, distance}
    %              specifies units for Resistance, Capacitance, Inductance and 
    %              position vectors. 
    %              * Possible values for Resistance units are uOhm, mOhm, ohm, 
    %              kOhm, megohm and GOhm.
    %              * Possible values for Inductance units are fH, pH, nH, mH and
    %              H.
    %              * Possible values for Capacitance units are fF, pF, nF, mF and
    %              farad.
    %
    % @note Every parameter is mandatory. If any of the three LRC conditions is set
    % to false, its correspondent value and unit are not read.
    %
    % Example :
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... 
    % hfssAssignLumpedRLC(fid, 'RLC1', 'Sheet', true, true, false, 10, 2, 0,...
    %                  [-width/2, 0, 0], [width/2, 0, 0], {'ohm', 'nH, ...
    %                  'pF', 'mm'});
    % @endcode
    %
    % @author Pablo Alcon Garcia, pabloalcongarcia@gmail.com / palcon@tsc.uniovi.es
    % @date 25 Sep 2013

    % ----------------------------------------------------------------------------
    % CHANGELOG
    %
    % 25-Sep-2013: *Initial release.
    % 12-Nov-2013: *Fixed crash when not defining a capacitance
    % ----------------------------------------------------------------------------

    % arguments processor.
    if (nargin < 12)
    	error('Insufficient # of arguments !');
    end

    if UseResist
        UseResistString = 'true';
    else
        UseResistString = 'false';
    end
    if UseInduct
        UseInductString = 'true';
    else
        UseInductString = 'false';
    end
    if UseCap
        UseCapString = 'true';
    else
        UseCapString = 'false';
    end
    % Preamble.
    fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');

    % Parameters
    fprintf(fid, 'oModule.AssignLumpedRLC _\n');
    fprintf(fid, 'Array("NAME:%s", _\n', Name);
    fprintf(fid, '\t"Objects:=", Array("%s"), _\n', ObjName);
    fprintf(fid, '\tArray("NAME:CurrentLine", "Start:=", _\n');
    fprintf(fid, '\t\tArray("%.4f%s", "%.4f%s", "%.4f%s"), _\n', ...
            iStart(1), Units{4}, iStart(2), Units{4}, iStart(3), Units{4});
    fprintf(fid, '\t\t"End:=", Array("%.4f%s", "%.4f%s", "%.4f%s") _\n', ...
            iEnd(1), Units{4}, iEnd(2), Units{4}, iEnd(3), Units{4});
    fprintf(fid, '\t\t), _\n');
    fprintf(fid, '\t"UseResist:=", %s, _\n',UseResistString);
    if UseResist
        fprintf(fid, '\t"Resistance:=", "%.4f%s", _\n', Resist, Units{1});
    end
    fprintf(fid, '\t"UseInduct:=", %s, _\n',UseInductString);
    if UseInduct
        fprintf(fid, '\t"Inductance:=", "%.4f%s", _\n', Induct, Units{2});
    end
    if UseCap
        fprintf(fid, '\t"UseCap:=", %s, _\n',UseCapString);
        fprintf(fid, '\t"Capacitance:=", "%.4f%s" _\n', Cap, Units{3});
    else
        fprintf(fid, '\t"UseCap:=", %s _\n',UseCapString);
    end
    fprintf(fid, '\t)');