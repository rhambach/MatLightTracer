%% 1. input argument
speed=0.1; % 0-1 0-faster, 1-slowest
plotIn2D = 1; % 2D:1, 3D:0
system_location='D:\MatLightTracer_GitHub\Sample_Optical_Systems\Double Gauss 28 degree field.mat';
% system_location = 'D:\MatLightTracer_GitHub\Sample_Optical_Systems\Prisms using coordinate breaks.mat';
wavefront_number=1000;

wavelengthIndices = 1; % 1:0.48610^-6, 2:0.58710^-6, 3:0.656*10^-6
fieldIndices = [1,2]; % 1,2,3
pupilSamplingType= 'Tangential'; %'Cartesian','Polar','Tangential','Sagittal','Cross','Random';

%% 2. calculate OpticalSystem
optSystem = OpticalSystem(system_location);
%% 3. Tracer the rays though the optical system using rayTracer
[ options ] = RayTraceOptionStruct( );
options.RecordIntermediateResults = 1;
options.ComputeOpticalPathLength = 1;

nRay1=5; 
nRay2=5;
initialRayBundle=getInitialRayBundle( optSystem, wavelengthIndices,...
fieldIndices, nRay1,nRay2,pupilSamplingType);
rayTracerResult = rayTracer(optSystem, initialRayBundle,options);

IntersectionPoint= getAllSurfaceRayIntersectionPoint(rayTracerResult);