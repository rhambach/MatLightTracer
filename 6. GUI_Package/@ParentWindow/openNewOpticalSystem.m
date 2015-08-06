function [ opened ] = openNewOpticalSystem(parentWindow)
% openNewOpticalSystem: Close all windows and Initialize a new optical system
% Member of ParentWindow class

    global CURRENT_SELECTED_SURFACE
    global CAN_ADD_SURFACE
    global CAN_REMOVE_SURFACE
    
    CURRENT_SELECTED_SURFACE = 0;
    CAN_ADD_SURFACE = 0;
    CAN_REMOVE_SURFACE = 0;
    
  
    % Define initial surface Array
    defaultOpticalSystem = OpticalSystem;
    
    parentWindow.ParentHandles.OpticalSystem = defaultOpticalSystem;
    closeAllChildWindows(parentWindow);    
    resetParentParameters(parentWindow);
    updateSurfaceOrComponentEditorPanel( parentWindow );
    updateSystemConfigurationWindow( parentWindow );    
    opened = 1;
end

