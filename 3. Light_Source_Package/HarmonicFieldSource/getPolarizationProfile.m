function [ matrixOfJonesVector ] = getPolarizationProfile( harmonicFieldSource )
    %GETPOLARIZATIONPROFILE returns matrix of the Jones vector
    
    samplingPoints = harmonicFieldSource.SamplingPoints;
    samplingDistance = harmonicFieldSource.SamplingDistance;
    embeddingFrameSamplePoints = harmonicFieldSource.AdditionalBoarderSamplePoints;
    
    totalSamplingPoints = samplingPoints + 2*embeddingFrameSamplePoints;
    
    polarizationType = harmonicFieldSource.PolarizationType;
    polarizationParameters = harmonicFieldSource.PolarizationParameters;
    
    % get the spatial distribution of polarization (jones vector)
    % profile function
    
    % Connect the polarization definition function
    polarizationDefinitionHandle = str2func(polarizationType);
    returnFlag = 2; %
    [ jonesVector,polDistributionType ] = polarizationDefinitionHandle(...
        returnFlag,polarizationParameters,totalSamplingPoints,samplingDistance);
    switch lower(polDistributionType)
        case ('Global')
            matrixOfJonesVector = jonesVector.*ones(totalSamplingPoints(1),totalSamplingPoints(2),1);
        case ('Local')
            matrixOfJonesVector = jonesVector;
    end
    
end

