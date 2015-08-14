function [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow)
    % getCurrentOpticalSystem: Constructs an optical system object from the
    % Main Window
    % Member of ParentWindow class
    

    % Check validity of the optical system inputs
    [ validSystem,message ] = validateOpticalSystem(parentWindow);
    
    if ~validSystem
        msg1 = (['Warning: The optical system was invalid and the following ',...
            'changes have been made to make it Valid. So plaese confirm the changes. ']);
        for mm = 1:length(message)
            msg1 = [msg1  ([num2str(mm) , ' : ',message{mm}])];
        end
        
        msgHandle = msgbox(msg1,'Invalid system: Confirm changes','Warn');
    end
    
    aodHandles = parentWindow.ParentHandles;
    savedOpticalSystem = aodHandles.OpticalSystem;
    
    % Update surface array and coordinate trasnformation matrices for each
    % surface
    if isfield(savedOpticalSystem,'IsUpdatedSurfaceArray') && ...
            savedOpticalSystem.IsUpdatedSurfaceArray
        updatedSystem = savedOpticalSystem;
        %         updatedSurfaceArray = savedOpticalSystem.SurfaceArray;
    else
        if IsComponentBased(savedOpticalSystem)
            componentArray = savedOpticalSystem.ComponentArray;
            nComponent = getNumberOfComponents(savedOpticalSystem);
            totalSurfaceArray = [];
            for tt = 1:nComponent
                currentSurfaceArray = getComponentSurfaceArray(componentArray(tt));
                stopSurfaceInComponentIndex = componentArray(tt).StopSurfaceIndex;
                if stopSurfaceInComponentIndex
                    currentSurfaceArray(stopSurfaceInComponentIndex).IsStop = 1;
                end
                totalSurfaceArray = [totalSurfaceArray,currentSurfaceArray];
            end
            tempSurfaceArray = totalSurfaceArray;
        else
            tempSurfaceArray = savedOpticalSystem.SurfaceArray;
        end
        updatedSurfaceArray = updateSurfaceCoordinateTransformationMatrices(tempSurfaceArray);
        
        savedOpticalSystem.SurfaceArray = updatedSurfaceArray;
        % Set flaoting apertures
        updatedSystem = setFloatingApertures( savedOpticalSystem );
        updatedSystem.IsUpdatedSurfaceArray = 1;
    end
    aodHandles.OpticalSystem = updatedSystem;
    saved = 1;
    aodHandles.OpticalSystem.Saved = 1;
    parentWindow.ParentHandles = aodHandles;
end

