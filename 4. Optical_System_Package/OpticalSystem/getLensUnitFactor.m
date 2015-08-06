function [ lensUnitFactor,lensUnitText ] = getLensUnitFactor( optSystem )
    %GETLENSUNITFACTOR returns the factor for unit used for lens 
    % length in the system
    
   % determine the lens units and wavelength units factors
   lensUnitList = {'mm','cm','mt'};
   if isnumeric(optSystem.LensUnit)
       lensUnit = lensUnitList{optSystem.LensUnit};
   else
       lensUnit = optSystem.LensUnit; % '(mm)','(cm)','(mt)'
   end
   switch lower(lensUnit)
       case 'mm'
            lensUnitText = 'Milimeter';
            lensUnitFactor = (10^-3);
        case 'cm'
            lensUnitText = 'Centimeter';
            lensUnitFactor = (10^-2);
        case 'mt'
            lensUnitText = 'Meter';
            lensUnitFactor = (1);
    end    
end

