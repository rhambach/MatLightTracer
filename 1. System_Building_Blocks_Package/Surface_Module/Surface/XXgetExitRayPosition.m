function [ exitRayPosition,totalInternalReflection ] = getExitRayPosition( currentSurface,rayDirection,...
        indexBefore,indexAfter,wavlenInM, surfaceNormal,rayPosition,refWavlenInM )
    %GETEXITRAYPOSITION Computes the exit ray position for the given surface.
    % Inputs:
    %   (currentSurface,rayDirection,indexBefore,indexAfter,wavlenInM,
    %    surfaceNormal,rayPosition,refWavlenInM )
    % Outputs:
    %   [exitRayPosition,totalInternalReflection ]
    
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
    xyCoordinateMeshGrid = NaN;
    if  strcmpi(currentSurface.Glass.Name,'Mirror') % reflection
        reflection = 1;
    else
        reflection = 0;
    end
    
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'EXRP';
    [ exitRayPosition] = surfaceDefinitionHandle(...
        returnFlag,surfaceParameters,rayPosition,rayDirection,...
        indexBefore,indexAfter,wavlenInM,...
        surfaceNormal,reflection,xyCoordinateMeshGrid,refWavlenInM);   
end

