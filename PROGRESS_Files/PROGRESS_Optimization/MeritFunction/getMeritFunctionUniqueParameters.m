function [fieldNames,fieldFormat,uniqueParamStruct] = getMeritFunctionUniqueParameters( variableInputArgument )
    %getUniqueParameters Returns the field names, formats, and current
    %struct of all unique parameters which are specific to this merit function type
    % Inputs:
    % variableInputArgument:
    %       1. Struct/object --> currentMeritFunction
    %       2. Char --> meritFunctionName
    % Outputs:
    %   [fieldNames,fieldFormat,uniqueParamStruct]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    if nargin == 0
        returnDefault = 1;
        meritFunctionName = 'DefaultMeritFunction';
    elseif isMeritFunction(variableInputArgument)
        currentMeritFunction = variableInputArgument;
        returnDefault = 0;
        meritFunctionName = currentMeritFunction.Name;
    elseif ischar(variableInputArgument)
        returnDefault = 1;
        meritFunctionName = variableInputArgument;
    else
        disp('Error: Invalid input to getMeritFunctionUniqueParameters. So it is just ignored.');
        returnDefault = 1;
        meritFunctionName = 'DefaultMeritFunction';
    end
    
    if returnDefault
        % Connect the surface definition function
        meritFunctionHandle = str2func(meritFunctionName);
        returnFlag = 1;
        [returnDataStruct] = meritFunctionHandle(returnFlag);
        fieldNames = returnDataStruct.UniqueParametersStructFieldNames;
        fieldFormat = returnDataStruct.UniqueParametersStructFieldTypes;
        defaultUniqueParamStruct = returnDataStruct.DefaultUniqueParametersStruct;
        uniqueParamStruct = defaultUniqueParamStruct;
    else
        uniqueParamStruct = currentMeritFunction.UniqueParameters;
    end
end

