function [n] = computeGlassRefractiveIndex(formulaType, wavLen, glassParameters)  
% computes the refractive index of glass from its dispersion formula

switch lower(formulaType)
    case lower('Sellmeier1')
        % all the coeffifints are in sq. µm and the wavelength in um 
        B1 = 0; B2 = 0; B3 = 0; C1 = 0; C2 = 0; C3 = 0;
        % First convert Wavelength to um as all sellmeir coefficients
        % are in sq um.
        wavLen = wavLen*10^6;        
        try
            B1 = glassParameters(1);
            B2 = glassParameters(2);
            B3 = glassParameters(3);
            C1 = glassParameters(4);
            C2 = glassParameters(5);
            C3 = glassParameters(6);
        catch
        end
        n = sqrt(1 + ...
            ((B1*wavLen.^2)./(wavLen.^2 - C1)) + ...
            ((B2*wavLen.^2)./(wavLen.^2 - C2)) + ...
            ((B3*wavLen.^2)./(wavLen.^2 - C3)));       
end
