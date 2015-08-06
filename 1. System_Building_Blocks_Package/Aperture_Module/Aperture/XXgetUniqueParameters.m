function [ fieldNames,fieldFormat,currentUniqueParamStruct ] = getUniqueParameters( currentAperture )
   %getDefaultUniqueParameters Returns the field names, formats, and default
    %struct of all unique parameters which are specific to this surface type
    % Inputs:
    %   (currentAperture)
    % Outputs:
    %   [fieldNames,fieldFormat,currentUniqueParamStruct]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    apertureType = currentAperture.Type;
    % Connect the surface definition function
    apertureDefinitionHandle = str2func(apertureType);
    returnFlag = 1;
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = apertureDefinitionHandle(returnFlag);
    currentUniqueParamStruct = currentAperture.UniqueParameters;
end

