function [ pupilPosition ] = computeExitPupilLocation...
        (stopIndex,refIndex,thick,curv) 
    % computeExitPupilLocation: compute the paraxial exit pupil 
	% position from first optical surface
    % Inputs
    %   stopIndex:  index of Stop surface
    % 	refIndex,thick,curv : arrays of n,t of medium following and C  of 
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
    
    % Trace a paraxial ray from axial point @ stop and determine the
    % corresponding ray parameter at image surface.
    
    
    ystop = 0;
    ustop = 0.01;
    [yimg,uimg] = yniTrace(ystop,ustop,stopIndex,...
                   length(curv), refIndex,thick,curv);
    % Then exit pupil position is where this object ray crosses the
    % optical axis
    pupilPosition =  - yimg / (uimg);
    