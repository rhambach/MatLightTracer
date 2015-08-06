function [ isGlass ] = isGlass( currentGlass )
    %ISGlass Summary of this function goes here
    %   Detailed explanation goes here
    isGlass = 0;
    if isstruct(currentGlass)
        if isfield(currentGlass,'ClassName') && strcmpi(currentGlass.ClassName,'Glass')
           isGlass = 1; 
        end
    else
        if strcmpi(class(currentGlass),'Glass')
            isGlass = 1; 
        end
    end
    
end

