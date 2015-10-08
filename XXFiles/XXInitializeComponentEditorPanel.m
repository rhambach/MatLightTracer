function InitializeComponentEditorPanel( parentWindow )
%INITIALIZECOMPONENTEDITORPANEL Define and initialized the uicontrols of the
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
    'Position',[0.0,0.0,0.30,1.0]);
aodHandles.panelComponentDetail = uipanel(...
    'Parent',aodHandles.panelComponentEditorMain,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.3,0.0,0.70,1.0]);

aodHandles.chkUpdateSurfaceEditorFromComponentEditor = uicontrol( ...
    'Parent', aodHandles.panelComponentDetail, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'checkbox', ...
    'String', 'Update Surface Editor',...
    'units','normalized',...
    'Position',[0.0,0.95,0.35,0.05],...
    'Value', false);

aodHandles.panelComponentFigure = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'Title','Component Figure',...
    'units','normalized',...
    'Position',[0.0,0.5,0.35,0.45]);
aodHandles.panelComponentDescription = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'Title','Component Description',...
    'units','normalized',...
    'Position',[0.0,0.0,0.35,0.5]);
aodHandles.panelComponentParameters = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'Title','Component Parameters',...
    'units','normalized',...
    'Position',[0.36,0.0,0.65,1.0]);

% Initialize the ui table for componentlist
aodHandles.tblComponentList = uitable('Parent',aodHandles.panelComponentList,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 0.93]);

% Command buttons for adding and removing surfaces
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

set(aodHandles.chkUpdateSurfaceEditorFromComponentEditor,'value',0);

% Set  celledit and cellselection callbacks
set(aodHandles.tblComponentList,...
    'CellSelectionCallback',{@tblComponentList_CellSelectionCallback,parentWindow},...
    'CellEditCallback',{@tblComponentList_CellEditCallback,parentWindow});
% Initialize the axes for component figure
aodHandles.axesComponentFigure = axes( ...
    'Parent',aodHandles.panelComponentFigure,...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Units', 'Normalized',...
    'Position', [0.0,0.0, 1.0, 1.0],...
    'Box','on','xticklabel',[],'yticklabel',[]);
% Initialize the lable for component description
aodHandles.lblComponentDescription = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelComponentDescription,...
    'FontSize',fontSize,'FontName', fontName,...
    'String','Component description ...',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,1.0]);
% Initialize the ui table for component parameters
aodHandles.tblComponentParameters = uitable('Parent',aodHandles.panelComponentParameters,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 1]);
%     Set  celledit and cellselection callbacks
set(aodHandles.tblComponentParameters,...
    'CellSelectionCallback',{@tblComponentParameters_CellSelectionCallback,parentWindow},...
    'CellEditCallback',{@tblComponentParameters_CellEditCallback,parentWindow});

% Give all tables initial data
parentWindow.ParentHandles = aodHandles;
updateSurfaceOrComponentEditorPanel( parentWindow );
end

% Local functions
function btnInsertComponent_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.ParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'SQS','SequenceOfSurfaces',insertPosition);
    aodHandles = myParent.ParentHandles;
end
end



function btnRemoveComponent_Callback(~,~,parentWindow)
if ~checkTheCurrentSystemDefinitionType(parentWindow.ParentHandles)
    return
end
global CAN_REMOVE_COMPONENT
global CURRENT_SELECTED_COMPONENT

aodHandles = parentWindow.ParentHandles;
%     if eventdata.Indices(2) == 4 % when the delete column selected
if CAN_REMOVE_COMPONENT
    %             if ~eventdata.EditData
    % Confirm action
    % Construct a questdlg with three options
    choice = questdlg('Are you sure to delete the component?', ...
        'Confirm Deletion', ...
        'Yes','No','Yes');
    % Handle response
    switch choice
        case 'Yes'
            % Delete the component
            removePosition = CURRENT_SELECTED_COMPONENT;
            %                         removePosition = eventdata.Indices(1);
            RemoveComponent(parentWindow,removePosition);
            aodHandles = parentWindow.ParentHandles;
        case 'No'
            % Mark the delete box again
     end
else
    %             % Mark the delete box again
end
parentWindow.ParentHandles = aodHandles;
end

% Cell select and % CellEdit Callback
% --- Executes when selected cell(s) is changed in aodHandles.tblComponentLis.
function tblComponentList_CellSelectionCallback(~, eventdata,parentWindow)
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
global CAN_REMOVE_COMPONENT
aodHandles = parentWindow.ParentHandles;

% selectedCell = cell2mat(struct2cell(eventdata)); %struct to matrix
selectedCell = eventdata.Indices;
if isempty(selectedCell)
    return
end
CURRENT_SELECTED_COMPONENT = selectedCell(1);

tblData = get(aodHandles.tblComponentList,'data');
sizeTblData = size(tblData);

%     if selectedCell(2)== 1 || selectedCell(2)== 6 %  when the 1st,5th and 6th column selected
if CURRENT_SELECTED_COMPONENT == 1 % object surf
    CAN_ADD_COMPONENT = 0;
    CAN_REMOVE_COMPONENT = 0;
    % make the 2nd column uneditable
    columnEditable1 = [false,false,true];
    set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
elseif CURRENT_SELECTED_COMPONENT == sizeTblData(1)% image surf
    CAN_ADD_COMPONENT = 1;
    CAN_REMOVE_COMPONENT = 0;
    % make the 2nd column uneditable
    columnEditable1 = [false,false,true];
    set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
else
    CAN_ADD_COMPONENT = 1;
    CAN_REMOVE_COMPONENT = 1;
    % make the 2nd column editable
    columnEditable1 = [false,true,true];
    set(aodHandles.tblComponentList,'ColumnEditable', columnEditable1);
end

% Show the component parameters in the component detail window
currentComponent = aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENT);
displayComponentDetail(currentComponent,aodHandles);
parentWindow.ParentHandles = aodHandles;
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

global CURRENT_SELECTED_COMPONENT
aodHandles = parentWindow.ParentHandles;
editedCellIndex = eventdata.Indices;
if ~isempty(editedCellIndex)
    editedRow = editedCellIndex(1,1);
    editedCol = editedCellIndex(1,2);
else
    return;
end
CURRENT_SELECTED_COMPONENT = editedRow;
if editedCol== 2 % component type changed
    if strcmpi(eventdata.PreviousData,'OBJECT')||strcmpi(eventdata.PreviousData,'IMAGE')
        % for object or image surf surf change the comp type back to OBJECT or
        % IMAGE
        tblData1 = get(aodHandles.tblComponentList,'data');
        sizeTblData1 = size(tblData1);
        nComponent = sizeTblData1(1);
        tblData1{1,2} = 'OBJECT';
        tblData1{nComponent,2} = 'IMAGE';
        set(aodHandles.tblComponentList, 'Data', tblData1);
    else
        if ~checkTheCurrentSystemDefinitionType(aodHandles)
            return
        end
        % reset the component type in the component detail window
        selectedComponentType = eventdata.NewData;
        fullName = ComponentNameConverter (selectedComponentType,1);
        newComponent = Component(fullName);
        % Add the new componet to the temporary componentArray
        aodHandles.OpticalSystem.ComponentArray(CURRENT_SELECTED_COMPONENT) = newComponent;
        displayComponentDetail(newComponent,aodHandles);
    end
else
end
parentWindow.ParentHandles = aodHandles;
end



function tblComponentParameters_CellSelectionCallback(~, eventdata,parentWindow)
% hObject    handle to aodHandles.tblComponentList (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% parentWindow: object with structure with aodHandles and user data (see GUIDATA)

global CURRENT_SELECTED_COMPONENT
aodHandles = parentWindow.ParentHandles;
selectedCellIndex = eventdata.Indices;
if ~isempty(selectedCellIndex)
    selectedRow = selectedCellIndex(1,1);
    selectedCol = selectedCellIndex(1,2);
else
    return;
end
if selectedCol == 3 % component Edit value selected
    componentIndex = CURRENT_SELECTED_COMPONENT;
    parameterIndex = selectedRow;
    componentParametersInputDialog(parentWindow,componentIndex, parameterIndex);
    
    % update the component detail window
    aodHandles = parentWindow.ParentHandles;
    newEditedComponent = aodHandles.OpticalSystem.ComponentArray(componentIndex);
    displayComponentDetail(newEditedComponent,aodHandles)
    % paramName, paramType, paramValueOld,paramValueOldDisplay);
end
end

function  displayComponentDetail(selectedComponent,aodHandles)
[ dispName, imgFileName, compDescription ] = getComponentAboutInfo(selectedComponent);
%     componentParameters = getComponentParameters(selectedComponent);
% Display the component description figure
imshow(imgFileName{:}, 'Parent', aodHandles.axesComponentFigure);
% Display the domponent description text
set(aodHandles.lblComponentDescription, 'String', compDescription{:});
% Display component parmeters
[ componentParametersTable,componentParametersTableDisplay ] = getComponentParametersTable(selectedComponent);
compParamTable = componentParametersTableDisplay;
set(aodHandles.tblComponentParameters, ...
    'Data', compParamTable);
end


function UpdateCurrentComponent()
end
function UpdateComponentArray(aodHandles)

end

function InsertNewComponent(parentWindow,componentTypeDisp,componentType,insertPosition)
%update component list table
aodHandles = parentWindow.ParentHandles;

tblData1 = get(aodHandles.tblComponentList,'data');
sizeTblData1 = size(tblData1);
nComponent = sizeTblData1(1);

partA = tblData1(1:insertPosition-1,:);

newRow =  {['COMP'],componentTypeDisp,''};

partB = tblData1(insertPosition:sizeTblData1 ,:);

newTable1 = [partA; newRow; partB];
set(aodHandles.tblComponentList, 'Data', newTable1);

% Update the component array
for kk = nComponent:-1:insertPosition
    aodHandles.OpticalSystem.ComponentArray(kk+1) = aodHandles.OpticalSystem.ComponentArray(kk);
end
aodHandles.OpticalSystem.ComponentArray(insertPosition) = Component(componentType);
%
% If possible add here a code to select the first cell of newly added row
% automatically

parentWindow.ParentHandles = aodHandles;
end

function RemoveComponent(parentWindow,removePosition)
aodHandles = parentWindow.ParentHandles;

%update component list table
tblData1 = get(aodHandles.tblComponentList,'data');
sizeTblData1 = size(tblData1);
partA = tblData1(1:removePosition-1,:);
partB = tblData1(removePosition+1:sizeTblData1 ,:);

newTable1 = [partA; partB];
%sysTable1 = aodHandles.tblComponentList;
set(aodHandles.tblComponentList, 'Data', newTable1);

% Update the component array
aodHandles.OpticalSystem.ComponentArray = aodHandles.OpticalSystem.ComponentArray([1:removePosition-1,removePosition+1:end]);

% If possible add here a code to select the first cell of newly added row
% automatically

parentWindow.ParentHandles = aodHandles;
end
function ret = checkTheCurrentSystemDefinitionType(aodHandles)
    
if get(aodHandles.popSystemDefinitionType,'Value') == 2
    ret = 1;
else
    choice = questdlg(['Your system is not defined using Component',...
        ' Based method. Editing in the component editor',...
        ' window automatically converts your system to Component',...
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

