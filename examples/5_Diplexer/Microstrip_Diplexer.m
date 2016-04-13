% This is an example file for hfss-api
% Changes to do before running
% 1) Change the hfss-api path
% 2) Change the hfss executable path
% 3) If you have a HFSS version 15 or less, please change the hfss file
% extension to '.hfss'
% 4) This file don't assign excitation and don't create any solution setup
% So, generated hfss file need those to run simulation
%
% IMPORTANT NOTE: Please check there is no space in the filename and
% filepath. This program doesn't work if there is any spaces in filename
% and filepath.


clear all;
close all;

% Change this to your specified hfss-api path
path_to_hfssapi='C:\Users\rn5949\git\hfss-api\src';
addpath([path_to_hfssapi '\3dmodeler']);
addpath([path_to_hfssapi '\general']);
addpath([path_to_hfssapi '\analysis']);
addpath([path_to_hfssapi '\boundary']);
addpath([path_to_hfssapi '\general']);

% 1 mil =0.0254mm
mil=0.001*25.4;

% Variables 
% measurements is in mm
substrate_L=90;
substrate_W=40;
substrate_H=60*mil;
substrate_Er=3;
substrate_tand=0.0012;

Cu_thickness=18E-3;

W1a=1;
W1b=2;
W1c=2;
L1a=24.1;
L1b=17.15;
L1c=12.8;
W2L=2;
W2H=2;
Wf=0.8;
gf=1;
Lf=14.3;
Lc=11.2;
grL=1.7;
grH=1.75;
LtL=8.7;
LtH=4;

% Assumed, Not sure about the lengths
L2H=10;
L2L=13;      
L2V=20;

center_offset=-8;

%Port1 (ANT line)
W_ANT=3.8;
%L_ANT=48.0573;
L_ANT=8;

% Port2=
% Port3=

% Generating HFSS files
% File name to save as hfss file
% IMPORTANT NOTE: Please check there is no space in the filename.
NewFolderName='HFSS_files';
mkdir(pwd,NewFolderName);

Hfss_folder_path=[pwd '\' NewFolderName];
filename=['Diplexer_T_resonator'];
hfss_ext='.aedt';
sm3_ext='.sm3';
PrjFilePath = [Hfss_folder_path '\' filename hfss_ext];
SM3FilePath=[Hfss_folder_path '\' filename sm3_ext];
tmpDataFile = [Hfss_folder_path '\tempData.m'];
ScriptFile = [Hfss_folder_path  '\test.vbs'];

% HFSS Executable Path. Change to your system's HFSS path.
hfssExePath = 'C:\"Program Files"\AnsysEM\AnsysEM17.0\Win64\ansysedt.exe';

% Create a new temporary HFSS script file.
fid = fopen(ScriptFile, 'wt');
% create a new HFSS project.
hfssNewProject(fid);
hfssInsertDesign(fid, 'Diplexer');

% If this is in meters, then the hfss models in mm;
% there is some problem, I don't know why.
units='mm';

% Modelling

% Substrate and bottom layer
hfssBox(fid, 'substrate', [-substrate_L/2 -substrate_W/2 -substrate_H], [substrate_L, substrate_W, substrate_H], units);
hfssBox(fid, 'cu_cladding_bottom', [-substrate_L/2 -substrate_W/2 -substrate_H-Cu_thickness], [substrate_L, substrate_W, Cu_thickness], units);
hfssAssignMaterial(fid, 'cu_cladding_bottom', 'copper');
% Add a new material for the substrate
hfssAddMaterial(fid, 'RogersRO3003', 3, 0, 0.0012);
hfssAssignMaterial(fid, 'substrate', 'RogersRO3003');

% Trace modelling
hfssBox(fid, 'R11', [W1a/2 center_offset 0], [-W1a, L1a, Cu_thickness], units);
hfssAssignMaterial(fid, 'R11', 'copper');

WCS_X=L1c;
WCS_Y=center_offset+L1a+W1c;
WCS_Z=0;
hfssBox(fid, 'T_arm_c', [WCS_X WCS_Y 0], [-L1c, -W1c, Cu_thickness], units);

WCS_X=L1c;
WCS_Y=center_offset+L1a;
WCS_Z=0;
hfssBox(fid, 'T_arm_c_1', [WCS_X WCS_Y 0], [-W1c, -(Lc-W1c), Cu_thickness], units);

WCS_X=-L1b;
WCS_Y=center_offset+L1a+W1b;
WCS_Z=0;
hfssBox(fid, 'T_arm_b', [WCS_X WCS_Y 0], [L1b, -W1b, Cu_thickness], units);

WCS_X=-L1b;
WCS_Y=center_offset+L1a;
WCS_Z=0;
hfssBox(fid, 'T_arm_b_1', [WCS_X WCS_Y 0], [W1b, -(Lc-W1b), Cu_thickness], units);

%R2H
%Center_5
WCS_X=L1c+grH+L2H;
WCS_Y=center_offset+L1a+W2H;
hfssBox(fid, 'R2_H_1', [WCS_X WCS_Y 0], [-W2H, -L2V, Cu_thickness], units);

%Center_6
WCS_X=L1c+grH;
WCS_Y=center_offset+L1a+W2H;
hfssBox(fid, 'R2_H_2', [WCS_X WCS_Y 0], [+L2H-W2H, -W2H, Cu_thickness], units);

%Center_7
WCS_X=L1c+grH;
WCS_Y=center_offset+L1a+W2H-L2V;
hfssBox(fid, 'R2_H_3', [WCS_X WCS_Y 0], [+L2H-W2H, W2H, Cu_thickness], units);

%Center_8
WCS_X=L1c+grH;
WCS_Y=center_offset+L1a+W2H-Lc;
hfssBox(fid, 'R2_H_4', [WCS_X WCS_Y 0], [W2H, Lc-W2H, Cu_thickness], units);

%R2L
%Center_9
WCS_X=-L1b-grL-L2L;
WCS_Y=center_offset+L1a+W2L;
hfssBox(fid, 'R2_L_1', [WCS_X WCS_Y 0], [W2L, -L2V, Cu_thickness], units);

%Center_10
WCS_X=-L1b-grL;
WCS_Y=center_offset+L1a+W2L;
hfssBox(fid, 'R2_L_2', [WCS_X WCS_Y 0], [-(L2L-W2L), -W2L, Cu_thickness], units);

%Center_11
WCS_X=-L1b-grL;
WCS_Y=center_offset+L1a+W2L-L2V;
hfssBox(fid, 'R2_L_3', [WCS_X WCS_Y 0], [-(L2L-W2L), W2L, Cu_thickness], units);

%Center_12
WCS_X=-L1b-grL;
WCS_Y=center_offset+L1a+W2L-Lc;
hfssBox(fid, 'R2_L_4', [WCS_X WCS_Y 0], [-W2L, Lc-W2L, Cu_thickness], units);

% Coupled feeding 
%Center_13
WCS_X=W1a/2+gf+Wf;
WCS_Y=center_offset-gf-Wf;
hfssBox(fid, 'R1_Coupled_feeding_1', [WCS_X WCS_Y 0], [-Wf, Lf+gf+Wf, Cu_thickness], units);

%Center_14
WCS_X=W1a/2+gf;
WCS_Y=center_offset-gf-Wf;
hfssBox(fid, 'R1_Coupled_feeding_2', [WCS_X WCS_Y 0], [-2*gf-W1a, Wf, Cu_thickness], units);

%Center_15
WCS_X=-W1a/2-gf-Wf;
WCS_Y=center_offset-gf-Wf;
hfssBox(fid, 'R1_Coupled_feeding_3', [WCS_X WCS_Y 0], [Wf, Lf+gf+Wf, Cu_thickness], units);

% 50 ohm ANT line (Port 1)
%Center_16
WCS_X=0;
WCS_Y=center_offset-gf-Wf;
hfssBox(fid, 'ANT_line', [WCS_X WCS_Y 0], [W_ANT/2, -L_ANT, Cu_thickness], units);
hfssBox(fid, 'ANT_line_1', [WCS_X WCS_Y 0], [-W_ANT/2, -L_ANT, Cu_thickness], units);
hfssUnite(fid,{'ANT_line','ANT_line_1'});

length_of_port=5;
%Port 2
%Center_17
WCS_X=-L1b-grL-L2L;
WCS_Y=center_offset+L1a+W2L-LtL;
hfssBox(fid, 'Port2', [WCS_X WCS_Y 0], [-length_of_port, -W_ANT/2, Cu_thickness], units);
hfssBox(fid, 'Port2_1', [WCS_X WCS_Y 0], [-length_of_port, W_ANT/2, Cu_thickness], units);
hfssUnite(fid,{'Port2','Port2_1'});

%Port 3
%Center_18
WCS_X=L1c+grH+L2H;
WCS_Y=center_offset+L1a+W2H-LtH;
hfssBox(fid, 'Port3', [WCS_X WCS_Y 0], [length_of_port, -W_ANT/2, Cu_thickness], units);
hfssBox(fid, 'Port3_1', [WCS_X WCS_Y 0], [length_of_port, W_ANT/2, Cu_thickness], units);
hfssUnite(fid,{'Port3','Port3_1'});

% Assigning all the traces as Copper

Trace_names={'T_arm_c', 'T_arm_c_1', 'T_arm_b', 'T_arm_b_1', 'R2_H_1', 'R2_H_2', 'R2_H_3'...
    , 'R2_H_4', 'R2_L_1', 'R2_L_2', 'R2_L_3', 'R2_L_4','R1_Coupled_feeding_1', 'R1_Coupled_feeding_2'...
    , 'R1_Coupled_feeding_3', 'ANT_line', 'Port2', 'Port3'}
for i=1:length(Trace_names)
    hfssAssignMaterial(fid, Trace_names{i}, 'copper');
end

%Excitations
% Port 1
%Center_19
WCS_X=W_ANT/2;
WCS_Y=center_offset-gf-Wf-L_ANT;
hfssRectangle(fid, 'Source_port1','Y', [WCS_X WCS_Y 0], -substrate_H, -W_ANT, units);

% Port 2
%Center_20
WCS_X=-L1b-grL-L2L-length_of_port;
WCS_Y=center_offset+L1a+W2L-LtL-W_ANT/2;
hfssRectangle(fid, 'Source_port2','X', [WCS_X WCS_Y 0], W_ANT, -substrate_H, units);

% Port 3
%Center_21
WCS_X=L1c+grH+L2H+length_of_port;
WCS_Y=center_offset+L1a+W2H-LtH-W_ANT/2;
hfssRectangle(fid, 'Source_port3','X', [WCS_X WCS_Y 0], W_ANT, -substrate_H, units);

% Export SM3 file
%hfssExportModelToSM3(fid, SM3FilePath);

%Save Project
hfssSaveProject(fid, PrjFilePath, true);
%hfssCloseActiveProject(fid);
%Close the HFSS Script File.
fclose(fid);
% Execute the Script by starting HFSS.
%disp('Solving using HFSS ..');
hfssExecuteScript(hfssExePath, ScriptFile,false, false);