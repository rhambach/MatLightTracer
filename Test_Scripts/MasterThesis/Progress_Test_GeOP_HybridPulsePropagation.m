% Prism pair compressor
% fOpticalSystemName = which ('TestPrismPair.mat'); 
% testOptSystem = OpticalSystem(fOpticalSystemName);

% % Simple parallel glass strecher
% fOpticalSystemName = which ('ParallelPlate.mat'); 
% testOptSystem = OpticalSystem(fOpticalSystemName);

% sinlet lens
fOpticalSystemName = which ('SingletFusedSilicaF150mm.mat'); 
testOptSystem = OpticalSystem(fOpticalSystemName);

spatialWidthInSI = 6*10^-3;  % Here half width at 1/e maxima is used
radiusOfCurvatureInSI = Inf;
temporalWidthInSI = 100*10^-15; % Here half width at 1/e maxima is used is used 
% as it is used to define Q parameters of  gaussian pulse represnetation
initialChirpInSI = 0;
pulsedBeamParameterInSI = [spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
centralWavelengthInSI = testOptSystem.getPrimaryWavelength;
direction = [0,0,1]';
nWavSampling = 64;
nXYSampling = 32;
timeWindowFactor = 3;

gaussianPulsedBeam = GaussianPulsedBeam(pulsedBeamParameterInSI,centralWavelengthInSI,direction);
inputPulse = gaussianPulsedBeam.convertToGeneralPulse(nWavSampling,nXYSampling,timeWindowFactor);

nTimeSampling = 128;

% %% Only Geometric method
% inputHarmonicFieldSet = inputPulse.PulseHarmonicFieldSet;
% % endSurfaceIndex = 4; 
% % endSurfaceIndex = 6; 
% endSurfaceIndex = 8; % last surface
% 
% phaseToDirMethod = 2; % gradient
% effectsToInclude = 1; % OPL
% [ outputHarmonicFieldSet ] = GeometricalOpticsPropagator( ...
%     testOptSystem, inputHarmonicFieldSet, endSurfaceIndex, phaseToDirMethod, effectsToInclude );
% outputPulse = GeneralPulse(outputHarmonicFieldSet);
% 
% % plot the y-t graph
% % timeWindow = 200*10^-15;
% % nTimeSampling = 10;
% % plotYVersusTime(inputPulse,timeWindow, nTimeSampling);
% % plotYVersusTime(outputPulse,timeWindow, nTimeSampling);
% % nTimeSampling = 256*2;
% plotYversusTime(inputPulse,nTimeSampling);
% plotYversusTime(outputPulse,nTimeSampling);
% 
%% Hybrid diffraction model
outputWindowSize = 0.2*10^-4;
% plotYversusTime(inputPulse,nTimeSampling);
[ outputPulse ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize);
plotYversusTime(outputPulse,nTimeSampling);


% changeImgPosition = [0:9]*200*10^-6;
% nn = length(changeImgPosition);
% pulseFrontInFocalRegionFigure = figure('Name','Phase and Pulse Front Propagation (Near Focus)');
% pulseFrontInFocalRegionAxes = axes('parent',pulseFrontInFocalRegionFigure);
% 
% plotYversusTime(inputPulse,nTimeSampling);
% for zz = 1:nn
%     testOptSystem.SurfaceArray(end-1).Thickness =  ...
%         testOptSystem.SurfaceArray(end-1).Thickness + ...
%         changeImgPosition(zz)/testOptSystem.getLensUnitFactor;
% 
%     [ outputPulse ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize);
%     [ yt_intensity,t_lin,y_lin  ] = plotYversusTime(outputPulse,nTimeSampling,1);
% %     subplot(1,nn,zz);
% %     surf(t_lin,y_lin,yt_intensity,'facecolor','interp',...
% %         'edgecolor','none',...
% %         'facelighting','phong');
% %     view([0,90]);
% %     hold on
% end

% plot all in a figure with subplots


% deltaZ1 = -40000*10^-6;
% deltaZ2 = -0*10^-6;
% deltaZ3 = 40000*10^-6;
% [ outputPulse1 ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize,deltaZ1 );
% [ outputPulse2 ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize,deltaZ2 );
% [ outputPulse3 ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize,deltaZ3 );
% plotYversusTime(inputPulse,nTimeSampling);
% plotYversusTime(outputPulse1,nTimeSampling);
% plotYversusTime(outputPulse2,nTimeSampling); 
% plotYversusTime(outputPulse3,nTimeSampling); 
% shifted

% defocusImageSurface = [-4*10-3,-3*10-3,-2*10-3,-1*10-3,-0.5*10-3,0*10-3,0.5*10-3,1*10-3,2*10-3,3*10-3,4*10-3];
% plotYversusTime(inputPulse,nTimeSampling);
% for location = 1:length(defocusImageSurface)
%     % change the location of last plane in the optical system
%     testOptSystem.SurfaceArray(end-1).Thickness =  ...
%         testOptSystem.SurfaceArray(end-1).Thickness + ...
%         defocusImageSurface(location)/testOptSystem.getLensUnitFactor;
%     [ outputPulse ] = propagateGeneralPulse( testOptSystem,inputPulse,outputWindowSize,defocusImageSurface(location) );
%     plotYversusTime(outputPulse,nTimeSampling);    
% end
