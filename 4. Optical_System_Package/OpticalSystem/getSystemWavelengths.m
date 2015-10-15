function [ wavelengthInM, weight ] = getSystemWavelengths( optSystem,indices )
    %GETSYSTEMWAVELENGTH returns the system wavelength with corresponding
    %weight for given index. If index is not given or == 0, then all
    %wavelengths in the wavelength matrix will be returned.
    if nargin < 2
        indices = 0;
    end
    wavelengthMatrix = optSystem.WavelengthMatrix;
    
    if length(indices) == 1 && indices == 0
        wavelengthInM = (wavelengthMatrix(:,1))'*getWavelengthunitFactor(optSystem);
        weight = (wavelengthMatrix(:,2))';
    else
        wavelengthInM = (wavelengthMatrix(indices,1))'*getWavelengthUnitFactor(optSystem);
        weight = (wavelengthMatrix(indices,2))';
    end
    
end

