% sinlet lens
fOpticalSystemName = which ('SingletFusedSilicaF150mm.mat'); 
testOptSystem = OpticalSystem(fOpticalSystemName);

spatialFWHM = 4*10^-3;
spatialWidthInSI = spatialFWHM/(sqrt(2*log(2)));  % Here half width at 1/e maxima is used
radiusOfCurvatureInSI = Inf;
temporalFWHM = 25*10^-15; 
temporalWidthInSI = temporalFWHM/(sqrt(2*log(2))); % Here half width at 1/e maxima is used is used 
% as it is used to define Q parameters of  gaussian pulse represnetation
initialChirpInSI = 0;
pulsedBeamParameterInSI = [spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
centralWavelengthInSI = testOptSystem.getPrimaryWavelength;
direction = [0,0,1]';
nWavSampling = 64;
nXYSampling = 64;
timeWindowFactor = 10;

gaussianPulsedBeam = GaussianPulsedBeam(pulsedBeamParameterInSI,centralWavelengthInSI,direction);
inputPulse = gaussianPulsedBeam.convertToGeneralPulse(nWavSampling,nXYSampling,timeWindowFactor);

nTimeSampling = 256;


%% Hybrid diffraction model
outputWindowSize = 0.05*10^-3;
[ yt_intensity1,t_lin1,y_lin1  ]  = plotYversusTime(inputPulse,nTimeSampling);
[ outputPulse ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize);
[ yt_intensity2,t_lin2,y_lin2  ]  = plotYversusTime(outputPulse,nTimeSampling);

% plot the 1D cross sections
figure;
plot(t_lin1,yt_intensity1(floor(length(y_lin1)/2),:)/(max(yt_intensity1(floor(length(y_lin1)/2),:))));
figure;
plot(t_lin2,yt_intensity2(floor(length(y_lin2)/2),:)/(max(yt_intensity2(floor(length(y_lin2)/2),:))));

