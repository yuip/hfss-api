% ----------------------------------------------------------------------------
% function hfssSweepAlongVector(fid, Object2D, Vector, Units, ...
%                             [DraftAngle = 0 deg], [DraftType = 'Round'])
%
% Description:
% ------------
% Creates the VB Script necessary to sweep a 2D object along the given vector
% to create a 3D object. 
% 
% Parameters:
% -----------
% fid        - file identifier of the HFSS script file.
% Object2D   - name of the 2D Object to be sweeped.
% Vector     - vector along which Object2D is to be sweeped.
% Units      - Units of the vector (specify using either 'in', 'mm', 'meter'
%              or anything else defined in HFSS).
% DraftAngle - angle (in *deg*) to which the object's profile, or shape is 
%              expanded (or contracted) as it is swept.
% DraftType  - set it to either 'Round' (default), 'Extended' or 'Natural'
%              (consult the HFSS Help for more info).
%							 
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 07-Aug-2014: *Initial release.
% 06-Oct-2014: *Fixed help text.
% 06-Sep-2024: *Don't limit to four decimal places the sweep vector. 
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado@tsc.uniovi.es
% 07 August 2014
% ----------------------------------------------------------------------------

function hfssSweepAlongVector(fid, Object, Vector, Units, ...
                             DraftAngle, DraftType)

% arguments processor.
if (nargin < 4)
	error('Not enough arguments !');
elseif (nargin < 5)
	DraftAngle = 0;
	DraftType = 'Round';
elseif (nargin < 6)
	DraftType = 'Round';
end

% default arguments.
if isempty(DraftAngle)
	DraftAngle = 0;
end
if isempty(DraftType)
	DraftType = 'Extended';
end

fprintf(fid, '\n');

fprintf(fid, 'oEditor.SweepAlongVector _\n');
fprintf(fid, '\tArray("NAME:Selections", "Selections:=", "%s", ', Object);
fprintf(fid, '"NewPartsModelFlag:=", "Model"), _\n');
fprintf(fid, '\tArray("NAME:VectorSweepParameters", _\n');
fprintf(fid, '\t\t"DraftAngle:=", "%fdeg", _\n', DraftAngle);
fprintf(fid, '\t\t"DraftType:=", "%s", _\n', DraftType);
fprintf(fid, '\t\t"CheckFaceFaceIntersection:=", false, _ \n');
fprintf(fid, '\t\t"SweepVectorX:=", "%f%s", _\n', Vector(1), Units);
fprintf(fid, '\t\t"SweepVectorY:=", "%f%s", _\n', Vector(2), Units);
fprintf(fid, '\t\t"SweepVectorZ:=", "%f%s")\n', Vector(3), Units);