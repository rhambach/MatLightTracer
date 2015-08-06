function InitializeSurfaceEditorPanel(parentWindow)
% InitializeSurfaceEditorPanel: Define and initialized the uicontrols of the 
% Surface Editor Panel
% Member of AODParentWindow class

aodHandles = parentWindow.AODParentHandles;
    fontSize = aodHandles.FontSize;
    fontName = aodHandles.FontName;
    
    nMainTab = aodHandles.nMainTab;
    aodHandles.surfEditorTabGroup = uitabgroup(...
        'Parent', aodHandles.panelSurfaceEditorMain, ...
        'Units', 'Normalized', ...
        'Position', [0, 0, 1.0, 0.94]); 
    aodHandles.surfStandardDataTab = ...
        uitab(aodHandles.surfEditorTabGroup, 'title','Standard Data');
    aodHandles.surfApertureDataTab = ...
        uitab(aodHandles.surfEditorTabGroup, 'title','Aperture Data');
    aodHandles.surfTiltDecenterDataTab = ...
        uitab(aodHandles.surfEditorTabGroup, 'title','Tilt Decenter Data');

    
    % Command buttons for adding and removing surfaces
    aodHandles.btnInsertSurface = uicontrol( ...
        'Parent',aodHandles.panelSurfaceEditorMain,...
        'Style', 'pushbutton', ...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.001,0.94,0.075,0.05],...
        'String','Insert',...
        'Callback',{@btnInsertSurface_Callback,parentWindow});
    aodHandles.btnRemoveSurface = uicontrol( ...
        'Parent',aodHandles.panelSurfaceEditorMain,...
        'Style', 'pushbutton', ...
        'FontSize',fontSize,'FontName', fontName,...
        'units','normalized',...
        'Position',[0.077,0.94,0.075,0.05],...
        'String','Remove',...
        'Callback',{@btnRemoveSurface_Callback,parentWindow});



    % Initialize the panel and table for standard data
    aodHandles.tblStandardData = uitable('Parent',aodHandles.surfStandardDataTab,...
        'FontSize',fontSize,'FontName', fontName,'units','normalized','Position',[0 0 1 1]);                    
    % Initialize the panel and table for aperture data
    aodHandles.tblApertureData = ...
        uitable('Parent',aodHandles.surfApertureDataTab,'FontSize',fontSize,'FontName', fontName,...
                  'units','normalized','Position',[0 0 1 1]);            
    % Initialize the panel and table for tilt decenter data
    aodHandles.tblTiltDecenterData = ...
        uitable('Parent',aodHandles.surfTiltDecenterDataTab,'FontSize',fontSize,'FontName', fontName,...
                  'units','normalized','Position',[0 0 1 1]); 
              

    % Give all tables initial data
    parentWindow.AODParentHandles = aodHandles;
    parentWindow = resetSurfaceEditorPanel(parentWindow);
    aodHandles = parentWindow.AODParentHandles;
    
    % Set all celledit and cellselection callbacks
    set(aodHandles.tblStandardData,...
        'CellEditCallback',{@tblStandardData_CellEditCallback,aodHandles},...
        'CellSelectionCallback',{@tblStandardData_CellSelectionCallback,aodHandles});    
    
    set(aodHandles.tblApertureData,...
        'CellEditCallback',{@tblApertureData_CellEditCallback,aodHandles},...
        'CellSelectionCallback',{@tblApertureData_CellSelectionCallback,aodHandles});    
    
    set(aodHandles.tblTiltDecenterData,...
        'CellEditCallback',{@tblTiltDecenterData_CellEditCallback,aodHandles},...
        'CellSelectionCallback',{@tblTiltDecenterData_CellSelectionCallback,aodHandles});
    parentWindow.AODParentHandles = aodHandles;
end

%% Callback Function Definitions
    %% Toolbar Callbacks
    function btnInsertSurface_Callback(~,~,myParent)                  
        aodHandles = myParent.AODParentHandles;
        if get(aodHandles.popSystemDefinitionType,'Value') == 1
            InsertNewSurface(aodHandles);
        else
            choice = questdlg(['Your system is not defined using Surface',...
                'Based method. Editing in the surface editor',...
                'window automatically converts your system to Surface',...
                'Based definition. Do you want to continue editing surface?'], ...
                'Change System Definition Type', ...
                'Yes','No','No');
            % Handle response
            switch choice
                case 'Yes'
                    set(aodHandles.popSystemDefinitionType,'Value', 1);
                    InsertNewSurface(aodHandles);
                case 'No'
            end
        end
        
    end

    function btnRemoveSurface_Callback(~,~,myParent)
        aodHandles = myParent.AODParentHandles;
        if get(aodHandles.popSystemDefinitionType,'Value') == 1
            RemoveThisSurface(aodHandles);
        else
            choice = questdlg(['Your system is not defined using Surface',...
                'Based method. Editing in the surface editor',...
                'window automatically converts your system to Surface',...
                'Based definition. Do you want to continue editing surface?'], ...
                'Change System Definition Type', ...
                'Yes','No','No');
            % Handle response
            switch choice
                case 'Yes'
                    set(aodHandles.popSystemDefinitionType,'Value', 1);
                    RemoveThisSurface(aodHandles);
                case 'No'
            end            
        end
        
    end

% CellEditCallback
% --- Executes when entered data in editable cell(s) in aodHandles.tblStandardData.
function tblStandardData_CellEditCallback(~, eventdata,aodHandles)
% hObject    handle to aodHandles.tblStandardData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% aodHandles    structure with aodHandles and user data (see GUIDATA)

if ~checkTheCurrentSystemDefinitionType(aodHandles) 
    return
end

if eventdata.Indices(2) == 1    %if surface tag  is changed update all tables in the editor
    if (strcmpi(eventdata.PreviousData,'OBJECT'))||(strcmpi(eventdata.PreviousData,'IMAGE'))||(strcmpi(eventdata.PreviousData,'STOP'))
         tblData1 = get(aodHandles.tblStandardData,'data');
         tblData1{eventdata.Indices(1),1} = eventdata.PreviousData;
         set(aodHandles.tblStandardData, 'Data', tblData1);

    elseif (strcmpi(eventdata.NewData,'STOP')) ||(strcmpi(eventdata.NewData,'STO'))||(strcmpi(eventdata.NewData,'ST'))||(strcmpi(eventdata.NewData,'S'))
         tblData1 = get(aodHandles.tblStandardData,'data');
         tblData2 = get(aodHandles.tblApertureData,'data');
         tblData5 = get(aodHandles.tblTiltDecenterData,'data');        
         kk = 2;
         while ~strcmpi(tblData1{kk,1},'Image')
             
             if kk == eventdata.Indices(1)
                 surfTag = 'STOP';
             else
                 surfTag = 'Surf';
             end
             tblData1{kk,1} = surfTag;         
             set(aodHandles.tblStandardData, 'Data', tblData1);  

             tblData2{kk,1} = surfTag;
             set(aodHandles.tblApertureData, 'Data', tblData2);
             tblData5{kk,1} = surfTag;
             set(aodHandles.tblTiltDecenterData, 'Data', tblData5);             
             kk = kk+1;
         end
    else
         tblData1 = get(aodHandles.tblStandardData,'data');
         tblData1{eventdata.Indices(1),1} = eventdata.PreviousData;
         set(aodHandles.tblStandardData, 'Data', tblData1);
    end
             
    columnEditable1 =  [false true true false true false true false true ...
        false true false true false true false];                     
    sysTable1 = aodHandles.tblStandardData;
    set(sysTable1,'ColumnEditable', columnEditable1);  
elseif eventdata.Indices(2) == 3 && ~(strcmpi(eventdata.NewData,''))   
    %if surface type is changed update all tables in the editor  
     tblData2 = get(aodHandles.tblApertureData,'data');
     tblData2{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(aodHandles.tblApertureData, 'Data', tblData2);     
   
     tblData5 = get(aodHandles.tblTiltDecenterData,'data');
     tblData5{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(aodHandles.tblTiltDecenterData, 'Data', tblData5);

    % Set the Column Names of the Standard data table
    surfaceType = eventdata.NewData;
    setStandardDataTableColumnNames(aodHandles,surfaceType);

elseif eventdata.Indices(1) == 1 && eventdata.Indices(2) == 5 
    % if first thickness is changed    
    if isValidGeneralInput() % This returns 1 by default, but in the future
        % input validation code shall be defined
    else
         button = questdlg('Invalid input detected. Do you want to restore previous valid object thickness value?','Restore Object Thickness');
         if strcmpi(button,'Yes')
             tblData1 = get(aodHandles.tblStandardData,'data');
             tblData1{eventdata.Indices(1),7} = eventdata.PreviousData;
             set(aodHandles.tblStandardData, 'Data', tblData1);
         end
    end  
elseif eventdata.Indices(2) == 7 % if glass is changed   
    glassName = eventdata.NewData;
    % Check if the glass name is just Mirror
    if strcmpi(glassName,'Mirror')
        tblData = get(aodHandles.tblStandardData,'data');
        tblData{eventdata.Indices(1),7} = 'MIRROR';
        set(aodHandles.tblStandardData, 'Data', tblData);        
        return;         
    % Check if the glass name is just the refractive index of the glass
    elseif ~isnan(str2double(glassName)) % Fixed Index Glass
        tblData = get(aodHandles.tblStandardData,'data');
        ndvdpg = str2num(glassName);
        if length(ndvdpg) == 1
            nd = ndvdpg(1);
            vd = 0;
            pg = 0;
        elseif length(ndvdpg) == 2
            nd = ndvdpg(1);
            vd = ndvdpg(2);
            pg = 0;
        elseif length(ndvdpg) == 3
            nd = ndvdpg(1);
            vd = ndvdpg(2);
            pg = ndvdpg(3);
        else
        end        
        tblData{eventdata.Indices(1),7} = [num2str((nd),'%.4f '),',',...
            num2str((vd),'%.4f '),',',...
            num2str((pg),'%.4f ')];
        set(aodHandles.tblStandardData, 'Data', tblData);        
        return;        
    end             
                       
    % check for its existance among selected catalogues
    if ~isempty(glassName)
        objectType = 'glass';
        objectName = glassName;
        % Glass Catalogue
        tableData1 = get(aodHandles.tblGlassCatalogues,'data');
        if ~isempty(tableData1)
            % Take only the selected ones
            selectedRows1 = find(cell2mat(tableData1(:,1)));
            if ~isempty(selectedRows1)
                glassCatalogueListFullNames = tableData1(selectedRows1,3);
            else
                glassCatalogueListFullNames = '';
            end
        else
            glassCatalogueListFullNames = '';
        end
        objectCatalogueListFullNames = glassCatalogueListFullNames;
        objectIndex = 0;
        for kk = 1:size(objectCatalogueListFullNames,1)
            objectCatalogueFullName = objectCatalogueListFullNames{kk};
            [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                (objectType,objectName,objectCatalogueFullName );
            if objectIndex ~= 0
                break;
            end
        end
        % if exists capitalize its name else ask for new glass definition
        if objectIndex ~= 0
            tblData = get(aodHandles.tblStandardData,'data');
            tblData{eventdata.Indices(1),7} = upper(tblData{eventdata.Indices(1),7});
            set(aodHandles.tblStandardData, 'Data', tblData);
        else
            button = questdlg('The glass is not found in the catalogues. Do you want to add or choose another?','Glass Not Found');
            switch button
                case 'Yes'
                    glassEnteryFig = glassDataInputDialog(glassCatalogueListFullNames);
                    set(glassEnteryFig,'WindowStyle','Modal');
                    uiwait(glassEnteryFig);
                    try
                        load('tempglass.mat','glassObj');
                        selectedGlassName = glassObj.Name;
                        delete('tempglass.mat')                        
                    catch
                        selectedGlassName = '';                        
                    end                    
                    tblData = get(aodHandles.tblStandardData,'data');
                    tblData{eventdata.Indices(1),7} = upper(selectedGlassName);
                    set(aodHandles.tblStandardData, 'Data', tblData);
                case 'No'
                    % Do nothing
                    disp('Warning: Undefined glass used. It may cause problem in the analysis.');
                case 'Cancel'
                    tblData = get(aodHandles.tblStandardData,'data');
                    tblData{eventdata.Indices(1),7} = '';
                    set(aodHandles.tblStandardData, 'Data', tblData);
            end
        end
    end

elseif eventdata.Indices(2) == 9 % if coating is changed
    % check for its existance among selected catalogues
    coatName = eventdata.NewData;

    objectType = 'coating';
    objectName = coatName;
    % Coating Catalogue
    tableData1 = get(aodHandles.tblCoatingCatalogues,'data');
    if ~isempty(tableData1)
        % Take only the selected ones
        selectedRows1 = find(cell2mat(tableData1(:,1)));
        if ~isempty(selectedRows1)
            coatingCatalogueListFullNames = tableData1(selectedRows1,3);
        else
            coatingCatalogueListFullNames = '';
        end
    else
        coatingCatalogueListFullNames = '';
    end
    objectCatalogueListFullNames = coatingCatalogueListFullNames;
    objectIndex = 0;
    for kk = 1:size(objectCatalogueListFullNames,1)
        objectCatalogueFullName = objectCatalogueListFullNames{kk};
        [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
            (objectType,objectName,objectCatalogueFullName );
        if objectIndex ~= 0
            break;
        end
    end
    
    % if empty, replace with None. If it exists in the catal capitalize its 
    % name else ask for new coating definition
    if isempty(coatName)
        coatName = 'None';
        tblData = get(aodHandles.tblStandardData,'data');
        tblData{eventdata.Indices(1),9} = upper(coatName);
        set(aodHandles.tblStandardData, 'Data', tblData);    
    elseif objectIndex ~= 0
        tblData = get(aodHandles.tblStandardData,'data');
        tblData{eventdata.Indices(1),9} = upper(tblData{eventdata.Indices(1),9});
        set(aodHandles.tblStandardData, 'Data', tblData);
    else
        button = questdlg('The coating is not found in the catalogues. Do you want to add or choose another?','Coating Not Found');
        switch button
            case 'Yes'
                coatingEnteryFig = coatingDataInputDialog(coatingCatalogueListFullNames);
                set(coatingEnteryFig,'WindowStyle','Modal');
                uiwait(coatingEnteryFig);
                try
                    load('tempcoating.mat','coatingObj');
                    selectedCoatingName = coatingObj.Name;
                    delete('tempcoating.mat')
                catch
                    selectedCoatingName = 'None';
                end
                tblData = get(aodHandles.tblStandardData,'data');
                tblData{eventdata.Indices(1),9} = upper(selectedCoatingName);
                set(aodHandles.tblStandardData, 'Data', tblData);
            case 'No'
                % Do nothing Just leave it
                disp('Warning: Undefined caoting used. It may cause problem in the analysis.');
            case 'Cancel'
                tblData = get(aodHandles.tblStandardData,'data');
                tblData{eventdata.Indices(1),15} = 'NONE';
                set(aodHandles.tblStandardData, 'Data', tblData);
        end
    end
end
end


% --- Executes when entered data in editable cell(s) in aodHandles.tblApertureData.
function tblApertureData_CellEditCallback(~, ~,aodHandles)
if ~checkTheCurrentSystemDefinitionType(aodHandles) 
    return
end
end

% --- Executes when entered data in editable cell(s) in aodHandles.tblGratingData.
% function tblGratingData_CellEditCallback(~, ~,~)
% end


% --- Executes when entered data in editable cell(s) in aodHandles.tblTiltDecenterData.
function tblTiltDecenterData_CellEditCallback(~, eventdata,aodHandles)
if ~checkTheCurrentSystemDefinitionType(aodHandles) 
    return
end

if eventdata.Indices(2) == 3  % 3rd row / tiltanddecenter data
    if isempty(eventdata.NewData) || ...
            ~isValidGeneralInput(eventdata.NewData,'TiltDecenterOrder')
        % restore previous data
        tblData = get(aodHandles.tblTiltDecenterData,'data');
        tblData{eventdata.Indices(1),3} = eventdata.PreviousData;
        set(aodHandles.tblTiltDecenterData, 'Data', tblData);
    else
        % valid input so format the text
        orderStr = upper(eventdata.NewData);
        formatedOrder(1:2:11) = upper(orderStr(1:2:11));
        formatedOrder(2:2:12) = lower(orderStr(2:2:12));
        tblData = get(aodHandles.tblTiltDecenterData,'data');
        tblData{eventdata.Indices(1),3} = formatedOrder;
        set(aodHandles.tblTiltDecenterData, 'Data', tblData);
    end
end
end

% --- Executes when selected cell(s) is changed in aodHandles.tblStandardData.
function tblStandardData_CellSelectionCallback(~, eventdata,aodHandles)
global SELECTED_CELL
global CAN_ADD
global CAN_REMOVE

% SELECTED_CELL = cell2mat(struct2cell(eventdata)); %struct to matrix
SELECTED_CELL = eventdata.Indices; 
if isempty(SELECTED_CELL)
    return
end

tblData = get(aodHandles.tblStandardData,'data');
sizeTblData = size(tblData);

% Set the Column Names of the Standard data table
surfaceType = tblData{SELECTED_CELL(1),3};
setStandardDataTableColumnNames(aodHandles,surfaceType);

if SELECTED_CELL(2)==1 % only when the first column selected
    if SELECTED_CELL(1)==1 
        CAN_ADD = 0; 
        CAN_REMOVE = 0;
        columnEditable1 =  [false true true false true false true false true false true false true false true false];                     
        sysTable1 = aodHandles.tblStandardData;
        set(sysTable1,'ColumnEditable', columnEditable1);         
    elseif SELECTED_CELL(1)== sizeTblData(1)
        CAN_ADD = 1; 
        CAN_REMOVE = 0;
        columnEditable1 =  [false true true false true false true false true false true false true false true false];                     
        sysTable1 = aodHandles.tblStandardData;
        set(sysTable1,'ColumnEditable', columnEditable1);         
    else
        CAN_ADD = 1; 
        CAN_REMOVE = 1;  
        columnEditable1 =  [true true true false true false true false true false true false true false true false];                     
        sysTable1 = aodHandles.tblStandardData;
        set(sysTable1,'ColumnEditable', columnEditable1);  
    end
end
end

% --- Executes when selected cell(s) is changed in aodHandles.tblApertureData.
function tblApertureData_CellSelectionCallback(~, ~,~)
end
% --- Executes when selected cell(s) is changed in aodHandles.tblTiltDecenterData.
function tblTiltDecenterData_CellSelectionCallback(~, ~,~)
end


% Local functions
function setStandardDataTableColumnNames (aodHandles,surfaceType)
% Initialize the panel and table for standard data
    surfDefinition = surfaceType;
    surfaceDefinitionHandle = str2func(surfDefinition);
    returnFlag = 1;
    [fieldNames,fieldFormat,initialData] = surfaceDefinitionHandle(returnFlag);
    nColumns = size(fieldNames,2);
    columnNames = fieldNames;
    columnWidth = num2cell(100*ones(1,nColumns));
    columnEditable = num2cell(ones(1,nColumns));
    columnFormat = fieldFormat;
    
    hGetSupportedSurfaces = str2func('GetSupportedSurfaces');
    supportedSurfaces = hGetSupportedSurfaces();
    
    columnName1 =   {'Surface', 'Name/Note', 'Surface Type', '',...
       'Thickness', '', 'Glass', '','Coating', '',columnNames{:}};
    columnWidth1 = {80, 100, 120, 15, 80, 15, 80, 15, 80, 15,columnWidth{:}};
    columnEditable1 =  [false true true false true false true false true ...
        false columnEditable{:}];
    set(aodHandles.tblStandardData, 'ColumnFormat', ...
        {'char', 'char',{supportedSurfaces{:}},'char','numeric', 'char','char', 'char',...
        'char', 'char', columnFormat{:}});
    set(aodHandles.tblStandardData,'ColumnEditable', logical(columnEditable1),...
        'ColumnName', columnName1,'ColumnWidth',columnWidth1);
    
end



    %% Local Function
    function RemoveThisSurface(aodHandles)
        global SELECTED_CELL
        global CAN_REMOVE
        if isempty(SELECTED_CELL)
            return
        end

        if CAN_REMOVE
            removePosition = SELECTED_CELL(1);

            %update standard data table
            tblData1 = get(aodHandles.tblStandardData,'data');
            sizeTblData1 = size(tblData1);
            parta1 = tblData1(1:removePosition-1,:);
            partb1 = tblData1(removePosition+1:sizeTblData1 ,:);
            newTable1 = [parta1; partb1];
            sysTable1 = aodHandles.tblStandardData;
            set(sysTable1, 'Data', newTable1);

             %update aperture table
            tblData3 = get(aodHandles.tblApertureData,'data');
            sizeTblData3 = size(tblData3);
            parta3 = tblData3(1:removePosition-1,:);
            partb3 = tblData3(removePosition+1:sizeTblData3 ,:);
            newTable3 = [parta3; partb3];
            sysTable3 = aodHandles.tblApertureData;
            set(sysTable3, 'Data', newTable3);
   
             %update tilt decenter table
            tblData5 = get(aodHandles.tblTiltDecenterData,'data');
            sizeTblData5 = size(tblData5);
            parta5 = tblData5(1:removePosition-1,:);
            partb5 = tblData5(removePosition+1:sizeTblData5 ,:);
            newTable5 = [parta5; partb5];
            sysTable5 = aodHandles.tblTiltDecenterData;
            set(sysTable5, 'Data', newTable5);  
            
        end
    end


    function InsertNewSurface(aodHandles)
        global SELECTED_CELL
        global CAN_ADD
        if isempty(SELECTED_CELL)
            return
        end
        if CAN_ADD
            insertPosition = SELECTED_CELL(1);
            %update standard data table
            tblData1 = get(aodHandles.tblStandardData,'data');
            sizeTblData1 = size(tblData1);
            parta1 = tblData1(1:insertPosition-1,:);
            newRow1 =  {'Surf','','Standard','',[0],'','','','','',[Inf],[0],[0],[0],[0],[0],[0],[0],[0],[0]};
            partb1 = tblData1(insertPosition:sizeTblData1 ,:);
            newTable1 = [parta1; newRow1; partb1];
            sysTable1 = aodHandles.tblStandardData;
            set(sysTable1, 'Data', newTable1);

             %update aperture table
            tblData3 = get(aodHandles.tblApertureData,'data');
            sizeTblData3 = size(tblData3);
            parta3 = tblData3(1:insertPosition-1,:);
            newRow3 =  {'Surf','Standard','Floating','',[0],'',[0],'',[0],'',[0],'',[1],[0],false};
            partb3 = tblData3(insertPosition:sizeTblData3 ,:);
            newTable3 = [parta3; newRow3; partb3];
            sysTable3 = aodHandles.tblApertureData;
            set(sysTable3, 'Data', newTable3);

             %update tilt decenter table
            tblData5 = get(aodHandles.tblTiltDecenterData,'data');
            sizeTblData5 = size(tblData5);
            parta5 = tblData5(1:insertPosition-1,:);
            newRow5 =  {'Surf','Standard','DxDyDzTxTyTz','',[0],'',[0],'',[0],'',[0],'',[0],'','DAR',''};
            partb5 = tblData5(insertPosition:sizeTblData5 ,:);
            newTable5 = [parta5; newRow5; partb5];
            sysTable5 = aodHandles.tblTiltDecenterData;
            set(sysTable5, 'Data', newTable5);
            
            % If possible add here a code to select the first cell of newly added row
            % automatically
        end
    end 

function ret = checkTheCurrentSystemDefinitionType(aodHandles)
    
if get(aodHandles.popSystemDefinitionType,'Value') == 1
    ret = 1;
else
    choice = questdlg(['Your system is not defined using Surface',...
        ' Based method. Editing in the surface editor',...
        ' window automatically converts your system to Surface',...
        ' Based definition. Do you want to continue editing surface?'], ...
        'Change System Definition Type', ...
        'Yes','No','No');
    % Handle response
    switch choice
        case 'Yes'
            set(aodHandles.popSystemDefinitionType,'Value', 1);
            ret = 1;
        case 'No'
            ret = 0;
            return;
    end
end
end
