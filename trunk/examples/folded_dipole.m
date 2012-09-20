% this example script creates a Folded Dipole array design in HFSS.
clear all;
close all;

% add necessary paths.
addpath('../3dmodeler');
addpath('../general');
addpath('../boundary');
addpath('../analysis');

% temporary script file to output script commands.
hfssScriptFile = '/users/rvc/temp/tmpFoldedDipoleR1.vbs';
fid = fopen(hfssScriptFile, 'wt');

% General parameters.
c = 3e8;
fc = 150e6;
Wv = c/fc;

% Solution parameters.
fSolve = fc;
f0 = 130e6;
f1 = 170e6;

% number of elements.
N = 4;
% antenna spacing.
dAnt = 0.85*Wv;

% Dimensions of folded dipole.
% 1. length of the inner section.
L = 0.7747; % 35in - 4.5in
% 2. radius of the outer semi-circles.
Rs =0.05715; % 2.25in
% 3. width between the folded arms.
W = 2*Rs; % 4.5in
% 4. radius (thickness) of the arm.
Rd = 0.0127; % ~ 0.5in
% 5. feeding gap.
G = L/25;

% General dimensions.
% ground plane height (from bottom arm).
GpH = Wv/4;
% length of the harness rod.
Lhrns = 0.9*GpH;
% radius (thickness) of the harness rod.
Rhrns = 2*Rd;

% Ground Plane Dimensions.
GpL = (N-1)*dAnt + 2*(Wv/4);
GpW = L + Rs + 2*(Wv/4);

% AirBox.
AirX = GpL;
AirY = GpW;
AirZt = GpH - W/2;
AirZb = W/2 + Wv/4;

% Port Parameters (Lumped Port)
PortW = G;    % same as the antenna gap.
PortH = 2*Rd; % same as the diameter of the rods.

% Create a new HFSS Project and insert a new design.
hfssNewProject(fid);
hfssInsertDesign(fid, 'folded_dipole');

% ---- Single Element Design ---

% Create the Outer Semi-Circles first.
% semicircle-1
hfssCircle(fid, 'SemiCircle1', 'Y', [0, 0, W/2], Rd, 'meter');
hfssSweepAroundAxis(fid, 'SemiCircle1', 'X', -180);
hfssMove(fid, {'SemiCircle1'}, [0,  L/2, 0], 'meter');
% semicircle-2
hfssCircle(fid, 'SemiCircle2', 'Y', [0, 0, W/2], Rd, 'meter');
hfssSweepAroundAxis(fid, 'SemiCircle2', 'X',  180);
hfssMove(fid, {'SemiCircle2'}, [0, -L/2, 0], 'meter');

% Create the connecting cylinders.
hfssCylinder(fid, 'TopCylinder', 'Y', [0, -L/2, W/2], Rd, L, 'meter'); 
hfssCylinder(fid, 'BottomCylinder1', 'Y', [0, -L/2, -W/2], Rd,  (L/2 - G/2), 'meter'); 
hfssCylinder(fid, 'BottomCylinder2', 'Y', [0,  L/2, -W/2], Rd, -(L/2 - G/2), 'meter'); 

% Create the harness rod.
%hfssCylinder(fid, 'Harness', 'Z', [0, 0, GpH - W/2], Rhrns, -Lhrns, 'meter');

% Unite all the Objects together.
%hfssUnite(fid, {'TopCylinder', 'SemiCircle1', 'BottomCylinder1', ...
%                'BottomCylinder2', 'SemiCircle2', 'Harness'});
hfssUnite(fid, {'TopCylinder', 'SemiCircle1', 'BottomCylinder1', ...
                'BottomCylinder2', 'SemiCircle2'});
hfssRename(fid, 'TopCylinder', 'FoldedDipole');

% Assign material to coppper.
hfssAssignMaterial(fid, 'FoldedDipole', 'copper');

% Create a Gap Source and add a Lumped port.
hfssRectangle(fid, 'GapSource', 'X', [0, -PortW/2, -W/2 - PortH/2], PortW, PortH, 'meter');
hfssAssignLumpedPort(fid, 'Port', 'GapSource', [0, -PortW/2, -W/2], [0, PortW/2, -W/2], 'meter', 200);

% --- Array, Ground Plane and Airbox ----

% Repeat the elements as an array.
if (N > 1)
	hfssMove(fid, {'FoldedDipole', 'GapSource'}, [-((N-1)/2)*dAnt, 0, 0], 'meter');
	hfssDuplicateAlongLine(fid, {'FoldedDipole', 'GapSource'}, [dAnt, 0, 0], N, 'meter');
end;

% Create an airbox.
hfssBox(fid, 'AirBox', [-AirX/2, -AirY/2, AirZt], [AirX, AirY, -(AirZt + AirZb)], 'meter');
hfssAssignRadiation(fid, 'ABC', 'AirBox');

% Create the Ground Plane.
hfssRectangle(fid, 'GroundPlane', 'Z', [-GpL/2, -GpW/2, GpH - W/2], GpL, GpW, 'meter');
hfssAssignPE(fid, 'Ground', {'GroundPlane'});

% Set Transparencies.
hfssSetTransparency(fid, {'AirBox'}, 0.95);
hfssSetTransparency(fid, {'GroundPlane'}, 0.90);

% Solution Setup and Sweeps.
hfssInsertSolution(fid, 'Setup150MHz', fSolve/1e9);
hfssInterpolatingSweep(fid, 'Sweep130to170MHz', 'Setup150MHz', f0/1e9, f1/1e9);

fclose(fid);
