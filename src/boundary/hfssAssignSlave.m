function hfssAssignSlave(fid, Name, ObjName, iUStart, iUEnd, Units, Master, ReverseV)
    % Creates the necessary VB Script to assign a Slave Boundary to a given Object.
    %
    % Parameters :
    % fid:      file identifier of the HFSS script file.
    % Name:     name of the slave boundary (appears under 'Boundaries' in HFSS).
    % ObjName:  name of the (sheet-like) object to which the slave boundary is to 
    %           be assigned.
    % iUStart:  (vector) starting point of the U vector. Specify as
    %           [x, y, z].
    % iUEnd:    (vector) ending point of the U vector. Specify as
    %           [x, y, z].
    % Units:    specify as 'meter', 'in', 'cm' (defined in HFSS).
    % Master:   master of this slave
    % ReverseV:   (boolean, optional) reverses vector V (defaults to 
    %                true if the U vector points +y, and to false elsewise)
    %
    % Example :
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... 
    % hfssAssignMaster(fid, 'Master', 'Sheet', [-width/2, 0, 0], ...
    %                    [width/2, 0, 0], 'meter', false);
    % @endcode
    % 
    % @author Pablo Alcon Garcia, pabloalcongarcia@gmail.com / palcon@tsc.uniovi.es
    %
    % @date 21 May 2013

    % arguments processor.
    if (nargin < 7)
    	error('Insufficient # of arguments !');
    elseif (nargin < 8)
        if iUEnd(2)~=iUStart(2)
            ReverseV = true;
        else
            ReverseV = false;
        end
    end

    if ReverseV
        ReverseV = 'true';
    else
        ReverseV = 'false';
    end

    % Preamble.
    fprintf(fid, '\n');
    fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');

    % Parameters
    fprintf(fid, 'oModule.AssignSlave _\n');
    fprintf(fid, 'Array("NAME:%s", _\n', Name);
    fprintf(fid, '\t"Objects:=", Array("%s"), _\n', ObjName);
    fprintf(fid, '\tArray("NAME:CoordSysVector", "Origin:=", _\n');
    fprintf(fid, '\t\tArray("%f%s", "%f%s", "%f%s"), _\n', ...
            iUStart(1), Units, iUStart(2), Units, iUStart(3), Units);
    fprintf(fid, '\t\t"UPos:=", Array("%f%s", "%f%s", "%f%s") _\n', ...
            iUEnd(1), Units, iUEnd(2), Units, iUEnd(3), Units);
    fprintf(fid, '\t\t), _\n');
    fprintf(fid, '\t"ReverseV:=", %s, _\n', ReverseV);
    fprintf(fid, '\t"Master:=", "%s", _\n', Master);
    fprintf(fid, '\t"UseScanAngles:=", true, "Phi:=", "0deg", "Theta:=", "0deg" _\n');
    fprintf(fid, '\t)\n');
