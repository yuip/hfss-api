function hfssAssignLengthOp(fid, Name, Object, MaxLength, Units, Inside,...
    RestrictElem, MaxElem)
    % Creates the VB Script necessary to assign a length-based mesh operation
    % to one object.
    %
    % Parameters :
    % fid:          file identifier of the HFSS script file.
    % Name:         name of the mesh operation.
    % Object:       object to which the mesh operation needs to be applied.
    % MaxLength:    max length of the edges of triangle or tetrahedra.
    % Units:        units of MaxLength, e.g. 'mm'.
    % Inside:       (optional) Boolean which indicates if the mesh operation will be applied
    %                to the surface of the object (MaxLength restricts the edges
    %                of the triangles) or to the volume (MaxLength restricts the
    %                edges of the triangles and tetrahedra). Default is false.
    % RestrictElem: (optional) boolean which indicates if there should be a restriction
    %                in the number of elements. If true, MaxElem should be
    %                specified. Default is false.
    % MaxElem:      (optional) Maximum number of elements to be created by the mesh
    %                if RestrictElem if true. By default is 1000.
    % 
    % Example :
    % @code
    % fid = fopen('myantenna.vbs', 'wt');
    % ... 
    % hfssAssignLengthOp(fid, 'Mesh1', 'Air', Lambda/2, 'mm', true);
    % @endcode
    %
    % @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
    % 
    % @date 04 November 2012

    % ----------------------------------------------------------------------------
    % CHANGELOG
    % 
    % 04-Nove-2012: Initial release.
    % ----------------------------------------------------------------------------

    % arguments processor.
    if (nargin < 5)
    	error('Insufficient number of arguments!');
    elseif (nargin < 6)
    	Inside = false;
        RestrictElem = false;
        MaxElem = 1000;
    elseif (nargin < 7)
        RestrictElem = false;
        MaxElem = 1000;
    elseif (nargin < 8)
        MaxElem = 1000;
    end

    % process Inside
    if Inside
        Inside = 'true';
    else
        Inside = 'false';
    end

    % process RestrictElem
    if RestrictElem
        RestrictElem = 'true';
    else
        RestrictElem = 'false';
    end

    fprintf(fid, 'Set oModule = oDesign.GetModule("MeshSetup")\n');
    fprintf(fid, 'oModule.AssignLengthOp _\n');
    fprintf(fid, 'Array("NAME:%s", _\n', Name);
    fprintf(fid, '"RefineInside:=", %s, _\n', Inside);
    fprintf(fid, '"Enabled:=", true, _\n');
    fprintf(fid, '"Objects:=", Array("%s"), _\n', Object);
    fprintf(fid, '"RestrictElem:=", %s, _\n', RestrictElem);
    fprintf(fid, '"NumMaxElem:=", "%d", _\n', MaxElem);
    fprintf(fid, '"RestrictLength:=", true, _\n');
    fprintf(fid, '"MaxLength:=", "%f%s")\n', MaxLength, Units);s