function [ returnData1, returnData2, returnData3] = GaussianPowerSpectrum(...
        returnFlag,PowerSpectrumParameters)
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function GaussianPowerSpectrum() needs two arguments',...
                'return type and PowerSpectrumParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function GaussianPowerSpectrum() needs two arguments',...
            'return type and PowerSpectrumParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of PowerSpectrumParameters
            returnData1 = {'CentralWavelength','HalfWidthHalfMaxima','NumberOfSamplingPoints','CutoffPowerFactor'};
            returnData2 = {{'numeric'},{'numeric'},{'numeric'},{'numeric'}};
            spectralParametersStruct = struct();
            spectralParametersStruct.CentralWavelength = 550*10^-9;
            spectralParametersStruct.HalfWidthHalfMaxima = 20*10^-9;
            spectralParametersStruct.NumberOfSamplingPoints = 20;
            spectralParametersStruct.CutoffPowerFactor = 0.01;
            returnData3 = spectralParametersStruct;
            
        case 2 % Return the spectral profile Wavelength and intensity vectors
            % Here we have used the same formulas from VirtualLab manual
            lambda0 = PowerSpectrumParameters.CentralWavelength;
            lambdaHWHM = PowerSpectrumParameters.HalfWidthHalfMaxima;
            nSampling = PowerSpectrumParameters.NumberOfSamplingPoints;
            cutoffPowerFactor = PowerSpectrumParameters.CutoffPowerFactor;
            
            % power spectrum is computed in frequency domain
            c = 299792458;
            omega0 = 2*pi*c/lambda0;
            omegaHWHM = -(omega0/lambda0)*lambdaHWHM;
            omegaMin = omega0 + omegaHWHM*sqrt(-log(cutoffPowerFactor)/log(2));
            omegaMax = 2*omega0 - omegaMin;
            
            lambdaMin = 2*pi*c/omegaMin;
            lambdaMax = 2*pi*c/omegaMax;
            
            % equidistance sampling in wavelength domain
            wavLenVector = (linspace(lambdaMin,lambdaMax,nSampling))';
            omegaVector =  2*pi*c./wavLenVector;
            intVector = exp(-log(2)*(omegaVector-omega0).^2/(omegaHWHM)^2);
            
            returnData1 = intVector;
            returnData2 = wavLenVector;
            returnData3 = NaN;
    end
end