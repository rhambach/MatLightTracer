
%% Pulse front propagation through singlet lens
% Example1: Singlet Lens of Fused Silica
fOpticalSystemName = which ('SingletFusedSilicaF150mm.mat'); 
fusedSilicaLens = OpticalSystem(fOpticalSystemName);
wavLenInSI = fusedSilicaLens.getPrimaryWavelength;
wavLenInWavUnit = wavLenInSI/getWavelengthUnitFactor(fusedSilicaLens);

fieldPointXYInSI = [0;0];
fieldPointXYInLensUnit  = [0;0];

nSamplingPoints1 = 1;
nSamplingPoints2 = 50;
gridType =  'Rectangular'; 
plotIn2D = 1; 

% distanceAlongChiefRay = [160-60,160-40,160-20,160,160+20,160+40,160+60];

phaseAndPulseFrontFig = figure('Name','Phase and Pulse Front Propagation');
phaseAndPulseFrontAxes = axes('parent',phaseAndPulseFrontFig);
nn = size(distanceAlongChiefRay,2);

c = 299792458;
refSurfaceIndex = getNumberOfSurfaces(fusedSilicaLens);

deltaTime = (20)*getLensUnitFactor(fusedSilicaLens)/c;
numberOfTimeSamples = 7;
[ drawn ] = plotPhaseAndPulseFrontEvolution( ...
        fusedSilicaLens, wavLenInWavUnit,fieldPointXYInLensUnit, refSurfaceIndex, deltaTime,...
        numberOfTimeSamples,nSamplingPoints1,nSamplingPoints2,gridType,plotIn2D,phaseAndPulseFrontAxes );

% More detailed near focus
phaseAndPulseFrontFig2 = figure('Name','Phase and Pulse Front Propagation');
phaseAndPulseFrontAxes2 = axes('parent',phaseAndPulseFrontFig2);

deltaTime = (0.1)*getLensUnitFactor(fusedSilicaLens)/c;
numberOfTimeSamples = 5;
[ drawn ] = plotPhaseAndPulseFrontEvolution( ...
        fusedSilicaLens, wavLenInWavUnit,fieldPointXYInLensUnit, refSurfaceIndex, deltaTime,...
        numberOfTimeSamples,nSamplingPoints1,nSamplingPoints2,gridType,plotIn2D,phaseAndPulseFrontAxes2 );





