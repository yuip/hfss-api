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
function hfssAddMaterial(fid, Name, Er, bSigma, tanDelta)
	% Creates VB Script necessary to add a new material to the HFSS Materials
	% Manager.
	%
	% Parameters :
	% fid:		file identifier of the HFSS script file.
	% Name:		name of the material to be added.
	% Er:		dielectric constant of the material to be added.
	% bSigma:	bulk conductivity of the material to be added (Siemens)
	% tanDelta:	loss tangent of the material.
	% 
	% @note
	% If a material with the given name already exists in HFSS, this code will
	% have no effect and the script will continue running. A warning message will
	% appear in the HFSS message log.
	%
	% Example :
	% @code
	% fid = fopen('Dipole.vbs', 'wt');
	% ...
	% hfssAddMaterial(fid, 'CoaxDielectric', 2.07, 0, 0);
	% @endcode

	% Preamble.
	fprintf(fid, '\n');
	fprintf(fid, 'oProject.AddMaterial _\n');

	% Name.
	fprintf(fid, 'Array("NAME:%s", _\n', Name);

	% Dielectric Properties.
	fprintf(fid, '"permittivity:=", "%f", _\n', Er);
	fprintf(fid, '"conductivity:=", "%f", _\n', bSigma); 
	fprintf(fid, '"dielectric_loss_tangent:=", "%f")\n', tanDelta);
