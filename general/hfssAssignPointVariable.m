% ----------------------------------------------------------------------------
% function hfssAssignPointVariable(fid, Name, segment, point, variables)
% 
% Description :
% -------------
% Create the VB Script necessary to assign a local variable to a polyline
% point in HFSS.
%
% Parameters :
% ------------
% fid      - File identifier of the HFSS script file.
% Name     - Name of the object to which the variable will be assigned.
% segment  - Segment of the polyline, starting in 0.
% point    - Point of the polyline. It can be 1 or 2.
% variable - The name of the variable to be assigned.
%
% Note : 
% ------
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssAssignPointVariable(fid, 'Polyline1', 0, 2, {'x1','y1','0mm'});
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% CHANGELOG
%
% 21-Apr-2021: *Initial release (DRP).
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel Rodriguez Prado
% danysan@gmail.com
% 21 April 2021
% ----------------------------------------------------------------------------
function hfssAssignPointVariable(fid, Name, segment, point, variables)
	% Preamble.
	fprintf(fid, '\n');

	% Change the variable name
	fprintf(fid, 'oEditor.ChangeProperty _\n');
	fprintf(fid, 'Array("NAME:AllTabs", _\n');
	fprintf(fid, 'Array("NAME:Geometry3DPolylineTab", _\n');
	fprintf(fid, 'Array("NAME:PropServers",  _\n');
    fprintf(fid, '"%s:CreatePolyline:2:Segment%u"), _\n', Name, segment);

    
	fprintf(fid, 'Array("NAME:ChangedProps", _\n');
    fprintf(fid, 'Array("NAME:Point%u", _\n', point);
    fprintf(fid, '"X:=", "%s", _\n', variables{1});
    fprintf(fid, '"Y:=", "%s", _\n', variables{2});
    fprintf(fid, '"Z:=", "%s"))))\n', variables{3});