function [ stopIndex, stopHeight] = computeSystemStop(givenStopIndex,refIndex,thick,curv,clearAperture)
	% computeSystemStop: calculate the stop index and stop height 
	% the stop index may be given directly by the user
	% Inputs
	% 	givenStopIndex: Stop index if specified by user otherwise = 0
	% 	refIndex,thick,curv,clearAperture : arrays of n,t of medium following, C and 
	%       effective apperture radius of each surface from object to image direction
	% Output
	% 	stopIndex, stopHeight: surface index and radius of stop surface. 
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

	% send pseudo mariginal ray from oxial point at object
	
    % if the stop surface is fixed by the user
	if givenStopIndex
	  stopIndex = givenStopIndex;
	else
	  if thick(1)==Inf % for object side afocal systems (object from infinity)     
		ytm = 0.01;
		utm = 0;  
	  else    
		ytm = 0;
		utm = 0.01; % assume object surface at origin of the coordinate system
      end
	  
	 % compute clear aperture to height ratio for each surface
	  CAy(1) = abs((clearAperture(1))/(ytm));
	  nsurf = length(curv); % number of surfaces including object and image
	  for kk=1:1:nsurf-1 
		  [ytm,utm]=yniTrace(ytm,utm,kk,kk+1, refIndex,thick,curv);
		  CAy(kk+1) = abs((clearAperture(kk+1))/(ytm));
	  end
	  % the surface with minimum value of clear aperture to height ratio is the stop
	  [C,I] = min(CAy);
	  stopIndex = I;
    end
    
    % The stop height shall be determined from the system aperture
    stopHeight = clearAperture(stopIndex);
end
