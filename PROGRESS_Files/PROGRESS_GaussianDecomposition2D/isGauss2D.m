function [ isGauss2D ] = isGauss2D( currentGauss2D )
    %isGauss2D Summary of this function goes here
    %   Detailed explanation goes here
    isGauss2D = 0;
    if isstruct(currentGauss2D)
        if isfield(currentGauss2D,'ClassName') && strcmpi(currentGauss2D.ClassName,'Gauss2D')
           isGauss2D = 1; 
        end
    else
        if strcmpi(class(currentGauss2D),'Gauss2D')
            isGauss2D = 1; 
        end
    end
    
end

