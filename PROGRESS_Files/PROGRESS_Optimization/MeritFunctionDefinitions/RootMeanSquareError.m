function [ returnDataStruct ] = RootMeanSquareError( returnFlag,...
        uniqueParameters,inputDataStruct )
      %RootMeanSquareError  Defines a merit function for computing
    %    the rms error of an input data and fitted data.
    % uniqueParameters = values {'Unused'} unique to this merit function
    % inputDataStruct : Struct of all additional inputs (not included in the
    % uniqueParameters) required for computing the return.
    % (Vary depending on the returnFlag)
    % returnFlag : An integer indicating what is requested. Depending on it the
    % returnDataStruct and inputDataStruct will have different fields
    % 1: Merit function specific 'MeritFunctionUniqueParameters' table field names
    %    and initial values in Merit function Editor GUI
    %   Input Struct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.UniqueParametersStructFieldNames
    %       returnDataStruct.UniqueParametersStructFieldTypes
    %       returnDataStruct.UniqueParametersDefaultStruct
    % 2: The merit function evaluated value for given input parameters
    %   Input Struct:
    %       optimizableObject % Gauss1DArray
    %       additionalParameters.Rect1D % The given rectangular signal to
    %       be decomposed
    %       additionalParameters.Nx;
    %   Output Struct:
    %       returnDataStruct.Value
    
    %% Default input vaalues
    if nargin == 0
        disp('Error: The function RootMeanSquareError() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 3
            uniqueParameters = struct();
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for RootMeanSquareError().');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % Merit function specific 'UniqueParameters'
            uniqueParametersStructFieldNames = {'Unused'};
            uniqueParametersStructFieldTypes = {{'numeric'}};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.Unused = 0;

            returnDataStruct = struct();
            returnDataStruct.UniqueParametersStructFieldNames = uniqueParametersStructFieldNames;
            returnDataStruct.UniqueParametersStructFieldTypes = uniqueParametersStructFieldTypes;
            returnDataStruct.DefaultUniqueParametersStruct = defaultUniqueParametersStruct;
        case 2 % The merit function value evaluated for given input parameters
            optimizableObject =  inputDataStruct.OptimizableObject;
            operandArray = inputDataStruct.OptimizationOperand;
            
            returnDataStruct = struct();
            
            % compute the RMS error using the formula given in zemax manual
            % RMSE = SQRT[(SUM(weight*(target-value)^2)/(SUM(weight))]
            
            [totlaValueVector,totalTargetVector,totalWeightVector] = computeOperandValue(operandArray,optimizableObject);

            % First make a huge vector of all operand values, targets and
            % weights
            nOperands = length(operandArray);


            RMSE = sqrt((sum(totalWeightVector.*(totalTargetVector-totlaValueVector).^2))/(sum(totalWeightVector)));

            returnDataStruct.Value = RMSE;
    end  
end

