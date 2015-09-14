function hfssInsertFarFieldSphereSetup(fid, Name, Theta, Phi, WCS)
	% Creates the VB Script necessary to rotate a given set of objects.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		Name of the Far Field setup.
	% Theta:	Azimuthal angles [start, stop, step]
	% Phi:		Elevation angles [start, stop, step]
	% WCS:		(optional)Name of the WCS coordinate system. Default is 'Global'
	% 
	% Example :
	% @code
	% fid = fopen('myantenna.vbs', 'wt');
	% ... 
	% hfssInsertFarFieldSphereSetup(fid, 'Radiation', {'Dipole1', 'Dipole2'}, 'X', -30);
	% @endcode
	%
	% @author Daniel R. Prado, danysan@gmail.com / drprado@tsc.uniovi.es
	% @date 23 September 2012
	
	% ----------------------------------------------------------------------------
	% CHANGELOG
	%
	% 25-Sept-2012: *Initial release.
	% ----------------------------------------------------------------------------

	useLocalCS = true;

	% arguments processor.
	if (nargin < 4)
		error('Insufficient # of arguments !');
	elseif (nargin < 5)
		WCS = [];
	    useLocalCS = false;
	end

	% default arguments.
	if isempty(WCS)
		WCS = 'Global';
	end

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'Set oModule = oDesign.GetModule("RadField")\n');
	fprintf(fid, 'oModule.InsertFarFieldSphereSetup _\n');
	fprintf(fid, 'Array("NAME:%s", _\n', Name);

	% Parameters
	fprintf(fid, '"UseCustomRadiationSurface:=", false, _\n');
	fprintf(fid, '"ThetaStart:=", "%fdeg", _\n', Theta(1));
	fprintf(fid, '"ThetaStop:=", "%fdeg", _\n', Theta(2));
	fprintf(fid, '"ThetaStep:=", "%fdeg", _\n', Theta(3));
	fprintf(fid, '"PhiStart:=", "%fdeg", _\n', Phi(1));
	fprintf(fid, '"PhiStop:=", "%fdeg", _\n', Phi(2));
	fprintf(fid, '"PhiStep:=", "%fdeg", _\n', Phi(3));
	if useLocalCS
	    fprintf(fid, '"UseLocalCS:=", true, _\n');
	    fprintf(fid, '"CoordSystem:=", "%s")\n', WCS);
	else
	    fprintf(fid, '"UseLocalCS:=", false)\n');
	end