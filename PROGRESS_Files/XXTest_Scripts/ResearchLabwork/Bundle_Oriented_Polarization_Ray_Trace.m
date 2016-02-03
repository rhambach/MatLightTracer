% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensPolarizationTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);
OS.plot2DLayout;
%% Bundle oriented polarization ray trace
% surfIndex = OS.NumberOfSurface;
surfIndex = 4;

wavLen = OS.WavelengthMatrix(OS.PrimaryWavelengthIndex);
% fieldPointXY = [0 0 ;1 0]; % start from an axis point
fieldPointXY = [0;0];
% fieldPointXY = [0;1];
sampleGridSize = 32;
JonesVec = [1*exp(1i*10*pi/180);2*exp(1i*20*pi/180)];
% JonesVec = [0;1];
%JonesVec = [NaN;NaN];

% % test code
% OS.plotAmplitudeTransmissionMap(surfIndex,wavLen,...
% fieldPointXY,sampleGridSize)
% % test code
% OS.plotPhaseMap(surfIndex,wavLen,...
% fieldPointXY,sampleGridSize)

% test code
% OS.plotWavefrontDiattenuationMap(surfIndex,wavLen,...
%     fieldPointXY,sampleGridSize)
% test code 
% OS.plotWavefrontRetardanceMap(surfIndex,wavLen,...
%     fieldPointXY,sampleGridSize)


% test time for multiple ray tracer
tic
resu = OS.multipleRayTracer(wavLen,...
        fieldPointXY,sampleGridSize^2,1,JonesVec);
toc
% test pupil polarization ellipse map
% for index = surfIndex:surfIndex;
% draw = OS.plotPupilPolarizationEllipseMap(index,wavLen,...
%         fieldPointXY,sampleGridSize,JonesVec);
% end
%% Plot Polarization Pupil at Entrance pupil
% toc