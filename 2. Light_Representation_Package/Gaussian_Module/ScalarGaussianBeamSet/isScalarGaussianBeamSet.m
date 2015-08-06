function [ isScalarGaussianBeam ] = isScalarGaussianBeamSet( currentScalarGaussianBeam )
    %ISScalarGaussianBeam Summary of this function goes here
    %   Detailed explanation goes here
    isScalarGaussianBeam = 0;
    if isstruct(currentScalarGaussianBeam)
        if isfield(currentScalarGaussianBeam,'ClassName') && strcmpi(currentScalarGaussianBeam.ClassName,'ScalarGaussianBeam')
           isScalarGaussianBeam = 1; 
        end
    else
        if strcmpi(class(currentScalarGaussianBeam),'ScalarGaussianBeam')
            isScalarGaussianBeam = 1; 
        end
    end
    
end

