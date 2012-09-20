% Script to generate a MxN patch antenna array.

clear all;
close all;

addpath('../boundary/');
addpath('../3dmodeler/');
addpath('../analysis/');
addpath('../general/');

% frequency.
c = 3e8;
fC = 3.75e9;
Lambda = c/fC;

% patch dimensions.
Wy = 24*1e-3;
Lx = 24*1e-3;

% Array Parameters.
Nx = 3;
Ny = 3;
dAnt = Lambda/2;

% uStrip feed dimensions.
Wms = (200/1000)*0.0254;
Lfeed = Lx/6;

% Substrate parameters.
Hsub = (60/1000)*0.0254;
WsubX = Nx*dAnt + Lambda/2;
WsubY = Ny*dAnt + Lambda/2;

% lumped port dimensions.
PortH = Hsub;
PortW = Wms;

% radiation boundaries.
AirX = Nx*dAnt + Lambda/2;
AirY = Ny*dAnt + Lambda/2;
AirZ = Lambda/4 + Hsub;
	
% solution parameters (GHz)
fSolve = fC/1e9;
fStart = 3;
fStop  = 4.5;

% open a temporary script file.
tmpScriptFile = 'tempPatch.vbs';
fid = fopen(tmpScriptFile, 'wt');

% create a new HFSS project.
hfssNewProject(fid);
hfssInsertDesign(fid, 'NxN_uStrip_Patch');

% draw the patch & feed,  and assign an PE boundary to it.
hfssRectangle(fid, 'Patch', 'Z', [-Lx/2, -Wy/2, 0], Lx, Wy, 'meter');
hfssRectangle(fid, 'Feed', 'Z', [-Lx/2, -Wms/2, 0], -Lfeed, Wms, 'meter');
hfssUnite(fid, {'Patch', 'Feed'});
hfssAssignPE(fid, 'PatchMetal', {'Patch'});
hfssSetColor(fid, 'Patch', [128, 128, 0]);
hfssSetTransparency(fid, {'Patch'}, 0);

% draw a lumped port for the patch.
hfssRectangle(fid, 'Port', 'X', [-Lx/2 - Lfeed, -PortW/2, 0], PortW, -PortH, 'meter');
hfssAssignLumpedPort(fid, 'LPort', 'Port', [-Lx/2-Lfeed, 0, 0], ...
                     [-Lx/2-Lfeed, 0, -PortH], 'meter');

% draw the substrate.
hfssBox(fid, 'Substrate', [-WsubX/2, -WsubY/2, 0], [WsubX, WsubY, -Hsub], 'meter');
hfssAssignMaterial(fid, 'Substrate', 'Rogers RT/duroid 5880 (tm)');
hfssSetColor(fid, 'Substrate', [0, 128, 0]);
hfssSetTransparency(fid, {'Substrate'}, 0.2);

% clone the patch along X-axis ...
if (Nx > 1)
	hfssMove(fid, {'Patch', 'Port'}, [-0.5*(Nx-1)*dAnt, 0, 0], 'meter');
	hfssDuplicateAlongLine(fid, {'Patch', 'Port'}, [dAnt, 0, 0], Nx, 'meter');
end;

% ... and clone the linear array along the Y-dimension.
xObjList_patch = cell(Ny, 1);
xObjList_patch{1} = 'Patch';
xObjList_port = cell(Ny, 1);
xObjList_port{1} = 'Port';
for iY = 2:Ny,
	xObjList_patch{iY} = ['Patch_', num2str(iY-1)];
	xObjList_port{iY}  = ['Port_', num2str(iY-1)];
end;
xObjList = [xObjList_patch; xObjList_port];
if (Nx > 1)
	hfssMove(fid, xObjList , [0, -0.5*(Ny-1)*dAnt, 0], 'meter');
	hfssDuplicateAlongLine(fid, xObjList, [0, dAnt, 0], Ny, 'meter');
end;

% draw radiation boundaries.
hfssBox(fid, 'AirBox', [-AirX/2, -AirY/2, -Hsub], [AirX, AirY, AirZ], 'meter'); 
hfssAssignRadiation(fid, 'ABC', 'AirBox');
hfssSetTransparency(fid, {'AirBox'}, 0.95);

% draw a ground plane.
hfssRectangle(fid, 'GroundPlane', 'Z', [-AirX/2, -AirY/2, -Hsub], AirX, AirY, 'meter');
hfssAssignPE(fid, 'GND', {'GroundPlane'});

% insert solution and sweep.
hfssInsertSolution(fid, 'Setup3_75GHz', fC/1e9);
hfssInterpolatingSweep(fid, 'Sweep3to4_5GHz', 'Setup3_75GHz', fStart, fStop, 1001);
hfssSaveProject(fid, 'D:\HFSSProjects\tmpMicrowavePatch.hfss', true);

fclose(fid);
