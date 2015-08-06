function [ returnData1, returnData2, returnData3] = ExamplePowerSpectrum(...
        returnFlag,powerSpectrumParameters)
    %% Default input vaalues
    if nargin < 2
        disp(['Error: The function ExamplePowerSpectrum() needs two arguments',...
            'return type and PowerSpectrumParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of PowerSpectrumParameters
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            spectralParametersStruct = struct();
            spectralParametersStruct.Unused = 0;
            returnData3 = spectralParametersStruct;
        case 2 % Return the spectral profile as matrix of Wavelength-Amplitude-Phase
            returnData1 = [];
            returnData2 = NaN;
            returnData3 = NaN;
    end
end