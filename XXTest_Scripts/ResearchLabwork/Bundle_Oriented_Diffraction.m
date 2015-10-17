% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);

%% Bundle oriented polarization ray trace
% surfIndex = OS.NumberOfSurface;
surfIndex = 4;

wavLen = OS.WavelengthMatrix(OS.PrimaryWavelengthIndex);
fieldPointXY = [0;0]; % start from an axis point
sampleGridSize = 100;
JonesVec = [1*exp(1i*10*pi/180);2*exp(1i*20*pi/180)];
% JonesVec = [5;0];


%% Plot Wavefront at Exit Pupil
tic
figure;
axesHandle2 = axes; 
[ X,Y,OPDAtExitPupil ] = ...
    OS.plotWavefrontAtExitPupil(axesHandle2,sampleGridSize,wavLen,...
        fieldPointXY,JonesVec);
toc
hold off;
%% Add Pupil Apodization
figure;
axesHandle3 = axes; 
apodType = 1; % Supergauss
I0 = 1; m = 2; w = 7;
apodParam = [I0,m,w];
[ X,Y,pupilApodization ] =...
        OS.plotPupilApodization(axesHandle3,sampleGridSize,apodType,apodParam);

%% Plot PSF 
figure;
axesHandle = axes;
spotPlotRadius = 0.007;
apodType = 1; % Supergauss
I0 = 1; m = 2; w = 7;
apodParam = [I0,m,w];

[ X,Y,pupilApodization ] =...
        plotFFTPointSpreadFunction( OS,axesHandle,sampleGridSize,...
        apodType,apodParam,wavLen,fieldPointXY,JonesVec,spotPlotRadius);

