function draw =  plot2DLayout(optSystem,rayPathMatrix,...
    axesHandle)
    % plot2DSurface: Drwas a 2D layout diagram
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

    % Check for inputs
    % deafualt inputs
    if nargin < 1
        disp(['Error: The function needs atleast the optical system.']);
        return;
    elseif nargin == 1 % No rays paths are given
        rayPathMatrix = NaN;
        axesHandle = axes('Parent',figure,'Units','normalized',...
            'Position',[0.1,0.1,0.8,0.8]);
    elseif nargin == 2
        axesHandle = axes('Parent',figure,'Units','normalized',...
            'Position',[0.1,0.1,0.8,0.8]);     
    else

    end

    lensCounter = 0;
    nPoints = 500;
    lensColor = [0.9,0.9,0.9];
    
    %look for lens
    
    nSurf = optSystem.NumberOfSurfaces;
    %draw the object surface
    surf1CoordinateTM = optSystem.SurfaceArray(1).SurfaceCoordinateTM;

    surf1Position = optSystem.SurfaceArray(1).Position;
    objThick = - surf1Position(3);
    if abs(surf1Position(3))>10^10
        surf1Position(3) = 0;
        objThick = 0;
    end

    rad1 = optSystem.SurfaceArray(1).Radius;
    conic1 = optSystem.SurfaceArray(1).ConicConstant;
    semiDiam1 = optSystem.SurfaceArray(1).SemiDiameter;
    apertType1 = optSystem.SurfaceArray(1).ApertureType;
    if strcmpi(apertType1,'None')
        apertParam1 = [semiDiam1,semiDiam1,0,0];
    else
        apertParam1 = optSystem.SurfaceArray(1).ApertureParameter;
    end
    apartSizeX1 = apertParam1(1);
    apartSizeY1 = apertParam1(2);
    apartDecX1 = apertParam1(3);
    apartDecY1 = apertParam1(4);
    dr = 2*max([apartSizeX1,apartSizeY1])/nPoints;
    if dr == 0
        % dr = 0.01;
    end

    lensXRange1 = [-apartSizeX1+apartDecX1,apartSizeX1+apartDecX1];
    lensYRange1 = [-apartSizeY1+apartDecY1,apartSizeY1+apartDecY1];
    draw2DSurface(surf1CoordinateTM,rad1,conic1,apertType1,apertParam1,lensXRange1,lensYRange1,axesHandle,dr,lensColor) ;


    
%     dr = 2*semiDiam1/nPoints;
%     actualSurfHeight1= semiDiam1;
%     drawnSurfHeight1 = semiDiam1;    
%     hold on;
%     surfColor = 'k';
%     [ surfH,zyPoints,errCode ] = draw2DSurface...
%         (surf1CoordinateTM,rad1,conic1,actualSurfHeight1,...
%             drawnSurfHeight1,axesHandle,dr,surfColor) ;
%     if errCode
%         return;
%     end
    hold on;
    
    
    % initialize the array for sake of speed
    lensHeight = zeros(1,nSurf);
    lensPositionZ= zeros(1,nSurf);

    opticalAxisPoints(:,1) = optSystem.SurfaceArray(1).SurfaceCoordinateTM(1:3,4);
    for kk=2:1:nSurf-1
        medium = optSystem.SurfaceArray(kk).Glass.Name;
        lensCounter = lensCounter + 1;
        if mod(lensCounter,3)== 0
            lensColor = [0.9,0.8,0.7];
        elseif mod(lensCounter,3)== 1
            lensColor = [0.9,0.9,0.9];
        else
            lensColor = [0.7,0.8,0.9];
        end
        if strcmpi(medium,'None')||strcmpi(medium,'Air')
            %%%%
            surf1Position = optSystem.SurfaceArray(kk).Position;
            surf1CoordinateTM = optSystem.SurfaceArray(kk).SurfaceCoordinateTM;
            rad1 = optSystem.SurfaceArray(kk).Radius;
            conic1 = optSystem.SurfaceArray(kk).ConicConstant;
            semiDiam1 = optSystem.SurfaceArray(kk).SemiDiameter;
            dr = 2*semiDiam1/nPoints;

            actualSurfHeight1= semiDiam1;
            drawnSurfHeight1 = semiDiam1;
            negThick = (optSystem.SurfaceArray(kk).Thickness < 0)
            hold on;
            if strcmpi(optSystem.SurfaceArray(kk).DeviationMode,'-1 Reflective')
                [lensHeight(lensCounter),zyPoints,errCode] = draw2DMirror...
                (surf1CoordinateTM,rad1,conic1,semiDiam1,axesHandle,dr,lensColor,negThick);
            else
                surfColor = 'k';
                [lensHeight(lensCounter),zyPoints,errCode] = draw2DSurface...
                (surf1CoordinateTM,rad1,conic1,actualSurfHeight1,...
            drawnSurfHeight1,axesHandle,dr,surfColor);
            end
            
            if errCode
                return;
            end
            lensPositionZ(lensCounter) = surf1Position(3)+ abs(semiDiam1);
            hold on;
        else
            surf1Position = optSystem.SurfaceArray(kk).Position;
            surf1CoordinateTM = optSystem.SurfaceArray(kk).SurfaceCoordinateTM;
            rad1 = optSystem.SurfaceArray(kk).Radius;
            conic1 = optSystem.SurfaceArray(kk).ConicConstant;
            semiDiam1 = optSystem.SurfaceArray(kk).SemiDiameter;

            surf2Position = optSystem.SurfaceArray(kk+1).Position;
            surf2CoordinateTM = optSystem.SurfaceArray(kk+1).SurfaceCoordinateTM;
            rad2 = optSystem.SurfaceArray(kk+1).Radius;
            conic2 = optSystem.SurfaceArray(kk+1).ConicConstant;
            semiDiam2 = optSystem.SurfaceArray(kk+1).SemiDiameter;
            
            dr = 2*semiDiam2/nPoints;
            hold on;
            [lensHeight(lensCounter),zyPoints,errCode] = draw2DLens...
                (surf1CoordinateTM,rad1,conic1, semiDiam1, ...
                surf2CoordinateTM,rad2,conic2,semiDiam2,axesHandle,dr,lensColor);
            if errCode
                return;
            end
            lensPositionZ(lensCounter) = surf2Position(3)+ abs(semiDiam2);
            hold on;            
        end
        opticalAxisPoints(:,kk) = optSystem.SurfaceArray(kk).SurfaceCoordinateTM(1:3,4);
    end
    % draw the image surface
    surf1CoordinateTM = optSystem.SurfaceArray(nSurf).SurfaceCoordinateTM;
    surf1Position = optSystem.SurfaceArray(nSurf).Position;
    rad1 = optSystem.SurfaceArray(nSurf).Radius;
    conic1 = optSystem.SurfaceArray(nSurf).ConicConstant;
    semiDiam1 = optSystem.SurfaceArray(nSurf).SemiDiameter;
    dr = 2*semiDiam1/nPoints;
    surfColor = 'k';
    actualSurfHeight1= semiDiam1;
    drawnSurfHeight1 = semiDiam1;
    hold on;
    
    [ surfH,zyPoints,errCode ] = draw2DSurface...
        (surf1CoordinateTM,rad1,conic1,actualSurfHeight1,...
            drawnSurfHeight1,axesHandle,dr,surfColor) ;
    if errCode
        return;
    end
    opticalAxisPoints(:,nSurf) = optSystem.SurfaceArray(nSurf).SurfaceCoordinateTM(1:3,4);
    hold on;

    if nargin > 1 && length(rayPathMatrix)~=1  % NaN is double and its length is 1
        % Use different color for diffrent wavelengths and different line style for
        % different field points.
        nRay = size(rayPathMatrix,3);
        nField = size(rayPathMatrix,4);
        nWav = size(rayPathMatrix,5);
        
        availableLineColors = repmat({'b','g','r','c','m','y','k'},1,20); % 7*20 = 140
        lineColors = availableLineColors(1:nWav*nField);           
        
        for wavIndex = 1:nWav
            for fieldIndex = 1:nField
                lineColor = char(lineColors((fieldIndex-1)*nWav + wavIndex));
                for rayIndex = 1:nRay
                    plot(axesHandle,rayPathMatrix(3,:,rayIndex,fieldIndex,wavIndex),...
                        rayPathMatrix(2,:,rayIndex,fieldIndex,wavIndex),...
                        lineColor); hold on;
                end
                hold on;
            end
            hold on;
        end
    end
    % finally set the axis
    xmin = - (1+objThick);
    xmax = max(lensPositionZ);%surf1Position(3)+1;
    %     ymax = 2*max(lensHeight);
    %     ymin = - ymax;
    %     axis([xmin xmax ymin ymax])
    
    % draw optical axis
    hold on;
    plot3(axesHandle,opticalAxisPoints(3,:),opticalAxisPoints(2,:),...
        opticalAxisPoints(1,:),'-.r','LineWidth',2);
    hold off;
    axis equal;
    draw =  1;

end
