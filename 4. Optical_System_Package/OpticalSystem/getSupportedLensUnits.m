function [ fullNames,shortNames,conversionFactor  ] = getSupportedLensUnits()
    %GETSUPPORTEDWAVELENGTHUNITS Summary of this function goes here
    %   Detailed explanation goes here
    shortNames = {'MM','CM','MT','IN','UM'};
    fullNames = {'Milimeter','Centimeter','Meter','Inch','Micrometer'};
    conversionFactor = [10^-3,10^-2,1,0.0254,10^-6];
end

