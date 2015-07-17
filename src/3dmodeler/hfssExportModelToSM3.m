% ----------------------------------------------------------------------------
% function hfssExportModelToSM3(fid, FilePath, MajorVersion, MinorVersion)
% 
% Written by:
% -----------
% Rounak Singh Narde (rn5949@rit.edu)
%
% Description :
% -------------
% Create the VB Script necessary to export the 3D model to Ansoft 3D model
% file. 
%
% Parameters :
% ------------
% fid           - file identifier of the HFSS script file.
% FilePath      - FilePath with filename and extension(.sm3)
% MajorVersion  - Major Version for sm3 file. (default=22)
% MinorVersion  - Minor Version for sm3 file. (default=0)
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% % Export 3D model to a sm3 file
% hfssExportModelToSM3(fid, 'C:\Users\test1234\Documents\exportToMe.sm3');
% 
% or
% hfssExportModelToSM3(fid, 'C:\Users\test1234\Documents\exportToMe.sm3',
% 21,0);
% ----------------------------------------------------------------------------

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
function hfssExportModelToSM3(fid, FilePath, MajorVersion, MinorVersion)
    
    % arguments processor.
    if (nargin < 2)
        error('Insufficient # of arguments !');
    elseif (nargin < 3)
        MajorVersion = [];
        MinorVersion = [];
    elseif (nargin < 4)
        MinorVersion=[];
    end;

    % default arguments.
    if isempty(MajorVersion)
        MajorVersion=22;
    end;
    if isempty(MinorVersion)
        MinorVersion=0;
    end;
    
    
    % Preamble.
    fprintf(fid, '\n');
    fprintf(fid, 'oEditor.Export _\n');
    
    fprintf(fid, 'Array("NAME:ExportParameters", _\n');
    fprintf(fid, '"File Name:=", _\n');
    fprintf(fid, '"%s", _\n', FilePath);
    fprintf(fid, '"Major Version:=", %d,_\n', MajorVersion);
    fprintf(fid, '"Minor Version:=", %d)\n', MinorVersion);
    
end