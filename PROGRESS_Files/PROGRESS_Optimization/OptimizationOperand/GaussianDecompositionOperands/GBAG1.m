function [ returnDataStruct] = GBAG1(...
        returnFlag,uniqueParameters,inputDataStruct)
    %GBAG: Gaussian beam agregate 
    % operandUniqueParameters = values of {'nPoints'} unique to this operand function
    % inputDataStruct : Struct of all additional inputs (not included in the
    % operandUniqueParameters) required for computing the return.
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
    % 2: The operand function evaluated value for given input parameters
    %   Input Struct:
    %       OptimizableObject % Gauss1DArray
    %       AdditionalParameters.Rect1D % The given rectangular signal to
    %       be decomposed
    %       AdditionalParameters.Nx;
    %   Output Struct:
    %       returnDataStruct.Value
    % 3: Set the varibale parameters of the operand function and return the
    % newOperand
    
    %% Default input vaalues
    if nargin == 0
        disp('Error: The function GaussianDecompositionOfRectRMSE() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 3
            uniqueParameters = struct();
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for GaussianDecompositionOfRectRMSE().');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % Merit function specific 'MeritFunctionUniqueParameters'
            uniqueParametersStructFieldNames = {'nPoints','lowerX','upperX'};
            uniqueParametersStructFieldTypes = {{'numeric'},{'numeric'},{'numeric'}};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.nPoints = 100;
            defaultUniqueParametersStruct.lowerX = -1.5;
            defaultUniqueParametersStruct.upperX = 1.5;
            
            returnDataStruct = struct();
            returnDataStruct.UniqueParametersStructFieldNames = uniqueParametersStructFieldNames;
            returnDataStruct.UniqueParametersStructFieldTypes = uniqueParametersStructFieldTypes;
            returnDataStruct.DefaultUniqueParametersStruct = defaultUniqueParametersStruct;
        case 2 % The merit function value evaluated for given input parameters
            myGauss1DArray =  inputDataStruct.OptimizableObject;
            returnDataStruct = struct();
            nPoints = uniqueParameters.nPoints;
            lowerX = uniqueParameters.lowerX;
            upperX = uniqueParameters.upperX;
            xlin = linspace(lowerX,upperX,nPoints);
            % COmpute the agregate value
            [ totalAmpGauss,individualAmpGauss ] = computeGaussAmplitude1D( myGauss1DArray,xlin );
            returnDataStruct.Value = totalAmpGauss; 
    end
    
    
end

