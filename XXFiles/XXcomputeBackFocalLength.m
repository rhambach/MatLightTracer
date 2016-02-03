function [ BFL ] = computeBackFocalLength( refIndex,thick,curv,obj_img )
	% computeBackFocalLength: computes the back focal length of system by 
    %                         tracing collimated rays. 
    % Inputs
    % 	refIndex,thick,curv : arrays of n,t of medium following and C of 
    %                         each surface from object to image direction
    %   obj_img: 'FF','FI','IF','II' showing location of object and
    %   image Finite and infinite. 'FI' and 'II' are afocal image side and
    %   usually need special tratment
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
    
    if strcmpi(obj_img,'FF') || strcmpi(obj_img,'IF')
        y0 = 0.01;
        u0 = 0;
        [yf,uf] = yniTrace(y0,u0,1,length(curv)-1, refIndex,thick,curv); 
        BFL = -yf/(uf);
        % In image space
        BFL = BFL * refIndex(end-1);
    elseif strcmpi(obj_img,'FI') || strcmpi(obj_img,'II')
        BFL = Inf;
    end
end

