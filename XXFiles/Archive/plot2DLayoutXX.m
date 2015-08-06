function draw = plot2DLayout( opticalSystem,rayPathMatrix,axesHandle )
    % plot2DLayout: Drwas  2D layout diagram
    % Inputs
    %   opticalSystem: the optical system object
    %   rayPathMatrix:  3 dimensional matrix of dimensions(nSurf X 3 X nRay)
    %                   Matrix of ray itersection points to be drwan.
    %   axesHandle: axes on to plot the layout
    % Output
    %   draw:  1: indicate success of the function

    % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

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

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    global INF_OBJ_Z;
    lensCounter = 0;
    dr = 0.1;
    %look for lens
    nSurf = opticalSystem.NumberOfSurface;
    %draw the object surface
    surf1Position = opticalSystem.SurfaceArray(1).Position;
    objThick = -surf1Position(3);
    if abs(surf1Position(3))>10^10
        surf1Position(3) = -INF_OBJ_Z; % for graph plotting
        objThick = INF_OBJ_Z;
    end

    rad1 = opticalSystem.SurfaceArray(1).Radius;
    conic1 = opticalSystem.SurfaceArray(1).ConicConstant;
    semiDiam1 = opticalSystem.SurfaceArray(1).SemiDiameter;
    draw2DSurface(surf1Position,rad1,conic1,semiDiam1,axesHandle,dr) ;
    hold on;

    for kk=2:1:nSurf-1
        medium = opticalSystem.SurfaceArray(kk).Glass.Name;
        lensCounter = lensCounter + 1;
        if ~strcmpi(medium,'None')            
            surf1Position = opticalSystem.SurfaceArray(kk).Position;
            rad1 = opticalSystem.SurfaceArray(kk).Radius;
            conic1 = opticalSystem.SurfaceArray(kk).ConicConstant;
            semiDiam1 = opticalSystem.SurfaceArray(kk).SemiDiameter;

            surf2Position = opticalSystem.SurfaceArray(kk+1).Position;
            rad2 = opticalSystem.SurfaceArray(kk+1).Radius;
            conic2 = opticalSystem.SurfaceArray(kk+1).ConicConstant;
            semiDiam2 = opticalSystem.SurfaceArray(kk+1).SemiDiameter;
            lensHeight(lensCounter) = draw2DLens(surf1Position,rad1,conic1,...
                semiDiam1, surf2Position,rad2,conic2,semiDiam2,axesHandle,dr);
            lensPositionZ(lensCounter) = surf2Position(3)+ abs(semiDiam2);
            hold on;
        else
            surf1Position = opticalSystem.SurfaceArray(kk).Position;
            rad1 = opticalSystem.SurfaceArray(kk).Radius;
            conic1 = opticalSystem.SurfaceArray(kk).ConicConstant;
            semiDiam1 = opticalSystem.SurfaceArray(kk).SemiDiameter;
            lensHeight(lensCounter) = draw2DSurface(surf1Position,rad1,conic1,semiDiam1,axesHandle,dr);
            lensPositionZ(lensCounter) = surf1Position(3)+ abs(semiDiam1);
            hold on;
        end
    end
    %draw the image surface
    surf1Position = opticalSystem.SurfaceArray(nSurf).Position;
    rad1 = opticalSystem.SurfaceArray(nSurf).Radius;
    conic1 = opticalSystem.SurfaceArray(nSurf).ConicConstant;
    semiDiam1 = opticalSystem.SurfaceArray(nSurf).SemiDiameter;
    draw2DSurface(surf1Position,rad1,conic1,semiDiam1,axesHandle,dr) ;
    hold on;

    if nargin>1
        %Plot the rays
        %check if the rays are meridional

        % plot the rays on the layout
        sizeOfRayPathMatrix = size(rayPathMatrix);
        if length(sizeOfRayPathMatrix)==2
            nRay=1;
        else
            nRay = sizeOfRayPathMatrix(3);
        end
        for kk=1:1:nRay
            plot(axesHandle,rayPathMatrix(:,3,kk),rayPathMatrix(:,2,kk)); hold on;
            plot(axesHandle,rayPathMatrix(:,3,kk),rayPathMatrix(:,2,kk)); hold on;    
        end
    end

    hold off;
    % finally set the axis
     xmin = - (1+objThick);
     xmax = max(lensPositionZ);%surf1Position(3)+1;
%     ymax = 2*max(lensHeight);
%     ymin = - ymax;
%     axis([xmin xmax ymin ymax])
    %draw optical axis
    patch('Faces',[1 2],'Vertices',[xmin,0;xmax,0],'FaceColor','b','Parent',axesHandle);
    hold on;
    axis equal;
    draw =  1;
end

