function [optimizableObject] = getOptimizableObject( variableInputArgument )
    %getOptimizableObject Returns the current optimizable object
    %for given merit function struct / merit function name respectively.
    % Inputs:
    % variableInputArgument:
    %       1. Struct/object --> currentMeritFunction
    % Outputs:
    %   [optimizableObject]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    if nargin < 1
        disp('Error: The function getOptimizableObject.');
        optimizableObject = NaN;
        return;
    end
    
    if returnDefault
        % Connect the surface definition function
        meritFunctionHandle = str2func(meritFunctionName);
        returnFlag = 3;
        [returnDataStruct] = meritFunctionHandle(returnFlag);
        optimizableObject = returnDataStruct.OptimizableObject;
    else
        optimizableObject = currentMeritFunction.OptimizableObject;
    end
end

