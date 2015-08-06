function [ pupilPosition, pupilHeight] = computeParaxialEntrancePupil...
        (givenStopIndex,refIndex,thick,curv,clearAperture,obj_img) 
    % computeParaxialEntrancePupil: compute the paraxial entrance pupil 
	% position and diameter.
    % Inputs
    %   givenStopIndex: Stop index if specified by user otherwise = 0
    % 	refIndex,thick,curv,clearAperture : arrays of n,t of medium following and C and 
	%       effective apperture radius of 
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
    
    stopIndex = computeSystemStopIndex...
        (givenStopIndex,refIndex,thick,curv,clearAperture,obj_img);

    % Trace a paraxial ray from axial point @ stop and determine the
    % corresponding ray parameter at object surface.
    ystop = 0;
    ustop = 0.01;
    [yobj,uobj] = yniTrace(ystop,ustop,stopIndex,1, refIndex,thick,curv);
    % Then entrance pupil position is where this object ray crosses the
    % optical axis
    pupilPosition = -yobj/uobj- thick(1); %from 1st surface of the optical system

    % And the entrance pupil height can be determined from mariginal ray
    % The stop radius shall be computed from given apertures. Now use the
    % clear aperture
    stopRadius = clearAperture(stopIndex);
    [ ym, um ] = computeParaxialMariginalRay...
        (stopIndex,refIndex,thick,curv,stopRadius,obj_img); 
    if um == 0
        % Object @ inf and so Mariginal ray is parallel to axis
        % The PupilDiameter shall be given by user. Otherwise error
        disp(['For objects at infinity the Entrance pupil diameter can '...
            'not be computed, It should be specified by user as system aperture']);
        % Just make the mariginal ray height as pupil height
        pupilHeight = ym;
    else
        % Finite object
        pupilHeight = abs((pupilPosition+thick(1))*um); 
    end
    
    
    %compute the initial ray to the left of the stop. That is at surface just before stop
    % to avoid refraction effect of the stop surface during backtracing
    %ystopm1 = -ustop * thick(stopIndex-1); 
    %ustopm1 = ustop ;

 
 

