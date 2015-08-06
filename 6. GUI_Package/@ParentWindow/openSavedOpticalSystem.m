function opened = openSavedOpticalSystem(parentWindow,savedOpticalSystem,pathName, fileName)
    % extract all data from a given OpticalSystem object "savedOpticalSystem"
    % and load it to surface data editor and configuration window.
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    
    aodHandles.Saved = savedOpticalSystem.Saved;
    aodHandles.PathName = pathName;
    aodHandles.FileName = fileName;
    
    % Close all child windows
    closeAllChildWindows(parentWindow);
    
    % Change the title bar to optical system name
    set(aodHandles.FigureHandle,'Name',[savedOpticalSystem.PathName,savedOpticalSystem.FileName]);
    parentWindow.ParentHandles.OpticalSystem = savedOpticalSystem;
    
    %% System Configuration Data
    updateSystemConfigurationWindow( parentWindow );
    % Update the surface or component editor panel
    updateSurfaceOrComponentEditorPanel(parentWindow);
    % Display the system layout and general system parameters
    updateQuickLayoutPanel(parentWindow,1)
    % displayOpticalSystemDetail(parentWindow);
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem = savedOpticalSystem;
    
    parentWindow.ParentHandles = aodHandles;
    opened = 1;
end