% ----------------------------------------------------------------------------
% This file is part of HFSS-MATLAB-API.
%
% HFSS-MATLAB-API is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the Free 
% Software Foundation; either version 2 of the License, or (at your option) 
% any later version.
%
% HFSS-MATLAB-API is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
% or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
% for more details.
%
% You should have received a copy of the GNU General Public License along with
% Foobar; if not, write to the Free Software Foundation, Inc., 59 Temple 
% Place, Suite 330, Boston, MA  02111-1307  USA
%
% Copyright 2004, Vijay Ramasami (rvc@ku.edu)
% ----------------------------------------------------------------------------
function hfssSweepAroundAxis(fid, Object, Axis, SweepAngle, ...
                             DraftAngle, DraftType)
	% function hfssSweepAroundAxis(fid, Object2D, Axis, SweepAngle, ...
	%                             [DraftAngle = 0 deg], [DraftType = 'Round'])
	%
	% Description:
	% ------------
	% Creates the VB Script necessary to sweep a 2D object around the given axis
	% to create a 3D object. 
	% 
	% Parameters:
	% -----------
	% fid:			file identifier of the HFSS script file.
	% Object2D:		name of the 2D Object to be sweeped.
	% Axis:			axis around which Object2D is to be sweeped.
	% SweepAngle:	angle (in *deg*) over which the object is to be sweeped.
	% DraftAngle:	(optional) Angle (in *deg*) to which the object's profile, or shape is 
	%              expanded (or contracted) as it is swept. Default value is 0 *deg*.
	% DraftType:	(optional) set it to either 'Round' (default), 'Extended' or 'Natural'
	%              (consult the HFSS Help for more info).

	% arguments processor.
	if (nargin < 4)
		error('Not enough arguments !');
	elseif (nargin < 5)
		DraftAngle = 0;
		DraftType = 'Round';
	elseif (nargin < 6)
		DraftType = 'Round';
	end;

	% default arguments.
	if isempty(DraftAngle)
		DraftAngle = 0;
	end;
	if isempty(DraftType)
		DraftType = 'Round';
	end;

	fprintf(fid, '\n');

	fprintf(fid, 'oEditor.SweepAroundAxis _\n');
	fprintf(fid, '\tArray("NAME:Selections", "Selections:=", "%s"), _\n', Object);
	fprintf(fid, '\tArray("NAME:AxisSweepParameters", _\n');
	fprintf(fid, '\t\t"DraftAngle:=", "%fdeg", _\n', DraftAngle);
	fprintf(fid, '\t\t"DraftType:=", "%s", _\n', DraftType);
	fprintf(fid, '\t\t"SweepAxis:=", "%s", _\n', Axis);
	fprintf(fid, '\t\t"SweepAngle:=", "%fdeg")\n', SweepAngle);
