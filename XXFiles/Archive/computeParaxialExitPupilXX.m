function [ exitPupilPosition, exitPupilHeight] = computeParaxialExitPupil(givenStopIndex,refIndex,thick,curv,clearAperture) 
    % computeParaxialExitPupil: compute the paraxial exit pupil 
	% position and diameter.
    % Inputs
    %   givenStopIndex: Stop index if specified by user otherwise = 0
    % 	refIndex,thick,curv,clearAperture : arrays of n,t of medium following and C and 
	%       effective apperture radius of 
    %                         each surface from object to image direction

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
    [ entPupilPosition, entPupilHeight] = computeParaxialEntrancePupil(givenStopIndex,refIndex,thick,curv,clearAperture);
    angMag = computeParaxialAngularMagnification(refIndex,thick,curv);
    % Exit pupil height is computed from magnification
    exitPupilHeight = entPupilHeight/angMag;
    % Exit pupil location obtained by paraxial raytrace from stop surface
    % axis point to image space
    nSurf = size(curv,2);
    ystop = 0;
    ustop = 0.01;
    [yimg,uimg] = yniTrace(ystop,ustop,givenStopIndex,...
                   nSurf, refIndex,thick,curv);
    exitPupilPosition =  - yimg / tan(uimg); 
    