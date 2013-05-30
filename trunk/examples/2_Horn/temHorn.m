clc; clear all; close all;

% HFSS Executable Path.
hfssExePath = 'E:\HFSSv15\HFSS15.0\Win64\hfss.exe';

% Script and project files.
tmpPrjFile = [pwd, '\temHornEPlaneArraySnow.hfss'];
tmpScriptFile = [pwd, '\temHornMacro.vbs'];

snow = true;
nElements = 4;
dAnt = 604; %mm
arrayDirection = 'E-Plane';

% Add paths to the required m-files.
addpath('../../');
hfssIncludePaths('../../');

% Create a new temporary HFSS script file.
fid = fopen(tmpScriptFile, 'wt');

% Create a new HFSS Project and insert a new design.
hfssNewProject(fid);
hfssInsertDesign(fid, 'Basic');

% Load the tem polyline points.
data = csvread('temHornPoints.csv');
xP = data(:, 1);
yP = data(:, 2);
zP = data(:, 3);

% General parameters.
scale = 0.73;
feedLength = scale*150;

% Scale the points.
Length = 500;
xP = xP*scale*Length;
yP = yP*scale;
zP = zP*scale;

% Freq. parameters
fSolve = 120e6;
wSolve = 3e8/fSolve;
wSolve = wSolve*1000;

% AirBox parameters.
if strcmp(arrayDirection, 'H-Plane')
	maxAntZ = 2*zP(end);
	maxAntY = dAnt*(nElements-1) + 2*yP(end);
elseif strcmp(arrayDirection, 'E-Plane')
	maxAntZ = dAnt*(nElements-1) + 2*zP(end);
	maxAntY = 2*yP(end);
else
	error('Array direction is unknown !');
end;
AirY = maxAntY + wSolve;
AirZ = maxAntZ + wSolve;
AirXfront = xP(end) + wSolve/2;
AirXback = feedLength + wSolve/2;

% Air Box.
hfssBox(fid, 'AirBox', [-AirXback, -AirY/2, -AirZ/2], ...
    [AirXback + AirXfront, AirY, AirZ], 'mm');
hfssAssignRadiation(fid, 'ABC', 'AirBox');
hfssSetTransparency(fid, {'AirBox'}, 0.95);

% Snow Box.
SnowY = AirY;
SnowZ = AirZ;
SnowXfront = xP(end);
SnowXback = AirXfront;
hfssBox(fid, 'SnowBox', [SnowXfront, -SnowY/2, -SnowZ/2], ...
    [SnowXback - SnowXfront, SnowY, SnowZ], 'mm');
hfssSetTransparency(fid, {'SnowBox'}, 0.85);
hfssAddMaterial(fid, 'Snow', 1.7, 0, 0);
hfssAssignMaterial(fid, 'SnowBox', 'Snow');

% Create two polylines and connect
hfssPolyline(fid, 'HornEdge1', [xP, yP, zP], 'mm', 'Spline');
hfssPolyline(fid, 'HornEdge2', [xP, -yP, zP], 'mm', 'Spline');
hfssConnect(fid, {'HornEdge1', 'HornEdge2'});
hfssRename(fid, 'HornEdge1', 'HornPlate1');

% Rectangular feed plate.
rectOrigin = [xP(1), yP(1), zP(1)];
rectAxis = 'Z';
rectWidth = -feedLength;
rectHeight = -2*yP(1);
hfssRectangle(fid, 'RectFeed1', rectAxis, rectOrigin, rectWidth, ...
    rectHeight, 'mm');

% Unite and set PE boundary to the first plate.
hfssUnite(fid, {'HornPlate1', 'RectFeed1'});
hfssAssignPE(fid, 'AntennaMetal', {'HornPlate1'});

% Duplicate to get the plate on the other side.
hfssDuplicateMirror(fid, {'HornPlate1'}, [0, 0, 0], [0, 0, -1], ...
    'mm', true);

% Create the coaxial cable feed.
feedPort = scale*130;
cxInnerR = 1.524;
cxOuterR = 4.953;
hfssCylinder(fid, 'coaxInner', 'Z', [-feedPort, 0, -zP(11)/5], ...
    cxInnerR, zP(11)/5 + zP(1), 'mm');
hfssHollowCylinder(fid, 'coaxOuter', 'Z', [-feedPort, 0, -zP(11)/5], ...
    cxInnerR, cxOuterR, zP(11)/5 - zP(1), 'mm');
hfssUncoveredCylinder(fid, 'coaxOuterCover', 'Z', ...
    [-feedPort, 0, -zP(11)/5], cxOuterR, zP(11)/5 - zP(1), 'mm');
hfssAssignPE(fid, 'FeedMetals', {'coaxOuterCover'});
hfssAssignMaterial(fid, 'coaxInner', 'pec');
hfssAssignMaterial(fid, 'coaxOuter', 'Teflon (tm)');

% Create circles and cut them off.
hfssCircle(fid, 'HornPlate1_FeedCut', 'Z', [-feedPort, 0,  zP(1)], ...
    cxInnerR, 'mm');
hfssCircle(fid, 'HornPlate2_FeedCut', 'Z', [-feedPort, 0, -zP(1)], ...
    cxOuterR, 'mm');
hfssSubtract(fid, {'HornPlate1'}, {'HornPlate1_FeedCut'});
hfssSubtract(fid, {'HornPlate1_1'}, {'HornPlate2_FeedCut'});

% Create circle for port.
hfssCircle(fid, 'PortCircle', 'Z', [-feedPort, 0, -zP(11)/5], ...
    cxOuterR, 'mm');
hfssAssignWavePort(fid, 'Port1', 'PortCircle', 1, false, [-1, -1, -1], ...
    [-1, -1, -1], 'mm');
hfssCylinder(fid, 'PortCap', 'Z', [-feedPort, 0, -zP(11)/5], cxOuterR, ...
    -0.1, 'mm');
hfssAssignMaterial(fid, 'PortCap', 'pec');

% Move and duplicate antennas to create a array.
if (nElements > 1)
	if strcmp(arrayDirection, 'H-Plane')
		tVector = [0, -(nElements-1)*dAnt/2, 0];
		dVector = [0, dAnt, 0];
	elseif strcmp(arrayDirection, 'E-Plane')
		tVector = [0, 0, -(nElements-1)*dAnt/2];
		dVector = [0, 0, dAnt];
	else
		error('Array direction unknown !');
	end;
	ObjList = {'HornPlate1', 'HornPlate1_1', 'PortCircle', ...
        'coaxInner', 'coaxOuterCover', 'coaxOuter', 'PortCap'};
	hfssMove(fid, ObjList, tVector, 'mm');
	hfssDuplicateAlongLine(fid, ObjList, dVector, nElements, 'mm');
end;

% Insert a solution
hfssInsertSolution(fid, 'Setup120MHz', 0.120);
hfssInsertSolution(fid, 'Setup150MHz', 0.150);
hfssInsertSolution(fid, 'Setup225MHz', 0.225);
hfssInsertSolution(fid, 'Setup300MHz', 0.300);

% Final project save.
hfssSaveProject(fid, tmpPrjFile, true);
fclose(fid);

hfssExecuteScript(hfssExePath, tmpScriptFile, false, false);

% Remove paths.
hfssRemovePaths('../../');
rmpath('../../');