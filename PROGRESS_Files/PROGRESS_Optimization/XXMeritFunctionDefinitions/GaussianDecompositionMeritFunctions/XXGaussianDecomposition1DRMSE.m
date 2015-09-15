function [ returnDataStruct] = GaussianDecomposition1DRMSE(...
        returnFlag,meritFunctionParameters,inputDataStruct)
    %GaussianDecompositionOfRectRMSE (Root mean square error) Defines a merit function for computing
    %    the rms error of an input data and fitted data.
    % meritFunctionParameters = values of {'Gauss1DArray','Rect1D','Nx'}
    % unique to this merit function
    % inputDataStruct : Struct of all additional inputs (not included in the
    % meritFunctionParameters) required for computing the return.
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
    % 3: Set the varibale parameters of the Merit function and return the
    % newMeritFunction
    
    %% Default input vaalues
    if nargin == 0
        disp('Error: The function GaussianDecompositionOfRectRMSE() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 3
            meritFunctionParameters = struct();
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
            uniqueParametersStructFieldNames = {'nGauss','SignalCenter','SignalWidth','SignalAmplitudeVector','SignalEdgeFactor','nSampling'};
            uniqueParametersStructFieldTypes = {{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'}};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.nGauss = 10;
            defaultUniqueParametersStruct.SignalCenter = 0;
            defaultUniqueParametersStruct.SignalWidth = 20;
            defaultUniqueParametersStruct.SignalAmplitudeVector = ones(100,1);
            defaultUniqueParametersStruct.SignalEdgeFactor = 0.1;
            defaultUniqueParametersStruct.nSampling = 100;
            
            returnDataStruct = struct();
            returnDataStruct.UniqueParametersStructFieldNames = uniqueParametersStructFieldNames;
            returnDataStruct.UniqueParametersStructFieldTypes = uniqueParametersStructFieldTypes;
            returnDataStruct.DefaultUniqueParametersStruct = defaultUniqueParametersStruct;
        case 2 % The merit function value evaluated for given input parameters
            myGauss1DArray =  inputDataStruct.OptimizableObject;
            returnDataStruct = struct();
            % compute the RMS error
            givenAmpVector = meritFunctionParameters.SignalAmplitudeVector;
            nx = length(givenAmpVector);
            lowerX = meritFunctionParameters.SignalCenter - (0.5 + meritFunctionParameters.SignalEdgeFactor)*meritFunctionParameters.SignalWidth;
            upperX = meritFunctionParameters.SignalCenter + (0.5 + meritFunctionParameters.SignalEdgeFactor)*meritFunctionParameters.SignalWidth;
            xlin = linspace(lowerX,upperX,nx);
            
            [ totalAmpGauss,individualAmpGauss ] = computeGaussAmplitude1D( myGauss1DArray,xlin );
            
            returnDataStruct.Value = sqrt(sum((givenAmpVector(:)-totalAmpGauss(:)).^2)/nx); 
        case 3 % The defualt optimizable object
            nGauss = 10;
            gaussAmplitude = [1,0,-Inf,Inf];
            gaussCenter = [0,0,-Inf,Inf];
            gaussWaistRadius = [1,0,-Inf,Inf];
            
            gauss1DArray = Gauss1D( gaussAmplitude,gaussCenter,gaussWaistRadius,nGauss );
            returnDataStruct.OptimizableObject = gauss1DArray;
    end
    
    
end

