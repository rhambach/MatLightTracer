function [ updatedSystem ] = convertToSurfaceBased( currentOpticalSystem )
    %CONVERTTOSURFACEBASED Summary of this function goes here
    %   Detailed explanation goes here
    
    updatedSystem = currentOpticalSystem;
    if ~ActionConfirmed
        return;
    end
    if IsComponentBased(currentOpticalSystem) %isempty(updatedSystem.SurfaceArray)
        % Convert From componentArray to surfaceArray
        componentArray = updatedSystem.ComponentArray;
        nComponent = getNumberOfComponents(updatedSystem);
        totalSurfaceArray = [];
        for tt = 1:nComponent
            currentSurfaceArray = getComponentSurfaceArray(componentArray(tt));
            stopSurfaceInComponentIndex = componentArray(tt).StopSurfaceIndex;
            if stopSurfaceInComponentIndex
                currentSurfaceArray(stopSurfaceInComponentIndex).Stop = 1;
            end
            totalSurfaceArray = [totalSurfaceArray,currentSurfaceArray];
        end
        updatedSystem.SurfaceArray = totalSurfaceArray;
    else
        disp('Warning: The system is already surface based.');
    end
%     updatedSystem.ComponentArray = Component.empty;
    updatedSystem.ComponentArray = Component();
    updatedSystem.SystemDefinitionType = 'SurfaceBased';
    updatedSystem.SurfaceArray = updateSurfaceCoordinateTransformationMatrices(updatedSystem.SurfaceArray);
    
end



function actionConfirmed = ActionConfirmed()
        choice = questdlg(['Converting Component based system to surface based',...
            ' one replaces each component with its contituting surface arrays. ',...
            ' As it is not reversible, you will loose all your component level data. ',...
            ' Do you want to continue the conversion?'], ...
            'Convert to Surface based system', ...
            'Yes','No','No');
        % Handle response
        switch choice
            case 'Yes'
                actionConfirmed = 1;
            case 'No'
                actionConfirmed = 0;
        end
end
