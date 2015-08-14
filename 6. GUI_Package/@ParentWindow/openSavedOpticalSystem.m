function opened = openSavedOpticalSystem(parentWindow,savedOpticalSystem)
    % extract all data from a given OpticalSystem object "savedOpticalSystem"
    % and load it to surface data editor and configuration window.
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    % Change the title bar to optical system name
    set(aodHandles.FigureHandle,'Name',[savedOpticalSystem.PathName,savedOpticalSystem.FileName]);
    aodHandles.OpticalSystem = savedOpticalSystem;
    
    parentWindow.ParentHandles = aodHandles;
    % Close all child windows
    closeAllChildWindows(parentWindow);
    %% System Configuration Data
    updateSystemConfigurationWindow( parentWindow );
    % Update the surface or component editor panel
    updateSurfaceOrComponentEditorPanel(parentWindow);
    % Display the system layout and general system parameters
    updateQuickLayoutPanel(parentWindow,1)
    opened = 1;
end