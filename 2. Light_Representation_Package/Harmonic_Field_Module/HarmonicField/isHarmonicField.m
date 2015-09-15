function [ isHarmonicField ] = isHarmonicField( currentHarmonicField )
    %ISHarmonicField Summary of this function goes here
    %   Detailed explanation goes here
    isHarmonicField = 0;
    if isstruct(currentHarmonicField)
        if isfield(currentHarmonicField,'ClassName') && strcmpi(currentHarmonicField.ClassName,'HarmonicFieldSource')
           isHarmonicField = 1; 
        end
    else
        if strcmpi(class(currentHarmonicField),'HarmonicFieldSource')
            isHarmonicField = 1; 
        end
    end
    
end

