function [ returnData1, returnData2, returnData3] = HomogenousPowerSpectrum(...
        returnFlag,PowerSpectrumParameters)
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function HomogenousPowerSpectrum() needs two arguments',...
                'return type and PowerSpectrumParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function HomogenousPowerSpectrum() needs two arguments',...
            'return type and PowerSpectrumParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of PowerSpectrumParameters
            returnData1 = {'CentralWavelength','SpectralBandwidth','NumberOfSamplePoints'};
            returnData2 = {{'numeric'},{'numeric'},{'numeric'}};
            spectralParametersStruct = struct();
            spectralParametersStruct.CentralWavelength = 550*10^-9;
            spectralParametersStruct.SpectralBandwidth = 40*10^-9;
            spectralParametersStruct.NumberOfSamplingPoints = 20;
            returnData3 = spectralParametersStruct;
            
        case 2 % Return the spectral profile as matrix of Wavelength-intensity
            centralWavLen = PowerSpectrumParameters.CentralWavelength;
            bandwidth = PowerSpectrumParameters.SpectralBandwidth;
            nSamplingPoints = PowerSpectrumParameters.NumberOfSamplePoints;
            
            wavLenVector = (linspace(centralWavLen-bandwidth/2,centralWavLen-bandwidth/2,nSamplingPoints))';
            intVector = ones(nSamplingPoints,1);
            
            returnData1 = intVector;
            returnData2 = wavLenVector;
            returnData3 = NaN;
    end
end