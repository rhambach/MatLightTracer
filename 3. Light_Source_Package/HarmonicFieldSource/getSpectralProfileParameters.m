function [ fieldNames,fieldFormat,uniqueParamStruct ] = getSpectralProfileParameters( variableInputArgument )
    %getSpectralProfileParameters returns the fieldName,fieldType and
    %SpectralProfileParameter struct.
    % variableInputArgument:
    % 1. Struct/object --> inputHarmonicField
    % 2. Char --> profileType
    if nargin == 0
        returnDefault = 1;
        spectralProfileType = 'GaussianPowerSpectrum';
    elseif isHarmonicField(variableInputArgument)
        inputHarmonicField = variableInputArgument;
        returnDefault = 0;
        spectralProfileType = inputHarmonicField.SpectralProfileType;
    elseif ischar(variableInputArgument)
        returnDefault = 1;
        spectralProfileType = variableInputArgument;
    else
        disp('Error: Invalid input to getSpectralProfileParameters. So it is just ignored.');
        returnDefault = 1;
        spectralProfileType = 'GaussianPowerSpectrum';
    end
    % Connect the profile definition function
    spectralProfileDefinitionHandle = str2func(spectralProfileType);
    returnFlag = 1;
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = spectralProfileDefinitionHandle(returnFlag);
    
    if returnDefault
        uniqueParamStruct = defaultUniqueParamStruct;
    else
        uniqueParamStruct = inputHarmonicField.SpectralProfileParameter;
    end
end

