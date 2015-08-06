function [ lensH,xyzPoints1, xyzPoints2] = drawLens...
    (surf1CoordinateTM,rad1,conic1,apertType1,apertParam1, ...
    surf2CoordinateTM,rad2,conic2,apertType2,apertParam2,...
    plotIn2D,axesHandle,radSpacing,lensColor,gratingLinesPerUm1,gratingLinesPerUm2,gratingHeight )
% drawLens: Plots the 3 dimensional lay out of alens in 3d/2d Space
% given its two surfaces
% Inputs
%   surf1CoordinateTM,rad1,conic1,semiDiam1: coordinate transfer matrix
%                        , radius, conic constant and
%   axesHandle: axes to plot the lens
%   radSpacing: radius sampling Spacing
%   lensColor: Shading color of the lens
%   plotIn2D: Plot the YZ cross section in 2D layout
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
% If aperture of both surface is the same
apartSizeX1 = apertParam1(1);
apartSizeY1 = apertParam1(2);
apartSizeX2 = apertParam2(1);
apartSizeY2 = apertParam2(2);
apartDecX1 = apertParam1(3);
apartDecY1 = apertParam1(4);
apartDecX2 = apertParam2(3);
apartDecY2 = apertParam2(4);
if strcmpi(apertType1,apertType2)
    if strcmpi(apertType1,'None')
        % Assume circular and take the maximum
        lensHeight = max([apartSizeX1,apartSizeY1,apartSizeX2,apartSizeY2]);
        lensXRange = [-lensHeight,lensHeight];
        lensYRange = [-lensHeight,lensHeight];
    else
        % The lens height in x and y will be determined by the aperture
        % parameters including decenters
        % Consider the aperture decenter
        
        lensXRange = [min([-apartSizeX1+apartDecX1,-apartSizeX2+apartDecX2]),...
            max([apartSizeX1+apartDecX1,apartSizeX2+apartDecX2])];
        lensYRange = [min([-apartSizeY1+apartDecY1,-apartSizeY2+apartDecY2]),...
            max([apartSizeY1+apartDecY1,apartSizeY2+apartDecY2])];
    end
    [ surfH1,xyzPoints1 ] = drawSurface(surf1CoordinateTM,rad1,conic1,...
        apertType1,apertParam1,...
        lensXRange,lensYRange,plotIn2D,-1,radSpacing,'k',gratingLinesPerUm1,gratingHeight);
    [ surfH2,xyzPoints2 ] = drawSurface(surf2CoordinateTM,rad2,conic2,...
        apertType2,apertParam2,...
        lensXRange,lensYRange,plotIn2D,-1,radSpacing,'k',gratingLinesPerUm2,gratingHeight);
else
    disp(['Warning: Surfaces with different aperture type can not '...
        'be drawn as a single lens. So they are drawn as just separate surfaces.']);
    lensXRange1 = [-apartSizeX1+apartDecX1,apartSizeX1+apartDecX1];
    lensYRange1 = [-apartSizeY1+apartDecY1,apartSizeY1+apartDecY1];
    
    lensXRange2 = [-apartSizeX2+apartDecX2,apartSizeX2+apartDecX2];
    lensYRange2 = [-apartSizeY2+apartDecY2,apartSizeY2+apartDecY2];
    hold on;
    [ surfH1,xyzPoints1 ] = drawSurface(surf1CoordinateTM,rad1,conic1,...
        apertType1,apertParam1,lensXRange1,lensYRange1,plotIn2D,-1,radSpacing,lensColor,gratingHeight);
    hold on;
    [ surfH2,xyzPoints2 ] = drawSurface(surf2CoordinateTM,rad2,conic2,...
        apertType2,apertParam2,lensXRange2,lensYRange2,plotIn2D,-1,radSpacing,lensColor,gratingHeight);
    
end

x1 = xyzPoints1(:,:,1);
y1 = xyzPoints1(:,:,2);
z1 = xyzPoints1(:,:,3);

x2 = xyzPoints2(:,:,1);
y2 = xyzPoints2(:,:,2);
z2 = xyzPoints2(:,:,3);
   
    
% Draw the lens surfaces
if plotIn2D
     % Draw lens edges with black line
     borderColor = [0.6,0.6,0.6];
     patch([z1(1,:),fliplr(z2(1,:)),z1(1,1)]',[y1(1,:),fliplr(y2(1,:)),y1(1,1)]',...
         lensColor,'EdgeColor',borderColor,'Parent',axesHandle)
else
    surf(axesHandle,x1,z1,y1,'facecolor',lensColor,...
    'edgecolor','none',...
    'facelighting','phong','FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
    hold on;
    surf(axesHandle,x2,z2,y2,'facecolor',lensColor,...
    'edgecolor','none',...
    'facelighting','phong','FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
    % Draw lens edges with black line
    borderColor = [0.6,0.6,0.6];
    plot3(x2(1,:),z2(1,:),y2(1,:),'Color',borderColor,'Parent',axesHandle)
    plot3(x1(1,:),z1(1,:),y1(1,:),'Color',borderColor,'Parent',axesHandle)

    % Draw lens edges surface with slightly darker color
    % If aperture of both surface is the same
    if strcmpi(apertType1,apertType2)
        surf(axesHandle,[x2(1,:); x1(1,:)],[z2(1,:); z1(1,:)],[y2(1,:); y1(1,:)],...
            'facecolor',lensColor/1.2,'edgecolor','none','facelighting','phong','FaceAlpha', 0.5,'AmbientStrength', 0., 'SpecularStrength', 1);
    end
end

hold off;
lensH = surfH1;

