function [ isGauss1D ] = isGauss1D( currentGauss1D )
    %isGauss1D Summary of this function goes here
    %   Detailed explanation goes here
    isGauss1D = 0;
    if isstruct(currentGauss1D)
        if isfield(currentGauss1D,'ClassName') && strcmpi(currentGauss1D.ClassName,'Gauss1D')
           isGauss1D = 1; 
        end
    else
        if strcmpi(class(currentGauss1D),'Gauss1D')
            isGauss1D = 1; 
        end
    end
    
end

