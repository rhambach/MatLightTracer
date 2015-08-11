function [ parentWindow ] = saveMySystemAs(parentWindow)
    % saveMySystemAs: Display save dialog and save the optical system
    % Member of ParentWindow class
    
    % First compute all fast semi diameters
    % parentWindow.computeFastSemidiameters;
    
    aodHandles = parentWindow.ParentHandles;
    
    [fileName,pathName] = uiputfile('New Optical System.mat','Save As');
    
    if ~strcmpi(num2str(fileName),'0') && ~strcmpi(num2str(pathName),'0')
        aodHandles.OpticalSystem.IsSaved = 1;
        aodHandles.OpticalSystem.PathName = pathName;
        aodHandles.OpticalSystem.FileName = fileName;
        
        parentWindow.ParentHandles = aodHandles;
        currentOpticalSystem = getCurrentOpticalSystem(parentWindow);
        saveToMATFile( currentOpticalSystem,pathName,fileName);
        % Change the title bar to optical system name
        set(aodHandles.FigureHandle,'Name',[currentOpticalSystem.PathName,currentOpticalSystem.FileName]);
        parentWindow.ParentHandles = aodHandles;
    else
        return;
    end
end

