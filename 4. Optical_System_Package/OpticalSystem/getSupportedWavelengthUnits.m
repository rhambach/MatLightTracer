function [ fullNames,shortNames,conversionFactor ] = getSupportedWavelengthUnits()
    %GETSUPPORTEDWAVELENGTHUNITS Summary of this function goes here
    %   Detailed explanation goes here
    
    shortNames = {'nm','um','mm'};
    fullNames = {'Nanometer','Micrometer','Milimeter'};
    conversionFactor = [10^-9,10^-6,10^-3];
end

