function [ returnData1, returnData2, returnData3] = JonesVectorPolarization(...
        returnFlag,polarizationParameters,samplingPoints,samplingDistance)
    % JonesVectorPolarization
    
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function JonesVectorPolarization() needs two arguments',...
                'return type and polarizationParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function JonesVectorPolarization() needs two arguments',...
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
            returnData1 = {'JV1','JV2','Coordinate'};
            returnData2 = {{'numeric'},{'numeric'},{'SP','XY'}};
            polarizationParametersStruct = struct();
            polarizationParametersStruct.JV1 = 1;
            polarizationParametersStruct.JV2 = 0;
            polarizationParametersStruct.Coordinate = 'SP';
            returnData3 = polarizationParametersStruct;
            
        case 2 % Return the Jones vector for the given polarization parameter
            polDistributionType = 'Global';
            jonesVector = [polarizationParameters{1}/norm(polarizationParameters{1});...
                polarizationParameters{2}/norm(polarizationParameters{2})];
            
            returnData1 = jonesVector;
            returnData2 = polDistributionType;
            returnData3 = polarizationParameters{3};
    end
end