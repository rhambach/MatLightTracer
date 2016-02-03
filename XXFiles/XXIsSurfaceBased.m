function surfacetBased = IsSurfaceBased(currentOpticalSystem)
    %IsSurfaceBased Summary of this function goes here
    %   Detailed explanation goes here
    
    surfacetBased = 0;
    if isnumeric(currentOpticalSystem.SystemDefinitionType)
        if currentOpticalSystem.SystemDefinitionType == 1
            surfacetBased = 1;
        end
    else
        if strcmpi(currentOpticalSystem.SystemDefinitionType, 'SurfaceBased')
            surfacetBased = 1;
        end
    end
end

