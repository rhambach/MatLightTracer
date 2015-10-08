function [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow,configurationIndex)
    % getCurrentOpticalSystem: Constructs an optical system object from the
    % Main Window
    % Member of ParentWindow class
    
    if nargin < 1
        disp('Erorr: The function getCurrentOpticalSystem needs atleast one input argument.');
        updatedSystem = NaN;
        saved = NaN;
        return;
    end
    if nargin < 2
        configurationIndex = parentWindow.ParentHandles.CurrentConfiguration;
    end
    
    % Check validity of the optical system inputs
    [ isValidSystem,message,updatedOpticalSystem ] = validateOpticalSystem(parentWindow);
    if configurationIndex
        parentWindow.ParentHandles.OpticalSystem(configurationIndex) = updatedOpticalSystem;
    else
        parentWindow.ParentHandles.OpticalSystem = updatedOpticalSystem;
    end
    
    if ~isValidSystem
        msg1 = (['Warning: The optical system was invalid and the following ',...
            'changes have been made to make it Valid. So plaese confirm the changes. ']);
        for mm = 1:length(message)
            msg1 = [msg1  ([num2str(mm) , ' : ',message{mm}])];
        end
        
        msgHandle = msgbox(msg1,'Invalid system: Confirm changes','Warn');
    end
    
    aodHandles = parentWindow.ParentHandles;
    if configurationIndex
        savedOpticalSystem = aodHandles.OpticalSystem(configurationIndex);
    else
        savedOpticalSystem = aodHandles.OpticalSystem;
    end
    
    updatedSystem = savedOpticalSystem;
    nConfig = length(savedOpticalSystem);
    for kk = 1:nConfig
        % Update surface array and coordinate trasnformation matrices for each
        % surface
        if isfield(savedOpticalSystem(kk),'IsUpdatedSurfaceArray') && ...
                savedOpticalSystem(kk).IsUpdatedSurfaceArray
            updatedSystem(kk) = savedOpticalSystem(kk);
        else
            
            nElement = length(savedOpticalSystem(kk).OpticalElementArray);
            totalSurfaceArray = [];
            elementToSurfaceMap = cell(nElement,1);
            for ee = 1:nElement
                currentElement = savedOpticalSystem(kk).OpticalElementArray{ee};
                if isempty(totalSurfaceArray)
                    nSurfBefore = 0;
                else
                    nSurfBefore = length(totalSurfaceArray);
                end
                
                if isSurface(currentElement)
                    totalSurfaceArray = [totalSurfaceArray,currentElement];
                elseif isComponent(currentElement)
                    currentSurfaceArray = getComponentSurfaceArray(currentElement);
                    stopSurfaceInComponentIndex = currentElement.StopSurfaceIndex;
                    if stopSurfaceInComponentIndex
                        currentSurfaceArray(stopSurfaceInComponentIndex).StopSurfaceIndex = 1;
                    end
                    totalSurfaceArray = [totalSurfaceArray,currentSurfaceArray];
                else
                end
                nSurfAfter = length(totalSurfaceArray);
                elementToSurfaceMap{ee} = [nSurfBefore+1:nSurfAfter];
                surfaceToElementMap(nSurfBefore+1:nSurfAfter) = num2cell(ee*ones(1,nSurfAfter-nSurfBefore));
            end
            updatedSurfaceArray = updateSurfaceCoordinateTransformationMatrices(totalSurfaceArray);
            
            savedOpticalSystem(kk).SurfaceArray = updatedSurfaceArray;
            savedOpticalSystem(kk).ElementToSurfaceMap = elementToSurfaceMap;
            savedOpticalSystem(kk).SurfaceToElementMap = surfaceToElementMap;
            % Set flaoting apertures
            updatedSystem(kk) = setFloatingApertures( savedOpticalSystem(kk) );
            updatedSystem(kk).IsUpdatedSurfaceArray = 1;
        end
    end
    if configurationIndex
        aodHandles.OpticalSystem(configurationIndex) = updatedSystem;
    else
        aodHandles.OpticalSystem = updatedSystem;
    end
    
    saved = 1;
    %aodHandles.IsSaved = 1;
    parentWindow.ParentHandles = aodHandles;
end

