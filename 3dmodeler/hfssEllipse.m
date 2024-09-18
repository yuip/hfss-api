% ----------------------------------------------------------------------------
% function hfssEllipse(fid, Name, Axis, Center, MajRadius, Ratio, Units, [NumSegments])
% 
% Description :
% -------------
% Create the VB Script necessary to construct an ellipse using the HFSS
% 3D Modeler.
%
% Parameters :
% ------------
% fid         - file identifier of the HFSS script file.
% Name        - name of the ellipse object (appears in the HFSS objects tree).
% Axis        - axis that is normal to the rectangle object.
% Center      - center of the ellipse. Specify as [sx, sy, sz].
% MajRadius   - (scalar) the width of the rectangle. If the axis is 'X' then this 
%               represents the Y-axis size of the rectangle, and so on.
% Ratio       - (scalar) aspect ratio of the secondary radius to the major radius.
% Units       - specify as 'in', 'meter', 'mm', ... or anything else defined in HFSS.
% NumSegments - (optional) number of segments to draw the ellipse. By default it is 0.
%
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% % in this example, Y-axis size is 10in and Z-axis size is 20in.
% hfssEllipse(fid, 'Ellipse1', 'Z', [0,0,0], 10, 0.5, 'mm');
%
% ----------------------------------------------------------------------------

% ----------------------------------------------------------------------------
% Written by Daniel R. Prado
% danysan@gmail.com / drprado.tsc@gmail.com
% 18 September 2024
% ----------------------------------------------------------------------------
function hfssEllipse(fid, Name, Axis, Center, MajRadius, Ratio, Units, NumSegments)

if nargin < 8
    NumSegments = 0;
end

Transparency = 0.75;

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateEllipse _\n');

% Rectangle Parameters.
fprintf(fid, 'Array("NAME:EllipseParameters", _\n');
fprintf(fid, '"IsCovered:=", true, _\n');
fprintf(fid, '"XCenter:=", "%f%s", _\n', Center(1), Units);
fprintf(fid, '"YCenter:=", "%f%s", _\n', Center(2), Units);
fprintf(fid, '"ZCenter:=", "%f%s", _\n', Center(3), Units);

fprintf(fid, '"MajRadius:=", "%f%s", _\n', MajRadius, Units);
fprintf(fid, '"Ratio:=", "%f", _\n', Ratio);

fprintf(fid, '"WhichAxis:=", "%s", _\n', upper(Axis));
fprintf(fid, '"NumSegments:=", "%d"), _\n', NumSegments);


% Ellipse Attributes.
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(132 132 193)", _\n');
fprintf(fid, '"Transparency:=", %d, _\n', Transparency);
fprintf(fid, '"PartCoordinateSystem:=", "Global")\n');