function [ isHarmonicField ] = isHarmonicField( currentHarmonicField )
    %ISHarmonicField Summary of this function goes here
    %   Detailed explanation goes here
    isHarmonicField = 0;
    if isstruct(currentHarmonicField)
        if isfield(currentHarmonicField,'ClassName') && strcmpi(currentHarmonicField.ClassName,'HarmonicField')
           isHarmonicField = 1; 
        end
    else
        if strcmpi(class(currentHarmonicField),'HarmonicField')
            isHarmonicField = 1; 
        end
    end
    
end

