% ideal lens
% fOpticalSystemName = which ('IdealLens.mat');
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

% %% Spectral phase at exit pupil
% endSurfaceIndex = 'ExP'; % exit pupil
% phaseToDirMethod = 2; % gradient
% effectsToInclude = 1; % OPL
% 
% inputHarmonicFieldSet = inputPulse.PulseHarmonicFieldSet;
% [ outputHarmonicFieldSet ] = GeometricalOpticsPropagator( ...
%     testOptSystem, inputHarmonicFieldSet, endSurfaceIndex, phaseToDirMethod, effectsToInclude );
% 
% % exitPupilPulse = GeneralPulse(outputHarmonicFieldSet);
% nFreqSampling = 256;
% N1 = size(outputHarmonicFieldSet.HarmonicFieldArray(1).computeEx,1);
% N2 = size(outputHarmonicFieldSet.HarmonicFieldArray(1).computeEx,2);
% [ allExIn3D,x_lin,y_lin,v_lin ] = computeFieldSpectrumIn3D( outputHarmonicFieldSet,'Ex' );
% yv_phase = squeeze(angle(allExIn3D(:,floor(N2/2),:)));
% % % Interpolate the intensity in freq axis to match nFreqSampling
% % % nFreqSampling = size(allExIn3D,3);
% % v_lin_new = linspace(min(v_lin),max(v_lin), nFreqSampling);
% % y_lin_new = y_lin;
% % 
% % % interpolate using grid function from matlab
% % [v_mesh_old,y_mesh_old] = meshgrid(v_lin,y_lin);
% % [v_mesh_new,y_mesh_new] = meshgrid(v_lin_new,y_lin_new);
% % interpMethod = 'spline';
% % yv_phase_interpolated = interp2(v_mesh_old,y_mesh_old,yv_phase,v_mesh_new,y_mesh_new,interpMethod);
% 
% [v_mesh_old,y_mesh_old] = meshgrid(v_lin,y_lin);
% yv_phase_interpolated = unwrap (yv_phase);
% v_mesh_new = v_mesh_old;
% y_mesh_new = y_mesh_old;
% 
% draw = 1;
% if draw
%     figure;
%     axesHandle = axes;
%     surf(axesHandle,v_mesh_new,y_mesh_new,yv_phase_interpolated,'facecolor','interp',...
%                  'edgecolor','none',...
%                  'facelighting','phong');
%     view([0,90]);
% end



%% geometric propagator
 endSurfaceIndex = 7; % plane with flat pulse front
 phaseToDirMethod = 2; % gradient
effectsToInclude = 1; % OPL

inputHarmonicFieldSet = inputPulse.PulseHarmonicFieldSet;
[ outputHarmonicFieldSet ] = GeometricalOpticsPropagator( ...
    testOptSystem, inputHarmonicFieldSet, endSurfaceIndex, phaseToDirMethod, effectsToInclude );
outputPulse = GeneralPulse(outputHarmonicFieldSet);
plotYversusTime(outputPulse,nTimeSampling);

% %% Hybrid diffraction model
% outputWindowSize = 0.05*10^-3;
% plotYversusTime(inputPulse,nTimeSampling);
% [ outputPulse ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize);
% plotYversusTime(outputPulse,nTimeSampling);


