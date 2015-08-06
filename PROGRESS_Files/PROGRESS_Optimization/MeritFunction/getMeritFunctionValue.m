function [meritFunctionValue] = getMeritFunctionValue( currentMeritFunction )
    %getMeritFunctionValue Returns the Merit Function Value
    % Inputs:
    % currentMeritFunction:
    %       1. Struct/object --> currentMeritFunction
    % Outputs:
    %   [meritFunctionValue]
    
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
        disp('Error: The function getMeritFunctionValue requires atleast 1 input argument.');
        meritFunctionValue = NaN;
        return;
    end
    
    % Connect the surface definition function
    meritFunctionName = currentMeritFunction.Name;
    meritFunctionHandle = str2func(meritFunctionName);
    returnFlag = 2;
    
    meritFunctionParameters = currentMeritFunction.UniqueParameters;
    inputDataStruct = struct();
    inputDataStruct.OptimizableObject = currentMeritFunction.OptimizableObject;
    [returnDataStruct] = meritFunctionHandle(returnFlag,meritFunctionParameters,inputDataStruct);
    meritFunctionValue = returnDataStruct.Value;
end

