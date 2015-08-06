function [ surfH ] = draw2DSurface(surfPosition,rad,conic,semiDiam,axesHandle) 
    % draw2DSurface: Drwas a single surface in 2D layout diagram
    % Inputs
    %   surfPosition,rad,conic,semiDiam: position, radius, conic constant and
    %   semidiameter of the surface 
    %   axesHandle: axes to plot the surface
    % Output
    %   surfH:  height of the surface drawn

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

    surfH = draw2DLens(surfPosition,rad,conic,semiDiam, surfPosition,rad,conic,semiDiam,axesHandle);
end

