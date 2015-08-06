function rayPathMatrix = computeRayPathMatrix...
        (optSystem,wavLen,fieldPointXY,PupSamplingType,nRay1,nRay2)
    % computeRayPathMatrix: computes the ray path coordinates for all field
    % points and wavelengths by performing multiple ray trace. The
    % wavInd,fldInd can be vectors. Then the output rayPathMatrix will be
    % of 3D dimension. (3 X nSurf X nTotalRay)
    
    JonesVec = [NaN;NaN];
    considerSurfAperture = 1;
    recordIntermediateResults = 1;
    % The polarizedRayTraceResult will be a 4D matrix of RayTraceResult
    % object (nSurf X nRay x nField  x nWav).
    [polarizedRayTracerResult] =  ...
        multipleRayTracer(optSystem,wavLen,fieldPointXY,nRay1,nRay2,PupSamplingType,JonesVec,...
        considerSurfAperture,recordIntermediateResults);
    
    nSurface = size(polarizedRayTracerResult,1);
    nRayTotal = size(polarizedRayTracerResult,2);
    nField = size(polarizedRayTracerResult,3);
    nWav = size(polarizedRayTracerResult,4);
    % The intersection points are extracted and reshaped to a 3D matrix of
    % 3 X nSurf X nRay x nField x nWav  
    rayIntersectionPoints = [polarizedRayTracerResult.RayIntersectionPoint];
   
    exitRayPositions = [polarizedRayTracerResult.ExitRayPosition];

    % Make the ray path matrix taking two points per surface ray
    % intersection --> exit position    
    totalRayPath (:,[1:2:2*size(rayIntersectionPoints,2)]) = rayIntersectionPoints;
    totalRayPath (:,[2:2:2*size(rayIntersectionPoints,2)]) = exitRayPositions;
    
    rayPathMatrix = reshape(totalRayPath,3,2*nSurface,nRayTotal,nField,nWav);  
    % Ray to dummy surface should not be plotted at all
    
    % NB: To access ray trace result for indWave and indField, the following
    % formula can be used:
    % Index of 1st ray @ indWave and indField =
    % (indWave-1)*(nField*nRay) + (indField-1)*nRay + 1
end
