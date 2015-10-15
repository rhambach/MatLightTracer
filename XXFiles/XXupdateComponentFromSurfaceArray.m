function [ updatedSystem ] = updateComponentFromSurfaceArray( currentOpticalSystem )
    %updateComponentFromSurfaceArray Summary of this function goes here
    %   Detailed explanation goes here
    
    updatedSystem = currentOpticalSystem;
    if isempty(updatedSystem.ComponentArray)
        % Convert From surface arry to component array
        surfaceArray = updatedSystem.SurfaceArray;
        nSurface = getNumberOfSurfaces(updatedSystem);
        updatedSystem = updateSurfaceCoordinateTransformationMatrices(updatedSystem);
        for tt = 1:nSurface
            if surfaceArray(tt).ObjectSurface
                compType = 'OBJECT';
                updatedSystem.ComponentArray(tt) = Component(compType);
            elseif surfaceArray(tt).ImageSurface
                compType = 'IMAGE';
                updatedSystem.ComponentArray(tt) = Component(compType);
            else
                compType = 'SequenceOfSurfaces';
                uniqueParameters = struct();
                uniqueParameters.getSurfaceArray = surfaceArray(tt);
                updatedSystem.ComponentArray(tt) = Component(compType,uniqueParameters);
                if surfaceArray(tt).Stop
                    updatedSystem.ComponentArray(tt).StopSurfaceIndex = 1;
                end
            end
        end
    else
        disp('Warning: The component array of surface based system should be empty.');
    end
    updatedSystem.SurfaceArray = Surface.empty;
    updatedSystem.SystemDefinitionType = 'ComponentBased';
    updatedSystem = updateSurfaceCoordinateTransformationMatrices(updatedSystem);
    
end

