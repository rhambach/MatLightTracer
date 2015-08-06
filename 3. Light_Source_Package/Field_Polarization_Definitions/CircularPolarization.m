function [ returnData1, returnData2, returnData3] = CircularPolarization(...
        returnFlag,polarizationParameters,samplingPoints,samplingDistance)
    % CircularPolarization
    
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function CircularPolarization() needs two arguments',...
                'return type and polarizationParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function CircularPolarization() needs two arguments',...
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
            returnData1 = {'DirectionOfRotation'};
            returnData2 = {{'Right','Left'}};
            polarizationParametersStruct = struct();
            polarizationParametersStruct.DirectionOfRotation = 'Right';
            returnData3 = polarizationParametersStruct;
            
        case 2 % Return the Jones vector for the given polarization parameter
            polDistributionType = 'Global';
            dirOfRot = (polarizationParameters{1});
            switch lower(dirOfRot)
                case lower('Left')
                    jonesVector = (1/sqrt(2))*[1;-1i];
                case lower('Right')
                    jonesVector = (1/sqrt(2))*[1;1i];
            end
            
            
            returnData1 = jonesVector;
            returnData2 = polDistributionType;
            returnData3 = 'SP';
    end
end