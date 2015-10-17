clc;clear;close all;
%% Step 1. Get your optical system
doubleGaussFullFileName = 'C:\Users\li\Desktop\MatLightTracer_Toolbox\MatLightTracer_GitHub\Sample_Optical_Systems\Double Gauss 28 degree field.mat';
prismFullFileName = 'C:\Users\li\Desktop\MatLightTracer_Toolbox\MatLightTracer_GitHub\Sample_Optical_Systems\Prisms using coordinate breaks.mat';

optSystem = OpticalSystem(doubleGaussFullFileName);

%% 2. Get / construct intial rays
pos = [0,0,0;1*10^-3,0,-1*10^-3;0,0,0];
dir = [0,0,0;0,0,0;1,1,1];
wav = [0.55*10^-6];
initialRayBundle = ScalarRayBundle( pos,dir,wav);

% initialRayBundle = getChiefRay(optSystem);

% wavelength=getPrimaryWavelength(optSystem);
% getSystemWavelengths(optSystem,2)
% fieldPointXYInLensUnit=[0;0];

% nRay1=31;
% nRay2=31;
% pupilSamplingType='Tangential';
% initialRayBundle=getInitialRayBundle( optSystem, 2,...
%         1, nRay1,nRay2,pupilSamplingType);
%% 3. Tracer the rays though the optical system using rayTracer
[ options ] = RayTraceOptionStruct( );
options.RecordIntermediateResults = 1;
options.ComputeOpticalPathLength = 1;
rayTracerResult = rayTracer(optSystem, initialRayBundle,options);

%% 4. Access the ray trace results
 [ refractiveIndex ] = permute(getAllSurfaceRefractiveIndex( rayTracerResult),[3,2,1]);
 [ surfaceRayIntersectionPoint ] = getAllSurfaceRayIntersectionPoint(rayTracerResult);
 
 GPL=permute(getAllSurfaceGeometricalPathLength(rayTracerResult),[3,2,1]);
 OPL=permute(getAllSurfaceOpticalPathLength(rayTracerResult),[3,2,1]);
%  GRPL=permute(getAllSurfaceGroupPathLength(rayTracerResult),[3,2,1]);
 
 TGPL=permute(getAllSurfaceTotalGeometricalPathLength(rayTracerResult),[3,2,1]);
 TOPL=permute(getAllSurfaceTotalOpticalPathLength(rayTracerResult),[3,2,1]);
%  TGRPL=permute(getAllSurfaceTotalGroupPathLength(rayTracerResult),[3,2,1]);

