function [ waistRayInX,waistRayInY ] = getWaistRays( gaussianBeamSet )
    %GETWAISTRAYS Gives the waist rays used to trace the given gaussian beam
    % The code is also vectorized. Multiple inputs and outputs are possible.
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Nov 07,2014   Worku, Norman G.     Original Version
    
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    % Copy all ray data from central ray and then change the positions to shift
    waistRayInX = gaussianBeamSet.CentralRayBundle;
    waistRayInY = gaussianBeamSet.CentralRayBundle;
    centralRayBundle = gaussianBeamSet.CentralRayBundle;
    
    % Compute waist ray intersection with the reference plane where the gaussian beam set is defined
    waistRayInXPosition = centralRayBundle.Position + ...
        (ones(3,1)*gaussianBeamSet.WaistRadiusInX).*gaussianBeamSet.LocalXDirection;
    waistRayInYPosition =  centralRayBundle.Position + ...
        (ones(3,1)*gaussianBeamSet.WaistRadiusInY).*gaussianBeamSet.LocalYDirection;
   
    waistRayInX.Position = waistRayInXPosition;
    waistRayInY.Position = waistRayInYPosition;
    % NB: The direction of the wais t rays are left to be the same as that
    % of the centeral ray
end

