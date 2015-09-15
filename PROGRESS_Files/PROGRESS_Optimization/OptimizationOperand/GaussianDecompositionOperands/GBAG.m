function [ returnDataStruct] = GBAG(...
        returnFlag,uniqueParameters,inputDataStruct)
    %GBAG: Gaussian beam agregate in 2D
    % operandUniqueParameters = values of {'nPoints'} unique to this operand function
    % inputDataStruct : Struct of all additional inputs (not included in the
    % operandUniqueParameters) required for computing the return.
    % (Vary depending on the returnFlag)
    % returnFlag : An integer indicating what is requested. Depending on it the
    % returnDataStruct and inputDataStruct will have different fields
    % 1: Operand function specific 'UniqueParameters' table field names
    %    and initial values in Merit function Editor GUI
    %   Input Struct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.UniqueParametersStructFieldNames
    %       returnDataStruct.UniqueParametersStructFieldTypes
    %       returnDataStruct.UniqueParametersDefaultStruct
    % 2: The operand function evaluated value for given input parameters
    %   Input Struct:
    %       OptimizableObject % gaussianBeamSet
    %   Output Struct:
    %       returnDataStruct.Value

    
    %% Default input vaalues
    if nargin == 0
        disp('Error: The function GBAG (Gaussian Beam Agregate) needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 3
            uniqueParameters = struct();
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for GBAG (Gaussian Beam Agregate).');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % Merit function specific 'MeritFunctionUniqueParameters'
            uniqueParametersStructFieldNames = {'nPointsX','nPointsY','lowerX','lowerY','upperX','upperY'};
            uniqueParametersStructFieldTypes = {{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'}};
            
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.nPointsX = 100;
            defaultUniqueParametersStruct.lowerX = -1.5;
            defaultUniqueParametersStruct.upperX = 1.5;
            defaultUniqueParametersStruct.nPointsY = 100;
            defaultUniqueParametersStruct.lowerY = -1.5;
            defaultUniqueParametersStruct.upperY = 1.5;
            
            returnDataStruct = struct();
            returnDataStruct.UniqueParametersStructFieldNames = uniqueParametersStructFieldNames;
            returnDataStruct.UniqueParametersStructFieldTypes = uniqueParametersStructFieldTypes;
            returnDataStruct.DefaultUniqueParametersStruct = defaultUniqueParametersStruct;
        case 2 % The merit function value evaluated for given input parameters
            gaussianBeamSet =  inputDataStruct.OptimizableObject;
            returnDataStruct = struct();
            
            nPointsX = uniqueParameters.nPointsX;
            lowerX = uniqueParameters.lowerX;
            upperX = uniqueParameters.upperX;
            xlin = linspace(lowerX,upperX,nPointsX);
            
            nPointsY = uniqueParameters.nPointsY;
            lowerY = uniqueParameters.lowerY;
            upperY = uniqueParameters.upperY;
            ylin = linspace(lowerY,upperY,nPointsY);
            
            % COmpute the agregate value
            [ totalAmpGauss,individualAmpGauss,X,Y ] = computeTotalGaussianAmplitude( gaussianBeamSet,xlin,ylin );
            returnDataStruct.Value = totalAmpGauss; 
            returnDataStruct.X = X;
            returnDataStruct.Y = Y;
    end
    
    
end

