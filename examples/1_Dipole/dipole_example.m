% Description:
% ------------
% A simple example to demonstrate the HFSS-MATLAB-API. This script
% optimizes a dipole antenna design to resonate at a specified frequency.
% The initial length of the dipole is taken to be half the wavelength and
% is optimized so that the simulated resonance frequency and the desired
% resonance frequency are close.

clc; clear variables; close all;

% Add paths to the required m-files.
addpath('../../'); % add manually the API root directory.
hfssIncludePaths('../../');

% Antenna Parameters.
fC   = 150e6;    % Frequency of Interest.
Wv   = 3e8/fC;    % Wavelength.
L    = Wv/2;    % Antenna Length.
gapL = 5e-2;    % Antenna Gap.
aRad = 2e-2;    % Antenna Radius.

% Simulation Parameters.
fLow    = 100e6;
fHigh   = 200e6;
nPoints = 201;

% AirBox Parameters.
AirX = Wv/2 + L;    % Include the antenna length.
AirY = Wv/2; 
AirZ = Wv/2;

% Temporary Files. These files can be deleted after the optimization
% is complete. We have to specify the complete path for all of them.
% With pwd we save them in the current directory.
tmpPrjFile    = [pwd, '\tmpDipole.aedt'];
tmpDataFile   = [pwd, '\tmpData.m'];
tmpScriptFile = [pwd, '\dipole_example.vbs'];

% HFSS Executable Path.
hfssExePath = 'D:\Programas\HFSS\AnsysEM19.3\Win64\ansysedt.exe';

% Plot Colors.
pltCols = ['b', 'r', 'k', 'g', 'm', 'c', 'y'];
nCols = length(pltCols);

% Optimization stop conditions.
maxIters = 15;        % max # of iterations.
Accuracy = 0.01;      % accuracy required (1%).
hasConverged = false;

fprintf('The Initial Dipole Length is %.2f meter...\n', L);
for iIters = 1:maxIters
    fprintf('Running iteration #%d...\n', iIters);
    disp('Creating the Script File...');
    
    % Create a new temporary HFSS script file.
    fid = fopen(tmpScriptFile, 'wt');
    
    % Create a new HFSS Project and insert a new design.
    hfssNewProject(fid);
    hfssInsertDesign(fid, 'without_balun');
    
    % Create the Dipole.
    hfssDipole(fid, 'Dipole', 'X', [0, 0, 0], L, 2*aRad, gapL, 'meter');
    
    % Assign PE boundary to the antenna elements.
    hfssAssignPE(fid, 'Antennas',  {'Dipole1', 'Dipole2'});
    
    % Create a Lumped Gap Source (a rectangle normal to the Y-axis)
    hfssRectangle(fid, 'GapSource', 'Y', [-gapL/2, 0, -aRad], 2*aRad, ...
        gapL, 'meter');
    hfssAssignLumpedPort(fid, 'LumpedPort', 'GapSource', ...
        [-gapL/2, 0, 0], [gapL/2, 0, 0], 'meter');
    
    % Add an AirBox.
    hfssBox(fid, 'AirBox', [-AirX, -AirY, -AirZ]/2, [AirX, AirY, AirZ], ...
        'meter');
    hfssAssignRadiation(fid, 'ABC', 'AirBox');
    
    % Add a Solution Setup.
    hfssInsertSolution(fid, 'Setup150MHz', fC/1e9);
    hfssInterpolatingSweep(fid, 'Sweep100to200MHz', 'Setup150MHz', ...
        fLow/1e9, fHigh/1e9, nPoints);
    
    % Save the project to a temporary file and solve it.
    hfssSaveProject(fid, tmpPrjFile, true);
    hfssSolveSetup(fid, 'Setup150MHz');
    
    % Export the Network data as an m-file.
    hfssExportNetworkData(fid, tmpDataFile, 'Setup150MHz', ...
        'Sweep100to200MHz');
    
    % Close the HFSS Script File.
    fclose(fid);
    
    % Execute the Script by starting HFSS.
    disp('Solving using HFSS...');
    hfssExecuteScript(hfssExePath, tmpScriptFile);
    
    % Load the data by running the exported matlab file.
    run(tmpDataFile);
    tmpDataFile = [pwd, '\tmpData', num2str(iIters), '.m'];
    
    % The data items are in the f, S, Z variables now. 
    % Plot the data.
    disp('Solution Completed. Plotting Results for this iteration...');
    figure(1);
    hold on; grid on;
    plot(f/1e6, 20*log10(abs(S)), pltCols(mod(iIters, nCols) + 1)); 
    hold on;
    xlabel('Frequency (MHz)');
    ylabel('S_{11} (dB)');
    axis([fLow/1e6, fHigh/1e6, -20, 0]);
    
    % Find the Resonance Frequency.
    [Smin, iMin] = min(S);
    fActual = f(iMin);
    fprintf('Simulated Resonance Frequency: %.2f MHz\n', fActual/1e6);
    
    % Check if the required accuracy is met.
    if (abs((fC - fActual)/fC) < Accuracy)
        disp('Required Accuracy is met!');
        fprintf('Optimized Antenna Length is %.2f meter.\n', L);
        hasConverged = true;
        break;
    end
    
    % Adjust the antenna length in accordance with the discrepancy between
    % the estimated and desired resonance frequency.
    L = L*fActual/fC;

    % Loop all over again ...
    disp('Required accuracy not yet met ...');
    fprintf('The new estimate for the dipole length is %.2f meter\n', L);
end

if (~hasConverged)
    disp('Max Iterations exceeded. Optimization did NOT converge ...');
end
disp('');
disp('');

% Remove all the added paths.
hfssRemovePaths('../../');
rmpath('../../');