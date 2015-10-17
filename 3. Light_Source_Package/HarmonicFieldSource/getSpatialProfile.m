function [ U_xyTot,xlinTot,ylinTot] = getSpatialProfile( harmonicFieldSource,xlinTot,ylinTot)
    %GETSPATIALPROFILE Returns the spatial profile of the harmonic field
    %source which is computed from The spatial profile + Edge smoothening +
    %Embeding in to border frame.
    
    if nargin < 1
        disp('Error: The function getSpatialProfile requires atleast an input sargument of harmonicFieldSource.');
        U_xyTot = NaN;
        xlinTot = NaN;
        ylinTot = NaN;
        return;
    end
    if nargin < 3
        [ nBoarderPixel1, nBoarderPixel2] = getZeroBoarderSamplePoints( harmonicFieldSource );
        nBoarderPixel = [ nBoarderPixel1, nBoarderPixel2]';
        [Nx,Ny] = getNumberOfSamplingPoints(harmonicFieldSource);
        [dx,dy] = getSamplingDistance(harmonicFieldSource,Nx,Ny);
        samplingPoints = [Nx,Ny]';
        samplingDistance = [dx,dy]';
%         lateralPosition = harmonicFieldSource.LateralPosition;
        [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance);
        
        [xlinTot,ylinTot] = generateSamplingGridVectors(samplingPoints+2*nBoarderPixel,samplingDistance);
    else
        % Get the field size without the zero border
        [diameterX2,diameterY2] = getSpatialShapeAndSize( harmonicFieldSource,2 );
        
        xlin = xlinTot(abs(xlinTot) <= diameterX2/2);
        ylin = ylinTot(abs(ylinTot) <= diameterY2/2);
    end
    spatialProfileType = harmonicFieldSource.SpatialProfileType;
    spatialProfileParameters = harmonicFieldSource.SpatialProfileParameter;
    
    [fieldDiameterX1,fieldDiameterY1,boarderShape] = getSpatialShapeAndSize( harmonicFieldSource,1 );
    fieldDiameter = [fieldDiameterX1,fieldDiameterY1]';
    smootheningEdgeType = harmonicFieldSource.SmoothEdgeSizeSpecification;
    
    % get the spatial profile from the corresponding spatial profile function
    % Connect the spatial profile definition function
    spatialProfileDefinitionHandle = str2func(getSupportedSpatialProfiles(spatialProfileType));
    returnFlag = 3; %
    inputDataStruct = struct();
    [xMesh,yMesh] = meshgrid(xlin,ylin);
    inputDataStruct.xMesh = xMesh;
    inputDataStruct.yMesh = yMesh;
    inputDataStruct.LateralPosition = harmonicFieldSource.LateralPosition;
    [ returnDataStruct ] = spatialProfileDefinitionHandle(returnFlag,spatialProfileParameters,inputDataStruct);
    U_xy = returnDataStruct.SpatialProfileMatrix;
    
    % compute edge smoothening function
    smootheningEdgeValue = harmonicFieldSource.SmoothEdgeSizeValue;
    switch (smootheningEdgeType)
        case 1 %('Relative')
            absoluteEdgeValue = (smootheningEdgeValue).*fieldDiameter;
        case 2 % ('Absolute')
            absoluteEdgeValue = [smootheningEdgeValue,smootheningEdgeValue]';
    end
     lateralPosition = harmonicFieldSource.LateralPosition;
%         xlin = xlin - lateralPosition(1);
%     ylin = ylin - lateralPosition(2);
%     xlinTot = xlinTot - lateralPosition(1);
%     ylinTot = ylinTot - lateralPosition(2);  
    [edgeSmootheningFunction] = getEdgeSmootheningFunction(...
        xlin,ylin,boarderShape,absoluteEdgeValue,lateralPosition);
    U_xy_SmoothEdge = U_xy.*edgeSmootheningFunction;
    
    % Add the field into the embedding frame
    [U_xyTot] = EmbedInToFrame(U_xy_SmoothEdge,nBoarderPixel);  
end

