function [ isOrthogonalGaussianBeam ] = isOrthogonalGaussianBeamSet( currentOrthogonalGaussianBeam )
    %ISScalarGaussianBeam Summary of this function goes here
    %   Detailed explanation goes here
    isOrthogonalGaussianBeam = 0;
    if isstruct(currentOrthogonalGaussianBeam)
        if isfield(currentOrthogonalGaussianBeam,'ClassName') && strcmpi(currentOrthogonalGaussianBeam.ClassName,'ScalarGaussianBeamSet')
           isOrthogonalGaussianBeam = 1; 
        end
    else
        if strcmpi(class(currentOrthogonalGaussianBeam),'ScalarGaussianBeamSet')
            isOrthogonalGaussianBeam = 1; 
        end
    end
    
end

