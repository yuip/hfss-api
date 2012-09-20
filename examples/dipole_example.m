% Description:
% ------------
% A simple example to demonstrate the HFSS-MATLAB-API.  This script optimizes
% a dipole antenna design to resonate at a specified frequency. The initial
% length of the dipole is taken to be half the wavelength and is optimized 
% so that the simulated resonance frequency and the desired resonance 
% frequency are close.

clear all;

% add paths to the required m-files.
addpath('../3dmodeler/');
addpath('../general/');
addpath('../analysis/');
addpath('../boundary/');

% Antenna Parameters.
fC = 150e6;		% Frequency of Interest.
Wv = 3e8/fC;	% Wavelength.
L = Wv/2; 		% Antenna Length.
gapL = 5e-2;	% Antenna Gap.
aRad = 2e-2;    % Antenna Radius.

% Simulation Parameters.
fLow = 100e6;
fHigh = 200e6;
nPoints = 201;

% AirBox Parameters.
AirX = Wv/2 + L;	% Include the antenna length.
AirY = Wv/2; 
AirZ = Wv/2;

% Temporary Files. These files can be deleted after the optimization
% is complete. We have to specify the complete path for all of them.
tmpPrjFile = 'C:\temp\tmpDipole.hfss';
tmpDataFile = 'C:\temp\tmpData.m';
tmpScriptFile = 'C:\temp\dipole_example.vbs';

% HFSS Executable Path.
hfssExePath = 'C:\"Program Files"\Ansoft\HFSS9\hfss.exe';

% Plot Colors.
pltCols = ['b', 'r', 'k', 'g', 'm', 'c', 'y'];
nCols = length(pltCols);

% Optimization stop conditions.
maxIters = 15;		% max # of iterations.
Accuracy = 0.01;	% accuracy required (1%).
hasConverged = false;

disp(sprintf('The Initial Dipole Length is %.2f meter ...', L));
for iIters = 1:maxIters,
	disp(sprintf('Running iteration #%d ...', iIters));
	disp('Creating the Script File ...');
	
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
	hfssRectangle(fid, 'GapSource', 'Y', [-gapL/2, 0, -aRad], 2*aRad, gapL, ...
    	          'meter');
	hfssAssignLumpedPort(fid, 'LumpedPort', 'GapSource', [-gapL/2, 0, 0], ...
    	                 [gapL/2, 0, 0], 'meter');

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
	hfssExportNetworkData(fid, tmpDataFile, 'Setup150MHz', 'Sweep100to200MHz');

	% Close the HFSS Script File.
	fclose(fid);

	% Execute the Script by starting HFSS.
	disp('Solving using HFSS ..');
	hfssExecuteScript(hfssExePath, tmpScriptFile);

	% Load the data by running the exported matlab file.
	run(tmpDataFile);

	% The data items are in the f, S, Z variables now. 
	% Plot the data.
	disp('Solution Completed. Plotting Results for this Iteration ...');
	figure(1);
	hold on;
	plot(f/1e6, 20*log10(abs(S)), pltCols(mod(iIters, nCols) + 1)); 
    hold on;
	xlabel('Frequency (MHz) ->');
	ylabel('S_{11} (dB) ->');
	axis([fLow/1e6, fHigh/1e6, -20, 0]);
	
	% Find the Resonance Frequency.
	[Smin, iMin] = min(S);
	fActual = f(iMin);
	disp(sprintf('Simulated Resonance Frequency: %.2f MHz', fActual/1e6));

	% Check if the required accuracy is met.
	if (abs((fC - fActual)/fC) < Accuracy)
		disp('Required Accuracy is met !!');
		disp(sprintf('Optimized Antenna Length is %.2f meter.', L));
		hasConverged = true;
		break;
	end;
	
	% Adjust the antenna length in accordance with the discrepancy between
	% the estimated and desired resonance frequency.
	L = L*fActual/fC;

	% Loop all over again ...
	disp('Required accuracy not yet met ...');
	disp(sprintf('The new estimate for the dipole length is %.2f meter', L));
end;

if (~hasConverged)
	disp('Max Iterations exceeded. Optimization did NOT converge ...');
end;

% remove all the added paths.
rmpath('../3dmodeler/');
rmpath('../general/');
rmpath('../analysis/');
rmpath('../boundary/');
