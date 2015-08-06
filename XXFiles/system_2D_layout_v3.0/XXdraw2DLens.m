function [ lensH,zyPoints,errCode ] = draw2DLens(surf1CoordinateTM,rad1,conic1,semiDiam1, ...
    surf2CoordinateTM,rad2,conic2,semiDiam2,axesHandle,radSpacing,lensColor)
    % draw2DLens: Plots the 2 dimensional lay out of alens in meridional plane
    % given its two surfaces
    % Inputs
    %   surf1CoordinateTM,rad1,conic1,semiDiam1: coordinate transfer matrix
    %                        , radius, conic constant and
    %   semidiameter of the surface 1 ( the same is true for the second surface)
    %   axesHandle: axes to plot the lens
    %   radSpacing: radius sampling Spacing 
    % Output
    %   lensH:  height of the lens drawn
    %   zyPoints:  Coordinates of points on the surface

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

    surf1Position = surf1CoordinateTM(1:3,4);
    surf2Position = surf2CoordinateTM(1:3,4);
    
   

    lensHeight = max(min(abs([rad1,semiDiam1])),min(abs([rad2,semiDiam2])));
    
    actualSurfHeight1 = semiDiam1;
    drawnSurfHeight1 = lensHeight;
    
    actualSurfHeight2 = semiDiam2;
    drawnSurfHeight2 = lensHeight;    
    % Compute the surface coordinate points for 2D plots with out plotting the
    % individual surfaces.
    hold on;
    surfColor1 = lensColor/2;
    [ surfH1,zyPoints1,errCode1 ] = draw2DSurface(surf1CoordinateTM,rad1,...
        conic1,actualSurfHeight1,drawnSurfHeight1,-1,radSpacing,surfColor1);
    hold on;
    if errCode1
        lensH = NaN;
        zyPoints = NaN;
        errCode = 1; % Surface vertex is not in the Meridional Plane
        return;
    end
    surfColor2 = lensColor/4;
    [ surfH2,zyPoints2,errCode2 ] = draw2DSurface(surf2CoordinateTM,rad2,...
        conic2,actualSurfHeight2,drawnSurfHeight2,-1,radSpacing,surfColor2);
    if errCode2
        lensH = [];
        zyPoints = [];
        errCode = 1; % Surface vertex is not in the Meridional Plane
        return;
    end
    % Take the ZY cooridnates for the tangential layout plot.
    vertices1 = zyPoints1;
    vertices2 = zyPoints2;

    % check the continuity of the surface 2 data otherwise flipit upside down
    % compute the distance between Vertice1(End) to Vertice2(1) and to
    % Vertice2(End). Compare the distances and decide whether to flip
    % the matrices..

    surf1_Beg = vertices1(1,:);
    surf1_End = vertices1(end,:);
    surf2_Beg = vertices2(1,:);
    surf2_End = vertices2(end,:);

    surf1_EndTosurf2_Beg = sqrt((surf1_End(1)-surf2_Beg(1))^2 + ...
        (surf1_End(2)-surf2_Beg(2))^2);
    surf1_EndTosurf2_End = sqrt((surf1_End(1)-surf2_End(1))^2 + ...
        (surf1_End(2)-surf2_End(2))^2);
    if (surf1_EndTosurf2_End < surf1_EndTosurf2_Beg)
        vertices2 = flipud(vertices2);
    end

    lensVertices = [vertices1;vertices2];
    hold on;
    patch(lensVertices(:,1),lensVertices(:,2),lensColor,'Parent',axesHandle);
    hold on;
%     axis equal
    lensH = lensHeight;
    zyPoints = lensVertices;
    errCode = 0; % No error
end


