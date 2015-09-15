function [ returnDataStruct ] = EmptyMeritFunction(...
        returnFlag,meritFunctionParameters,inputDataStruct)
    %EmptyMeritFunction Defines a Empty merit function 
    % meritFunctionParameters = values of {'Unused'}
    % inputDataStruct : Struct of all additional inputs (not included in 
    % the meritFunctionParameters)required for computing the return. 
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
    %       inputDataStruct.OpticalSystem
    %   Output Struct:
    %       returnDataStruct.Value
    
    
end

