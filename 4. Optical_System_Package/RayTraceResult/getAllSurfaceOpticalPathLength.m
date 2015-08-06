function [ opticalPathLength,opticalPathLength2 ] = getAllSurfaceOpticalPathLength( allSurfaceRayTraceResult,...
        rayPupilIndices,rayFieldIndices,rayWavelengthIndices)
    %getAllSurfaceOpticalPathLength: Returns the exit ray direction of a specific
    % ray specified by (rayPupilIndex,rayFieldIndex,rayWavIndex) for all surfaces
    % Input:
    %   allSurfaceRayTraceResult: vector of raytrace result (size = nSurf)
    %   (rayPupilIndex,rayFieldIndex,rayWavIndex) : Indices specifying a given
    %   ray
    % Output:
    %   opticalPathLengths: is (1 X nSurface X nPupilPointsRequested X nFieldRequested X nWavRequested)
    
    if nargin == 0
        disp(['Error: The function  getAllSurfaceOpticalPathLength requires ',...
            'atleast the surface trace result struct as argument.']);
        opticalPathLength = NaN;
        return;
    elseif nargin == 1
        rayPupilIndices = 0; % All
        rayFieldIndices = 0; % All
        rayWavelengthIndices = 0; % All
    elseif nargin == 2
        rayFieldIndices = 0; % All
        rayWavelengthIndices = 0; % All
    elseif nargin == 3
        rayWavelengthIndices = 0; % All
    else
        
    end
    
    
    % Compute the GeometricalPathLength,indexBefore and additionalPath
    requestedResultFieldName1 = 'GeometricalPathLength';
    requestedFieldFirstDim1 = 1;
    geometricalPathLength = getRayTraceResultFieldForAllSurfaces( ...
        allSurfaceRayTraceResult,requestedResultFieldName1,requestedFieldFirstDim1,...
        rayPupilIndices,rayFieldIndices,rayWavelengthIndices);
    
    requestedResultFieldName2 = 'RefractiveIndex';
    requestedFieldFirstDim2 = 1;
    refractiveIndex = getRayTraceResultFieldForAllSurfaces( ...
        allSurfaceRayTraceResult,requestedResultFieldName2,requestedFieldFirstDim2,...
        rayPupilIndices,rayFieldIndices,rayWavelengthIndices);
    
    % compute the indexBefore each surface matrice
    nSurf = size(refractiveIndex,2);
    nPupilIndice = size(refractiveIndex,3);
    nFieldIndice = size(refractiveIndex,4);
    nWavelengthIndice = size(refractiveIndex,5);
    if nWavelengthIndice == 1 && nFieldIndice == 1
        indexBefore(1,:,:) = 0*refractiveIndex+1;
        indexBefore(1,2:end,:) = refractiveIndex(1,1:end-1,:);
    elseif nWavelengthIndice == 1
        indexBefore(1,:,:,:) = 0*refractiveIndex+1;
        indexBefore(1,2:end,:,:) = refractiveIndex(1,1:end-1,:,:);
    else
        indexBefore(1,1,:,:,:) = 0*refractiveIndex+1;
        indexBefore(1,2:end,:,:,:) = refractiveIndex(1,1:end-1,:,:,:);
    end
    requestedResultFieldName2 = 'AdditionalPathLength';
    requestedFieldFirstDim2 = 1;
    additionalPathLength = getRayTraceResultFieldForAllSurfaces( ...
        allSurfaceRayTraceResult,requestedResultFieldName2,requestedFieldFirstDim2,...
        rayPupilIndices,rayFieldIndices,rayWavelengthIndices);
    
    % now compute the OpticalPathLength
    opticalPathLength = indexBefore.*(geometricalPathLength + additionalPathLength);
    
    
    %% for checking
    requestedResultFieldName = 'OpticalPathLength';
    requestedFieldFirstDim = 1;
    opticalPathLength2 = getRayTraceResultFieldForAllSurfaces( ...
        allSurfaceRayTraceResult,requestedResultFieldName,requestedFieldFirstDim,...
        rayPupilIndices,rayFieldIndices,rayWavelengthIndices);
end

