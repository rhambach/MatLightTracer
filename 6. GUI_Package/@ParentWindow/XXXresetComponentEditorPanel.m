function parentWindow = resetComponentEditorPanel(parentWindow)
    % resetComponentEditorPanel: reset all Component editor tables (comp list and comp param)
    % Member of ParentWindow class
    global CURRENT_SELECTED_COMPONENT
    global CAN_ADD_COMPONENT
    global CAN_REMOVE_COMPONENT
    
    CURRENT_SELECTED_COMPONENT = 0;
    CAN_ADD_COMPONENT = 0;
    CAN_REMOVE_COMPONENT = 0;
    
    global SELECTED_CELL_SQS
    global CAN_ADD_SURFACE_SQS
    global CAN_REMOVE_SURFACE_SQS
    SELECTED_CELL_SQS = [];
    CAN_ADD_SURFACE_SQS = 0;
    CAN_REMOVE_SURFACE_SQS = 0;
    
    global SELECTED_CELL_SEQOFSURF
    global CAN_REMOVE_SURF_FROM_SEQOFSURF
    global CAN_ADD_SURF_TO_SEQOFSURF
    SELECTED_CELL_SEQOFSURF = [];
    CAN_REMOVE_SURF_FROM_SEQOFSURF = 0;
    CAN_ADD_SURF_TO_SEQOFSURF = 0;
    
    aodHandles = parentWindow.ParentHandles;
    
    supportedComponents = GetSupportedComponents();
    columnName1 =   {'Component','Type', 'Name/Note'};
    columnWidth1 = {70,120, 100};
    columnEditable1 =  [false,true true];
    columnFormat1 =  {'char',{supportedComponents{:}}, 'char'};
    initialTable1 = {'OBJ','OBJECT','Object';...
        'COMP','SQS',  '';...
        'IMG','IMAGE', 'Image'};
    set(aodHandles.tblComponentList, ...
        'ColumnFormat',columnFormat1,...
        'Data', initialTable1,'ColumnEditable', columnEditable1,...
        'ColumnName', columnName1,'ColumnWidth',columnWidth1);
    
    % reset component parameter table
    columnName2 =   {'Parameters', 'Value', 'Edit'};
    columnWidth2 = {250, 100 70};
    columnEditable2 =  [false false false];
    columnFormat2 =  {'char', 'char','char'};
    initialTable2 = {'Text Par','0','Edit'};
    set(aodHandles.tblComponentParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);
    
    % Initialize the panel and table for Component List
    set(aodHandles.chkUpdateSurfaceEditorFromComponentEditor,'value',0);
    
    % Define initial component Array
    componentArray(1) = Component('OBJECT');
    componentArray(1).Parameters.SurfaceArray(1).ObjectSurface = 1;
    componentArray(2) = Component('SequenceOfSurfaces');
    componentArray(2).Parameters.SurfaceArray(1).Stop = 1;
    componentArray(3) = Component('IMAGE');
    componentArray(3).Parameters.SurfaceArray(1).ImageSurface = 1;
    
    aodHandles.ComponentArray = componentArray;
    parentWindow.ParentHandles = aodHandles;
    
end