function [ divergenceRayInX,divergenceRayInY  ] = getDivergenceRays( gaussianBeamSet )
    %GETDIVERGENCERAYS Gives the divergence rays used to trace the given gaussian beam
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
    divergenceRayInX  = gaussianBeamSet.CentralRayBundle;
    divergenceRayInY  = gaussianBeamSet.CentralRayBundle;
    centralRayBundle = gaussianBeamSet.CentralRayBundle;
    [ divergenceHalfAngleInX,divergenceHalfAngleInY ] = getDivergenceHalfAngle(gaussianBeamSet);
    
    divergenceRayInXDirection = ...
        (ones(3,1)*cos(divergenceHalfAngleInX)).*(centralRayBundle.Direction) + ...
        (ones(3,1)*sin(divergenceHalfAngleInX)).*(gaussianBeamSet.LocalXDirection);
    divergenceRayInYDirection = ...
        (ones(3,1)*cos(divergenceHalfAngleInY)).*(centralRayBundle.Direction) + ...
        (ones(3,1)*sin(divergenceHalfAngleInY)).*(gaussianBeamSet.LocalYDirection);
    
    divergenceRayInX.Direction = divergenceRayInXDirection;
    divergenceRayInY.Direction = divergenceRayInYDirection;
    
    % Intersection of the divergence rays with the reference plane are 
    % left as the same as that of the central ray. 
end

