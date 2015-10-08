function [ rayleighRangeInX,rayleighRangeInY ] = getOrthogonalGaussianBeamRayleighRange( orthogonalGaussianBeamSet )
    %GETRAYLEIGHRANGE Returns the rayleigh range in local x and y directions
    % The code is also vectorized. Multiple inputs and outputs are possible.
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %   Part of the RAYTRACE_TOOLBOX
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Nov 07,2014   Worku, Norman G.     Original Version
    
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    rayleighRangeInX = (pi*(orthogonalGaussianBeamSet.WaistRadiusInX).^2)./...
        (orthogonalGaussianBeamSet.CentralRayWavelength);
    rayleighRangeInY = (pi*(orthogonalGaussianBeamSet.WaistRadiusInY).^2)./...
        (orthogonalGaussianBeamSet.CentralRayWavelength);
end

