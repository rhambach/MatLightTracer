function [ U_xyTot,xlinTot,ylinTot] = getSpatialProfile( harmonicFieldSource )
    %GETSPATIALPROFILE Returns the spatial profile of the harmonic field
    %source which is computed from The spatial profile + Edge smoothening +
    %Embeding in to border frame.
    
    spatialProfileType = harmonicFieldSource.SpatialProfileType;
    spatialProfileParameters = harmonicFieldSource.SpatialProfileParameters;
    samplingPoints = harmonicFieldSource.SamplingPoints;
    samplingDistance = harmonicFieldSource.SamplingDistance;
    smootheningEdgeType = harmonicFieldSource.EdgeSizeSpecification;
    
    smootheningEdgeValue = harmonicFieldSource.RelativeEdgeSizeFactor;
    embeddingFrameSamplePoints = harmonicFieldSource.AdditionalBoarderSamplePoints;
    
    switch lower(harmonicFieldSource.FieldSizeSpecification)
        case lower('Relative')
            % get the boarder shape and field size from the corresponding
            % spatial profile function
            
            % Connect the spatial profile definition function            
            spatialProfileDefinitionHandle = str2func(spatialProfileType);
            returnFlag = 3; %
            [ boarderShape,fieldDiameter ] = spatialProfileDefinitionHandle(...
                returnFlag,spatialProfileParameters,samplingPoints,samplingDistance);
            
        case lower('Absolute')
            boarderShape = harmonicFieldSource.AbsoluteBoarderShape;
            fieldDiameter = harmonicFieldSource.AbsoluteFieldSize;
    end
    
    % get the spatial profile from the corresponding
    % spatial profile function
    % Connect the spatial profile definition function 
    spatialProfileDefinitionHandle = str2func(spatialProfileType);
    returnFlag = 2; %
    [ U_xy ] = spatialProfileDefinitionHandle(...
        returnFlag,spatialProfileParameters,samplingPoints,samplingDistance);
       
    % compute edge smoothening function
    switch lower(smootheningEdgeType)
        case lower('Absolute')
            absouteEdgeValue = smootheningEdgeValue;
        case lower('Relative')
            absouteEdgeValue = (1 - smootheningEdgeValue)*fieldDiameter;
    end
    
    [edgeSmootheningFunction] = getEdgeSmootheningFunction(...
        samplingPoints,samplingDistance,boarderShape,absouteEdgeValue);
    
    U_xy_SmoothEdge = U_xy.*edgeSmootheningFunction;
    % Add the field into the embedding frame
    [U_xyTot,xlinTot,ylinTot] = EmbedInToFrame(U_xy_SmoothEdge,...
        embeddingFrameSamplePoints,samplingPoints,samplingDistance);    
end

