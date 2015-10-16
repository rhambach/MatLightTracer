% achromate
fOpticalSystemName = which ('AchromaticAt800nmF25mm.mat'); 
testOptSystem = OpticalSystem(fOpticalSystemName);

spatialWidthInSI = 6*10^-3;  % Here half width at 1/e maxima is used
radiusOfCurvatureInSI = Inf;
temporalWidthInSI = 100*10^-15; % Here half width at 1/e maxima is used is used 
% as it is used to define Q parameters of  gaussian pulse represnetation
initialChirpInSI = 0;
pulsedBeamParameterInSI = [spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
centralWavelengthInSI = testOptSystem.getPrimaryWavelength;
direction = [0,0,1]';
nWavSampling = 32; % 64
nXYSampling = 32; %32
timeWindowFactor = 4; % 3

gaussianPulsedBeam = GaussianPulsedBeam(pulsedBeamParameterInSI,centralWavelengthInSI,direction);
inputPulse = gaussianPulsedBeam.convertToGeneralPulse(nWavSampling,nXYSampling,timeWindowFactor);
nTimeSampling = 32; % 128

%% Hybrid diffraction model
outputWindowSize = 0.2*10^-4;
plotYversusTime(inputPulse,nTimeSampling);
[ outputPulse ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize);
plotYversusTime(outputPulse,nTimeSampling);


