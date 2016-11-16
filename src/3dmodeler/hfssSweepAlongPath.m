function hfssSweepAlongPath(fid, Object, Path, ...
                             DraftAngle, DraftType, TwistAngle)
	% Creates the VB Script necessary to sweep a 2D object along the given vector
	% to create a 3D object. 
	% 
	% Parameters:
	% fid:			file identifier of the HFSS script file.
	% Object:		name of the 2D Object to be sweeped.
    % Path:         name of the 1D path along which HFSS sweeps.
	% DraftAngle:	(optional) Angle (in *deg*) to which the object's profile, or shape is 
	%              expanded (or contracted) as it is swept. Default value is 0 deg
	% DraftType:	(optional) set it to either 'Round' (default), 'Extended' or 'Natural'
	%              Default value is Round. (consult the HFSS Help for more info)
	% TwistAngle:	(optional) Angle (in *deg*) to which the object's profile, or shape is 
	%              twisted as it is swept. Default value is 0 deg

	% arguments processor.
	if (nargin < 3)
		error('Not enough arguments !');
	elseif (nargin < 4)
		DraftAngle = 0;
		DraftType = 'Round';
        TwistAngle = 0;
	elseif (nargin < 5)
		DraftType = 'Round';
        TwistAngle = 0;
    elseif (nargin < 6)
        TwistAngle = 0;
	end;
    
	% default arguments.
	if isempty(DraftAngle)
		DraftAngle = 0;
	end;
	if isempty(DraftType)
		DraftType = 'Round';
	end;
	if isempty(TwistAngle)
		TwistAngle= 0;
	end;
    
	fprintf(fid, '\n');

	fprintf(fid, 'oEditor.SweepAlongPath _\n');
	fprintf(fid, 'Array("NAME:Selections", "Selections:=", "%s,%s", _\n', Object, Path);
    fprintf(fid, '"NewPartsModelFlag:=", "Model"), _\n');
	fprintf(fid, 'Array("NAME:PathSweepParameters", _\n');
	fprintf(fid, '"DraftAngle:=", "%fdeg", _\n', DraftAngle);
	fprintf(fid, '"DraftType:=", "%s", _\n', DraftType);
    fprintf(fid, '"CheckFaceFaceIntersection:=", false, _\n');
    fprintf(fid, '"TwistAngle:=", "%fdeg") \n', TwistAngle);