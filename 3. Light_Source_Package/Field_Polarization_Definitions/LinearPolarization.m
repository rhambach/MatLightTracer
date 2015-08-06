function [ returnData1, returnData2, returnData3] = LinearPolarization(...
        returnFlag,polarizationParameters,samplingPoints,samplingDistance)
    % LINEARPOLARIZATION
    
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function LinearPolarization() needs two arguments',...
                'return type and polarizationParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function LinearPolarization() needs two arguments',...
            'return type and polarizationParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    elseif nargin < 4
        samplingPoints = NaN;
        samplingDistance = NaN;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of polarizationParameters
            returnData1 = {'Angle'};
            returnData2 = {{'numeric'}};
            polarizationParametersStruct = struct();
            polarizationParametersStruct.Angle = 0;
            returnData3 = polarizationParametersStruct;
            
        case 2 % Return the Jones vector for the given polarization parameter
            polDistributionType = 'Global';
            angleInRad = (polarizationParameters{1})*pi/180;
            jonesVector = [cos(angleInRad);sin(angleInRad)];
            
            returnData1 = jonesVector;
            returnData2 = polDistributionType;
            returnData3 = 'SP';
    end
end