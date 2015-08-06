function [ ym um ] = computeParaxialMariginalRay...
        (stopIndex,refIndex,thick,curv,stopRadius,obj_img)
	% computeParaxialMariginalRay: computes the height and angle of a mariginal ray.
    % Inputs
    % 	refIndex,thick,curv : arrays of n,t of medium following, C  radius of 
    %                         each surface from object to image direction.
    %   stopRadius and stopIndex: Index and radius of physical stop
    %   surface.
    %   obj_img: 'FF','FI','IF','II' showing location of object and
    %   image Finite and infinite
	% Output
	% ym,um: the height and angle of mariginal ray in the object space. 


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
    

    % send pseudo mariginal ray from axial point at object
    if strcmpi(obj_img,'IF') || strcmpi(obj_img,'IF')
        % for object side afocal systems (object from infinity)
        ytm0 = 0.001;
        utm0 = 0;  
    else
        % assume object surface at origin of the coordinate system
        ytm0 = 0;
        utm0 = 0.001;
    end
    % Determine the stopIndex
    [ stopIndex] = computeSystemStopIndex...
        (givenStopIndex,refIndex,thick,curv,clearAperture,obj_img);
    % Trace pseudo mariginal ray to the stop surface
    [ytm,utm] = yniTrace(ytm0,utm0,1,stopIndex, refIndex,thick,curv);
    % compute the ratio of stopRadius to Pseudo Mariginal ray intersection height
    apertureToHeight= stopRadius/(ytm);
    % scale the mariginal ray by the factor of apertureToHeight so that it 
    % becames the real mariginal ray and passes the edge of aperture stop edge.
    % This is possible because of linearity of paraxial ray tracing equations
    ym = ytm0*apertureToHeight; 
    um = utm0*apertureToHeight; 


% % if stop surface is fixed by the user
% if givenStopIndex
%   if thick(1) == Inf % for object side afocal systems (object from infinity)     
%     ytm0 = 0.001;
%     utm0 = 0;  
%   else    
%     ytm0 = 0;
%     utm0 = 0.001; %assume object surface at origin of the coordinate system
%   end
%   ytm(1) = ytm0; 
%   utm(1)= utm0;
% % compute clear aperture to height ratio for each surface
%   [ytm,utm] = yniTrace(ytm,utm,1,givenStopIndex, refIndex,thick,curv); 
%   CAy = (clearAperture(givenStopIndex))/(ytm);
%   %the surface with minimum value of clear aperture to height ratio is the stop
%   C = CAy;
%   I = givenStopIndex; 
% else
%   if thick(1)==Inf % for object side afocal systems (object from infinity)     
%     ytm0 = 0.001;
%     utm0 = 0;  
%   else    
%     ytm0 = 0;
%     utm0 = 0.001; %assume object surface at origin of the coordinate system
%   end
%   ytm(1) = ytm0; 
%   utm(1)= utm0;
% %compute clear aperture to height ration for each surface
%   CAy(1) = (clearAperture(1))/(ytm);
%   nsurf = length(curv) %number of surfaces including object and image
%   for kk=1:1:nsurf-1 
%       [ytm(kk+1),utm(kk+1)] = yniTrace(ytm(kk),utm(kk),kk,kk+1, refIndex,thick,curv); 
%       CAy(kk+1) = (clearAperture(kk+1))/(ytm(kk+1));
%   end
%   %the surface with minimum value of clear aperture to height ratio is the stop
%   [C,I] = min(CAy); 
%   
% end
%   %scale the ray by the factor of C so that it becames the real mariginal ray and passes the edge of aperture stop edge  
%   
%   %ymatstop = ytm(I)*C;    
%   %umatstop = utm(I)*C;
%   %trace this real mariginal ray back to object space
%   %[ym,um] = yniTrace(ymatstop,umatstop,I,1, refIndex,thick,curv); 
%   %or dirctly scale the input ray 
%   ym = ytm0*C; 
%   um = utm0*C; 
end
