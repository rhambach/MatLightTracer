function [ updatedSystem ] = convertToComponentBased( currentOpticalSystem )
    %CONVERTTOCOMPONENTBASED Summary of this function goes here
    %   Detailed explanation goes here
    
    updatedSystem = currentOpticalSystem;
    if ~ActionConfirmed
        return;
    end
    if IsSurfaceBased(currentOpticalSystem) %isempty(updatedSystem.ComponentArray)
        % Convert From surface arry to component array
        surfaceArray = updateSurfaceCoordinateTransformationMatrices(updatedSystem.SurfaceArray);
        nSurface = getNumberOfSurfaces(updatedSystem);
        for tt = 1:nSurface
            if surfaceArray(tt).IsObject
                compType = 'OBJECT';
                updatedSystem.ComponentArray(tt) = Component(compType);
            elseif surfaceArray(tt).IsImage
                compType = 'IMAGE';
                updatedSystem.ComponentArray(tt) = Component(compType);
            else
                compType = 'SequenceOfSurfaces';
                uniqueParameters = struct();
                uniqueParameters.SurfaceArray = surfaceArray(tt);
                updatedSystem.ComponentArray(tt) = Component(compType,uniqueParameters);
                if surfaceArray(tt).IsStop
                    updatedSystem.ComponentArray(tt).StopSurfaceIndex = 1;
                end
            end
        end
    else
        disp('Warning: The system is already component based.');
    end
    %     updatedSystem.SurfaceArray = Surface.empty;
    updatedSystem.SurfaceArray = Surface();
    updatedSystem.SystemDefinitionType = 'ComponentBased';
end




function actionConfirmed = ActionConfirmed()
    choice = questdlg(['Converting Surface based system to Component based',...
        ' one replaces each surface with a Sequence_Of_Surface component. ',...
        ' Do you want to continue the conversion?'], ...
        'Convert to Component based system', ...
        'Yes','No','No');
    % Handle response
    switch choice
        case 'Yes'
            actionConfirmed = 1;
        case 'No'
            actionConfirmed = 0;
    end
end