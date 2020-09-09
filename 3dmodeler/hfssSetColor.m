% ----------------------------------------------------------------------------
% function hfssSetColor(fid, Objects, Color)
% 
% Description :
% -------------
% Creates the VBScript necessary to set an object's color in HFSS. 
%
% Parameters :
% ------------
% fid     - file identifier of the HFSS script file.
% Objects - cell array with name(s) of the object(s) whose color require(s)
%           to be changed.
% Color   - [3x1 vector] represents the [R, G, B] components of the color.
% 
% Note :
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssSetColor(fid, 'Substrate', [0, 64, 0]);
% hfssSetColor(fid, {'Sub1', 'Sub2'}, [0, 64, 0]);
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% ??-???-????: *Initial release.
% 09-Sep-2020: *It can set a color to several objects simultaneously.
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
function hfssSetColor(fid, Objects, Color)

if (~iscell(Objects))
    Objects = cellstr(Objects);
end

fprintf(fid, '\n');
fprintf(fid, 'oEditor.ChangeProperty _\n');
fprintf(fid, '\tArray("NAME:AllTabs", _\n');
fprintf(fid, '\t\tArray("NAME:Geometry3DAttributeTab", _\n');
fprintf(fid, '\t\t\tArray("NAME:PropServers", ');

for n = 1:numel(Objects)-1
    fprintf(fid, '"%s", ', Objects{n});
end
fprintf(fid, '"%s"), _\n', Objects{end});

fprintf(fid, '\t\t\tArray("NAME:ChangedProps",  _\n');
fprintf(fid, '\t\t\t\tArray("NAME:Color", "R:=", %d, "G:=", %d, "B:=", %d) _\n', ...
        Color(1), Color(2), Color(3));
fprintf(fid, '\t\t\t) _\n');
fprintf(fid, '\t\t) _\n');
fprintf(fid, '\t) \n');