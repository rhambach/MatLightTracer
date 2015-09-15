function [ matrixOfJonesVector ] = getPolarizationProfile( harmonicFieldSource )
    %GETPOLARIZATIONPROFILE returns matrix of the Jones vector
    
%     samplingPoints = harmonicFieldSource.SamplingPoints;
    [ Nx,Ny ] = getNumberOfSamplingPoints( harmonicFieldSource);
    samplingPoints = [ Nx,Ny ]';
    [ dx,dy ] = getSamplingDistance( harmonicFieldSource);
    samplingDistance = [ dx,dy ];
%     samplingDistance = harmonicFieldSource.SamplingDistance;
%     embeddingFrameSamplePoints = harmonicFieldSource.AdditionalBoarderSamplePoints;
    [ zeroBoarderSamplePoints1, zeroBoarderSamplePoints2] = getZeroBoarderSamplePoints( harmonicFieldSource );
    nBoarderPixel = [ zeroBoarderSamplePoints1, zeroBoarderSamplePoints2]';
    totalSamplingPoints = samplingPoints + 2*nBoarderPixel;
    
    [xlinTot,ylinTot] = generateSamplingGridVectors(totalSamplingPoints,samplingDistance);
    [xMesh,yMesh] = meshgrid(xlinTot,ylinTot);
    
    polarizationType = harmonicFieldSource.PolarizationProfileType;
    polarizationParameters = harmonicFieldSource.PolarizationProfileParameter;
    
    % get the spatial distribution of polarization (jones vector)
    % profile function
    
    % Connect the polarization definition function
    polarizationDefinitionHandle = str2func(getSupportedPolarizationProfiles(polarizationType)); 
    returnFlag = 2; %
    inputDataStruct = struct;
    inputDataStruct.xMesh = xMesh;
    inputDataStruct.yMesh = yMesh;
    [ returnDataStruct ] = polarizationDefinitionHandle(returnFlag,polarizationParameters,inputDataStruct);
    jonesVector = returnDataStruct.JonesVector;
    polDistributionType = returnDataStruct.PolarizationDistributionType;
    switch lower(polDistributionType)
        case ('global')
            matrixOfJonesVector = repmat(reshape(jonesVector,1,1,2),totalSamplingPoints(1),totalSamplingPoints(2));
        case ('local')
            matrixOfJonesVector = jonesVector;
    end
    
end

