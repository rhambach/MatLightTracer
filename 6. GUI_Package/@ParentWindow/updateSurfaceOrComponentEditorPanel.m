function updateSurfaceOrComponentEditorPanel( parentWindow , selectedIndex)
    %UPDATESURFACEORCOMPONENTEDITORPANEL Updates the surface or component
    %editor windows
    
    if nargin == 1
        selectedIndex = 1;
    end
    
    aodHandles = parentWindow.ParentHandles;
    [ currentOpticalSystem,saved] = getCurrentOpticalSystem (parentWindow);

    if IsSurfaceBased(currentOpticalSystem)

        nSurface = getNumberOfSurfaces(currentOpticalSystem);
        surfaceArray = currentOpticalSystem.SurfaceArray;
        % Read the componets and fill table for Component List
        newSurfArray = surfaceArray;
        aodHandles.OpticalSystem.SurfaceArray = newSurfArray;
        surfaceListTable = generateSurfaceListTable(newSurfArray);
        set(aodHandles.tblSurfaceList, 'Data', surfaceListTable);
        
        set(aodHandles.popStopSurfaceIndex,'String',num2cell([1:nSurface]));
        set(aodHandles.popStopSurfaceIndex,'Value',getStopSurfaceIndex(currentOpticalSystem));
        
        set(aodHandles.panelSurfaceEditorMain,'Visible','On');
        set(aodHandles.panelComponentEditorMain,'Visible','Off');
        parentWindow.ParentHandles = aodHandles;
        updateSurfaceDetail( parentWindow,selectedIndex )
        
    elseif IsComponentBased(currentOpticalSystem)
        
        %Component List Data
        nComponent = getNumberOfComponents(currentOpticalSystem);
        nSurface = getNumberOfSurfaces(currentOpticalSystem);
        componentArray = currentOpticalSystem.ComponentArray;
        % Read the componets and fill table for Component List
        newCompArray = componentArray;
        aodHandles.OpticalSystem.ComponentArray = newCompArray;
        componentListTable = generateComponentListTable(newCompArray);
        set(aodHandles.tblComponentList, 'Data', componentListTable);
        
        [stopCompIndex, specified] = getStopComponentIndex(currentOpticalSystem);
        
        set(aodHandles.popStopComponentIndex,'String',num2cell([1:nComponent]));
        set(aodHandles.popStopComponentIndex,'Value',stopCompIndex);
        
        stopComponent = currentOpticalSystem.ComponentArray(stopCompIndex);
        stopSurfaceInComponentIndex = stopComponent.StopSurfaceIndex;
        nSurfaceInComponent = getComponentNumberOfSurfaces(stopComponent);
        
        set(aodHandles.popStopSurfaceInComponentIndex,'String',num2cell([1:nSurfaceInComponent]));
        set(aodHandles.popStopSurfaceInComponentIndex,'Value',stopSurfaceInComponentIndex);
        
        set(aodHandles.panelSurfaceEditorMain,'Visible','Off');
        set(aodHandles.panelComponentEditorMain,'Visible','On');
        
        parentWindow.ParentHandles = aodHandles;
        updateComponentDetail( parentWindow,selectedIndex )
    else
        disp([num2str(systemDef),' : Invalid SystemDefinitionType']);
        return
    end
    
    aodHandles.OpticalSystem = currentOpticalSystem;
    parentWindow.ParentHandles =  aodHandles;
    
end


function       surfaceListTable = generateSurfaceListTable(surfArray);
    nSurface = length(surfArray);
    surfaceListTable = cell(nSurface,3);
    for kk = 1:nSurface
        if surfArray(kk).ObjectSurface
            surfType = 'OBJECT';
            surfTypeDisp = surfType;
            surf = 'OBJ';
            comment = 'Object';
        elseif surfArray(kk).ImageSurface
            surfType = 'IMAGE';
            surfTypeDisp = surfType;
            surf = 'IMG';
            comment = 'Image';
        elseif surfArray(kk).Stop
            surfType = surfArray(kk).Type;
            surfTypeDisp = surfType;
            surf = 'STOP';
            comment = 'Stop surface';
        else
            surfType = surfArray(kk).Type;
            surfTypeDisp = surfType;
            surf = '';
            comment = surfArray(kk).Comment;
        end
        
        surfaceListTable(kk,:) = {surf,surfTypeDisp,comment};
    end
end

function       componentListTable = generateComponentListTable(compArray);
    nComponent = length(compArray);
    componentListTable = cell(nComponent,3);
    for kk = 1:nComponent
        if strcmpi(compArray(kk).Type,'OBJECT')
            compType = 'OBJECT';
            compTypeDisp = compType;
            comp = 'OBJ';
            comment = 'Object';
        elseif strcmpi(compArray(kk).Type,'IMAGE')
            compType = 'IMAGE';
            compTypeDisp = compType;
            comp = 'IMG';
            comment = 'Image';
        elseif compArray(kk).StopSurfaceIndex
            compType = compArray(kk).Type;
            fullName = compType;
            compTypeDisp = fullName;
            comp = 'STOP';
            comment = '';            
        else
            compType = compArray(kk).Type;
            fullName = compType;
            compTypeDisp = fullName;
            comp = '';
            comment = '';
        end
        componentListTable(kk,:) = {comp,compTypeDisp,comment};
    end
end
