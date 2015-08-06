function [ updatedSystem ] = updateSurfaceFromComponentArray( currentOpticalSystem )
    %updateSurfaceFromComponentArray Summary of this function goes here
    %   Detailed explanation goes here
    
    updatedSystem = currentOpticalSystem;
    if isempty(updatedSystem.SurfaceArray)
        % Convert From componentArray to surfaceArray
        componentArray = updatedSystem.ComponentArray;
        nComponent = getNumberOfComponents(updatedSystem);
        totalSurfaceArray = [];
        for tt = 1:nComponent
            currentSurfaceArray = getSurfaceArray(componentArray(tt));
            stopSurfaceInComponentIndex = componentArray(tt).StopSurfaceIndex;
            if stopSurfaceInComponentIndex
                currentSurfaceArray(stopSurfaceInComponentIndex).Stop = 1;
            end
            totalSurfaceArray = [totalSurfaceArray,currentSurfaceArray];
        end
        updatedSystem.SurfaceArray = totalSurfaceArray;
    else
        disp('Warning: The surface array of component based system should be empty.');
    end
    updatedSystem.ComponentArray = Component.empty;
    updatedSystem = updateSurfaceCoordinateTransformationMatrices(updatedSystem);
end

