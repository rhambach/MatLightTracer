function [ intersectionPoint, surfaceNormal ] = getIntersectionPointAndSurfaceNormal(...
        currentSurface,rayPosition,rayDirection)
    %getIntersectionPointAndSurfaceNormal returns the intersection points and
    %surface normals at the intersection points for a given set of rays
    % Inputs:
    %   (currentSurface,rayPosition,rayDirection)
    % Outputs:
    %   [intersectionPoint, surfaceNormal]
    
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
    surfaceParameters = currentSurface.UniqueParameters;
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'SIAN';
    [ intersectionPoint, surfaceNormal ] = surfaceDefinitionHandle(...
        returnFlag,surfaceParameters,rayPosition,rayDirection);
end



