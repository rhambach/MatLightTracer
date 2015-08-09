function [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow)
    % getCurrentOpticalSystem: Constructs an optical system object from the
    % Main Window
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    savedOpticalSystem = aodHandles.OpticalSystem;
    
    if isfield(savedOpticalSystem,'IsUpdatedSurfaceArray') && ...
            savedOpticalSystem.IsUpdatedSurfaceArray
        updatedSurfaceArray = savedOpticalSystem.SurfaceArray;
    else
        if IsComponentBased(savedOpticalSystem)
            componentArray = savedOpticalSystem.ComponentArray;
            nComponent = getNumberOfComponents(savedOpticalSystem);
            totalSurfaceArray = [];
            for tt = 1:nComponent
                currentSurfaceArray = getComponentSurfaceArray(componentArray(tt));
                stopSurfaceInComponentIndex = componentArray(tt).StopSurfaceIndex;
                if stopSurfaceInComponentIndex
                    currentSurfaceArray(stopSurfaceInComponentIndex).Stop = 1;
                end
                totalSurfaceArray = [totalSurfaceArray,currentSurfaceArray];
            end
            tempSurfaceArray = totalSurfaceArray;
        else
            tempSurfaceArray = savedOpticalSystem.SurfaceArray;
        end
        updatedSurfaceArray = updateSurfaceCoordinateTransformationMatrices(tempSurfaceArray);
    end
    savedOpticalSystem.SurfaceArray = updatedSurfaceArray;
    % Set flaoting apertures
    updatedSystem = setFloatingApertures( savedOpticalSystem );
    savedOpticalSystem.IsUpdatedSurfaceArray = 1;
    aodHandles.OpticalSystem = updatedSystem;
    saved = 1;
    aodHandles.OpticalSystem.Saved = 1;
    parentWindow.ParentHandles = aodHandles;
end

