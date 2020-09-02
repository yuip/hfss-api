% Script to simulate a reflectarray unit cell consisting on stacked
% rectangular patches backed by a ground plane.

% Changelog:
% XX-Sep-2020: -Initial script.

clc; clear variables; close all; drawnow;

%% UNIT CELL CONFIGURATION
nLayers = 5;
h       = [0.2d-3, 2.1d-3, 1d-3, 1.524d-3, 0.7d-3];
er      = [1.2, 3.3, 5.5, 2.3, 3.0];
tand    = [0.0001, 0.0025, 0.005, 0.001, 0.0009];
f       = 18.0d9;  % Hz.
l       = 3e8/f;
a       = 8.0d-3;  % m.
b       = 4.0d-3;  % m.
alpha   = [1, 0.9, 0.85, 0.7, 0.55];
pA      = [a/2, a/2, a/2, a/2, a/2].*alpha; % Patch length in X.
pB      = [b/2, b/2, b/2, b/2, b/2].*alpha; % Patch length in Y.

%% DIRECTORIES
tmpPrjFile    = [pwd, '\tmpStackedPatches.aedt'];
tmpScriptFile = [pwd, '\StackedPatches.vbs'];

% HFSS Executable Path.
hfssExePath = 'D:\Programas\HFSS\AnsysEM19.3\Win64\ansysedt.exe';
%hfssExePath = '"C:\Program Files\AnsysEM\AnsysEM19.3\Win64\ansysedt.exe"';

%% INITIAL SET-UP OF HFSS DESIGN.
% Add paths to the required m-files.
addpath('../../../'); % add manually the API root directory.
hfssIncludePaths('../../../');

% Create a new temporary HFSS script file.
fid = fopen(tmpScriptFile, 'wt');

% Create a new HFSS Project and insert a new design.
hfssNewProject(fid);
hfssInsertDesign(fid, 'stacked_patches');

%% SET VARIABLES.
hfssSetVariable(fid, 'var1', 1, 'mm');
hfssSetVariable(fid, 'var2', 2, 'mm');

hfssRectangle(fid, 'Ground', 'Z', [0, 0, -1], {'var1'}, {'var2'}, 'mm');




return
%% AIR BOX AND BOUNDARIES.
% Create an air box. By default, the material is vaccum. It also draws
% rectangles to cover it and later assign boundaries.
hBox = l/4 + sum(h);
hDmb = l/4;
hfssBox(fid, 'AirBox', [0, 0, 0], [a, b, hBox], 'meter');
hfssRectangle(fid, 'Ground', 'Z', [0, 0, 0], a, b, 'meter');
hfssRectangle(fid, 'Port', 'Z', [0, 0, hBox], a, b, 'meter');
hfssRectangle(fid, 'MasterRec1', 'X', [a, 0, 0], b, hBox, 'meter');
hfssRectangle(fid, 'SlaveRec1',  'X', [0, 0, 0], b, hBox, 'meter');
hfssRectangle(fid, 'MasterRec2', 'Y', [0, b, 0], hBox, a, 'meter');
hfssRectangle(fid, 'SlaveRec2',  'Y', [0, 0, 0], hBox, a, 'meter');

% Asign boundaries to the air box.
hfssAssignPE(fid, 'GND', {'Ground'});
hfssAssignFloquetPort(fid, 'FloquetPort', 'Port', hDmb, 0, 0, ...
                      [0, 0, hBox], [a, 0, hBox], ...
                      [0, 0, hBox], [0, b, hBox], 'meter');
hfssAssignMaster(fid, 'Master1', 'MasterRec1', [a, 0, 0], ...
 	             [a, b, 0], 'meter', true);
hfssAssignSlave(fid, 'Slave1', 'SlaveRec1',    [0, 0, 0], ...
	            [0, b, 0], 'meter', 'Master1', true);
hfssAssignMaster(fid, 'Master2', 'MasterRec2', [a, b, 0], ...
 	             [0, b, 0], 'meter', true);
hfssAssignSlave(fid, 'Slave2', 'SlaveRec2',    [a, 0, 0], ...
	            [0, 0, 0], 'meter', 'Master2', true);

%% UNIT CELL.
% Draw each layer. From bottom to top.
for n = 1:nLayers
    % Substrate.
    if (n == 1)
        hfssBox(fid, ['Layer', num2str(n)], [0, 0, 0], [a, b, h(n)], 'meter');
    else
        hfssBox(fid, ['Layer', num2str(n)], [0, 0, sum(h(1:n-1))], [a, b, h(n)], 'meter');
    end
    hfssSetColor(fid, ['Layer', num2str(n)], [255, 128, 0]);
    hfssAddMaterial(fid, ['Substrate', num2str(n)], er(n), 0, tand(n));
    hfssAssignMaterial(fid, ['Layer', num2str(n)], ['Substrate', num2str(n)]);
    
    % Metallization. In this case the patch is centered.
    if (n == 1)
        hfssRectangle(fid, ['Patch', num2str(n)], 'Z', ...
            [a/2-pA(n)/2, b/2-pB(n)/2, h(n)], pA(n), pB(n), 'meter');
    else
        hfssRectangle(fid, ['Patch', num2str(n)], 'Z', ...
            [a/2-pA(n)/2, b/2-pB(n)/2, sum(h(1:n))], pA(n), pB(n), 'meter');
    end
    hfssAssignPE(fid, ['PatchMetal', num2str(n)], {['Patch', num2str(n)]});
    hfssSetColor(fid, ['Patch', num2str(n)], [0, 0, 255]);
end



%% LAST STEPS.
% Save project and close file.
hfssSaveProject(fid, tmpPrjFile, true);
fclose(fid);

% Remove all the added paths.
%hfssRemovePaths('../../../');
rmpath('../../../');