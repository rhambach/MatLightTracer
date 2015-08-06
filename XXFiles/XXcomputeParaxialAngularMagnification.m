function [ angMag] = computeParaxialAngularMagnification(refIndex,thick,curv,stopIndex) 
	% computeParaxialAngularMagnification: computes the paraxial angular 
	%                                   magnificatrion using Lagrange invariant. 
    % Inputs
    % 	refIndex,thick,curv : arrays of n,t of medium following and C of 
    %                         each surface from object to image direction
    %   obj_img: 'FF','FI','IF','II' showing location of object and
    %   image Finite and infinite
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

	% trace a paraxial cheif ray from stop to forward and backward. 
    % Then compute the angular magnification
    % Angular magnification
    % The ratio of the paraxial image space chief ray angle to the paraxial object space chief ray angle. The angles
    % are measured with respect to the paraxial entrance and exit pupil locations.

    ystop = 0;
    ustop = 0.01;
    [yimg,uimg] = yniTrace(ystop,ustop,stopIndex,...
                   length(curv)-1, refIndex,thick,curv);

    [yobj,uobj] = yniTrace(ystop,ustop,stopIndex,1, refIndex,thick,curv);
    angMag = (uimg*refIndex(length(curv)-1))/(uobj*refIndex(1));

