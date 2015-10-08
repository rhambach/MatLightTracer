function [ qx,qy ] = getOrthogonalGaussianBeamComplexQParameter( orthogonalGaussianBeamSet )
    %GETCOMPLEXQPARAMETER Returns the complex q parameter which completely
    % specifies the gaussian beam
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
    [ spotRadiusInX,spotRadiusInY ] = getSpotRadius(orthogonalGaussianBeamSet);
    [ radiusOfCurvatureInX,radiusOfCurvatureInY ] = getRadiusOfCurvature(orthogonalGaussianBeamSet);
    
    qx = 1./((1./radiusOfCurvatureInX)-...
        1i*([orthogonalGaussianBeamSet.CentralRayWavelength]./(pi*(spotRadiusInX).^2)));
    qy = 1./((1./radiusOfCurvatureInY)-...
        1i*([orthogonalGaussianBeamSet.CentralRayWavelength]./(pi*(spotRadiusInY).^2)));
end

