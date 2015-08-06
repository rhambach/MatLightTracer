optSystem = OpticalSystem;
optSystem.SurfaceArray(1).Glass = Glass('BK7');
optSystem.SurfaceArray(2) = [];
optSystem.SurfaceArray(1).Stop = 1;

wavLenInWavUnit = getPrimaryWavelength(optSystem);
fieldPointmatrix = optSystem.FieldPointMatrix;
fieldPointXYInLensUnit = (fieldPointmatrix(1,1:2))';
nRay1 = 1129; nRay2 = 1130; % 1 001 043 rays
% nRay1 = 4000; nRay2 = 4000;

pupSamplingType = 'Rectangular';

[ rayTraceOptionStruct ] = RayTraceOptionStruct( );
rayTraceOptionStruct.ConsiderPolarization = 0;
rayTraceOptionStruct.ConsiderSurfAperture = 1;
rayTraceOptionStruct.RecordIntermediateResults = 1;
rayTraceOptionStruct.ComputeGroupPathLength = 0;

endSurface = getNumberOfSurfaces(optSystem);

profile on
tic
multipleRayTracer(optSystem,wavLenInWavUnit,fieldPointXYInLensUnit,...
    nRay1,nRay2,pupSamplingType,rayTraceOptionStruct,endSurface);
disp('Total ray tracing')
toc
profile viewer
