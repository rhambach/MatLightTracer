function [ wavUnitFactor, wavUnitText] = getWavelengthUnitFactor( optSystem )
    %GETWAVELENGTHUNITFACTOR returns the factor for unit used for wave
    %length in the system

    % determine the lens units and wavelength units factors
    wavLenList = {'nm','um','mm'};
    
    if isnumeric(optSystem.WavelengthUnit)
        wavUnit = wavLenList{optSystem.WavelengthUnit};
    else
        wavUnit = optSystem.WavelengthUnit; % '(nm)','(um)'
    end
    switch lower(wavUnit)
        case 'nm'
            wavUnitText = 'Nanometer';
            wavUnitFactor = 10^-9;
        case 'um'
            wavUnitText = 'Micrometer';
            wavUnitFactor = 10^-6;
        case 'mm'
            wavUnitText = 'Milimeter';
            wavUnitFactor = 10^-3;
    end        
end

