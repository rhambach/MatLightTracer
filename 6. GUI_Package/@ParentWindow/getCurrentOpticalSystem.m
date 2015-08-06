function [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow)
    % getCurrentOpticalSystem: Constructs an optical system object from the
    % Main Window
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    savedOpticalSystem = aodHandles.OpticalSystem;
    updatedSystem = savedOpticalSystem;
%     if IsSurfaceBased(savedOpticalSystem) && isempty(savedOpticalSystem.SurfaceArray)
%         %         [ updatedSystem ] = updateSurfaceFromComponentArray( savedOpticalSystem );
%         disp('Error: IsSurfaceBased(savedOpticalSystem) && isempty(savedOpticalSystem.SurfaceArray)');
%     elseif IsComponentBased(savedOpticalSystem) && isempty(savedOpticalSystem.ComponentArray)
%         %         [ updatedSystem ] = updateComponentFromSurfaceArray( savedOpticalSystem );
%         disp('Error: IsComponentBased(savedOpticalSystem) && isempty(savedOpticalSystem.ComponentArray)');
%     else
%         updatedSystem.SurfaceArray = updateSurfaceCoordinateTransformationMatrices(savedOpticalSystem.SurfaceArray);   
%     end
    
    aodHandles.OpticalSystem = updatedSystem;
    saved = 1;
    aodHandles.OpticalSystem.Saved = 1;
    parentWindow.ParentHandles = aodHandles;
end

