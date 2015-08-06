function [ xyzPoints,centerPoints] = drawSurfaceArray...
        (surfaceArray,plotIn2D,nPoints1,nPoints2,...
        axesHandle,drawEdge)
    % drawLens: Plots the 3 dimensional lay out of alens in 3d/2d Space
    % given its two surfaces
    % Inputs
    %   surfaceArray: Array of non dummy surface objects of the lens
    %   axesHandle: axes to plot the lens
    %   radSpacing: radius sampling Spacing
    %   plotIn2D: Plot the YZ cross section in 2D layout
    %   drawEdge: boolean indicating to draw edge
    %   nPoints1,nPoints2: nRadialPoints,nAngularPoints or nPointsX,nPointsY
    % Output
    %   lensH:  height of the lens drawn
    
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
    if nargin > 0 && strcmpi(getGridType(surfaceArray(1)),'Polar')
        %     nPoints1Default = 17;
        %     nPoints2Default = 33;
        nPoints1Default = 100;
        nPoints2Default = 50;
    else
        nPoints1Default = 75;
        nPoints2Default = 75;
    end
    if nargin < 1
        disp('Error: The function drawLens requires aleast surfaceArray object.');
        xyzPoints = NaN;
        return;
    elseif nargin == 1
        plotIn2D = 0;
        nPoints1 = nPoints1Default;
        nPoints2 = nPoints2Default;
        figure;
        axesHandle = axes;
        drawEdge = 1;
    elseif nargin == 2
        nPoints1 = nPoints1Default;
        nPoints2 = nPoints2Default;
        figure;
        axesHandle = axes;
        drawEdge = 1;
    elseif nargin == 3
        if strcmpi(nPoints1,'default')
            nPoints1 = nPoints1Default;
        end
        nPoints2 = nPoints2Default;
        figure;
        axesHandle = axes;
        drawEdge = 1;
    elseif nargin == 4
        if strcmpi(nPoints1,'default')
            nPoints1 = nPoints1Default;
        end
        if strcmpi(nPoints2,'default')
            nPoints2 = nPoints2Default;
        end
        figure;
        axesHandle = axes;
        drawEdge = 1;
    elseif nargin == 5
        if strcmpi(nPoints1,'default')
            nPoints1 = nPoints1Default;
        end
        if strcmpi(nPoints2,'default')
            nPoints2 = nPoints2Default;
        end
        drawEdge = 1;
    else
        if strcmpi(nPoints1,'default')
            nPoints1 = nPoints1Default;
        end
        if strcmpi(nPoints2,'default')
            nPoints2 = nPoints2Default;
        end
    end
    nSurface = size(surfaceArray,2);
    surfEdge = zeros(nSurface,1);
    if drawEdge
        for ss = 1: nSurface
            surfEdge(ss) = surfaceArray(ss).Aperture.AdditionalEdge;
        end
    end
    
    sameApertureType = ones(nSurface,1);
    samegetGridType = ones(nSurface,1);
    IsFreeSpace = ones(nSurface,1);
    IsMirror = zeros(nSurface,1);
    
    apartSizeX = zeros(nSurface,1);
    apartSizeY = zeros(nSurface,1);
    apartDecX = zeros(nSurface,1);
    apartDecY = zeros(nSurface,1);
    for ss =  1:nSurface
        
        if ss == 1
            currentGridType = getGridType(surfaceArray(ss));
            currentApertureOuterShape = surfaceArray(ss).Aperture.OuterShape;
        else
            prevGridType = currentGridType;
            prevApertureOuterShape = currentApertureOuterShape;
            
            currentGridType = getGridType(surfaceArray(ss));
            currentApertureOuterShape = surfaceArray(ss).Aperture.OuterShape;
            
            sameApertureType(ss-1) = strcmpi(prevApertureOuterShape,currentApertureOuterShape);
            samegetGridType(ss-1) = strcmpi(prevGridType,currentGridType);
        end
        IsFreeSpace(ss) = (strcmpi(surfaceArray(ss).Glass.Name,'None')||...
            strcmpi(surfaceArray(ss).Glass.Name,'Air')||...
            isempty((surfaceArray(ss).Glass.Name)));
        IsMirror(ss) = strcmpi(surfaceArray(ss).Glass.Name,'Mirror');
        [outerApertShape{ss},maximumRadiusXY] = getOuterAperture(surfaceArray(ss).Aperture);
        apartSizeX(ss) = (1+surfEdge(ss))*maximumRadiusXY(1);
        apartSizeY(ss) = (1+surfEdge(ss))*maximumRadiusXY(2);
        
        drawnApertureRadiusXY(ss,:) = (1+surfEdge(ss))*maximumRadiusXY;
        
        apartDecX(ss) = surfaceArray(ss).Aperture.Decenter(1);
        apartDecY(ss) = surfaceArray(ss).Aperture.Decenter(2);
        
    end
    
    surfacePointsComputedFlag =  zeros(nSurface,1);
    singletCounter = 0;
    singleSurfaceCounter = 0;
    mirrorCounter = 0;
    
    surfColor = zeros(nSurface,3);
    centerPoints = zeros(3,nSurface);
    for ss =  1:nSurface
        if mod(ss,4)== 0
            surfColor(ss,:) = [0,1,0.5];
        elseif mod(ss,4)== 1
            surfColor(ss,:) = [0,0.75,0.75];
        elseif mod(ss,4)== 2
            surfColor(ss,:) = [0,1,0.75];
        else
            surfColor(ss,:) = [0,0.75,1];
        end
        centerPoints(:,ss) = surfaceArray(ss).SurfaceCoordinateTM(1:3,4);
        
        
        if IsMirror(ss) || IsFreeSpace(ss) || ~sameApertureType(ss) || ~samegetGridType(ss) || nSurface == 1
            if ~surfacePointsComputedFlag(ss)
                singleSurfaceCounter = singleSurfaceCounter + 1;
                % Just compute plot points for the surface as it is
                % Set the aperure sizes to the aperture size
                drawnAperture = [apartSizeX(ss),apartSizeY(ss)];
                %             [outerApertShape,maximumRadiusXY] = getOuterAperture(surfaceArray(ss).Aperture);
                xyzPoints1 = drawSurface(surfaceArray(ss),plotIn2D,nPoints1,nPoints2,...
                    -1,surfColor,2*drawnApertureRadiusXY(ss,:));
                %             xyzPoints(:,:,:,ss) = xyzPoints1;
                xyzPoints{ss} = xyzPoints1;
                surfacePointsComputedFlag(ss) = 1;
                
                % Compute the single surface plot points from the xyzPoints1
                if strcmpi(getGridType(surfaceArray(ss)),'Polar')
                    if plotIn2D
                        % Only one angle so take all r for that angle
                        singleSurfaceBoarderX{singleSurfaceCounter} = [xyzPoints1(:,1,1)];
                        singleSurfaceBoarderY{singleSurfaceCounter} = [xyzPoints1(:,1,2)];
                        singleSurfaceBoarderZ{singleSurfaceCounter} = [xyzPoints1(:,1,3)];
                    else
                        % Take all R for maximum r
                        singleSurfaceBoarderX{singleSurfaceCounter} = [xyzPoints1(1,:,1)];
                        singleSurfaceBoarderY{singleSurfaceCounter} = [xyzPoints1(1,:,2)];
                        singleSurfaceBoarderZ{singleSurfaceCounter} = [xyzPoints1(1,:,3)];
                    end
                else
                    singleSurfaceBoarderX{singleSurfaceCounter} = [xyzPoints1(1,:,1),(xyzPoints1(:,end,1))',fliplr(xyzPoints1(end,:,1)),fliplr((xyzPoints1(:,1,1))')];
                    singleSurfaceBoarderY{singleSurfaceCounter}  = [xyzPoints1(1,:,2),(xyzPoints1(:,end,2))',fliplr(xyzPoints1(end,:,2)),fliplr((xyzPoints1(:,1,2))')];
                    singleSurfaceBoarderZ{singleSurfaceCounter}  = [xyzPoints1(1,:,3),(xyzPoints1(:,end,3))',fliplr(xyzPoints1(end,:,3)),fliplr((xyzPoints1(:,1,3))')];
                end
            end
            
            
            
            
            if IsMirror(ss)
                mirrorCounter = mirrorCounter + 1;
                %             xyzPoints1 = xyzPoints(:,:,:,ss);
                xyzPoints1 = xyzPoints{ss};
                % Compute the second surface points
                secondSurface = surfaceArray(ss);
                maxAperture = max(secondSurface.ApertureParameter(1:2));
                deltaZ = -((-1)^mirrorCounter)*0.05*maxAperture;
                % Transform the deltaZ to global coordinate
                globalShift = [0,0,deltaZ]*(secondSurface.SurfaceCoordinateTM(1:3,1:3));
                secondSurface.SurfaceCoordinateTM(1:3,4) = ...
                    secondSurface.SurfaceCoordinateTM(1:3,4)+globalShift';
                xyzPoints2 = drawSurface(secondSurface,plotIn2D,nPoints1,nPoints2,...
                    -1,surfColor,2*drawnApertureRadiusXY(ss,:));
                
                % Draw the second surface of the mirror now % Not too optimum solution
                % Compute the singlet boarder surface plot points from the
                % xyzPoints1 and xyzPoints2
                if strcmpi(secondSurface.getGridType,'Polar')
                    mirrorBoarderX = [xyzPoints2(1,:,1);xyzPoints1(1,:,1)];
                    mirrorBoarderY = [xyzPoints2(1,:,2);xyzPoints1(1,:,2)];
                    mirrorBoarderZ = [xyzPoints2(1,:,3);xyzPoints1(1,:,3)];
                else
                    mirrorBoarderX = [xyzPoints2(1,:,1),(xyzPoints2(:,end,1))',fliplr(xyzPoints2(end,:,1)),fliplr((xyzPoints2(:,1,1))');...
                        xyzPoints1(1,:,1),(xyzPoints1(:,end,1))',fliplr(xyzPoints1(end,:,1)),fliplr((xyzPoints1(:,1,1))')];
                    mirrorBoarderY  = [xyzPoints2(1,:,2),(xyzPoints2(:,end,2))',fliplr(xyzPoints2(end,:,2)),fliplr((xyzPoints2(:,1,2))');...
                        xyzPoints1(1,:,2),(xyzPoints1(:,end,2))',fliplr(xyzPoints1(end,:,2)),fliplr((xyzPoints1(:,1,2))')];
                    mirrorBoarderZ  = [xyzPoints2(1,:,3),(xyzPoints2(:,end,3))',fliplr(xyzPoints2(end,:,3)),fliplr((xyzPoints2(:,1,3))');...
                        xyzPoints1(1,:,3),(xyzPoints1(:,end,3))',fliplr(xyzPoints1(end,:,3)),fliplr((xyzPoints1(:,1,3))')];
                end
                if plotIn2D
                    surf(axesHandle,[mirrorBoarderZ(:,:)],[mirrorBoarderY(:,:)],[mirrorBoarderX(:,:)],...
                        'facecolor',surfColor(ss,:),'edgecolor','none','FaceAlpha', 0.9);
                    hold on;
                else
                    x2 = xyzPoints2(:,:,1);
                    y2 = xyzPoints2(:,:,2);
                    z2 = xyzPoints2(:,:,3);
                    surf(axesHandle,x2,z2,y2,'facecolor',surfColor(ss,:),...
                        'edgecolor','none','FaceAlpha', 0.5);
                    hold on;
                    % Plot the edges with slightly darker color
                    surf(axesHandle,[mirrorBoarderX(:,:)],[mirrorBoarderZ(:,:)],[mirrorBoarderY(:,:)],...
                        'facecolor',surfColor(ss,:)/1.2,'edgecolor','none','FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
                    hold on;
                end
            end
        else
            % Increment the singlet counter
            singletCounter = singletCounter + 1;
            
            % Compute the common aperture size of this surf with next surface
            % and plot both if not ploted yet
            lensXRange = [min([-apartSizeX(ss)+apartDecX(ss),-apartSizeX(ss+1)+apartDecX(ss+1)]),...
                max([apartSizeX(ss)+apartDecX(ss),apartSizeX(ss+1)+apartDecX(ss+1)])];
            lensYRange = [min([-apartSizeY(ss)+apartDecY(ss),-apartSizeY(ss+1)+apartDecY(ss+1)]),...
                max([apartSizeY(ss)+apartDecY(ss),apartSizeY(ss+1)+apartDecY(ss+1)])];
            commonApertureSizeX = (lensXRange(2)-lensXRange(1))/2;
            commonApertureSizeY = (lensYRange(2)-lensYRange(1))/2;
            
            if surfaceArray(ss).Aperture.DrawAbsolute
                
            else
                drawnApertureRadiusXY(ss,:) = [commonApertureSizeX,commonApertureSizeY]';
            end
            
            if ~surfacePointsComputedFlag(ss)
                % Compute the surface plot points and compute the singlet border
                xyzPoints1 = drawSurface(surfaceArray(ss),plotIn2D,nPoints1,nPoints2,...
                    -1,surfColor(ss,:),2*drawnApertureRadiusXY(ss,:));
                xyzPoints{ss} = xyzPoints1;
                surfacePointsComputedFlag(ss) = 1;
            else
                % Compute the surface plot points just for the computation of the singlet border
                xyzPoints1 = drawSurface(surfaceArray(ss),plotIn2D,nPoints1,nPoints2,...
                    -1,surfColor(ss,:),2*drawnApertureRadiusXY(ss,:));
            end
            if surfaceArray(ss+1).Aperture.DrawAbsolute
                
            else
                drawnApertureRadiusXY(ss+1,:) = [commonApertureSizeX,commonApertureSizeY]';
            end
            
            
            xyzPoints2 = drawSurface(surfaceArray(ss+1),plotIn2D,nPoints1,nPoints2,...
                -1,surfColor(ss,:),2*drawnApertureRadiusXY(ss+1,:));
            surfacePointsComputedFlag(ss+1) = 1;
            xyzPoints{ss+1} = xyzPoints2;
            
            % Compute the singlet boarder surface plot points from the
            % xyzPoints1 and xyzPoints2
            if strcmpi(getGridType(surfaceArray(ss)),'Polar')
                if plotIn2D
                    % Only one angle so take all r for that angle
                    singletBoarderX{singletCounter} = [xyzPoints2(:,end,1);flipud(xyzPoints1(:,end,1))];
                    singletBoarderY{singletCounter} = [xyzPoints2(:,end,2);flipud(xyzPoints1(:,end,2))];
                    singletBoarderZ{singletCounter} = [xyzPoints2(:,end,3);flipud(xyzPoints1(:,end,3))];
                else
                    % Take all angle for maximum radius
                    singletBoarderX{singletCounter} = [xyzPoints2(end,:,1);(xyzPoints1(end,:,1))];
                    singletBoarderY{singletCounter} = [xyzPoints2(end,:,2);(xyzPoints1(end,:,2))];
                    singletBoarderZ{singletCounter} = [xyzPoints2(end,:,3);(xyzPoints1(end,:,3))];
                end
            else
                singletBoarderX{singletCounter} = ...
                    [xyzPoints2(1,:,1),(xyzPoints2(:,end,1))',fliplr(xyzPoints2(end,:,1)),fliplr((xyzPoints2(:,1,1))');...
                    xyzPoints1(1,:,1),(xyzPoints1(:,end,1))',fliplr(xyzPoints1(end,:,1)),fliplr((xyzPoints1(:,1,1))')];
                singletBoarderY{singletCounter}  = ...
                    [xyzPoints2(1,:,2),(xyzPoints2(:,end,2))',fliplr(xyzPoints2(end,:,2)),fliplr((xyzPoints2(:,1,2))');...
                    xyzPoints1(1,:,2),(xyzPoints1(:,end,2))',fliplr(xyzPoints1(end,:,2)),fliplr((xyzPoints1(:,1,2))')];
                singletBoarderZ{singletCounter}  = ...
                    [xyzPoints2(1,:,3),(xyzPoints2(:,end,3))',fliplr(xyzPoints2(end,:,3)),fliplr((xyzPoints2(:,1,3))');...
                    xyzPoints1(1,:,3),(xyzPoints1(:,end,3))',fliplr(xyzPoints1(end,:,3)),fliplr((xyzPoints1(:,1,3))')];
            end
        end
    end
    
    % Plot all surfaces
    if plotIn2D
        % Plot singlets
        for ss = 1:singletCounter
            patch([singletBoarderZ{ss}],[singletBoarderY{ss}],[singletBoarderX{ss}],'Parent',axesHandle,'FaceColor',surfColor(ss,:));
            hold(axesHandle,'on');
        end
        % Plot single surfaces
        for ss = 1:singleSurfaceCounter
            plot(axesHandle,[singleSurfaceBoarderZ{ss}],[singleSurfaceBoarderY{ss}],'Color',surfColor(ss,:));
            hold(axesHandle,'on');
        end
        view(axesHandle,[0,-1,1]);
        axis equal
    else
        for ss =  1:nSurface
            xyzPointsCurrent = xyzPoints{ss};
            x = xyzPointsCurrent(:,:,1);
            y = xyzPointsCurrent(:,:,2);
            z = xyzPointsCurrent(:,:,3);
            surf(axesHandle,x,z,y,z+35,'Facecolor','interp',...
                'edgecolor','none','FaceAlpha', 0.6);
            hold(axesHandle,'on');
        end
        % Plot the edges for matching singlets with slightly darker color
        for ss = 1:singletCounter
            surf(axesHandle,[singletBoarderX{ss}],[singletBoarderZ{ss}],[singletBoarderY{ss}],...
                'facecolor',surfColor(ss,:)/1.5,'edgecolor','none','facelighting','phong','FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
            hold(axesHandle,'on');
        end
    end
    if plotIn2D
        % draw optical axis
        hold on;
        xlabel(axesHandle,'Z-axis','fontweight','bold','Color','k');
        ylabel(axesHandle,'Y-axis','fontweight','bold','Color','k');
        view(axesHandle,[0, 90]);
        title(axesHandle,'System 2D Layout in YZ plane','Color','k');
        set(axesHandle, 'XColor', 'k', 'YColor', 'k', 'ZColor', 'k');
        grid(axesHandle,'on');
        box(axesHandle,'On')
        axis equal
    else
        % draw optical axis
        hold on;
        set(axesHandle, 'YDir','reverse');
        xlabel(axesHandle,'X-axis','fontweight','bold','Color','k');
        ylabel(axesHandle,'Z-axis','fontweight','bold','Color','k');
        zlabel(axesHandle,'Y-axis','fontweight','bold','Color','k');
        view([-110, 30]);
        title(axesHandle,'System 3D Shaded Model','Color','k');
        set(axesHandle, 'XColor', 'k', 'YColor', 'k', 'ZColor', 'k');
        grid(axesHandle,'on');
        box(axesHandle,'On')
    end
    axis equal
    hold off;
    %     camlight
    lighting gouraud