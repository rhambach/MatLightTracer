function plotSpotDiagram(optSystem,axesHandle,surfIndex,wavLen,...
                     fieldPointXY,numberOfRays1,numberOfRays2,PupSamplingType,directionCosines,spotSymbal,spotColor)
    % Plots the spot diagram at a given surface.
    % If directionCosines = 0 then the spatial coordinates of
    % the intersection points of all rays with the given surface will be
    % displayed. The graph will be in the local cooordinate of the surface.
    % If directionCosines = 1 then the X and Y values displayed will be the
    % direction cosines in X and Y direction instead. The later can be
    % used for afocal system system evaluation.
    % spotSymbal,spotColor: characterrs indncating spot color and symboals
    
	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    % Jan 18,2014   Worku, Norman G.     Vectorized version
    
	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
       
    
    % Default Inputs
    if nargin < 9
        directionCosines = 0;
        spotSymbal = ['.','o','x','+','*','s','d','v','^','<','>'];
        spotColor = ['b','g','r','c','m','y','k'];
    end
    
    cla(axesHandle,'reset')
    JonesVec = [NaN;NaN];
    % polarizedRayTracerResult =  nSurf X nRay X nField X nWav
    [polarizedRayTracerResult] = optSystem.multipleRayTracer(wavLen,...
                fieldPointXY,numberOfRays1,numberOfRays2,PupSamplingType,JonesVec);
    % Spatial Distribution of spot diagram in a given surface 
    % Use different color for diffrent wavelengths and different symbal for
    % different field points.
    entrancePupilRadius = (optSystem.getEntrancePupilDiameter)/2;
    nSurface = size(polarizedRayTracerResult,1);
    nRay = size(polarizedRayTracerResult,2);
    nField = size(polarizedRayTracerResult,3);
    nWav = size(polarizedRayTracerResult,4);
    SurfaceCoordinateTM = optSystem.SurfaceArray(surfIndex).SurfaceCoordinateTM;
    for wavIndex = 1:nWav
        for fieldIndex = 1:nField
            globalIntersectionPoints = ...
                [polarizedRayTracerResult(surfIndex,:,fieldIndex,wavIndex).RayIntersectionPoint];
            % convert from global to local coordinate of the surface
            localIntersectionPoints = globalToLocalPosition...
                (globalIntersectionPoints, SurfaceCoordinateTM);
            px = localIntersectionPoints(1,:); py = localIntersectionPoints(2,:);
            spotShapeColor = [spotSymbal(wavIndex),spotColor(fieldIndex)];
            plot(axesHandle,px,py,spotShapeColor);
            hold on;
        end
    end
%     globalIntersectionPoints = [polarizedRayTracerResult(surfIndex,:).RayIntersectionPoint];
%     
%     % convert from global to local coordinate of the surface
%     localIntersectionPoints = globalToLocalPosition(globalIntersectionPoints,...
%         optSystem.SurfaceArray(surfIndex).SurfaceCoordinateTM);
%     px = localIntersectionPoints(1,:); py = localIntersectionPoints(2,:);
%     plot(axesHandle,px,py,spotSymbal);
    
    % finally set the axis to the apperture size of the surface
    appType = optSystem.SurfaceArray(surfIndex).ApertureType;
    appParam = optSystem.SurfaceArray(surfIndex).ApertureParameter;
    xmin = -max(appParam);
    xmax = max(appParam);
    ymin = -max(appParam);
    ymax = max(appParam);
    axis([xmin xmax ymin ymax]);
    
    hold on;    
    axis equal;
    xlabel('X Coordinate','FontSize',12);
    ylabel('Y Coordinate','FontSize',12);
    title(['Spot Diagram at surface : ',num2str(surfIndex)],'FontSize',12)             
end