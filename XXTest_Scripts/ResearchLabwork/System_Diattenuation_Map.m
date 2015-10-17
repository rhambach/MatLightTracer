% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);

%% Plot System Diattenuation Map
surfIndex = OS.NumberOfSurface; % Image surface index
wavLenIndex = OS.PrimaryWavelengthIndex;
fieldPointIndex = 1;

wavLen = OS.WavelengthMatrix(wavLenIndex,1);
fieldPoint = OS.FieldPointMatrix(fieldPointIndex,1:2);
fieldPointType = OS.FieldType;    
gridSize = 25; % Trace 25 X 25 Rays
JonesVec = [1,10*pi/180;2,20*pi/180]; 
numberOfRays = gridSize^2;
samplingType = 1; % cartesian

figure;
axesHandle = axes;
OS.plotWavefrontDiattenuationMap(axesHandle, ...
 surfIndex,wavLen,fieldPoint,numberOfRays,samplingType,JonesVec)