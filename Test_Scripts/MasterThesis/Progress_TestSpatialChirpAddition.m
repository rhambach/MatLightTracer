spatialWidthInSI = 3*10^-3;  % Here half width at 1/e maxima is used
radiusOfCurvatureInSI = Inf;
temporalFWHM = 70*10^-15; 
temporalWidthInSI = temporalFWHM/(sqrt(2*log(2))); % Here half width at 1/e maxima is used is used 
% as it is used to define Q parameters of  gaussian pulse represnetation
initialChirpInSI = 0;
pulsedBeamParameterInSI = [spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
centralWavelengthInSI = 800*10^-9;
direction = [0,0,1]';
nWavSampling = 64;
nXYSampling = 64;
timeWindowFactor = 12;

gaussianPulsedBeam = GaussianPulsedBeam(pulsedBeamParameterInSI,centralWavelengthInSI,direction);
inputPulse = gaussianPulsedBeam.convertToGeneralPulse(nWavSampling,nXYSampling,timeWindowFactor);

nTimeSampling = 128;
nFreqSampling = 128;

% Add spatial chirp to simulate the diffractive part
spatialChirpFactor = 2*pi*7.5*10^-17; % in m/Hz
chirpedPulse = addSpatialChirp(inputPulse,spatialChirpFactor);
%%
plotYversusTime(inputPulse,nTimeSampling);
plotYversusTime(chirpedPulse,nTimeSampling);
% 
plotYversusFrequency(inputPulse,nFreqSampling);
plotYversusFrequency(chirpedPulse,nFreqSampling);
%%
% Now use hybrid diffraction model for pulse propagation to focus the pulse
% through ideal lens
% ideal lens of f=25 mm

fOpticalSystemName = which ('IdealLens.mat'); 
testOptSystem = OpticalSystem(fOpticalSystemName);
outputWindowSize = 0.016*10^-3;
[ outputPulse ] = propagateGeneralPulse( testOptSystem,chirpedPulse,outputWindowSize);
plotYversusTime(outputPulse,nTimeSampling);