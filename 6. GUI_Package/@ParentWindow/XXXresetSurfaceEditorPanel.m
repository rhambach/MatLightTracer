function parentWindow = resetSurfaceEditorPanel(parentWindow)
    % resetSurfaceEditorPanel: reset all Surface editor tables (comp list and comp param)
    % Member of ParentWindow class
    global CURRENT_SELECTED_SURFACE
    global CAN_ADD_SURFACE
    global CAN_REMOVE_SURFACE
    
    CURRENT_SELECTED_SURFACE = 0;
    CAN_ADD_SURFACE = 0;
    CAN_REMOVE_SURFACE = 0;
    
    
    aodHandles = parentWindow.ParentHandles;
    
    supportedSurfaces = GetSupportedSurfaces();
    columnName1 =   {'Surface','Type', 'Name/Note'};
    columnWidth1 = {70,120, 100};
    columnEditable1 =  [false,true ,true];
    columnFormat1 =  {'char',{supportedSurfaces{:}}, 'char'};
    initialTable1 = {'OBJ','OBJECT','Object';...
        'STOP','Standard',  '';...
        'IMG','IMAGE', 'Image'};
    set(aodHandles.tblSurfaceList, ...
        'ColumnFormat',columnFormat1,...
        'Data', initialTable1,'ColumnEditable', columnEditable1,...
        'ColumnName', columnName1,'ColumnWidth',columnWidth1);
    
    % reset surface parameter tables
    columnName2 =   {'Parameters', 'Value', 'Solve'};
    columnWidth2 = {150, 100 70};
    columnEditable2 =  [false true false];
    columnFormat2 =  {'char', 'char','char'};
    initialTable2 = {'Param 1','0',' '};
    set(aodHandles.tblSurfaceBasicParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);
    set(aodHandles.tblSurfaceApertureParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);
    set(aodHandles.tblSurfaceTiltDecenterParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);   
    
    
    
    % Initialize the panel and table for Surface List    
    % Define initial surface Array
    surfaceArray(1) = Surface('ObjectSurface');
    surfaceArray(1).ObjectSurface = 1;
    surfaceArray(2) = Surface('Standard');
    surfaceArray(2).Stop = 1;
    surfaceArray(3) = Surface('ImageSurface');
    surfaceArray(3).ImageSurface = 1;
    
    aodHandles.OpticalSystem.SurfaceArray = surfaceArray;
    parentWindow.ParentHandles = aodHandles;
    
end