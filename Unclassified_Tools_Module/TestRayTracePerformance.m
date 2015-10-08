optSystem = OpticalSystem; % Default system with three surfaces
optSystem.SurfaceArray(2).Glass = Glass('BK7');
% optSystem.SurfaceArray(2) = []; % remove the middle surface to limit the computation to just 1 surface
optSystem.SurfaceArray(2).IsStop = 1;

wavLenInWavUnit = getPrimaryWavelength(optSystem);
fieldPointmatrix = optSystem.FieldPointMatrix;
fieldPointXYInLensUnit = (fieldPointmatrix(1,1:2))';
nRay1 = 1129; nRay2 = 1130; % 1 001 043 rays
% nRay1 = 4000; nRay2 = 4000;

pupSamplingType = 'Rectangular';

[ rayTraceOptionStruct ] = RayTraceOptionStruct( );
rayTraceOptionStruct.ConsiderPolarization = 0;
rayTraceOptionStruct.ConsiderSurfAperture = 1;
rayTraceOptionStruct.RecordIntermediateResults = 0;
rayTraceOptionStruct.ComputeGroupPathLength = 0;

endSurface = getNumberOfSurfaces(optSystem);

profile on
tic
multipleRayTracer(optSystem,wavLenInWavUnit,fieldPointXYInLensUnit,...
    nRay1,nRay2,pupSamplingType,rayTraceOptionStruct,endSurface);
disp(['Total ray tracing through ', num2str(endSurface-1), ' surfaces.']);
toc
profile viewer
