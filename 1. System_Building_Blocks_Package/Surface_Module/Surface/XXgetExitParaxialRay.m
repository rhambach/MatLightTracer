function [ yf,uf ] = getExitParaxialRay( ...
        currentSurface,yi,ui,reverseTracing,indexBefore,indexAfter )
    %GETEXITPARAXIALRAY Summary of this function goes here
    %   Detailed explanation goes here
    % Inputs:
    %   (currentSurface,yi,ui,reverseTracing,indexBefore,indexAfter )
    % Outputs:
    %   [yf,uf ]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    initialRayParameter = [yi;ui];
    surfaceType = currentSurface.Type;
    surfaceParameters = currentSurface.UniqueParameters;
    xyCoordinateMeshGrid = NaN;
    rayPosition  = NaN;
    rayDirection = NaN;
    wavlenInM  = NaN;
    surfaceNormal  = NaN;
    refWavlenInM  = NaN;
    if  strcmpi(currentSurface.Glass.Name,'Mirror') % reflection
        reflection = 1;
    else
        reflection = 0;
    end
    
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'PRYT';
    [ exitParaxialRayParameter ] = surfaceDefinitionHandle(returnFlag,...
        surfaceParameters,rayPosition,rayDirection,indexBefore,indexAfter,...
        wavlenInM,surfaceNormal,reflection,xyCoordinateMeshGrid,...
        refWavlenInM,initialRayParameter,reverseTracing);
    yf = exitParaxialRayParameter(1,:);
    uf = exitParaxialRayParameter(2,:);
end

