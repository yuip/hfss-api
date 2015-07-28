function hfssAssignFloquetPort(fid, Name, ObjName, Deembed, ...
         Phi, Theta, iAStart, iAEnd, iBStart, iBEnd, Units, Ref)
	% Creates the necessary VB Script to assign a Floquet Port to a given Object.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		name of the floquet port (appears under 'Excitations' in HFSS).
	% ObjName:	name of the (sheet-like) object to which the floquet port is to 
	%           be assigned.
	% Deembed:	(scalar) distance for deembeding the port. It accepts 0.
	% Phi:		(degrees) scan angle phi.
	% Theta:	(degrees) scan angle theta.
	% iAStart:	(vector) starting point of the Lattice A direction. Specify as
	%           [x, y, z].
	% iAEnd:	(vector) ending point of the Lattice A direction. Specify as
	%           [x, y, z].
	% iBStart:	(vector) starting point of the Lattice B direction. Specify as
	%           [x, y, z].
	% iBEnd:	(vector) ending point of the Lattice B direction. Specify as
	%           [x, y, z].
	% Units:	specify as 'meter', 'in', 'cm' (defined in HFSS).
	% Ref:		(boolean, optional) enables 3D Refinement for Floquet modes.
	%           Defaults to false.
	%
	% @note It sets up only the default specular pair of nodes.
	%
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssAssignMaster(fid, 'FloquetPort', 'Sheet', 0, 0, [-width/2, 0, 0], ...
	%	               [width/2, 0, 0], [0, -height/2, 0], [0, height/2, 0], ...
	%                  'meter');
	% @endcode
	%
	% @author Pablo Alcon Garcia, pabloalcongarcia@gmail.com / palcon@tsc.uniovi.es
	% @date 21 May 2013

	% arguments processor.
	if (nargin < 11)
		error('Insufficient # of arguments !');
	elseif (nargin < 12)
	    Ref = false;
	end

	if Ref
	    Ref = 'true';
	else
	    Ref = 'false';
	end

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');

	% Parameters
	fprintf(fid, 'oModule.AssignFloquetPort _\n');
	fprintf(fid, 'Array("NAME:%s", _\n', Name);
	fprintf(fid, '\t"Objects:=", Array("%s"), _\n', ObjName);
	fprintf(fid, '\t"NumModes:=", 2, _\n');
	fprintf(fid, '\t"RenormalizeAllTerminals:=", true, _\n');
	fprintf(fid, '\t"DoDeembed:=", true, _\n');
	fprintf(fid, '\t"DeembedDist:=", "%f%s", _\n',Deembed, Units);
	fprintf(fid, '\tArray("NAME:Modes", _\n');
	fprintf(fid, '\t\tArray("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=", false), _\n');
	fprintf(fid, '\t\tArray("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=", false) _\n');
	fprintf(fid, '\t\t), _\n');
	fprintf(fid, '\t"ShowReporterFilter:=", false, "UseScanAngles:=", true, _\n');
	fprintf(fid, '\t"Phi:=", "%fdeg", "Theta:=", "%fdeg", _\n',Phi,Theta);
	fprintf(fid, '\tArray("NAME:LatticeAVector", "Start:=", _\n');
	fprintf(fid, '\t\tArray("%f%s", "%f%s", "%f%s"), _\n', ...
	        iAStart(1), Units, iAStart(2), Units, iAStart(3), Units);
	fprintf(fid, '\t\t"End:=", Array("%f%s", "%f%s", "%f%s") _\n', ...
	        iAEnd(1), Units, iAEnd(2), Units, iAEnd(3), Units);
	fprintf(fid, '\t\t), _\n');
	fprintf(fid, '\tArray("NAME:LatticeBVector", "Start:=", _\n');
	fprintf(fid, '\t\tArray("%f%s", "%f%s", "%f%s"), _\n', ...
	        iBStart(1), Units, iBStart(2), Units, iBStart(3), Units);
	fprintf(fid, '\t\t"End:=", Array("%f%s", "%f%s", "%f%s") _\n', ...
	        iBEnd(1), Units, iBEnd(2), Units, iBEnd(3), Units);
	fprintf(fid, '\t\t), _\n');
	fprintf(fid, '\tArray("NAME:ModesList", _\n');
	fprintf(fid, '\t\tArray("NAME:Mode", "ModeNumber:=",1, _\n');
	fprintf(fid, '\t\t\t"IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, _\n');
	fprintf(fid, '\t\t\t"PropagationState:=", "Propagating", _\n');
	fprintf(fid, '\t\t\t"Attenuation:=", 0, "PolarizationState:=", "TE", _\n');
	fprintf(fid, '\t\t\t"AffectsRefinement:=", %s _\n', Ref);
	fprintf(fid, '\t\t\t), _\n');
	fprintf(fid, '\t\tArray("NAME:Mode", "ModeNumber:=",2, _\n');
	fprintf(fid, '\t\t\t"IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, _\n');
	fprintf(fid, '\t\t\t"PropagationState:=", "Propagating", _\n');
	fprintf(fid, '\t\t\t"Attenuation:=", 0, "PolarizationState:=", "TM", _\n');
	fprintf(fid, '\t\t\t"AffectsRefinement:=", %s _\n', Ref);
	fprintf(fid, '\t\t\t) _\n');
	fprintf(fid, '\t\t) _\n');
	fprintf(fid, '\t)\n');