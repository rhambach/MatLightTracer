function [ intensityVect, wavelengthVect, referenceWavelengthIndex ] = getPowerSpectrumProfile( harmonicFieldSource )
    %GETSPECTRALPROFILE returns the power spectrum and wavelength vector
    
    spectralProfileType = harmonicFieldSource.SpectralProfileType;
    spectralProfileParameter = harmonicFieldSource.SpectralProfileParameter;
    % get the spectral profile from the corresponding
    % spectral profile function
    % Connect the spectral profile definition function 
    spectralProfileDefinitionHandle = str2func(spectralProfileType);
    returnFlag = 2; %
    [ intensityVect, wavelengthVect  ] = spectralProfileDefinitionHandle(...
        returnFlag,spectralProfileParameter);    
    referenceWavelengthIndex = floor(length(wavelengthVect)/2);
end

