function [fieldNames,fieldFormat,defaultUniqueParamStruct] = getDefaultUniqueParameters( currentSurface )
    %getDefaultUniqueParameters Returns the field names, formats, and initial
    %struct of all unique parameters which are specific to this surface type
    % Inputs:
    %   (currentSurface)
    % Outputs:
    %   [fieldNames,fieldFormat,defaultUniqueParamStruct]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    surfaceType = currentSurface.Type;
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'SSPB';
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = surfaceDefinitionHandle(returnFlag);
    
end

