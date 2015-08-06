function [ fieldNames,fieldFormat,uniqueParamStruct ] = getPolarizationProfileParameters( variableInputArgument )
    %getPolarizationProfileParameters returns the fieldName,fieldType and
    %polarizationProfileParameter struct.
    % variableInputArgument:
    % 1. Struct/object --> inputHarmonicField
    % 2. Char --> profileType
    if nargin == 0
        returnDefault = 1;
        polarizationProfileType = 'LinearPolarization';
    elseif isHarmonicField(variableInputArgument)
        inputHarmonicField = variableInputArgument;
        returnDefault = 0;
        polarizationProfileType = inputHarmonicField.PolarizationProfileType;
    elseif ischar(variableInputArgument)
        returnDefault = 1;
        polarizationProfileType = variableInputArgument;
    else
        disp('Error: Invalid input to getpolarizationProfileParameters. So it is just ignored.');
        returnDefault = 1;
        polarizationProfileType = 'LinearPolarization';
    end
    
    % Connect the profile definition function
    polarizationProfileDefinitionHandle = str2func(polarizationProfileType);
    returnFlag = 1;
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = polarizationProfileDefinitionHandle(returnFlag);
    
    if returnDefault
        uniqueParamStruct = defaultUniqueParamStruct;
    else
        uniqueParamStruct = inputHarmonicField.PolarizationProfileParameter;
    end
end

