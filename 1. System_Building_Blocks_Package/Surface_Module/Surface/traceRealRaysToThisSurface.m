function [ geometricalPathLength,additionalPathLength,localRayIntersectionPoint,...
        localSurfaceNormal,localExitRayPosition,localExitRayDirection,...
        totalInternalReflectionFlag,noIntersectionPointFlag] = ...
        traceRealRaysToThisSurface(currentSurface,rayPosition,rayDirection,...
        indexBefore,indexAfter,wavlenInM,referenceWavlenInM,reflection )
    %TRACERAYSTOTHISSURFACE Traces real rays to the current surface and returns
    %all neccessary results
    
    returnFlag = 6; % Real ray tracing
    surfaceType = currentSurface.Type;
    surfaceUniqueParameters = currentSurface.UniqueParameters;
    
    inputDataStruct = struct();
    reverseTracing = 0;
    inputDataStruct.InitialRayPosition = rayPosition;
    inputDataStruct.InitialRayDirection = rayDirection;
    inputDataStruct.ReverseTracingFlag = reverseTracing;
    inputDataStruct.ReflectionFlag = reflection;
    inputDataStruct.IndexBefore = indexBefore;
    inputDataStruct.IndexAfter = indexAfter;
    inputDataStruct.Wavelength = wavlenInM;
    inputDataStruct.ReferenceWavelength = referenceWavlenInM;
    
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    [ returnDataStruct] = surfaceDefinitionHandle(returnFlag,...
        surfaceUniqueParameters,inputDataStruct);
    
    geometricalPathLength = returnDataStruct.GeometricalPathLength;
    additionalPathLength = returnDataStruct.AdditionalPathLength;
    localRayIntersectionPoint = returnDataStruct.LocalRayIntersectionPoint;
    localSurfaceNormal = returnDataStruct.LocalSurfaceNormal;
    localExitRayPosition = returnDataStruct.LocalExitRayPosition;
    localExitRayDirection = returnDataStruct.LocalExitRayDirection;
    totalInternalReflectionFlag = returnDataStruct.TotalInternalReflectionFlag;
    noIntersectionPointFlag = returnDataStruct.NoIntersectionPointFlag;
    
end

