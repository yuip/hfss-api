% This example script creates a folded dipole array design in HFSS.
clc; clear all; close all;

% Add paths to the required m-files.
addpath('../../');
hfssIncludePaths('../../');

% HFSS Executable Path.
hfssExePath = 'E:\HFSSv15\HFSS15.0\Win64\hfss.exe';

% Script and project files.
tmpPrjFile = [pwd, '\tmpFoldedDipole.hfss'];
tmpScriptFile = [pwd, '\tmpFoldedDipole.vbs'];

% Temporary script file to output script commands.
fid = fopen(tmpScriptFile, 'wt');

% General parameters.
c  = 3e8;
fc = 150e6;
Wv = c/fc;

% Solution parameters.
fSolve = fc;
f0     = 130e6;
f1     = 170e6;

% Number of elements.
N = 4;

% Antenna spacing.
dAnt = 0.85*Wv;

% Dimensions of folded dipole.
% 1. Length of the inner section.
L = 0.7747; % 35in - 4.5in
% 2. Radius of the outer semi-circles.
Rs =0.05715; % 2.25in
% 3. Width between the folded arms.
W = 2*Rs; % 4.5in
% 4. Radius (thickness) of the arm.
Rd = 0.0127; % ~ 0.5in
% 5. Feeding gap.
G = L/25;

% General dimensions.
% Ground plane height (from bottom arm).
GpH = Wv/4;
% Length of the harness rod.
Lhrns = 0.9*GpH;
% Radius (thickness) of the harness rod.
Rhrns = 2*Rd;

% Ground Plane Dimensions.
GpL = (N-1)*dAnt + 2*(Wv/4);
GpW = L + Rs + 2*(Wv/4);

% AirBox.
AirX  = GpL;
AirY  = GpW;
AirZt = GpH - W/2;
AirZb = W/2 + Wv/4;

% Port Parameters (Lumped Port)
PortW = G;    % Same as the antenna gap.
PortH = 2*Rd; % Same as the diameter of the rods.

% Create a new HFSS Project and insert a new design.
hfssNewProject(fid);
hfssInsertDesign(fid, 'folded_dipole');

% ---- Single Element Design ---

% Create the Outer Semi-Circles first.
% Semicircle-1
hfssCircle(fid, 'SemiCircle1', 'Y', [0, 0, W/2], Rd, 'meter');
hfssSweepAroundAxis(fid, 'SemiCircle1', 'X', -180);
hfssMove(fid, {'SemiCircle1'}, [0,  L/2, 0], 'meter');
% Semicircle-2
hfssCircle(fid, 'SemiCircle2', 'Y', [0, 0, W/2], Rd, 'meter');
hfssSweepAroundAxis(fid, 'SemiCircle2', 'X',  180);
hfssMove(fid, {'SemiCircle2'}, [0, -L/2, 0], 'meter');

% Create the connecting cylinders.
hfssCylinder(fid, 'TopCylinder', 'Y', [0, -L/2, W/2], Rd, L, 'meter'); 
hfssCylinder(fid, 'BottomCylinder1', 'Y', [0, -L/2, -W/2], Rd, ...
    (L/2 - G/2), 'meter'); 
hfssCylinder(fid, 'BottomCylinder2', 'Y', [0,  L/2, -W/2], Rd, ...
    -(L/2 - G/2), 'meter'); 

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
hfssRectangle(fid, 'GapSource', 'X', [0, -PortW/2, -W/2 - PortH/2], ...
    PortW, PortH, 'meter');
hfssAssignLumpedPort(fid, 'Port', 'GapSource', [0, -PortW/2, -W/2], ...
    [0, PortW/2, -W/2], 'meter', 200);

% --- Array, Ground Plane and Airbox ----

% Repeat the elements as an array.
if (N > 1)
	hfssMove(fid, {'FoldedDipole', 'GapSource'}, ...
        [-((N-1)/2)*dAnt, 0, 0], 'meter');
	hfssDuplicateAlongLine(fid, {'FoldedDipole', 'GapSource'}, ...
        [dAnt, 0, 0], N, 'meter');
end

% Create an airbox.
hfssBox(fid, 'AirBox', [-AirX/2, -AirY/2, AirZt], ...
    [AirX, AirY, -(AirZt + AirZb)], 'meter');
hfssAssignRadiation(fid, 'ABC', 'AirBox');

% Create the Ground Plane.
hfssRectangle(fid, 'GroundPlane', 'Z', [-GpL/2, -GpW/2, GpH - W/2], ...
    GpL, GpW, 'meter');
hfssAssignPE(fid, 'Ground', {'GroundPlane'});

% Set Transparencies.
hfssSetTransparency(fid, {'AirBox'}, 0.95);
hfssSetTransparency(fid, {'GroundPlane'}, 0.90);

% Solution Setup and Sweeps.
hfssInsertSolution(fid, 'Setup150MHz', fSolve/1e9);
hfssInterpolatingSweep(fid, 'Sweep130to170MHz', 'Setup150MHz', ...
    f0/1e9, f1/1e9);

% Save project and close file.
hfssSaveProject(fid, tmpPrjFile, true);
fclose(fid);

% Open HFSS executing the script.
hfssExecuteScript(hfssExePath, tmpScriptFile, false, false);

% Remove paths
hfssRemovePaths('../../');
rmpath('../../');