function [ paramName,paramType,paramValue,paramValueDisp] = ...
        getSurfaceParameter(currentSurface,tableName,rowNumber)
    % getSurfaceParameter: returns the surface parameter 
    % paramName,paramType,paramValue,paramValueDisp
    % Inputs:
    %   (currentSurface,tableName,rowNumber)
    % Outputs:
    %   [paramName,paramType,paramValue,paramValueDisp]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    
    
    [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParametersAll(currentSurface,tableName);
    paramType = paramTypes{rowNumber};
    paramName = paramNames{rowNumber};
    paramValue = paramValues{rowNumber};
    paramValueDisp = paramValuesDisp{rowNumber};
    
end

