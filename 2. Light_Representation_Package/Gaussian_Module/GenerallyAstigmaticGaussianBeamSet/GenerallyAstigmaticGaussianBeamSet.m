function [ newGaussianBeamSet ] = ...
        GenerallyAstigmaticGaussianBeamSet( complexRay1Position,...
        complexRay1Direction,complexRay2Position,complexRay2Direction,...
        centralRayPosition,centralRayDirection,wavelength )
    %GENERALLYASTIGMATICGAUSSIANBEAMSET Defines a generally astigmatic
    %gaussain beam using the complex ray parameters
    
    newGaussianBeamSet.ComplexRay1Position = complexRay1Position;
    newGaussianBeamSet.ComplexRay1Direction = complexRay1Direction;
    newGaussianBeamSet.ComplexRay2Position = complexRay2Position;
    newGaussianBeamSet.ComplexRay2Direction = complexRay2Direction;
    newGaussianBeamSet.CentralRayPosition = centralRayPosition;
    newGaussianBeamSet.CentralRayDirection = centralRayDirection;
    newGaussianBeamSet.Wavelength = wavelength;
    newGaussianBeamSet.ClassName = 'GenerallyAstigmaticGaussianBeamSet';
end

