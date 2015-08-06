function [ mirrorH,xyzPoints1, xyzPoints2] = drawMirror...
    (surfCoordinateTM,rad,conic,apertType,apertParam,...
    plotIn2D,axesHandle,radSpacing,mirrorColor,negThick,gratingLinesPerUm,gratingHeight,varagrin)  
% drawSMirror: Drwas a single Mirror in 3D/2D layout diagram
    % Inputs
    %   surfCoordinateTM,rad,conic,semiDiam: coordinate transfer matrix, radius, conic constant and
    %   semidiameter of the surface
    %   axesHandle: axes to plot the surface. A negative number can be
    %   passed as axes handle to supress the graphical output.
    %   radSpacing: radius sampling Spacing 
    %   plotIn2D: Plot the YZ cross section in 2D layout
    %   varagrin: Not used yet. Can be used to indicate edge type and
    %   thickness in future
    % Output
    %   mirrorH:  height of the surface drawn
    %   xyzPoints:  Coordinates of points on the surfaces

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
    surf1CoordinateTM = surfCoordinateTM;
    rad1 = rad;
    conic1 = conic;
    apertType1 = apertType;
    apertParam1 = apertParam;
    surf2CoordinateTM = surfCoordinateTM;
    if negThick
        surf2CoordinateTM(3,4) = surf2CoordinateTM(3,4) + 0.2;
        gratingHeight = -abs(gratingHeight);
    else
        surf2CoordinateTM(3,4) = surf2CoordinateTM(3,4) - 0.2;
        gratingHeight = abs(gratingHeight);
    end
    rad2 = rad;
    conic2 = conic;
    apertType2 = apertType;
    apertParam2 = apertParam;
    gratingLinesPerUm1 = gratingLinesPerUm;
    gratingLinesPerUm2 = 0;
    
    
    [ mirrorH,xyzPoints1, xyzPoints2 ] = drawLens...
        (surf1CoordinateTM,rad1,conic1,apertType1,apertParam1,...
    surf2CoordinateTM,rad2,conic2,apertType2,apertParam2,...
    plotIn2D,axesHandle,radSpacing,mirrorColor,gratingLinesPerUm1,gratingLinesPerUm2,gratingHeight);    
end

