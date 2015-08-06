function [ transMag] = computeParaxialTransverseMagnification(refIndex,thick,curv,obj_img) 
	% computeParaxialTransverseMagnification: computes the paraxial transverse 
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

	% trace a paraxial axial ray
    if strcmpi(obj_img,'FF') 
        y0 = 0;
        u0 = 0.01;
        [yf,uf] = yniTrace(y0,u0,1,length(curv)-1, refIndex,thick,curv);
        transMag = (u0*refIndex(1))/(uf*refIndex(length(curv)-1));
    elseif strcmpi(obj_img,'FI')
        
    elseif strcmpi(obj_img,'IF')
        
    elseif strcmpi(obj_img,'II') 
        
    end