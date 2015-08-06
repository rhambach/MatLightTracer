function [ surfaceArray, nSurface ] = getSurfaceArray( optSystem,surfIndex )
    %GETSURFACEARRAY Returns the surface array of an optical system. The
    %surface coordinate transformation matrices are updated if they were
    %not updated.
    
    if nargin == 1
        surfIndex = 0;
    end
    if isfield(optSystem,'IsUpdatedSurfaceArray') && optSystem.IsUpdatedSurfaceArray
        updatedSurfaceArray = optSystem.SurfaceArray;
    else
        if IsComponentBased(optSystem)
            componentArray = optSystem.ComponentArray;
            nComponent = getNumberOfComponents(optSystem);
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
            tempSurfaceArray = optSystem.SurfaceArray;
        end
        updatedSurfaceArray = updateSurfaceCoordinateTransformationMatrices(tempSurfaceArray);
    end
    
    if surfIndex
        % Return the required surface
        surfaceArray = updatedSurfaceArray(surfIndex);
    else
        surfaceArray = updatedSurfaceArray;
    end
    nSurface = length(surfaceArray);
end

