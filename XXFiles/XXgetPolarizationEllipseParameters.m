 function [polarizationEllipseAfterSurface] = ...
         getPolarizationEllipseParameters(RayTraceResult,initialJonesVector, initialRayDirection, wavLen)
     % getPolarizationEllipseParameters: Returns polarization ellipse
     % parameters of the ray after the surface including coating.
     %   The function is also vectorized so if the inputs are vectors then 
     %   the output will also be vector of the same size.
     
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
	% Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs

    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    polarizationVectorAfterSurface = computeFinalPolarizationVector(RayTraceResult,...
    initialJonesVector, initialRayDirection, wavLen);

%     PolEllipseBeforeCoating = computeEllipseParameters...
%         ( [RayTraceResult.PolarizationVectorBeforeCoating]);
    polarizationEllipseAfterSurface = computeEllipseParameters...
        ( polarizationVectorAfterSurface);
 end