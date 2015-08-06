function [ clearAperture ] = getClearAperture( surface )
    %GETCLEARAPERTURE returns the clear aperture of a given surface
    
    switch surface.ApertureType
        case 'Circular'
            clearAperture = ...
                surface.ApertureParameter(1);
        case 'Rectangular'
            clearAperture = ...
                sqrt(sum((surface.ApertureParameter(1:2)).^2));
        case 'Elliptical'
            clearAperture = ...
                sqrt(sum((surface.ApertureParameter(1:2)).^2));
        otherwise
            clearAperture = ...
                sqrt(sum((surface.ApertureParameter(1:2)).^2));
    end
    
end

