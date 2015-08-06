function componentBased = IsComponentBased(currentOpticalSystem)
    %ISCOMPONENTBASED Summary of this function goes here
    %   Detailed explanation goes here
    
    componentBased = 0;
    if isnumeric(currentOpticalSystem.SystemDefinitionType)
        if currentOpticalSystem.SystemDefinitionType == 2
            componentBased = 1;
        end
    else
        if strcmpi(currentOpticalSystem.SystemDefinitionType, 'ComponentBased')
            componentBased = 1;
        end
    end
end

