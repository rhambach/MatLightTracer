function InitializeComponentEditorPanel( parentWindow )
    %INITIALIZECOMPONENETEDITORPANEL Define and initialized the uicontrols of the
    % Component Editor Panel
    % Member of ParentWindow class
    aodHandles = parentWindow.ParentHandles;
    fontSize = aodHandles.FontSize;
    fontName = aodHandles.FontName;
    
    %% Divide the area in to component list panel, and comp detail
    % ( comp figure, comp description and component parameters) panel
    aodHandles.panelComponentList = uipanel(...
        'Parent',aodHandles.panelComponentEditorMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'Title','Component List',...
        'units','normalized',...
        'Position',[0.0,0.05,0.5,0.95]);
    
    aodHandles.panelComponentDetail = uipanel(...
        'Parent',aodHandles.panelComponentEditorMain,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.5,0.05,0.5,0.95]);
    
    aodHandles.componentParametersTabGroup = uitabgroup(...
        'Parent', aodHandles.panelComponentDetail, ...
        'Units', 'Normalized', ...
        'Position', [0,0.0,1.0,1.0]);
    aodHandles.compBasicDataTab = ...
        uitab(aodHandles.componentParametersTabGroup, 'title','Standard Data');
    aodHandles.compTiltDecenterDataTab = ...
        uitab(aodHandles.componentParametersTabGroup, 'title','Tilt Decenter Data');
    
    
    % Initialize the ui table for componentlist
    aodHandles.tblComponentList = uitable('Parent',aodHandles.panelComponentList,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 0.93]);
    
    % Command buttons for adding and removing components
    aodHandles.btnInsertComponent = uicontrol( ...
        'Parent',aodHandles.panelComponentList,...
        'Style', 'pushbutton', ...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.01,0.94,0.2,0.05],...
        'String','Insert',...
        'Callback',{@btnInsertComponent_Callback,parentWindow});
    aodHandles.btnRemoveComponent = uicontrol( ...
        'Parent',aodHandles.panelComponentList,...
        'Style', 'pushbutton', ...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.21,0.94,0.2,0.05],...
        'String','Remove',...
        'Callback',{@btnRemoveComponent_Callback,parentWindow});
    
    
    % Select the stop component if it is component based
    updatedSystem = aodHandles.OpticalSystem;
    updatedSystem.SurfaceArray = updateSurfaceCoordinateTransformationMatrices(updatedSystem.SurfaceArray);
    if IsComponentBased(updatedSystem)
        nComponent = getNumberOfComponents(updatedSystem);
        stopComponentIndex = getStopComponentIndex(updatedSystem);
        
        stopComponent = updatedSystem.ComponentArray(stopComponentIndex);
        stopSurfaceInComponentIndex = stopComponent.StopSurfaceIndex;
        nSurfaceInComponent = getNumberOfSurfaces(stopComponent);
    else
        nComponent = 3;
        stopComponentIndex = 2;
        stopSurfaceInComponentIndex = 1;
        nSurfaceInComponent = 1;
    end
    
    aodHandles.lblStopComponentIndex = uicontrol( ...
        'Parent',aodHandles.panelComponentList,...
        'Tag', 'lblStopComponentIndex', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Stop Comp. ',...
        'units','normalized',...
        'Position',[0.45,0.935,0.2,0.04]);
    
    aodHandles.popStopComponentIndex = uicontrol( ...
        'Parent',aodHandles.panelComponentList,...
        'Tag', 'popStopComponentIndex', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', [num2cell(1:nComponent)],...
        'Value',stopComponentIndex,...
        'units','normalized',...
        'Position',[0.63,0.932,0.1,0.05]);
    
    aodHandles.lblStopSurfaceInComponentIndex = uicontrol( ...
        'Parent',aodHandles.panelComponentList,...
        'Tag', 'lblStopComponentIndex', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'String', 'Surface',...
        'units','normalized',...
        'Position',[0.75,0.935,0.12,0.04]);
    
    aodHandles.popStopSurfaceInComponentIndex = uicontrol( ...
        'Parent',aodHandles.panelComponentList,...
        'Tag', 'popStopComponentIndex', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style', 'popupmenu', ...
        'BackgroundColor', [1 1 1], ...
        'String', [num2cell(1:nSurfaceInComponent)],...
        'Value',stopSurfaceInComponentIndex,...
        'units','normalized',...
        'Position',[0.89,0.932,0.09,0.05]);
    
    % Set  celledit and cellselection callbacks
    set(aodHandles.tblComponentList,...
        'CellSelectionCallback',{@tblComponentList_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblComponentList_CellEditCallback,parentWindow});
    
    set(aodHandles.popStopComponentIndex,...
        'Callback',{@popStopComponentIndex_Callback,parentWindow});
    set(aodHandles.popStopSurfaceInComponentIndex,...
        'Callback',{@popStopSurfaceInComponentIndex_Callback,parentWindow});
    
    % Initialize the ui table for component parameters
    aodHandles.tblComponentBasicParameters = uitable('Parent',aodHandles.compBasicDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 1]);
    aodHandles.tblComponentTiltDecenterParameters = uitable('Parent',aodHandles.compTiltDecenterDataTab,...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized','Position',[0 0 1 1]);
    
    %     Set  celledit and cellselection callbacks
    set(aodHandles.tblComponentBasicParameters,...
        'CellSelectionCallback',{@tblComponentBasicParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblComponentBasicParameters_CellEditCallback,parentWindow});
    set(aodHandles.tblComponentTiltDecenterParameters,...
        'CellSelectionCallback',{@tblComponentTiltDecenterParameters_CellSelectionCallback,parentWindow},...
        'CellEditCallback',{@tblComponentTiltDecenterParameters_CellEditCallback,parentWindow});
    
    supportedComponents = GetSupportedComponents();
    columnName1 =   {'Component','Type', 'Name/Note'};
    columnWidth1 = {70,120, 100};
    columnEditable1 =  [false,true ,true];
    columnFormat1 =  {'char',{supportedComponents{:}}, 'char'};
    initialTable1 = {'OBJ','OBJECT','Object';...
        'STOP','SQS',  '';...
        'IMG','IMAGE', 'Image'};
    set(aodHandles.tblComponentList, ...
        'ColumnFormat',columnFormat1,...
        'Data', initialTable1,'ColumnEditable', columnEditable1,...
        'ColumnName', columnName1,'ColumnWidth',columnWidth1);
    
    % reset component parameter tables
    columnName2 =   {'Parameters', 'Value', 'Solve'};
    columnWidth2 = {150, 100 70};
    columnEditable2 =  [false true false];
    columnFormat2 =  {'char', 'char','char'};
    initialTable2 = {'Param 1','0',' '};
    set(aodHandles.tblComponentBasicParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);
    set(aodHandles.tblComponentTiltDecenterParameters, ...
        'ColumnFormat',columnFormat2,...
        'Data', initialTable2,'ColumnEditable', columnEditable2,...
        'ColumnName', columnName2,'ColumnWidth',columnWidth2);
    
    % Give all tables initial data
    parentWindow.ParentHandles = aodHandles;
    updateSystemConfigurationWindow( parentWindow );
    updateQuickLayoutPanel(parentWindow,1);
end

% Local functions
function btnInsertComponent_Callback(~,~,parentWindow)
    global CURRENT_SELECTED_COMPONENET
    global CAN_ADD_COMPONENET
    if CAN_ADD_COMPONENET
        insertPosition = CURRENT_SELECTED_COMPONENET;
        InsertNewComponent(parentWindow,'SQS','SequenceOfSurfaces',insertPosition);
%         aodHandles = parentWindow.ParentHandles;
    end
    updateQuickLayoutPanel(parentWindow,CURRENT_SELECTED_COMPONENET);
end



function btnRemoveComponent_Callback(~,~,parentWindow)
    global CAN_REMOVE_COMPONENET
    global CURRENT_SELECTED_COMPONENET
    
    aodHandles = parentWindow.ParentHandles;
    if CAN_REMOVE_COMPONENET
        % Confirm action
        % Construct a questdlg with three options
        choice = questdlg('Are you sure to delete the component?', ...
            'Confirm Deletion', ...
            'Yes','No','Yes');
        % Handle response
        switch choice
            case 'Yes'
                % Delete the component
                removePosition = CURRENT_SELECTED_COMPONENET;
                RemoveComponent(parentWindow,removePosition);
                aodHandles = parentWindow.ParentHandles;
            case 'No'
                % Mark the delete box again
        end
    else
        % Mark the delete box again
    end
    parentWindow.ParentHandles = aodHandles;
    updateQuickLayoutPanel(parentWindow,CURRENT_SELECTED_COMPONENET);
end

function popStopComponentIndex_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    currentOpticalSystem = aodHandles.OpticalSystem;
    prevStopIndex = getStopComponentIndex(currentOpticalSystem);
    newStopIndex = get(hObject,'Value');
    if newStopIndex == 1 || newStopIndex == getNumberOfComponents(currentOpticalSystem) % Object and image can not be Stop
        newStopIndex = prevStopIndex;
    end
    if newStopIndex ~= prevStopIndex
        aodHandles.OpticalSystem.ComponentArray(prevStopIndex).StopSurfaceIndex = 0;
        aodHandles.OpticalSystem.ComponentArray(newStopIndex).StopSurfaceIndex = 1;
    end
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , newStopIndex);
end
function popStopSurfaceInComponentIndex_Callback(hObject, eventdata,parentWindow)
    aodHandles = parentWindow.ParentHandles;
    currentOpticalSystem = aodHandles.OpticalSystem;
    stopComponentIndex = getStopComponentIndex(currentOpticalSystem);
    prevStopSurfIndex = currentOpticalSystem.ComponentArray(stopComponentIndex).StopSurfaceIndex;
    newStopSurfIndex = get(hObject,'Value');
    if newStopSurfIndex ~= prevStopSurfIndex
        aodHandles.OpticalSystem.ComponentArray(stopComponentIndex).StopSurfaceIndex = newStopSurfIndex;        
    end
    parentWindow.ParentHandles = aodHandles;
end
% Cell select and % CellEdit Callback
% --- Executes when selected cell(s) is changed in aodHandles.tblComponentLis.
function tblComponentList_CellSelectionCallback(~, eventdata,parentWindow)
    global CURRENT_SELECTED_COMPONENET
    global CAN_ADD_COMPONENET
    global CAN_REMOVE_COMPONENET
    aodHandles = parentWindow.ParentHandles;
    
    selectedCell = eventdata.Indices;
    if isempty(selectedCell)
        return
    end
    CURRENT_SELECTED_COMPONENET = selectedCell(1);
    
    tblData = get(aodHandles.tblComponentList,'data');
    sizeTblData = size(tblData);
    
    if CURRENT_SELECTED_COMPONENET == 1 % object comp
        CAN_ADD_COMPONENET = 0;
        CAN_REMOVE_COMPONENET = 0;
        % make the 2nd column uneditable
        columnEditable1 = [false,false,true];
        set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
    elseif CURRENT_SELECTED_COMPONENET == sizeTblData(1)% image comp
        CAN_ADD_COMPONENET = 1;
        CAN_REMOVE_COMPONENET = 0;
        % make the 2nd column uneditable
        columnEditable1 = [false,false,true];
        set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
    elseif sizeTblData(1) == 3 % only 3 components left
        CAN_ADD_COMPONENET = 1;
        CAN_REMOVE_COMPONENET = 0;
        % make the 2nd column editable
        columnEditable1 = [false,true,true];
        set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
    else
        CAN_ADD_COMPONENET = 1;
        CAN_REMOVE_COMPONENET = 1;
        % make the 2nd column editable
        columnEditable1 = [false,true,true];
        set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
    end
   parentWindow.ParentHandles = aodHandles;
    % Show the component parameters in the component detail window
    updateQuickLayoutPanel(parentWindow,CURRENT_SELECTED_COMPONENET)
    updateSurfaceOrComponentEditorPanel( parentWindow , CURRENT_SELECTED_COMPONENET)
end
% --- Executes when entered data in editable cell(s) in aodHandles.tblComponentLis.
function tblComponentList_CellEditCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblComponentList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    global CURRENT_SELECTED_COMPONENET
    aodHandles = parentWindow.ParentHandles;
    editedCellIndex = eventdata.Indices;
    if ~isempty(editedCellIndex)
        editedRow = editedCellIndex(1,1);
        editedCol = editedCellIndex(1,2);
    else
        return;
    end
    CURRENT_SELECTED_COMPONENET = editedRow;
    if editedCol== 2 % component type changed
        if strcmpi(eventdata.PreviousData,'OBJECT')||strcmpi(eventdata.PreviousData,'IMAGE')
            % for object or image comp comp change the comp type back to OBJECT or
            % IMAGE
            tblData1 = get(aodHandles.tblComponentList,'data');
            sizeTblData1 = size(tblData1);
            nComponent = sizeTblData1(1);
            tblData1{1,2} = 'OBJECT';
            tblData1{nComponent,2} = 'IMAGE';
            set(aodHandles.tblComponentList, 'Data', tblData1);
        else
            if IsSurfaceBased(aodHandles.OpticalSystem)
                return;
            else
                stopCompIndex = getStopComponentIndex(aodHandles.OpticalSystem);
            end
            % reset the component type in the component detail window
            selectedComponentType = eventdata.NewData;
            newComponent = Component(selectedComponentType);
            if editedRow == stopCompIndex
                newComponent.StopSurfaceIndex = 1;
            end
            % Add the new componet to the temporary componentArray
            aodHandles.OpticalSystem.ComponentArray(editedRow) = newComponent;          
            parentWindow.ParentHandles = aodHandles;         
        end
        
    elseif editedCol== 3 % component comment changed
        aodHandles.OpticalSystem.ComponentArray(editedRow).Comment = eventdata.NewData;
    end
    parentWindow.ParentHandles = aodHandles;
    updateQuickLayoutPanel(parentWindow,CURRENT_SELECTED_COMPONENET);
    updateSurfaceOrComponentEditorPanel( parentWindow , CURRENT_SELECTED_COMPONENET)
end



function tblComponentBasicParameters_CellSelectionCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblComponentList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    global CURRENT_SELECTED_COMPONENET
    aodHandles = parentWindow.ParentHandles;
    selectedComponent =  aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET);
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
    
    [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getComponentParameters(selectedComponent,'Basic',selectedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  iscell(myType) && length(myType)>1
        % type is choice of popmenu
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = myType{choice};
        newParamDisp = newParam;
        % Update the component parameter and component editor
        if selectedRow <=1
            selectedComponent.(myName) = newParam;
        else
            selectedComponent.UniqueParameters.(myName) = newParam;
        end
    else
        if strcmpi('logical',myType)
            % type is choice of popmenu true or false
            trueFalse = {'1','0'};
            choice = menu(myName,'False','True');
            if choice == 0
                choice = 1;
            end
            newParam = trueFalse{choice};
            newParamDisp = newParam;
            
            % Update the component parameter and component editor
            if selectedRow <=1
                selectedComponent.(myName) = newParam;
            else
                selectedComponent.UniqueParameters.(myName) = newParam;
            end
        elseif strcmpi('SQS',myType)
            initialSurfaceArray = selectedComponent.UniqueParameters.(myName);
            isSurfaceArrayComponent = 0;
            glassCatalogueListFullNames = aodHandles.OpticalSystem.GlassCataloguesList;
            coatingCatalogueListFullNames = aodHandles.OpticalSystem.CoatingCataloguesList;
            fontName = aodHandles.FontName;
            fontSize = aodHandles.FontSize;
            surfaceArrayEnteryFig = surfaceArrayInputDialog(initialSurfaceArray,...
                isSurfaceArrayComponent,glassCatalogueListFullNames,coatingCatalogueListFullNames,...
                fontName,fontSize );
            set(surfaceArrayEnteryFig,'WindowStyle','Modal');
            uiwait(surfaceArrayEnteryFig);
            surfaceArray = getappdata(0,'SurfaceArray');
            selectedComponent.UniqueParameters.(myName)  = surfaceArray;                        
        elseif strcmpi('numeric',myType) || strcmpi('char',myType)||...
                strcmpi('Glass',myType) || strcmpi('Coating',myType)
            
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET) = selectedComponent;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , CURRENT_SELECTED_COMPONENET)
end


function tblComponentTiltDecenterParameters_CellSelectionCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblComponentTiltDecenterParameters (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    global CURRENT_SELECTED_COMPONENET
    aodHandles = parentWindow.ParentHandles;
    selectedComponent =  aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET);
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
    [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getComponentParameters(selectedComponent,'TiltDecenter',selectedRow);
    
    myType = paramTypes{1};
    myName = paramNames{1};
    if  iscell(myType)&& length(myType)>1
        % type is choice of popmenu
        nChoice = length(myType);
        choice = menu(myName,myType(1:nChoice));
        if choice == 0
            choice = 1;
        end
        newParam = myType{choice};
        newParamDisp = newParam;
        % Update the component parameter and component editor
        selectedComponent.(myName) = newParam;
    else
        if strcmpi('logical',myType)
            % type is choice of popmenu true or false
            trueFalse = {'0','1'};
            choice = menu(myName,'False','True');
            if choice == 0
                choice = 1;
            end
            newParam = trueFalse{choice};
            
            newParamDisp = newParam;
            
            % Update the component parameter and component editor
            selectedComponent.(myName) = newParam;
        elseif strcmpi('numeric',myType) || strcmpi('char',myType)
            
        else
            disp(['Error: Unknown parameter type: ',myType]);
            return;
        end
    end
    aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET) = selectedComponent;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , CURRENT_SELECTED_COMPONENET)
end


function tblComponentBasicParameters_CellEditCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblComponentList (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    global CURRENT_SELECTED_COMPONENET
    aodHandles = parentWindow.ParentHandles;
    selectedComponent =  aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET);
    if CURRENT_SELECTED_COMPONENET > 1
        previousComponent =  aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET-1);
    else
        previousComponent =  selectedComponent;
    end
    selectedCellIndex = eventdata.Indices;
    if isempty(selectedCellIndex)
        return;
    else
        editedRow = selectedCellIndex(1,1);
        editedCol = selectedCellIndex(1,2);
        
    end
    if editedCol == 2 % component  value edited
        switch editedRow
            case 1
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedComponent.LastThickness = newParam;
            otherwise
                [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
                    getComponentParameters(selectedComponent,'Basic',editedRow);
                
                myType = paramTypes{1};
                myName = paramNames{1};
                
                if  (iscell(myType) && length(myType)>1)||(strcmpi('logical',myType))
                    % type is choice of popmenu and so already saved with popup menu
                else
                    if strcmpi('numeric',myType)
                        newParam = str2num(eventdata.EditData);
                        if isempty(newParam)
                            newParam = 0;
                        end
                        % Update the component parameter and component editor
                        selectedComponent.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('char',myType)
                        newParam = (eventdata.EditData);
                        % Update the component parameter and component editor
                        selectedComponent.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('Glass',myType)
                        glassName = (eventdata.EditData);
                        newParam = Glass(glassName);
                        % Update the component parameter and component editor
                        selectedComponent.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('Coating',myType)
                        coatingName = (eventdata.EditData);
                        newParam = Glass(coatingName);
                        % Update the component parameter and component editor
                        selectedComponent.UniqueParameters.(myName) = newParam;
                    elseif strcmpi('SQS',myType)
                        % SQS already saved using surfacearray input dialog 
                    else
                        disp(['Error: Unknown parameter type: ',myType]);
                        return;
                    end
                end
                
        end
    else
    end
    aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET) = selectedComponent;
    parentWindow.ParentHandles = aodHandles;
    updateQuickLayoutPanel(parentWindow,CURRENT_SELECTED_COMPONENET);
    updateSurfaceOrComponentEditorPanel( parentWindow );
end


function tblComponentTiltDecenterParameters_CellEditCallback(~, eventdata,parentWindow)
    % hObject    handle to aodHandles.tblComponentTiltDecenterParameters (see GCBO)
    % eventdata  structure with the following fields (see UITABLE)
    %	Indices: row and column indices of the cell(s) edited
    %	PreviousData: previous data for the cell(s) edited
    %	EditData: string(s) entered by the user
    %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
    %	Error: error string when failed to convert EditData to appropriate value for Data
    % parentWindow: object with structure with aodHandles and user data (see GUIDATA)
    
    
    global CURRENT_SELECTED_COMPONENET
    aodHandles = parentWindow.ParentHandles;
    selectedComponent =  aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET);
    
    selectedCellIndex = eventdata.Indices;
    if isempty(selectedCellIndex) || isempty(eventdata.NewData)
        return;
    else
        editedRow = selectedCellIndex(1,1);
        editedCol = selectedCellIndex(1,2);
        
    end
    if editedCol == 2 % component  value edited
        switch editedRow
            case 1
                orderString = eventdata.EditData;
                if length(orderString) ~= 12
                    selectedComponent.FirstTiltDecenterOrder = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                else
                    selectedComponent.FirstTiltDecenterOrder = {orderString(1:2),orderString(3:4),...
                        orderString(5:6),orderString(7:8),orderString(9:10),orderString(11:12)};
                end
                
            case 2
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedComponent.FirstTilt(1) = newParam;
            case 3
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedComponent.FirstTilt(2) = newParam;
            case 4
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedComponent.FirstTilt(3) = newParam;
            case 5
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedComponent.FirstDecenter(1) = newParam;
            case 6
                newParam = str2num(eventdata.EditData);
                if isempty(newParam)
                    newParam = 0;
                end
                selectedComponent.FirstDecenter(2) = newParam;
            case 7
                % already saved by pop up menu
            otherwise
        end
    else
    end
    aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENET) = selectedComponent;
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow , CURRENT_SELECTED_COMPONENET)
    
end

function InsertNewComponent(parentWindow,componentTypeDisp,componentType,insertPosition)
    %update component list table
    aodHandles = parentWindow.ParentHandles;
    nComponent = getNumberOfComponents(aodHandles.OpticalSystem);
    % Update the component array
    for kk = nComponent:-1:insertPosition
        aodHandles.OpticalSystem.ComponentArray(kk+1) = aodHandles.OpticalSystem.ComponentArray(kk);
    end
    aodHandles.OpticalSystem.ComponentArray(insertPosition) = Component(componentType);
    
    set(aodHandles.popStopComponentIndex,'String',[num2cell(1:nComponent+1)],...
        'Value',getStopComponentIndex(aodHandles.OpticalSystem));
    % If possible add here a code to select the first cell of newly added row
    % automatically
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow );
end

function RemoveComponent(parentWindow,removePosition)
    % check if it is stop component
    if getStopComponentIndex(parentWindow.ParentHandles.OpticalSystem) == removePosition
        stopComponentRemoved = 1;
    else
        stopComponentRemoved = 0;
    end
    aodHandles = parentWindow.ParentHandles;
    
    % Update the component array
    aodHandles.OpticalSystem.ComponentArray = aodHandles.OpticalSystem.ComponentArray([1:removePosition-1,removePosition+1:end]);
    if stopComponentRemoved
        if strcmpi(aodHandles.OpticalSystem.ComponentArray(removePosition).Type,'IMAGE')
            aodHandles.OpticalSystem.ComponentArray(removePosition-1).Stop = 1;
        else
            aodHandles.OpticalSystem.ComponentArray(removePosition).Stop = 1;
        end
    end
    % If possible add here a code to select the first cell of newly added row
    % automatically
    parentWindow.ParentHandles = aodHandles;
    updateSurfaceOrComponentEditorPanel( parentWindow );
end

function actionConfirmed = IsSurfaceBasedSystemDefinition(parentWindow)
    if (isnumeric(parentWindow.ParentHandles.OpticalSystem.SystemDefinitionType) &&...
            parentWindow.ParentHandles.OpticalSystem.SystemDefinitionType == 1)||...
            strcmpi(parentWindow.ParentHandles.OpticalSystem.SystemDefinitionType,'SurfaceBased')
        actionConfirmed = 1;
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
                % first sync the surface array with component array
                oldOpticalSystem = parentWindow.ParentHandles.OpticalSystem;
                [ updatedSystem ] = synchronizeSurfaceAndComponentArray( oldOpticalSystem );
                updatedSystem.SystemDefinitionType = 'SurfaceBased';
                parentWindow.ParentHandles.OpticalSystem = updatedSystem;
                
                updateSurfaceOrComponentEditorPanel( parentWindow );
                actionConfirmed = 1;
            case 'No'
                actionConfirmed = 0;
                return;
        end
    end
end


