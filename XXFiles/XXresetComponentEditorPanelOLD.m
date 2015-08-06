function parentWindow = resetComponentEditorPanel(parentWindow) 
% resetComponentEditorPanel: reset all Component editor tables
% Member of AODParentWindow class
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

    aodHandles = parentWindow.AODParentHandles;
    
    % Initialize the panel and table for Component List
    columnName1 =   {'Component', 'Name/Note', 'Ungroup','Delete'};
    columnWidth1 = {150, 100, 60, 60};
    columnEditable1 =  [false true true true];
    initialTable1 = {'OBJECT','Object',true,true,;...
        'SQS',  '',true,true,;...
        'IMAGE', 'Image',true,true};
    set(aodHandles.tblComponentList, ...
        'ColumnFormat',{'char', 'char','logical', 'logical'},...
        'Data', initialTable1,'ColumnEditable', columnEditable1,...
        'ColumnName', columnName1,'ColumnWidth',columnWidth1); 
    set(aodHandles.chkUpdateSurfaceEditorFromComponentEditor,'value',0);
    
    % Define initial component Array
    componentArray(1) = Component('SQS');
    componentArray(1).Parameters.SurfaceArray(1).ObjectSurface = 1;
    componentArray(2) = Component('SQS');
    componentArray(2).Parameters.SurfaceArray(1).Stop = 1;
    componentArray(3) = Component('SQS');
    componentArray(3).Parameters.SurfaceArray(1).ImageSurface = 1;
    
    aodHandles.ComponentArray = componentArray;
    parentWindow.AODParentHandles = aodHandles;
    % Reset Sequence of Surface panel
    parentWindow = resetSeqOfSurfEditorPanel(parentWindow);
    % Reset Prism parameter panel
    
end