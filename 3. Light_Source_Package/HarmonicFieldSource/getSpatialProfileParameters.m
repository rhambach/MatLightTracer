function [ fieldNames,fieldFormat,uniqueParamStruct ] = getSpatialProfileParameters( variableInputArgument )
    %GETSPATIALPROFILEPARAMETERS returns the fieldName,fieldType and
    %spatialProfileParameter struct.
    % variableInputArgument:
    % 1. Struct/object --> inputHarmonicField
    % 2. Char --> profileType
    
    if nargin == 0
        returnDefault = 1;
        spatialProfileType = 'GaussianWaveProfile';
    elseif isHarmonicField(variableInputArgument)
        inputHarmonicField = variableInputArgument;
        returnDefault = 0;
        spatialProfileType = inputHarmonicField.SpatialProfileType;
    elseif ischar(variableInputArgument)
        returnDefault = 1;
        spatialProfileType = variableInputArgument;
    else
        disp('Error: Invalid input to getSpatialProfileParameters. So it is just ignored.');
        returnDefault = 1;
        spatialProfileType = 'GaussianWaveProfile';
    end
    % Connect the surface definition function
    spatialDefinitionHandle = str2func(spatialProfileType);
    returnFlag = 1;
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = spatialDefinitionHandle(returnFlag);
    
    if returnDefault
        uniqueParamStruct = defaultUniqueParamStruct;
    else
        uniqueParamStruct = inputHarmonicField.SpatialProfileParameter;
    end
end

