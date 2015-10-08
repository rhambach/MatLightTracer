function [ isScalarGaussianBeam ] = isScalarOrthogonalGaussianBeamSet( currentScalarGaussianBeam )
    %ISScalarGaussianBeam Summary of this function goes here
    %   Detailed explanation goes here
    isScalarGaussianBeam = 0;
    if isstruct(currentScalarGaussianBeam)
        if isfield(currentScalarGaussianBeam,'ClassName') && strcmpi(currentScalarGaussianBeam.ClassName,'ScalarGaussianBeamSet')
           isScalarGaussianBeam = 1; 
        end
    else
        if strcmpi(class(currentScalarGaussianBeam),'ScalarGaussianBeamSet')
            isScalarGaussianBeam = 1; 
        end
    end
    
end

