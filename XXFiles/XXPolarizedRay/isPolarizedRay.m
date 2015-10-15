function [ isPolarizedRay ] = isPolarizedRay( currentPolarizedRay )
    %ISPolarizedRay Summary of this function goes here
    %   Detailed explanation goes here
    isPolarizedRay = 0;
    if isstruct(currentPolarizedRay)
        if isfield(currentPolarizedRay,'ClassName') && strcmpi(currentPolarizedRay.ClassName,'PolarizedRay')
           isPolarizedRay = 1; 
        end
    else
        if strcmpi(class(currentPolarizedRay),'PolarizedRay')
            isPolarizedRay = 1; 
        end
    end
    
end

