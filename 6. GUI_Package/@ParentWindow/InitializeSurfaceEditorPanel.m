function InitializeSurfaceEditorPanel( parentWindow )
    %INITIALIZESURFACEEDITORPANEL Define and initialized the uicontrols of the
    % Surface Editor Panel
    % Member of ParentWindow class
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    
    fontSize = aodHandles.FontSize;
    fontName = aodHandles.FontName;
    
    %% Divide the area in to surface list panel, and surf detail
    % ( surf figure, surf description and surface parameters) panel
    aodHandles.panelSurfaceList = uipanel(...
        'Parent',aodHandles.panelSurfaceEditorMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Title','Surface List',...
        'units','normalized',...
        'Position',[0.0,0.0,0.5,1.0]);
    
    aodHandles.panelSurfaceDetail = uipanel(...
        'Parent',aodHandles.panelSurfaceEditorMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.5,0.0,0.5,1.0]);
    
    aodHandles.surfaceParametersTabGroup = uitabgroup(...
        'Parent', aodHandles.panelSurfaceDetail, ...
        'Units', 'Normalized', ...
        'Position', [0,0.0,1.0,1.0]);
    aodHandles.surfBasicDataTab = ...
        uitab(aodHandles.surfaceParametersTabGroup, 'title','Standard Data');
    aodHandles.surfaceApertureDataTab = ...
        uitab(aodHandles.surfaceParametersTabGroup, 'title','Aperture Data');
    aodHandles.surfaceTiltDecenterDataTab = ...
        uitab(aodHandles.surfaceParametersTabGroup, 'title','Tilt Decenter Data');
    aodHandles.surfaceGratingDataTab = ...
        uitab(aodHandles.surfaceParametersTabGroup, 'title','Grating Ruling Data');
    aodHandles.surfaceExtraDataTab = ...
        uitab(aodHandles.surfaceParametersTabGroup, 'title','Extra Data');
    
    
    % Initialize the ui table for surfacelist
    aodHandles.tblSurfaceList = uitable('Parent',aodHandles.panelSurfaceList,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 0.93]);
    
    % Command buttons for adding and removing surfaces
    aodHandles.btnInsertSurface = uicontrol( ...
        'Parent',aodHandles.panelSurfaceList,...
        'Style', 'pushbutton', ...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.01,0.95,0.15,0.04],...
        'String','Insert',...
        'Callback',{@btnInsertSurface_Callback,parentWindow});
    aodHandles.btnRemoveSurface = uicontrol( ...
        'Parent',aodHandles.panelSurfaceList,...
        'Style', 'pushbutton', ...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.16,0.95,0.15,0.04],...
        'String','Remove',...
        'Callback',{@btnRemoveSurface_Callback,parentWindow});
    
    updatedSystem = aodHandles.OpticalSystem;
    updatedSystem.SurfaceArray = updateSurfaceCoordinateTransformationMatrices(aodHandles.OpticalSystem.SurfaceArray);
    
    if IsSurfaceBased(updatedSystem)
        nSurface = getNumberOfSurfaces(updatedSystem);
        stopSurfaceIndex = getStopSurfaceIndex(updatedSystem);
    else
        nSurface = 3;
        stopSurfaceIndex = 2;
    end
    
    
    aodHandles.lblStopSurfaceIndex = uicontrol( ...
        'Parent',aodHandles.panelSurfaceList,...
        'Tag', 'lblStopSurfaceIndex', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Stop Surface ',...
        'units','normalized',...
        'Position',[0.32,0.94,0.36,0.04]);
    
    aodHandles.popStopSurfaceIndex = uicontrol( ...
        'Parent',aodHandles.panelSurfaceList,...
        'Tag', 'popStopSurfaceIndex', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', [num2cell(1:nSurface)],...
        'Value',stopSurfaceIndex,...
        'units','normalized',...
        'Position',[0.70,0.937,0.15,0.05]);
    
    % Set  celledit and cellselection callbacks
    set(aodHandles.tblSurfaceList,...
        'CellSelectionCallback',{@tblSurfaceList_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblSurfaceList_CellEditCallback,parentWindow});
    
    set(aodHandles.popStopSurfaceIndex,...
        'Callback',{@popStopSurfaceIndex_Callback,parentWindow});
    
    % Initialize the ui table and other UI controls for surface parameters
    aodHandles.tblSurfaceBasicParameters = uitable('Parent',aodHandles.surfBasicDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 1]);
    
    aodHandles.tblSurfaceApertureParameters = uitable('Parent',aodHandles.surfaceApertureDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 0.71]);
    % Aperture Type popup
    aodHandles.lblSurfaceApertureType = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'lblSurfaceApertureType', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Aperture Type ',...
        'units','normalized',...
        'Position',[0.0,0.9175,0.45,0.05]);
    [~,supportedSurfaceApertureTypes] = GetSupportedSurfaceApertureTypes();
    aodHandles.popSurfaceApertureType = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'popSurfaceApertureType', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedSurfaceApertureTypes,...
        'units','normalized',...
        'Position',[0.5,0.92,0.475,0.05]);
    % Surface aperture outer shape popup
    aodHandles.lblSurfaceApertureOuterShape = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'lblSurfaceApertureOuterShape', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Outer Shape ',...
        'units','normalized',...
        'Position',[0.0,0.8575,0.45,0.05]);
    [~,supportedSurfaceApertureOuterShapes] = GetSupportedSurfaceApertureOuterShapes();
    aodHandles.popSurfaceApertureOuterShape = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'popSurfaceApertureOuterShape', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedSurfaceApertureOuterShapes,...
        'units','normalized',...
        'Position',[0.5,0.86,0.475,0.05]);
    % Surface aperture additional edge
    aodHandles.lblSurfaceApertureAdditionalEdge  = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'lblSurfaceApertureAdditionalEdge', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Additional Edge ',...
        'units','normalized',...
        'Position',[0.0,0.80,0.45,0.05]);
    [~,supportedSurfaceApertureAdditionalEdgeType] = GetSurfaceApertureAdditionalEdgeType();
    aodHandles.popSurfaceApertureAdditionalEdgeType = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'popSurfaceApertureAdditionalEdgeType', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedSurfaceApertureAdditionalEdgeType,...
        'units','normalized','enable','off',...
        'Position',[0.5,0.81,0.225,0.04]);
    aodHandles.txtSurfaceApertureAdditionalEdge = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'txtSurfaceApertureAdditionalEdge', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'edit', ...
        'BackgroundColor', [1 1 1], ...
        'String', '0.0',...
        'units','normalized',...
        'Position',[0.725,0.816,0.255,0.035]);
    % Surface aperture draw absolute popup
    aodHandles.lblSurfaceApertureDrawAbsolute = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'lblSurfaceApertureDrawAbsolute', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Draw Absolute ',...
        'units','normalized',...
        'Position',[0.0,0.7275,0.45,0.05]);
    [supportedSurfaceApertureDrawAbsolute] = {'True','False'};
    aodHandles.popSurfaceApertureDrawAbsolute = uicontrol( ...
        'Parent',aodHandles.surfaceApertureDataTab,...
        'Tag', 'popSurfaceApertureDrawAbsolute', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedSurfaceApertureDrawAbsolute,...
        'units','normalized',...
        'Position',[0.5,0.73,0.475,0.05]);
    
    %     aodHandles.lblSurfaceApertureType = uicontrol( ...
    %         'Parent',aodHandles.surfaceApertureDataTab,...
    %         'Tag', 'lblSurfaceApertureType', ...
    %         'Style', 'text', ...
    %         'HorizontalAlignment','right',...
    %         'FontSize',fontSize,'FontName', 'FixedWidth',...
    %         'String', 'Aperture Type ',...
    %         'units','normalized',...
    %         'Position',[0.0,0.955,0.35,0.03]);
    %     [~,supportedSurfaceApertureTypesDisplay] = GetSupportedSurfaceApertureTypes();
    %     aodHandles.popSurfaceApertureType = uicontrol( ...
    %         'Parent',aodHandles.surfaceApertureDataTab,...
    %         'Tag', 'popSurfaceApertureType', ...
    %         'FontSize',fontSize,'FontName', 'FixedWidth',...
    %         'Style', 'popupmenu', ...
    %         'BackgroundColor', [1 1 1], ...
    %         'String', supportedSurfaceApertureTypesDisplay,...
    %         'units','normalized',...
    %         'Position',[0.4,0.95,0.5,0.04]);
    
    %     aodHandles.lblSurfaceApertureType = uicontrol( ...
    %         'Parent',aodHandles.surfaceApertureDataTab,...
    %         'Tag', 'lblSurfaceApertureType', ...
    %         'Style', 'text', ...
    %         'HorizontalAlignment','right',...
    %         'FontSize',fontSize,'FontName', 'FixedWidth',...
    %         'String', 'Aperture Type ',...
    %         'units','normalized',...
    %         'Position',[0.0,0.955,0.35,0.03]);
    %     [~,supportedOuterShapesDisplay] = GetSupportedSurfaceApertureOuterShapes();
    %     aodHandles.popSurfaceApertureType = uicontrol( ...
    %         'Parent',aodHandles.surfaceApertureDataTab,...
    %         'Tag', 'popSurfaceApertureType', ...
    %         'FontSize',fontSize,'FontName', 'FixedWidth',...
    %         'Style', 'popupmenu', ...
    %         'BackgroundColor', [1 1 1], ...
    %         'String', supportedSurfaceApertureTypesDisplay,...
    %         'units','normalized',...
    %         'Position',[0.4,0.95,0.5,0.04]);
    
    aodHandles.tblSurfaceTiltDecenterParameters = uitable('Parent',aodHandles.surfaceTiltDecenterDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 0.84]);
    % Tilt order popup
    aodHandles.lblSurfaceTiltDecenterOrder = uicontrol( ...
        'Parent',aodHandles.surfaceTiltDecenterDataTab,...
        'Tag', 'lblSurfaceTiltDecenterOrder', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Tilt Decenter Order ',...
        'units','normalized',...
        'Position',[0.0,0.9175,0.45,0.05]);
    [~,supportedTiltDecenterOrders] = GetSupportedTiltDecenterOrder();
    aodHandles.popSurfaceTiltDecenterOrder = uicontrol( ...
        'Parent',aodHandles.surfaceTiltDecenterDataTab,...
        'Tag', 'popSurfaceTiltDecenterOrder', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedTiltDecenterOrders,...
        'units','normalized',...
        'Position',[0.5,0.92,0.475,0.05]);
    % Tilt mode popup
    aodHandles.lblSurfaceTiltMode = uicontrol( ...
        'Parent',aodHandles.surfaceTiltDecenterDataTab,...
        'Tag', 'lblSurfaceTiltMode', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Tilt Mode ',...
        'units','normalized',...
        'Position',[0.0,0.8575,0.45,0.05]);
    [~,supportedTiltModes] = GetSupportedTiltModes();
    aodHandles.popSurfaceTiltMode = uicontrol( ...
        'Parent',aodHandles.surfaceTiltDecenterDataTab,...
        'Tag', 'popSurfaceTiltMode', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedTiltModes,...
        'units','normalized',...
        'Position',[0.5,0.86,0.475,0.05]);
    
    
    aodHandles.tblSurfaceGratingParameters = uitable('Parent',aodHandles.surfaceGratingDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 0.84]);
    aodHandles.lblGratingType = uicontrol( ...
        'Parent',aodHandles.surfaceGratingDataTab,...
        'Tag', 'lblGratingType', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Grating Type ',...
        'units','normalized',...
        'Position',[0.0,0.9175,0.45,0.05]);
    [~,supportedGratingTypes] = GetSupportedGratingTypes();
    aodHandles.popGratingType = uicontrol( ...
        'Parent',aodHandles.surfaceGratingDataTab,...
        'Tag', 'popGratingType', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', supportedGratingTypes,...
        'units','normalized',...
        'Position',[0.5,0.92,0.475,0.05]);
    
    aodHandles.lblGratingDiffractionOrder = uicontrol( ...
        'Parent',aodHandles.surfaceGratingDataTab,...
        'Tag', 'lblGratingDiffractionOrder', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Diffraction Order ',...
        'units','normalized',...
        'Position',[0.0,0.8575,0.45,0.05]);
    aodHandles.popGratingDiffractionOrderSign = uicontrol( ...
        'Parent',aodHandles.surfaceGratingDataTab,...
        'Tag', 'popGratingDiffractionOrderSign', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', {'+','-'},...
        'units','normalized',...
        'Position',[0.5,0.86,0.15,0.05]);
    maxNumberOfOrder = 10;
    aodHandles.popGratingDiffractionOrder = uicontrol( ...
        'Parent',aodHandles.surfaceGratingDataTab,...
        'Tag', 'popGratingDiffractionOrder', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', num2cell([0:maxNumberOfOrder]),...
        'units','normalized',...
        'Position',[0.65,0.86,0.325,0.05]);
    
    %     aodHandles.txtGratingDiffractionOrder = uicontrol( ...
    %         'Parent',aodHandles.surfaceGratingDataTab,...
    %         'Tag', 'txtGratingDiffractionOrder', ...
    %         'FontSize',fontSize,'FontName', 'FixedWidth',...
    %         'Style', 'edit', ...
    %         'BackgroundColor', [1 1 1], ...
    %         'String', '0',...
    %         'units','normalized',...
    %         'Position',[0.4,0.90,0.5,0.04]);
    
    
    
    aodHandles.tblSurfaceExtraParameters = uitable('Parent',aodHandles.surfaceExtraDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 0.90]);
    aodHandles.lblNumberOfExtraParameters = uicontrol( ...
        'Parent',aodHandles.surfaceExtraDataTab,...
        'Tag', 'lblNumberOfExtraParameters', ...
        'Style', 'text', ...
        'HorizontalAlignment','right',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Number Of Extra Parameters ',...
        'units','normalized',...
        'Position',[0.0,0.9175,0.65,0.05]);
    maxNumberOfExtraParameter = 100;
    aodHandles.popNumberOfExtraParameters = uicontrol( ...
        'Parent',aodHandles.surfaceExtraDataTab,...
        'Tag', 'txtNumberOfExtraParameters', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', num2cell([0:maxNumberOfExtraParameter]),...
        'units','normalized',...
        'Position',[0.7,0.92,0.275,0.05]);
    
    
    %     Set  celledit and cellselection callbacks
    set(aodHandles.tblSurfaceBasicParameters,...
        'CellSelectionCallback',{@tblSurfaceBasicParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblSurfaceBasicParameters_CellEditCallback,parentWindow});
    set(aodHandles.tblSurfaceApertureParameters,...
        'CellSelectionCallback',{@tblSurfaceApertureParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblSurfaceApertureParameters_CellEditCallback,parentWindow});
    set(aodHandles.popSurfaceApertureType,...
        'Callback',{@popSurfaceApertureType_Callback,parentWindow});
    set(aodHandles.popSurfaceApertureOuterShape,...
        'Callback',{@popSurfaceApertureOuterShape_Callback,parentWindow});
    set(aodHandles.txtSurfaceApertureAdditionalEdge,...
        'Callback',{@txtSurfaceApertureAdditionalEdge_Callback,parentWindow});
    set(aodHandles.popSurfaceApertureAdditionalEdgeType,...
        'Callback',{@popSurfaceApertureAdditionalEdgeType_Callback,parentWindow});
    set(aodHandles.popSurfaceApertureDrawAbsolute,...
        'Callback',{@popSurfaceApertureDrawAbsolute_Callback,parentWindow});
    
    
    
    set(aodHandles.tblSurfaceTiltDecenterParameters,...
        'CellSelectionCallback',{@tblSurfaceTiltDecenterParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblSurfaceTiltDecenterParameters_CellEditCallback,parentWindow});
    set(aodHandles.popSurfaceTiltDecenterOrder,...
        'Callback',{@popSurfaceTiltDecenterOrder_Callback,parentWindow});
    set(aodHandles.popSurfaceTiltMode,...
        'Callback',{@popSurfaceTiltMode_Callback,parentWindow});
    
    set(aodHandles.tblSurfaceGratingParameters,...
        'CellSelectionCallback',{@tblSurfaceGratingParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblSurfaceGratingParameters_CellEditCallback,parentWindow});
    set(aodHandles.popGratingType,...
        'Callback',{@popGratingType_Callback,parentWindow});
    set(aodHandles.popGratingDiffractionOrderSign,...
        'Callback',{@popGratingDiffractionOrderSign_Callback,parentWindow});
    set(aodHandles.popGratingDiffractionOrder,...
        'Callback',{@popGratingDiffractionOrder_Callback,parentWindow});
    
    set(aodHandles.tblSurfaceExtraParameters,...
        'CellSelectionCallback',{@tblSurfaceExtraParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblSurfaceExtraParameters_CellEditCallback,parentWindow});
    set(aodHandles.popNumberOfExtraParameters,...
        'Callback',{@popNumberOfExtraParameters_Callback,parentWindow});
    
    supportedSurfaces = GetSupportedSurfaceTypes();
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
    set(aodHandles.tblSurfaceGratingParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);
    
    columnName3 =   {'Parameters'};
    columnWidth3 = {150};
    columnEditable3 =  [true];
    columnFormat3 =  {'numeric'};
    initialTable3 = {[0]};
    set(aodHandles.tblSurfaceExtraParameters, ...
        'ColumnFormat',columnFormat3,...
        'Data', initialTable3,'ColumnEditable', columnEditable3,...
        'ColumnName', columnName3,'ColumnWidth',columnWidth3);
    
    % Give all tables initial data
    parentWindow.ParentHandles = aodHandles;
    updateSystemConfigurationWindow( parentWindow );
    updateQuickLayoutPanel(parentWindow,1);
end

% Local functions
function btnInsertSurface_Callback(~,~,parentWindow)
    if ~checkTheCurrentSystemDefinitionType(parentWindow.ParentHandles)
        return
    end
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    
    selectedElementIndex = aodHandles.SelectedElementIndex;
    canAddElement = aodHandles.CanAddElement;
    
    if canAddElement
        insertPosition = selectedElementIndex;
        InsertNewSurface(parentWindow,'Standard','Standard',insertPosition);
        aodHandles = parentWindow.ParentHandles;
    end
end
function btnRemoveSurface_Callback(~,~,parentWindow)
    if ~checkTheCurrentSystemDefinitionType(parentWindow.ParentHandles)
        return
    end
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    
    selectedElementIndex = aodHandles.SelectedElementIndex;
    canRemoveElement = aodHandles.CanRemoveElement;
    
    if canRemoveElement
        % Confirm action
        % Construct a questdlg with three options
        choice = questdlg('Are you sure to delete the surface?', ...
            'Confirm Deletion', ...
            'Yes','No','Yes');
        % Handle response
        switch choice
            case 'Yes'
                % Delete the surface
                removePosition = selectedElementIndex;
                RemoveSurface(parentWindow,removePosition);
                aodHandles = parentWindow.ParentHandles;
            case 'No'
                % Mark the delete box again
        end
    else
        % Mark the delete box again
    end
    parentWindow.ParentHandles = aodHandles;
end
function popStopSurfaceIndex_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    
    currentOpticalSystem = aodHandles.OpticalSystem;
    prevStopIndex = getStopSurfaceIndex(currentOpticalSystem );
    newStopIndex = get(hObject,'Value');
    if newStopIndex == 1 || newStopIndex == getNumberOfSurfaces(currentOpticalSystem) % Object and image can not be Stop
        newStopIndex = prevStopIndex;
    end
    if newStopIndex ~= prevStopIndex
        aodHandles.OpticalSystem.SurfaceArray(prevStopIndex).IsStop = 0;
        aodHandles.OpticalSystem.SurfaceArray(newStopIndex).IsStop = 1;
    end
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , newStopIndex);
    updateQuickLayoutPanel(parentWindow,newStopIndex);
end

% Cell select and % CellEdit Callback
function tblSurfaceList_CellSelectionCallback(~, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    selectedCell = eventdata.Indices;
    if isempty(selectedCell)
        return
    end
    selectedElementIndex = selectedCell(1);
    aodHandles.SelectedElementIndex = selectedElementIndex;
    
    tblData = get(aodHandles.tblSurfaceList,'data');
    sizeTblData = size(tblData);
    
    if selectedElementIndex == 1 % object surf
        aodHandles.CanRemoveElement = 0;
        aodHandles.CanAddElement = 0;
        % make the 2nd column uneditable
        columnEditable1 = [false,false,true];
        set(aodHandles.tblSurfaceList,'ColumnEditable', columnEditable1);
    elseif selectedElementIndex == sizeTblData(1)% image surf
        aodHandles.CanRemoveElement = 0;
        aodHandles.CanAddElement = 1;
        % make the 2nd column uneditable
        columnEditable1 = [false,false,true];
        set(aodHandles.tblSurfaceList,'ColumnEditable', columnEditable1);
    elseif sizeTblData(1) == 3 % only 3 surfaces left
        aodHandles.CanRemoveElement = 0;
        aodHandles.CanAddElement = 1;
        % make the 2nd column editable
        columnEditable1 = [false,true,true];
        set(aodHandles.tblSurfaceList,'ColumnEditable', columnEditable1);
    else
        aodHandles.CanRemoveElement = 1;
        aodHandles.CanAddElement = 1;
        % make the 2nd column editable
        columnEditable1 = [false,true,true];
        set(aodHandles.tblSurfaceList,'ColumnEditable', columnEditable1);
    end
    
    % Show the surface parameters in the surface detail window
    parentWindow.ParentHandles = aodHandles;
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex);
end
function tblSurfaceList_CellEditCallback(hObject, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    editedCellIndex = eventdata.Indices;
    if ~isempty(editedCellIndex)
        editedRow = editedCellIndex(1,1);
        editedCol = editedCellIndex(1,2);
    else
        return;
    end
    
    selectedElementIndex = editedRow;
    aodHandles.SelectedElementIndex = selectedElementIndex;
    
    if editedCol== 2 % surface type changed
        if strcmpi(eventdata.PreviousData,'OBJECT')||strcmpi(eventdata.PreviousData,'IMAGE')
            % for object or image surf surf change the surf type back to OBJECT or
            % IMAGE
            tblData1 = get(aodHandles.tblSurfaceList,'data');
            sizeTblData1 = size(tblData1);
            nSurface = sizeTblData1(1);
            tblData1{1,2} = 'OBJECT';
            tblData1{nSurface,2} = 'IMAGE';
            set(aodHandles.tblSurfaceList, 'Data', tblData1);
        else
            if ~checkTheCurrentSystemDefinitionType(aodHandles)
                return
            end
            % reset the surface type in the surface detail window
            selectedSurfaceTypeString = eventdata.NewData;
            %newSurface = Surface(selectedSurfaceType);
            oldSurface = aodHandles.OpticalSystem.SurfaceArray(editedRow);
            % Add the new surf onet to the temporary surfaceArray
            if oldSurface.IsStop
                if strcmpi(selectedSurfaceTypeString,'Dummy')
                    % Stop surface can not be dummy
                    disp('Error: Stop surface can not be dummy. So please change the stop surface first.');
                    tblData1 = get(aodHandles.tblSurfaceList,'data');
                    tblData1{editedRow,2} = eventdata.PreviousData;
                    set(aodHandles.tblSurfaceList, 'Data', tblData1);
                    return;
                else
                    newSurface = Surface(selectedSurfaceTypeString);
                end
                newSurface.IsStop = 1;
            else
                newSurface = Surface(selectedSurfaceTypeString);
            end
            % 
            modifiedSurface = oldSurface;
            modifiedSurface.Type = newSurface.Type;
            modifiedSurface.UniqueParameters = newSurface.UniqueParameters;
            % Keep common properties of the surface
            
            aodHandles.OpticalSystem.SurfaceArray(editedRow) = modifiedSurface;
        end
        
    elseif editedCol== 3 % surface comment changed
        aodHandles.OpticalSystem.SurfaceArray(editedRow).Comment = eventdata.NewData;
    end
    parentWindow.ParentHandles = aodHandles;
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex);
end

function tblSurfaceBasicParameters_CellSelectionCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    selectedCellIndex = eventdata.Indices;
    if ~isempty(selectedCellIndex)
        selectedRow = selectedCellIndex(1,1);
        selectedCol = selectedCellIndex(1,2);
    else
        return;
    end
    
    if selectedCol ~= 2
        return;
    end
    
    [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'Basic',selectedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  iscell(myType) && length(myType)>1
        % type is choice of popmenu
        aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = choice;
        newParamDisp = myType{choice};
        % Update the surface parameter and surface editor
        if selectedRow <=3
            selectedSurface.(myName) = newParam;
        else
            selectedSurface.UniqueParameters.(myName) = newParam;
        end
    else
        if strcmpi('logical',myType)
            % type is choice of popmenu true or false
            aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
            trueFalse = {'1','0'};
            choice = menu(myName,'False','True');
            if choice == 0
                choice = 1;
            end
            newParam = trueFalse{choice};
            newParamDisp = newParam;
            
            % Update the surface parameter and surface editor
            if selectedRow <=3
                selectedSurface.(myName) = newParam;
            else
                selectedSurface.UniqueParameters.(myName) = newParam;
            end
        elseif strcmpi('numeric',myType) || strcmpi('char',myType)||...
                strcmpi('Glass',myType) || strcmpi('Coating',myType)
            
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function tblSurfaceApertureParameters_CellSelectionCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    selectedCellIndex = eventdata.Indices;
    if ~isempty(selectedCellIndex)
        selectedRow = selectedCellIndex(1,1);
        selectedCol = selectedCellIndex(1,2);
    else
        return;
    end
    if selectedCol ~= 2
        return;
    end
    [ paramNames,paramDispNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'Aperture',selectedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  iscell(myType)&& length(myType)>1
        % type is choice of popmenu
        aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = choice;
        newParamDisp = myType{choice};
        % Update the surface parameter and surface editor
        if selectedRow == 1
            % A new type with defualt parameter
            selectedSurface.Aperture = Aperture(newParam);
        elseif selectedRow <=7
            selectedSurface.Aperture.(myName) = newParam;
        else
            selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
        end
    else
        if strcmpi('logical',myType)
            % type is choice of popmenu true or false
            aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
            trueFalse = {'0','1'};
            choice = menu(myName,'False','True');
            if choice == 0
                choice = 1;
            end
            newParam = trueFalse{choice};
            
            newParamDisp = newParam;
            
            % Update the surface parameter and surface editor
            if selectedRow == 1
                % A new type with defualt parameter
                selectedSurface.Aperture = Aperture(newParam);
            elseif selectedRow <=7
                selectedSurface.Aperture.(myName) = newParam;
            else
                selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
            end
        elseif strcmpi('numeric',myType) || strcmpi('char',myType)
            
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popSurfaceApertureType_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    oldAperture = selectedSurface.Aperture;
    selectedSurfaceApertureType = GetSupportedSurfaceApertureTypes(get(hObject,'value'));
    newAperture = Aperture(selectedSurfaceApertureType);
    % If possible try to map the old aperture values to the new aperture.
    switch (oldAperture.Type)
        case 1 %lower('FloatingCircularAperture')
            switch (newAperture.Type)
                case 1 %lower('FloatingCircularAperture')
                    newAperture.UniqueParameters.Diameter = oldAperture.UniqueParameters.Diameter;
                case 2 %lower('CircularAperture')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.Diameter;
                    newAperture.UniqueParameters.SmallDiameter = 0;
                case 3 %lower('RectangularAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.Diameter;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.Diameter;
                case 4 %lower('EllipticalAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.Diameter;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.Diameter;
                case 5 %lower('CircularObstruction')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.Diameter;
                    newAperture.UniqueParameters.SmallDiameter = 0;
                otherwise
            end
        case 2 %lower('CircularAperture')
            switch lower(newAperture.Type)
                case 1 %lower('FloatingCircularAperture')
                    newAperture.UniqueParameters.Diameter = oldAperture.UniqueParameters.LargeDiameter;
                case 2 %lower('CircularAperture')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.SmallDiameter = oldAperture.UniqueParameters.SmallDiameter;
                case 3 %lower('RectangularAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.LargeDiameter;
                case 4 %lower('EllipticalAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.LargeDiameter;
                case 5 %lower('CircularObstruction')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.SmallDiameter = oldAperture.UniqueParameters.SmallDiameter;
                otherwise
            end
        case 3 %lower('RectangularAperture')
            switch (newAperture.Type)
                case 1 %lower('FloatingCircularAperture')
                    newAperture.UniqueParameters.Diameter = oldAperture.UniqueParameters.DiameterX;
                case 2 %lower('CircularAperture')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.SmallDiameter = 0;
                case 3 %lower('RectangularAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.DiameterY;
                case 4 %lower('EllipticalAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.DiameterY;
                case 5 %lower('CircularObstruction')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.SmallDiameter = 0;
                otherwise
            end
        case 4 %lower('EllipticalAperture')
            switch (newAperture.Type)
                case 1 %lower('FloatingCircularAperture')
                    newAperture.UniqueParameters.Diameter = oldAperture.UniqueParameters.DiameterX;
                case 2 %lower('CircularAperture')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.SmallDiameter = 0;
                case 3 %lower('RectangularAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.DiameterY;
                case 4 %lower('EllipticalAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.DiameterY;
                case 5 %lower('CircularObstruction')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.DiameterX;
                    newAperture.UniqueParameters.SmallDiameter = 0;
                otherwise
            end
        case 5 %lower('CircularObstruction')
            switch (newAperture.Type)
                case 1 %lower('FloatingCircularAperture')
                    newAperture.UniqueParameters.Diameter = oldAperture.UniqueParameters.LargeDiameter;
                case 2 %lower('CircularAperture')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.SmallDiameter = oldAperture.UniqueParameters.SmallDiameter;
                case 3 %lower('RectangularAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.LargeDiameter;
                case 4 %lower('EllipticalAperture')
                    newAperture.UniqueParameters.DiameterX = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.DiameterY = oldAperture.UniqueParameters.LargeDiameter;
                case 5 %lower('CircularObstruction')
                    newAperture.UniqueParameters.LargeDiameter = oldAperture.UniqueParameters.LargeDiameter;
                    newAperture.UniqueParameters.SmallDiameter = oldAperture.UniqueParameters.SmallDiameter;
                otherwise
            end
        otherwise
            % Do nothing for others. That is just initialize the defualt
    end
    % Keep other common parameters as well
    newAperture.Decenter = oldAperture.Decenter;
    newAperture.Rotation = oldAperture.Rotation;
    newAperture.DrawAbsolute = oldAperture.DrawAbsolute;
    newAperture.AdditionalEdge = oldAperture.AdditionalEdge;
    newAperture.OuterShape = oldAperture.OuterShape;
    
    
    selectedSurface.Aperture = newAperture;
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end


function popSurfaceApertureOuterShape_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    selectedSurface.Aperture.OuterShape = get(hObject,'value');
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function txtSurfaceApertureAdditionalEdge_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    enteredValue = str2num(get(hObject,'String'));
    if isempty((enteredValue))
        enteredValue = 0;
    end
    selectedSurface.Aperture.AdditionalEdge =  enteredValue;
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popSurfaceApertureAdditionalEdgeType_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    selectedSurface.Aperture.AdditionalEdgeType =  get(hObject,'value');
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end

function popSurfaceApertureDrawAbsolute_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    if (get(hObject,'value')==1)
        selectedSurface.Aperture.DrawAbsolute = 1;
    else
        selectedSurface.Aperture.DrawAbsolute = 0;
    end
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end


function tblSurfaceTiltDecenterParameters_CellSelectionCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceTiltDecenterParameters (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    selectedCellIndex = eventdata.Indices;
    if ~isempty(selectedCellIndex)
        selectedRow = selectedCellIndex(1,1);
        selectedCol = selectedCellIndex(1,2);
    else
        return;
    end
    if selectedCol ~= 2
        return;
    end
    [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'TiltDecenter',selectedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  iscell(myType)&& length(myType)>1
        % type is choice of popmenu
        aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = choice;
        newParamDisp = myType{choice};
        % Update the surface parameter and surface editor
        selectedSurface.(myName) = newParam;
    else
        if strcmpi('logical',myType)
            % type is choice of popmenu true or false
            aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
            trueFalse = {'0','1'};
            choice = menu(myName,'False','True');
            if choice == 0
                choice = 1;
            end
            newParam = trueFalse{choice};
            
            newParamDisp = newParam;
            
            % Update the surface parameter and surface editor
            selectedSurface.(myName) = newParam;
        elseif strcmpi('numeric',myType) || strcmpi('char',myType)
            
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popSurfaceTiltDecenterOrder_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    selectedSurface.TiltDecenterOrder = get(hObject,'value');
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popSurfaceTiltMode_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    selectedSurface.TiltMode = get(hObject,'value');
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end

function tblSurfaceGratingParameters_CellSelectionCallback(~, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    selectedCellIndex = eventdata.Indices;
    if ~isempty(selectedCellIndex)
        selectedRow = selectedCellIndex(1,1);
        selectedCol = selectedCellIndex(1,2);
    else
        return;
    end
    if selectedCol ~= 2
        return;
    end
    
    [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'Grating',selectedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  iscell(myType)&& length(myType)>1
        % type is choice of popmenu
        aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = choice;
        newParamDisp = myType{choice};
        % Update the surface parameter and surface editor
        selectedSurface.Grating.(myName) = newParam;
    else
        if strcmpi('logical',myType)
            % type is choice of popmenu true or false
            aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
            trueFalse = {'0','1'};
            choice = menu(myName,'False','True');
            if choice == 0
                choice = 1;
            end
            newParam = trueFalse{choice};
            
            newParamDisp = newParam;
            
            % Update the surface parameter and surface editor
            selectedSurface.Grating.(myName) = newParam;
        elseif strcmpi('numeric',myType) || strcmpi('char',myType)
            
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    
    
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popGratingType_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    oldGrating = selectedSurface.Grating;
    selectedGratingType = GetSupportedGratingTypes(get(hObject,'value'));
    newGrating = Grating(selectedGratingType);
    newGrating.DiffractionOrder = oldGrating.DiffractionOrder;
    
    % If possible try to map the old aperture values to the new aperture.
    switch (oldGrating.Type)
        case 1 %lower('ConcentricCylinderGrating')
            switch (newGrating.Type)
                case 1 %lower('ConcentricCylinderGrating')
                    newGrating.UniqueParameters.LinesPerMicrometer = oldGrating.UniqueParameters.LinesPerMicrometer;
                    newGrating.UniqueParameters.LinearCoefficient = oldGrating.UniqueParameters.LinearCoefficient;
                case 2 %lower('ParallelPlaneGrating')
                    newGrating.UniqueParameters.LinesPerMicrometer = oldGrating.UniqueParameters.LinesPerMicrometer;
                    newGrating.UniqueParameters.LinearCoefficient = oldGrating.UniqueParameters.LinearCoefficient;
            end
        case 2 %lower('ParallelPlaneGrating')
            switch (newGrating.Type)
                case 1 %lower('ConcentricCylinderGrating')
                    newGrating.UniqueParameters.LinesPerMicrometer = oldGrating.UniqueParameters.LinesPerMicrometer;
                    newGrating.UniqueParameters.LinearCoefficient = oldGrating.UniqueParameters.LinearCoefficient;
                case 2 %lower('ParallelPlaneGrating')
                    newGrating.UniqueParameters.LinesPerMicrometer = oldGrating.UniqueParameters.LinesPerMicrometer;
                    newGrating.UniqueParameters.LinearCoefficient = oldGrating.UniqueParameters.LinearCoefficient;
            end
    end
    % Keep other common parameteres  too
    newGrating.DiffractionOrder = oldGrating.DiffractionOrder;
    
    selectedSurface.Grating = newGrating;
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popGratingDiffractionOrderSign_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    diffOrder = get(aodHandles.popGratingDiffractionOrder,'value')-1;
    diffOrderSignIndex = get(aodHandles.popGratingDiffractionOrderSign,'value');
    if diffOrderSignIndex == 1 % +ve
        selectedSurface.Grating.DiffractionOrder = diffOrder;
    else
        selectedSurface.Grating.DiffractionOrder = -diffOrder;
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function popGratingDiffractionOrder_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    diffOrder = get(aodHandles.popGratingDiffractionOrder,'value')-1;
    diffOrderSignIndex = get(aodHandles.popGratingDiffractionOrderSign,'value');
    if diffOrderSignIndex == 1 % +ve
        selectedSurface.Grating.DiffractionOrder = diffOrder;
    else
        selectedSurface.Grating.DiffractionOrder = -diffOrder;
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function tblSurfaceExtraParameters_CellSelectionCallback(~, eventdata,parentWindow)
end
function popNumberOfExtraParameters_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    extraData = cell2mat(get(aodHandles.tblSurfaceExtraParameters,'Data'));
    nTermsOld = length(extraData);
    nTermsNew = get(hObject,'value')-1;
    if nTermsNew < nTermsOld
        extraDataNew = extraData(1:nTermsNew);
    elseif nTermsNew > nTermsOld
        extraDataNew = [extraData;zeros(nTermsNew-nTermsOld,1)];
    else
        extraDataNew = extraData;
    end
    
    selectedSurface.ExtraData = extraDataNew;
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end

function tblSurfaceBasicParameters_CellEditCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    if selectedElementIndex > 1
        previousSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex-1);
    else
        previousSurface =  selectedSurface;
    end
    selectedCellIndex = eventdata.Indices;
    if isempty(selectedCellIndex)
        return;
    else
        editedRow = selectedCellIndex(1,1);
        editedCol = selectedCellIndex(1,2);
        
    end
    if editedCol == 2 % surface  value edited
        switch editedRow
            case 1
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Thickness = newParam;
            case 2
                glassName = (eventdata.EditData);
                newParam = Glass(glassName);
                selectedSurface.Glass = newParam;
            case 3
                coatingName = (eventdata.EditData);
                newParam = Coating(coatingName);
                selectedSurface.Coating = newParam;
            otherwise
                [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
                    getSurfaceParameters(selectedSurface,'Basic',editedRow);
                
                myType = paramTypes{1};
                myName = paramNames{1};
                
                if  (iscell(myType) && length(myType)>1)||(strcmpi('logical',myType))
                    % type is choice of popmenu and so already saved with popup menu
                    % type is choice of popmenu
                    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
                    nChoice = length(myType);
                    choice = menu(myName,myType(1:nChoice));
                    if choice == 0
                        choice = 1;
                    end
                    newParam = choice;
                    newParamDisp = myType{choice};
                    % Update the surface parameter and surface editor
                    if editedRow <=3
                        selectedSurface.(myName) = newParam;
                    else
                        selectedSurface.UniqueParameters.(myName) = newParam;
                    end
                    
                else
                    if strcmpi('numeric',myType)
                        newParam = str2num(eventdata.EditData);
                        if isempty(newParam)
                            newParam = 0;
                        end
                        % Update the surface parameter and surface editor
                        selectedSurface.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('char',myType)
                        newParam = (eventdata.EditData);
                        % Update the surface parameter and surface editor
                        selectedSurface.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('Glass',myType)
                        glassName = (eventdata.EditData);
                        newParam = Glass(glassName);
                        % Update the surface parameter and surface editor
                        selectedSurface.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('Coating',myType)
                        coatingName = (eventdata.EditData);
                        newParam = Glass(coatingName);
                        % Update the surface parameter and surface editor
                        selectedSurface.UniqueParameters.(myName) = newParam;
                    else
                        disp(['Error: Unknown parameter type: ',myType]);
                        return;
                    end
                end
                
        end
    else
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
    updateSurfaceOrComponentEditorPanel( parentWindow,selectedElementIndex );
end
function tblSurfaceApertureParameters_CellEditCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    selectedCellIndex = eventdata.Indices;
    if isempty(selectedCellIndex) || isempty(eventdata.NewData)
        return;
    else
        editedRow = selectedCellIndex(1,1);
        editedCol = selectedCellIndex(1,2);
        
    end
    [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'Aperture',editedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    
    if editedCol == 2 % surface  value edited
        switch editedRow
            case 1
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Aperture.Decenter(1) = newParam;
            case 2
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Aperture.Decenter(2) = newParam;
            case 3
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Aperture.Rotation= newParam;
            otherwise
                [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
                    getSurfaceParameters(selectedSurface,'Aperture',editedRow);
                
                myType = paramTypes{1};
                myName = paramNames{1};
                
                if  (iscell(myType) && length(myType)>1)||(strcmpi('logical',myType))
                    % type is choice of popmenu and so already saved with popup menu
                    % type is choice of popmenu
                    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
                    nChoice = length(myType);
                    choice = menu(myName,myType(1:nChoice));
                    if choice == 0
                        choice = 1;
                    end
                    newParam = choice;
                    newParamDisp = myType{choice};
                    % Update the surface parameter and surface editor
                    selectedSurface.Aperture = Aperture(newParam);
                    selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
                    
                else
                    if strcmpi('numeric',myType)
                        newParam = str2num(eventdata.EditData);
                        if isempty(newParam)
                            newParam = 0;
                        end
                        % Update the surface parameter and surface editor
                        selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('char',myType)
                        newParam = (eventdata.EditData);
                        % Update the surface parameter and surface editor
                        selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('Glass',myType)
                        glassName = (eventdata.EditData);
                        newParam = Glass(glassName);
                        % Update the surface parameter and surface editor
                        selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('Coating',myType)
                        coatingName = (eventdata.EditData);
                        newParam = Glass(coatingName);
                        % Update the surface parameter and surface editor
                        selectedSurface.Aperture.UniqueParameters.(myName) = newParam;
                    else
                        disp(['Error: Unknown parameter type: ',myType]);
                        return;
                    end
                end
        end
    else
        
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex);
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function tblSurfaceTiltDecenterParameters_CellEditCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblSurfaceTiltDecenterParameters (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    
    selectedCellIndex = eventdata.Indices;
    if isempty(selectedCellIndex) || isempty(eventdata.NewData)
        return;
    else
        editedRow = selectedCellIndex(1,1);
        editedCol = selectedCellIndex(1,2);
        
    end
    if editedCol == 2 % surface  value edited
        switch editedRow
            case 1
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Tilt(1) = newParam;
            case 2
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Tilt(2) = newParam;
            case 3
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Tilt(3) = newParam;
            case 4
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Decenter(1) = newParam;
            case 5
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedSurface.Decenter(2) = newParam;
            case 6
                % already saved by pop up menu
            otherwise
        end
    else
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function tblSurfaceGratingParameters_CellEditCallback(~, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    
    editedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    editedCellIndex = eventdata.Indices;
    if ~isempty(editedCellIndex)
        editedRow = editedCellIndex(1,1);
        editedCol = editedCellIndex(1,2);
    else
        return;
    end
    if editedCol ~= 2
        return;
    end
    
    [ paramNames,paramDisplayNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(editedSurface,'Grating',editedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  (iscell(myType) && length(myType)>1)||(strcmpi('logical',myType))
        % type is choice of popmenu and so already saved with popup menu
        % type is choice of popmenu
        aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = choice;
        newParamDisp = myType{choice};
        % Update the surface parameter and surface editor
        selectedSurface.Grating = Aperture(newParam);
        selectedSurface.Grating.UniqueParameters.(myName) = newParam;
        
    else
        if strcmpi('numeric',myType)
            newParam = str2num(eventdata.EditData);
            if isempty(newParam)
                newParam = 0;
            end
            % Update the surface parameter and surface editor
            editedSurface.Grating.UniqueParameters.(myName) = newParam;
        elseif strcmpi('char',myType)
            newParam = (eventdata.EditData);
            % Update the surface parameter and surface editor
            editedSurface.Grating.UniqueParameters.(myName) = newParam;
        elseif strcmpi('Glass',myType)
            glassName = (eventdata.EditData);
            newParam = Glass(glassName);
            % Update the surface parameter and surface editor
            editedSurface.Grating.UniqueParameters.(myName) = newParam;
        elseif strcmpi('Coating',myType)
            coatingName = (eventdata.EditData);
            newParam = Glass(coatingName);
            % Update the surface parameter and surface editor
            editedSurface.Grating.UniqueParameters.(myName) = newParam;
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = editedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end
function tblSurfaceExtraParameters_CellEditCallback(~, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    selectedElementIndex = aodHandles.SelectedElementIndex;
    selectedSurface =  aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex);
    extraDataNew = cell2mat(get(aodHandles.tblSurfaceExtraParameters,'Data'));
    selectedSurface.ExtraData = extraDataNew;
    aodHandles.OpticalSystem.SurfaceArray(selectedElementIndex) = selectedSurface;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , selectedElementIndex)
    updateQuickLayoutPanel(parentWindow,selectedElementIndex);
end

function InsertNewSurface(parentWindow,surfaceTypeDisp,surfaceType,insertPosition)
    %update surface list table
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    nSurface = getNumberOfSurfaces(aodHandles.OpticalSystem);
    % Update the surface array
    for kk = nSurface:-1:insertPosition
        aodHandles.OpticalSystem.SurfaceArray(kk+1) = aodHandles.OpticalSystem.SurfaceArray(kk);
    end
    aodHandles.OpticalSystem.SurfaceArray(insertPosition) = Surface(surfaceType);
    
    set(aodHandles.popStopSurfaceIndex,'String',[num2cell(1:nSurface+1)],...
        'Value',getStopSurfaceIndex(aodHandles.OpticalSystem));
    % If possible add here a code to select the first cell of newly added row
    % automatically
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow,insertPosition );
    updateQuickLayoutPanel(parentWindow,insertPosition);
end
function RemoveSurface(parentWindow,removePosition)
    % check if it is stop surface
    if getStopSurfaceIndex(parentWindow.ParentHandles.OpticalSystem) == removePosition
        stopSurfaceRemoved = 1;
    else
        stopSurfaceRemoved = 0;
    end
    aodHandles = parentWindow.ParentHandles;
    aodHandles.OpticalSystem.IsUpdatedSurfaceArray = 0;
    % Update the surface array
    aodHandles.OpticalSystem.SurfaceArray = aodHandles.OpticalSystem.SurfaceArray([1:removePosition-1,removePosition+1:end]);
    if stopSurfaceRemoved
        if aodHandles.OpticalSystem.SurfaceArray(removePosition).IsImage
            aodHandles.OpticalSystem.SurfaceArray(removePosition-1).IsStop = 1;
        else
            aodHandles.OpticalSystem.SurfaceArray(removePosition).IsStop = 1;
        end
    end
    % The next selected row will be the one in the removed position, so if
    % it is image plane then dont let further removal
    if aodHandles.OpticalSystem.SurfaceArray(removePosition).IsImage
        canRemoveElement = 0;
        aodHandles.CanRemoveElement = canRemoveElement;
    end
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow,removePosition );
    updateQuickLayoutPanel(parentWindow,removePosition);
end

function ret = checkTheCurrentSystemDefinitionType(aodHandles)
    
    if get(aodHandles.popSystemDefinitionType,'Value') == 1
        ret = 1;
    else
        choice = questdlg(['Your system is not defined using Surface',...
            ' Based method. Editing in the surface editor',...
            ' window automatically converts your system to Surface',...
            ' Based definition. Do you want to continue editing?'], ...
            'Change System Definition Type', ...
            'Yes','No','No');
        % Handle response
        switch choice
            case 'Yes'
                set(aodHandles.popSystemDefinitionType,'Value', 2);
                ret = 1;
            case 'No'
                ret = 0;
                return;
        end
    end
end

