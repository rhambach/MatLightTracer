function [ wavelength, weight ] = getSystemWavelength( optSystem,index )
    %GETSYSTEMWAVELENGTH returns the system wavelength with corresponding
    %weight for given index. If index is not given or == 0, then all
    %wavelengths in the wavelength matrix will be returned.
    if nargin < 2
        index = 0;
    end
    wavelengthMatrix = optSystem.WavelengthMatrix;
    
    if index == 0
        wavelength = wavelengthMatrix(:,1);
        weight = wavelengthMatrix(:,2);
    else
        wavelength = wavelengthMatrix(index,1);
        weight = wavelengthMatrix(index,2);
    end
    
end

