function [ isCoating ] = isCoating( currentCoating )
    %ISCoating Summary of this function goes here
    %   Detailed explanation goes here
    isCoating = 0;
    if isstruct(currentCoating)
        if isfield(currentCoating,'ClassName') && strcmpi(currentCoating.ClassName,'Coating')
           isCoating = 1; 
        end
    else
        if strcmpi(class(currentCoating),'Coating')
            isCoating = 1; 
        end
    end
    
end

