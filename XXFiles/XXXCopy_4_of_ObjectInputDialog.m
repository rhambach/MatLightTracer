function [ updatedProperty, currentHandle] = ObjectInputDialog(currentHandle,parentHandle)
    %ObjectInputDialog Dialog window used to input the
    %general objects using uitables
    initialObject = currentHandle.Data.Value;
    updatedProperty = initialObject;
    figPosition = [0.3, 0.2, 0.4, 0.6];
    warning('off','all')
    if nargin == 0
        disp('Error: The ObjectInputDialog needs atleast the current object to be updated.');
        updatedProperty = NaN;
        return;
    elseif nargin == 1
        parentHandle = NaN;
        fontSize = 10;
        fontName = 'FixedSize';
    else
        fontSize = get(parentHandle.Data.btnOk,'FontSize');
        fontName = get(parentHandle.Data.btnOk,'FontName');
    end
    
    currentHandle.Data.InputGUI = dialog ( ...
        'Tag', 'InputGUI', ...
        'Units', 'normalized', ...
        'Position',figPosition ,...
        'Name', class(initialObject), ...
        'MenuBar', 'none', ...
        'NumberTitle', 'off', ...
        'Color', get(0,'DefaultUicontrolBackgroundColor'), ...
        'Resize', 'off','Visible','off',...
        'WindowStyle','Modal');

    currentHandle.Data.ParentHandle = parentHandle;
    currentHandle.Data.btnOk = uicontrol( ...
        'Parent', currentHandle.Data.InputGUI,...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style','pushbutton',...
        'Tag', 'btnOk', ...
        'String','OK',...
        'Units', 'Normalized', ...
        'Position', [0.55 0.01 0.2 0.07]);
    currentHandle.Data.btnCancel = uicontrol( ...
        'Parent', currentHandle.Data.InputGUI,...
        'Units', 'Normalized', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style','pushbutton',...
        'Tag', 'btnCancel', ...
        'String','Cancel', ...
        'Position', [0.77 0.01 0.2 0.07]);
    
    for k = 1:3
        currentHandle.Data.btnAdd(k) = uicontrol( ...
            'Parent', currentHandle.Data.InputGUI,...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','pushbutton',...
            'Tag', 'btnAdd', ...
            'visible', 'off', ...
            'String','+',...
            'Units', 'Normalized', ...
            'Position', [0.1+(k-1)*0.16 0.01 0.05 0.07]);
        currentHandle.Data.lblDimension(k) = uicontrol( ...
            'Parent', currentHandle.Data.InputGUI,...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','text',...
            'visible', 'off', ...
            'Tag', 'lblDimension', ...
            'String',['D',num2str(k)],...
            'Units', 'Normalized', ...
            'Position', [0.06+(k-1)*0.16, 0.005, 0.04, 0.05]);
        currentHandle.Data.btnRemove(k) = uicontrol( ...
            'Parent', currentHandle.Data.InputGUI,...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','pushbutton',...
            'Tag', 'btnRemove', ...
            'visible', 'off', ...
            'String','-',...
            'Units', 'Normalized', ...
            'Position', [0.01+(k-1)*0.16 0.01 0.05 0.07]);
    end
    
    displayObject(currentHandle);
    
    set(currentHandle.Data.btnOk,...
        'Callback', {@btnOk_Callback,currentHandle});
    set(currentHandle.Data.btnCancel,...
        'Callback', {@btnCancel_Callback,currentHandle});
    
    for k = 1:3
        set(currentHandle.Data.btnAdd(k),...
            'Callback', {@btnAdd_Callback,k,currentHandle});
        set(currentHandle.Data.btnRemove(k),...
            'Callback', {@btnRemove_Callback,k,currentHandle});
    end

    set(currentHandle.Data.InputGUI,'Visible','on');
    drawnow;
    
    if ishghandle(currentHandle.Data.InputGUI)
        % Go into uiwait if the figure handle is still valid.
        % This is mostly the case during regular use.
        currentHandle.Data.Value
        uiwait(currentHandle.Data.InputGUI);       
    end
        
    % Check handle validity again since we may be out of uiwait because the
    % figure was deleted.
    if ishghandle(currentHandle.Data.InputGUI)
        if strcmpi(get(currentHandle.Data.InputGUI,'UserData'),'OK')
            % Code to save the current object
            updatedProperty = saveCurrentProperty(currentHandle);
            delete(currentHandle.Data.InputGUI);
            if strcmpi(class(currentHandle.Data.ParentHandle),'MyHandle')
                displayObject(currentHandle.Data.ParentHandle);
            end
            currentHandle = currentHandle.Data.ParentHandle;
        elseif strcmpi(get(currentHandle.Data.InputGUI,'UserData'),'Cancel')
            delete(currentHandle.Data.InputGUI);
            if strcmpi(class(currentHandle.Data.ParentHandle),'MyHandle')
                displayObject(currentHandle.Data.ParentHandle);
            end
            currentHandle = currentHandle.Data.ParentHandle;
        end       
    else        
    end
end

function btnOk_Callback(~,~,currentHandle)
    set(currentHandle.Data.InputGUI,'UserData','OK');
    uiresume(currentHandle.Data.InputGUI);
end
function btnCancel_Callback(~,~,currentHandle)
    set(currentHandle.Data.InputGUI,'UserData','Cancel');
    uiresume(currentHandle.Data.InputGUI);
end



function btnAdd_Callback(~,~,dimIndex,currentHandle)
    % Increase the size of the table in selected dims and intialize to
    % to the 1st value in that dims
    currentObject = currentHandle.Data.Value;
    if dimIndex == 1
        currentObject(end+1,:,:) = currentObject(1,:,:) ;
    elseif dimIndex == 2
        currentObject(:,end+1,:) = currentObject(:,1,:) ;
    elseif dimIndex == 3
        currentObject(:,:,end+1) = currentObject(:,:,1) ;
    end
    currentHandle.Data.Value = currentObject;
    displayObject(currentHandle);
end
function btnRemove_Callback(~,~,dimIndex,currentHandle)
    % Remove the last element in the given direction#
    currentObject = currentHandle.Data.Value;
    if dimIndex == 1 && size(currentObject,1) > 1
        currentObject(end,:,:) = [] ;
    elseif dimIndex == 2 && size(currentObject,2) > 1
        currentObject(:,end,:) =  [] ;
    elseif dimIndex == 3 && size(currentObject,3) > 1
        currentObject(:,:,end) =  [] ;
    end
    currentHandle.Data.Value = currentObject;
    displayObject(currentHandle);
end

function newProperty = saveCurrentProperty(currentHandle)
    initialProperty = currentHandle.Data.Value;
    % fill the uitable with initial object
    if isnumeric(initialProperty) || iscell(initialProperty)  || ischar(initialProperty)
        % save the current table values
        dim3 = length(currentHandle.Data.tblProperties);
        for k = 1:dim3
            tempData = (get( currentHandle.Data.tblProperties(k),'data'));
            if isnumeric (tempData{1,1})
                newProperty(:,:,k) = cell2mat(tempData);
            elseif ischar (tempData{1,1})
                newProperty = tempData{:};
            else
                newProperty(:,:,k) = tempData(:,:);
            end
        end
    else
        % each field has been saved iddividually
        newProperty =  initialProperty ;       
    end
    currentHandle.Data.Value = newProperty;
    propertyName = currentHandle.Data.Name;
    currentHandle.Data.ParentHandle.Data.Value.(propertyName) = newProperty;
end
function displayObject(currentHandle)
    % fill the uitable with initial object
    fontName = get(currentHandle.Data.btnOk,'FontName');
    fontSize = get(currentHandle.Data.btnOk,'FontSize');
    
    currentHandle.Data.TabGroup = uitabgroup(...
        'Parent', currentHandle.Data.InputGUI, ...
        'Units', 'Normalized', ...
        'Position', [0 0.1 1 0.9]);
    
    [ objectDisplayTable,fieldsExist ] = getObjectDisplayTable(currentHandle);
    if fieldsExist
        if (currentHandle.Data.FixedSize)
            % If the object has fixed size in all dimensions then just
            % display the fields of the current object
            nFields = size(objectDisplayTable,1);
            tempTableData = cell(nFields,4);
            tempTableData(:,1:3) = objectDisplayTable;
            tempTableData(:,4) = {'Edit'};
            currentHandle.Data.Tab(1) = ...
                uitab('Parent',currentHandle.Data.TabGroup,...
                'title',['Tab ',num2str(1)]);
            
            currentHandle.Data.tblProperties(1) =  uitable(...
                'Parent', currentHandle.Data.Tab(1),...
                'FontSize',fontSize,'FontName', fontName,...
                'units','normalized','Position',[0 0 1 1]);
            set(currentHandle.Data.tblProperties,...
                'data',tempTableData,...
                'ColumnWidth',{180,120,100,80},...
                'ColumnEditable',[false,false,false,false],...
                'ColumnName',{'Property Name','Property Type','Property Value','Edit'});
        else
            % If the object can be extended in one or more dimensions then
            % display Type of the object in ui table and visible buttons for
            % extension
            for k = 1:3
                set(currentHandle.Data.btnAdd(k),'visible','On');
                set(currentHandle.Data.lblDimension(k),'visible','On');
                set(currentHandle.Data.btnRemove(k),'visible','On');
            end
            % display the objType in the tblProperties which has size equal
            % to theat of
            [dim1,dim2,dim3] = size(objectDisplayTable);
            for k = 1:dim3
                currentHandle.Data.Tab(k) = ...
                    uitab('Parent',currentHandle.Data.TabGroup,...
                    'title',['Tab ',num2str(k)]);
                
                currentHandle.Data.tblProperties(k) =  uitable(...
                    'Parent', currentHandle.Data.Tab(k),...
                    'FontSize',fontSize,'FontName', fontName,...
                    'units','normalized','Position',[0 0 1 1]);
                tableData = objectDisplayTable(:,:,k);
                set( currentHandle.Data.tblProperties(k),...
                    'data',tableData);
            end
            
        end
    else
        % Datas other than User defined objects and structs are assumed to
        % be not fixed in all three dims
        for k = 1:3
            set(currentHandle.Data.btnAdd(k),'visible','On');
            set(currentHandle.Data.lblDimension(k),'visible','On');
            set(currentHandle.Data.btnRemove(k),'visible','On');
        end        
        
        [dim1,dim2,dim3] = size(objectDisplayTable);
        for k = 1:dim3
            currentHandle.Data.Tab(k) = ...
                uitab('Parent',currentHandle.Data.TabGroup,...
                'title',['Tab ',num2str(k)]);
            
            currentHandle.Data.tblProperties(k) =  uitable(...
                'Parent', currentHandle.Data.Tab(k),...
                'FontSize',fontSize,'FontName', fontName,...
                'units','normalized','Position',[0 0 1 1]);
            tableData = objectDisplayTable(:,:,k);
            set( currentHandle.Data.tblProperties(k),...
                'data',tableData);
        end
    end
    
    set(currentHandle.Data.tblProperties,...
        'CellEditCallback',{@tblProperties_CellEditCallback,currentHandle},...
        'CellSelectionCallback',{@tblProperties_CellSelectionCallback,currentHandle});
end

% --- Executes when selected cell(s) is changed in aodHandles.tblComponentLis.
function tblProperties_CellSelectionCallback(~, eventdata,currentHandle)
    selectedCellIndex = eventdata.Indices;
    if ~isempty(selectedCellIndex)
        selectedRow = selectedCellIndex(1,1);
        selectedCol = selectedCellIndex(1,2);
    else
        return;
    end
    
    [ objectDisplayTable,fieldsExist ] = getObjectDisplayTable( currentHandle );
    if fieldsExist 
        % For Objects and Structs of fixed size
        if selectedCol== 4 
            % Edit column clicked
            parentHandle = MyHandle();
            parentHandle.Data = currentHandle.Data;            
            tblData = get(parentHandle.Data.tblProperties,'data');
            propertyName = tblData{selectedRow,1};            
            allProperties = parentHandle.Data.Value;
            selectedProperty = allProperties.(propertyName);
            currentHandle.Data.Value = selectedProperty;
            currentHandle.Data.Name = propertyName;
            currentHandle.Data.FixedSize = 0;
            [newProperty,currentHandle] = ObjectInputDialog(currentHandle,parentHandle);
            currentHandle.Data.Value.(propertyName) = newProperty;
        end
    else
        % For non fixed data (numeric, char, Objects and Structs)
        % Additional fields can be added in three dimensions
        initialPropertyArray = currentHandle.Data.Value;
        initialProperty = initialPropertyArray(selectedRow,selectedCol);
        if isnumeric(initialProperty) || iscell(initialProperty) ||...
                ischar(initialProperty)
            % just make the table columns editable
            for k = 1:length(currentHandle.Data.tblProperties)
                set( currentHandle.Data.tblProperties(k),...
                    'ColumnEditable',[true]);
            end
        else
            % For non fixed structs and objects
            parentHandle = MyHandle();
            parentHandle.Data = currentHandle.Data;                      
            allProperties = parentHandle.Data.Value;
            selectedProperty = allProperties(selectedRow,selectedCol);
            currentHandle.Data.Value = selectedProperty;
            currentHandle.Data.FixedSize = 1;
            [newProperty,currentHandle] = ObjectInputDialog(currentHandle,parentHandle);
            currentHandle.Data.Value(selectedRow,selectedCol) = newProperty;            
        end
    end    
end
% --- Executes when entered data in editable cell(s) in aodHandles.tblComponentLis.
function tblProperties_CellEditCallback(~, eventdata,handles)
    
end
