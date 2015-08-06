function [ mirrorH,zyPoints,errCode] = draw2DMirror(surfCoordinateTM,rad,conic,...
    semiDiam,axesHandle,radSpacing,mirrorColor, negThick,varagrin) 
    % draw2DMirror: Drwas a single Mirror in 2D layout diagram
    % Inputs
    %   surfCoordinateTM,rad,conic,semiDiam: coordinate transfer matrix, radius, conic constant and
    %   semidiameter of the surface
    %   axesHandle: axes to plot the surface. A negative number can be
    %   passed as axes handle to supress the graphical output.
    %   radSpacing: radius sampling Spacing 
    %   varagrin: Not used yet. Can be used to indicate edge type and
    %   thickness in future
    % Output
    %   mirrorH:  height of the Mirror surface drawn
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
    surf1CoordinateTM = surfCoordinateTM;
    rad1 = rad;
    conic1 = conic;
    semiDiam1 = semiDiam;
    
    surf2CoordinateTM = surfCoordinateTM;
    if negThick
        surf2CoordinateTM(3,4) = surf2CoordinateTM(3,4) + 0.2;
    else
        surf2CoordinateTM(3,4) = surf2CoordinateTM(3,4) - 0.2;
    end
    rad2 = rad;
    conic2 = conic;
    semiDiam2 = semiDiam;
    mirrorColor = [0.9,0.9,0.9];
    [ mirrorH,zyPoints,errCode ] = draw2DLens(surf1CoordinateTM,rad1,conic1,semiDiam1, ...
    surf2CoordinateTM,rad2,conic2,semiDiam2,axesHandle,radSpacing,mirrorColor);    
end

