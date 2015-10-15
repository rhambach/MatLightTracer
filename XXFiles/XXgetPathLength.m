function [ geometricalPathLength, NoIntersectionPoint,additionalPathLength ] = getPathLength(...
        currentSurface,rayPosition,rayDirection,indexBefore,indexAfter,wavlenInM )
    %GETPATHLENGTH returns the path length from ray position to the surface
    % intersection.
    % Inputs:
    %   (currentSurface,rayPosition,rayDirection,indexBefore,indexAfter,wavlenInM )
    % Outputs:
    %   [geometricalPathLength, NoIntersectionPoint,additionalPathLength ]
    
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
    surfaceUniqueParameters = currentSurface.UniqueParameters;
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'PLTS';
    [ geometricalPathLength, NoIntersectionPoint,additionalPathLength] = surfaceDefinitionHandle(...
        returnFlag,surfaceUniqueParameters,rayPosition,rayDirection,indexBefore,indexAfter,wavlenInM );
end

