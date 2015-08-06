function [ xyzPoints1, xyzPoints2] = drawLens...
    (surface1,surface2,plotIn2D,nPoints1,nPoints2,...
     axesHandle,lensColor,drawEdge,varagrin)
% drawLens: Plots the 3 dimensional lay out of alens in 3d/2d Space
% given its two surfaces
% Inputs
%   surface1,surface2: Two surface objects of the lens
%   axesHandle: axes to plot the lens
%   radSpacing: radius sampling Spacing
%   lensColor: Shading color of the lens
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
if nargin > 0 && strcmpi(surface1.GridType,'Polar')
    nPoints1Default = 16;
    nPoints2Default = 32;
else
    nPoints1Default = 75;
    nPoints2Default = 75;    
end
if nargin < 2
    disp('Error: The function drawLens requires aleast two surface object.');
    xyzPoints1 = NaN;
    xyzPoints2 = NaN;
    return;
elseif nargin == 2
    plotIn2D = 0;
    nPoints1 = nPoints1Default;
    nPoints2 = nPoints2Default;
    figure;
    axesHandle = axes;
    lensColor = 'interp';
    drawEdge = 1;
elseif nargin == 3
    nPoints1 = nPoints1Default;
    nPoints2 = nPoints2Default;
    figure;
    axesHandle = axes;
    lensColor = 'interp';
    drawEdge = 1;
elseif nargin == 4
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end   
    nPoints2 = nPoints2Default;
    figure;
    axesHandle = axes;
    lensColor = 'interp';
    drawEdge = 1;
elseif nargin == 5
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end     
    figure;
    axesHandle = axes;
    lensColor = 'interp';
    drawEdge = 1;
elseif nargin == 6
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end     
    lensColor = 'interp';
    drawEdge = 1;
elseif nargin == 7
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
lastSurf = size(surface2,2);

if ~drawEdge
    surf1Edge = 0;
    surfLastEdge = 0; 
else
    surf1Edge = surface1.AdditionalEdge;
    surfLastEdge = surface2(lastSurf).AdditionalEdge;    
end
apertType1 = surface1.ApertureType;
apertTypeLast = surface2(lastSurf).ApertureType;
gridType1 = surface1.GridType;
gridTypeLast = surface2(lastSurf).GridType;

apartSizeX1 = (1+surf1Edge)*surface1.ApertureParameter(1);
apartSizeY1 = (1+surf1Edge)*surface1.ApertureParameter(2);
apartDecX1 = surface1.ApertureParameter(3);
apartDecY1 = surface1.ApertureParameter(4);
for ss =  1:size(surface2,2)
    apartSizeX2(ss) = (1+surfLastEdge)*surface2(ss).ApertureParameter(1);
    apartSizeY2(ss) = (1+surfLastEdge)*surface2(ss).ApertureParameter(2);
    apartDecX2(ss) = surface2(ss).ApertureParameter(3);
    apartDecY2(ss) = surface2(ss).ApertureParameter(4);
end  
if strcmpi(apertType1,apertTypeLast) && strcmpi(gridType1,gridTypeLast)     
    
    % Take the coommon aperture  area for each doublet
    for ss = 1:size(surface2,2)
        lensXRange = [min([-apartSizeX1+apartDecX1,-apartSizeX2(ss)+apartDecX2(ss)]),...
            max([apartSizeX1+apartDecX1,apartSizeX2(ss)+apartDecX2(ss)])];
        lensYRange = [min([-apartSizeY1+apartDecY1,-apartSizeY2(ss)+apartDecY2(ss)]),...
            max([apartSizeY1+apartDecY1,apartSizeY2(ss)+apartDecY2(ss)])];     
        commonApertureSizeX(ss) = (lensXRange(2)-lensXRange(1))/2;
        commonApertureSizeY(ss) = (lensYRange(2)-lensYRange(1))/2;
    end 
    
    % Set the aperure sizes to the common aperture size 
    surface1.DrawnAperture = [commonApertureSizeX,commonApertureSizeY];
    for ss =  1:size(surface2,2)
        surface2(ss).DrawnAperture = [commonApertureSizeX(ss),commonApertureSizeY(ss)];
    end
    
    % Collect the points for both surface
    xyzPoints1 = surface1.drawSurface(plotIn2D,nPoints1,nPoints2,...
     -1,lensColor);
    for ss =  1:size(surface2,2)
        xyzPoints2(:,:,:,ss) = surface2(ss).drawSurface(plotIn2D,nPoints1,nPoints2,...
                        -1,lensColor);
    end
else
    disp(['Warning: Surfaces with different aperture type or grid type can not '...
        'be drawn as a single lens. So they are drawn as just separate surfaces.']);
    % Set the aperure sizes to the common aperture size 
    surface1.DrawnAperture = [apartSizeX1,apartSizeY1];
    for ss =  1:size(surface2,2)
        surface2(ss).DrawnAperture = [apartSizeX2(ss),apartSizeY2(ss)];
    end
    
    xyzPoints1 = surface1.drawSurface(plotIn2D,nPoints1,nPoints2,...
     -1,lensColor,varagrin);
    hold on;
    for ss =  1:size(surface2,2)
        xyzPoints2(:,:,:,ss) = surface2(ss).drawSurface(plotIn2D,nPoints1,nPoints2,...
                                -1,lensColor,varagrin);
    end
end

x1 = xyzPoints1(:,:,1);
y1 = xyzPoints1(:,:,2);
z1 = xyzPoints1(:,:,3);
for ss =  1:size(surface2,2)
    x2(:,:,ss) = xyzPoints2(:,:,1,ss);
    y2(:,:,ss) = xyzPoints2(:,:,2,ss);
    z2(:,:,ss) = xyzPoints2(:,:,3,ss);
end
if strcmpi(surface1.GridType,'Polar')
    boarderX1 = x1(1,:);
    boarderY1 = y1(1,:);
    boarderZ1 = z1(1,:);
else
    boarderX1 = [x1(1,:),(x1(:,end))',fliplr(x1(end,:)),fliplr((x1(:,1))')];
    boarderY1 = [y1(1,:),(y1(:,end))',fliplr(y1(end,:)),fliplr((y1(:,1))')];
    boarderZ1 = [z1(1,:),(z1(:,end))',fliplr(z1(end,:)),fliplr((z1(:,1))')];
end
if strcmpi(surface2(lastSurf).GridType,'Polar')
    boarderXLast = x2(1,:,lastSurf);
    boarderYLast = y2(1,:,lastSurf);
    boarderZLast = z2(1,:,lastSurf);
else
    boarderXLast = [x2(1,:,lastSurf),(x2(:,end,lastSurf))',fliplr(x2(end,:,lastSurf)),fliplr((x2(:,1,lastSurf))')];
    boarderYLast = [y2(1,:,lastSurf),(y2(:,end,lastSurf))',fliplr(y2(end,:,lastSurf)),fliplr((y2(:,1,lastSurf))')];
    boarderZLast = [z2(1,:,lastSurf),(z2(:,end,lastSurf))',fliplr(z2(end,:,lastSurf)),fliplr((z2(:,1,lastSurf))')];
end
    
% Draw the lens surfaces
if plotIn2D
     % Draw lens edges with black line
     borderColor = [0.6,0.6,0.6];
     patch([z1(1,:),fliplr(z2(1,:)),z1(1,1)]',[y1(1,:),fliplr(y2(1,:)),y1(1,1)]',...
         lensColor,'EdgeColor',borderColor,'Parent',axesHandle)
else
    surf(axesHandle,x1,z1,y1,'facecolor',lensColor,...
    'edgecolor','none',...
    'FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
    hold on;
    for ss =  1:size(surface2,2)
        surf(axesHandle,x2(:,:,ss),z2(:,:,ss),y2(:,:,ss),'facecolor',lensColor,...
        'edgecolor','none',...
        'FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
        hold on;
    end
%     % Draw lens edges with black line
%     borderColor = [0.6,0.6,0.6];
%     plot3(boarderX2,boarderZ2,boarderY2,'Color',borderColor,'Parent',axesHandle)
%     plot3(boarderX1,boarderZ1,boarderY1,'Color',borderColor,'Parent',axesHandle)

    % Draw lens edges surface with slightly darker color
    % If aperture of both surface is the same
    if strcmpi(apertType1,apertTypeLast)
        surf(axesHandle,[boarderXLast; boarderX1],[boarderZLast; boarderZ1],[boarderYLast; boarderY1],...
            'facecolor',lensColor/1.2,'edgecolor','none','facelighting','phong','FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
    end
end
axis equal;
hold off;