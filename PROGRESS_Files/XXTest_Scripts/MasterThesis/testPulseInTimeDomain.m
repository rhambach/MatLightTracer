c = 299792458;

% % % Prism pair compressor
% fOpticalSystemName = which ('TestPrismPair.mat'); 
% optSystem = OpticalSystem(fOpticalSystemName);

% simple paralle plate
fOpticalSystemName = which ('ParallelPlate.mat'); 
optSystem = OpticalSystem(fOpticalSystemName);
centralWavelengthInSI = optSystem.getPrimaryWavelength;


spatialWidthInSI = 0.02*10^-3;
radiusOfCurvatureInSI = Inf;
temporalWidthInSI = 100*10^-15;
initialChirpInSI = 0;
pulsedBeamParameterInSI = [spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
direction = [0,0,1]';
nWavSampling = 128;
nXYSampling = 32;
timeWindowFactor = 12;
gaussianPulsedBeam = GaussianPulsedBeam(pulsedBeamParameterInSI,centralWavelengthInSI,direction);
inputPulse = gaussianPulsedBeam.convertToGeneralPulse(nWavSampling,nXYSampling,timeWindowFactor);
nTimeSampling = 256;

% %% plot in time domain CHECKED !!
% timeWindow =  75*10^-15;
% nTimeSampling = 256;
% inputPulse.plotYVersusTime(nTimeSampling );

%% plot 1D amp vs freq plot for point (0,0)
[ frequencyVector ] = inputPulse.PulseHarmonicFieldSet.getFrequencyVector;
% Put Ex and Ey in 3D matrix with the 3rd dimension being the spectral dim
[ allExIn3D,allEyIn3D ] = complexAmplitudeIn3D( inputPulse.PulseHarmonicFieldSet );

Ex00Vector = squeeze([allExIn3D(floor(nXYSampling/2),floor(nXYSampling/2),:)]);
figure
plot(c./frequencyVector,Ex00Vector);
figure
plot(frequencyVector,Ex00Vector);

%% Convret to time doamin
[ complexExFieldInTime,x_lin,y_lin,t_lin ] = convertToTemporalDomain( inputPulse,nTimeSampling );
Ex00VectorInTime = (squeeze([complexExFieldInTime(floor(nXYSampling/2),floor(nXYSampling/2),:)]));
% Ex00VectorInTime = fftshift(fft(Ex00Vector,nTimeSampling));
% Ex00VectorInTime = (squeeze([complexExFieldInTime(floor(nXYSampling/2),floor(nXYSampling/2),:)]));
absEx00VectorInTime = abs(Ex00VectorInTime);
% figure
% plot(t_lin,Ex00VectorInTime);
figure
plot(t_lin,absEx00VectorInTime);

% %% phase factor
% % propPhaseFactor = (exp(1i*frequencyVector))';
% %  propPhaseFactor = (exp(1i*frequencyVector.^2))';
% propPhaseFactor = ((exp(1i*(frequencyVector-frequencyVector(floor(nWavSampling/2)))).^2))';
% Ex00VectorAfterProp = Ex00Vector.*propPhaseFactor;
% 
% Ex00VectorAfterPropInTime = fftshift(fft(Ex00VectorAfterProp,nTimeSampling));
% absEx00VectorAfterPropInTime = abs(Ex00VectorAfterPropInTime);
% 
% figure
% plot(t_lin,Ex00VectorAfterPropInTime);
% figure
% plot(t_lin,absEx00VectorAfterPropInTime);
%%
% figure
% plot(frequencyVector,frequencyVector.^2);
% figure
% plot(frequencyVector,(frequencyVector-frequencyVector(floor(nWavSampling/2))).^2);
%% propagate using geomteric optics
%% Only Geometric method
inputHarmonicFieldSet = inputPulse.PulseHarmonicFieldSet;
% endSurfaceIndex = 5; 
% endSurfaceIndex = 6; 
endSurfaceIndex = 8; % last surface

phaseToDirMethod = 2; % gradient
effectsToInclude = 1; % OPL
[ outputHarmonicFieldSet ] = GeometricalOpticsPropagator( ...
    optSystem, inputHarmonicFieldSet, endSurfaceIndex, phaseToDirMethod, effectsToInclude );
outputPulse = GeneralPulse(outputHarmonicFieldSet);

%% plot 1D amp vs freq plot for point (0,0)
[ frequencyVectorOut] = outputPulse.PulseHarmonicFieldSet.getFrequencyVector;
[ complexExOutFieldInTime,x_lin,y_lin,t_lin ] = convertToTemporalDomain( outputPulse,nTimeSampling );
% Ex00VectorOutInTime = (squeeze([complexExOutFieldInTime(floor(nXYSampling/2),floor(nXYSampling/2),:)]));
% Put Ex and Ey in 3D matrix with the 3rd dimension being the spectral dim
[ allExIn3DOut,allEyIn3DOut ] = complexAmplitudeIn3D( outputPulse.PulseHarmonicFieldSet );
Ex00VectorOut = squeeze([allExIn3DOut(floor(nXYSampling/2),floor(nXYSampling/2),:)]);

Ex00VectorOutInTime = fftshift(fft(Ex00VectorOut,nTimeSampling));
absEx00VectorOutInTime = abs(Ex00VectorOutInTime);
figure
plot(t_lin,absEx00VectorOutInTime);

% % phase added by the system
% phaseAdded = phase(Ex00VectorOut)-phase(Ex00Vector);
% figure
% plot(frequencyVectorOut,phaseAdded);
% figure
% plot(t_lin,absEx00VectorOutInTime);
% % figure
% % plot(c./frequencyVectorOut,Ex00VectorOut);