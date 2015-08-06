function [ lastThickness] = solveParaxialImageLocation(refIndex,thick,curv,obj_img)  
	% solveParaxialImageLocation: solves for location of paraxial images.
    % Inputs
    % 	refIndex,thick,curv : arrays of n,t of medium following and C of 
    %                         each surface from object to image direction
    %   obj_img: 'FF','FI','IF','II' showing location of object and
    %   image Finite and infinite
	% Output
	% lastThickness: he location of the image surface from the last system surface. 


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
	% trace a paraxial axial ray
    if strcmpi(obj_img,'FF') 
        y0 = 0;
        u0 = 0.01;
        [yf,uf] = yniTrace(y0,u0,1,length(curv)-1, refIndex,thick,curv); 
        lastThickness = -yf/uf;
    elseif  strcmpi(obj_img,'FI')
        lastThickness = Inf;
    elseif strcmpi(obj_img,'IF')
        y0 = 0.01;
        u0 = 0;
        [yf,uf] = yniTrace(y0,u0,1,length(curv)-1, refIndex,thick,curv); 
        lastThickness = -yf/uf;
    elseif strcmpi(obj_img,'II')
        lastThickness = Inf;
    end
