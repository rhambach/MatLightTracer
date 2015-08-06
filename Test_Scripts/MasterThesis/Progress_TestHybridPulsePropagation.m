% Spectral phase at exit pupil
fOpticalSystemName = which ('SingletFusedSilicaF150mm.mat'); 
singletLens = OpticalSystem(fOpticalSystemName);

spatialWidthInSI = 4*10^-3;
radiusOfCurvatureInSI = Inf;
temporalWidthInSI = 50*10^-15;
initialChirpInSI = 0;
pulsedBeamParameterInSI = [spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
centralWavelengthInSI = singletLens.getPrimaryWavelength;
direction = [0,0,1]';
nWavSampling = 64;
nXYSampling = 32;
gaussianPulsedBeam = GaussianPulsedBeam(pulsedBeamParameterInSI,centralWavelengthInSI,direction);
inputPulse = gaussianPulsedBeam.convertToGeneralPulse(nWavSampling,nXYSampling);

%% Only Geometric method
inputHarmonicFieldSet = inputPulse.PulseHarmonicFieldSet;
% endSurfaceIndex = 5; % intermediate surface
%  endSurfaceIndex = 6; % focal plane 
 endSurfaceIndex = 7; % plane with flat pulse front

phaseToDirMethod = 2; % gradient
effectsToInclude = 1; % OPL
[ outputHarmonicFieldSet ] = GeometricalOpticsPropagator( ...
    singletLens, inputHarmonicFieldSet, endSurfaceIndex, phaseToDirMethod, effectsToInclude );
outputPulse = GeneralPulse(outputHarmonicFieldSet);

% plot the y-t graph
% timeWindow = 200*10^-15;
% nTimeSampling = 100;
% plotYVersusTime(inputPulse,timeWindow, nTimeSampling);
% plotYVersusTime(outputPulse,timeWindow, nTimeSampling);

% plotYVersusTime(inputPulse);
plotYVersusTime(outputPulse);


% %% Hybrid approach
% tic
% [ complexAmplitudeAtExitPupilMulti,wrappedPhaseMulti,unwrappedPhaseMulti xp,yp ] = ...
%     computeComplexSpectralAmplitudeAtExitPupil(singletLens, inputPulse);
% toc
% 
% % surf(squeeze(wrappedPhaseMulti(:,26,:)),'FaceColor','interp')
% 
% % Propagate all components to focal plane +- z and add the complex
% % amplitudes to get the field distribution at that plane
% initialComplexAmplitude = complexAmplitudeAtExitPupilMulti;
% focalLength = -getExitPupilLocation(singletLens)*getLensUnitFactor(singletLens);
% zz = 0;
% 
% %%
% wavelength = [inputPulse.PlaneWaveArray.Wavelength];
% spotPlotRadius = 0.05*10^-3;
% 
% for deltaZ = -10000*10^-5:1000*10^-5:10000*10^-5
%     zz = zz + 1;
%     totalFieldInFocalRegion(:,:,zz) = computeTotalFocalFieldUsingFFT(initialComplexAmplitude, wavelength,xp,yp,spotPlotRadius, focalLength, deltaZ);
% %     figure 
% %     surf(abs(complexAmplitudeInFocalRegion(:,:,zz)).^2)
% end
%     figure 
%     surf(abs(squeeze(totalFieldInFocalRegion(floor(nXYSampling/2),:,:))).^2,'FaceColor','interp')
% 
%     