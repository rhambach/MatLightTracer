function rayPathMatrix = computeRayPathMatrix...
        (optSystem,wavLen,fieldPointXY,PupSamplingType,nRay1,nRay2)
    % computeRayPathMatrix: computes the ray path coordinates for all field
    % points and wavelengths by performing multiple ray trace. The
    % wavInd,fldInd can be vectors. Then the output rayPathMatrix will be
    % of 5D dimension. (3 X nSurf X nPupilPoints X nFieldPoints X nWav)

    lensUnitFactor = getLensUnitFactor(optSystem);
    
    [ rayTraceOptionStruct ] = RayTraceOptionStruct( );
    rayTraceOptionStruct.ConsiderPolarization = 0;
    rayTraceOptionStruct.ConsiderSurfAperture = 1;
    rayTraceOptionStruct.RecordIntermediateResults = 1;

    % The polarizedRayTraceResult will be a a vector of RayTraceResult
    % object of size = nSurf.
    [polarizedRayTracerResult] =  ...
        multipleRayTracer(optSystem,wavLen,fieldPointXY,nRay1,nRay2,PupSamplingType,rayTraceOptionStruct);
    
    nSurface = length(polarizedRayTracerResult);
    [ exitRayPositions ] = getAllSurfaceExitRayPosition( polarizedRayTracerResult);
    [ rayIntersectionPoints ] = getAllSurfaceRayIntersectionPoint( polarizedRayTracerResult);
    
    % Convert the intersection points and positions from meter to LensUnit
    rayPathMatrix(:,[1:2:2*nSurface],:,:,:) = rayIntersectionPoints/lensUnitFactor;
    rayPathMatrix(:,[2:2:2*nSurface],:,:,:)  = exitRayPositions/lensUnitFactor;
end
