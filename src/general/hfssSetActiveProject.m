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
function hfssSetActiveProject(fid, projectName)
	% This function creates the necessary VBScript initializations to use an
	% opened HFSS project. 
	%
	% It is helpful when you generated a HFSS file using a
	% script and want to use another script to edit more. There is no need to
	% close the generated project, just the run the another script.
	%
	% Parameters:
	% fid:			file identifier of the VBScript File.
	% projectName:	Project Name to make active
	%
	% @author Rounak Singh Narde, rounaksingh17@gmail.com or rn5949@rit.edu

	% -------------------------------------------------------------------------- %

    % arguments processor.
    if (nargin < 2)
        error('Insufficient number of arguments !');
    end;
    
    % create the necessary script.
    fprintf(fid, '\n');

    fprintf(fid, 'Set oProject = oDesktop.SetActiveProject("%s")\n', projectName);
