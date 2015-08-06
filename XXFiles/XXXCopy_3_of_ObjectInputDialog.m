function [ updatedObject ] = ObjectInputDialog(intialObjectHandle)
    %ObjectInputDialog Dialog window used to input the
    %general objects using uitables
    
    % assignin('caller', 'updatedObject', newObject)
    
    intialObject = intialObjectHandle.Data.Value;
    updatedObject = intialObject;
    warning('off','all')
    if nargin == 0
        disp('Error: The ObjectInputDialog needs atleast the current object to be updated.');
        updatedObject = NaN;
        return;
    elseif nargin == 1
        objectName = class(intialObjectHandle.Data.Value);
        fixedSize = 1;
        fontSize = 10;
        fontName = 'FixedSize';
    elseif nargin == 2
        fixedSize = 1;
        fontSize = 10;
        fontName = 'FixedSize';
    elseif nargin == 3
        fontSize = 10;
        fontName = 'FixedSize';        
    else
    end
    
     
%     objectHandle = objectHandleArray.Data.Value;
     objectHandle = intialObjectHandle;
%     objectHandle.Data.ParentHandle = parentHandle;
%     objectHandle.Data.Name = objectName;
    objectHandle.Data.InitialValue = intialObject;
%     objectHandle.Data.Value = intialObject;
%     objectHandle.Data.FixedSize = fixedSize;
    objectHandle.Data.InputGUI = struct();
    objectHandle.Data.InputGUI.FontSize = fontSize;
    objectHandle.Data.InputGUI.FontName = fontName;
    
%     if  length(objectHandle) > 1 %.Data,'InputGUI')
%         parentFigurePosition = get(objectHandle(end-1).Data.InputGUI.FigureHandle,'Position');
%         figSizeRed = 0.075;
%         figPosition = parentFigurePosition + ...
%         [parentFigurePosition(3)*(figSizeRed/2),parentFigurePosition(4)*(figSizeRed/2),...
%         -parentFigurePosition(3)*(figSizeRed),-parentFigurePosition(4)*(figSizeRed)];
%     else
%         figPosition = [0.3, 0.2, 0.4, 0.6];
%     end
    
    figPosition = [0.3, 0.2, 0.4, 0.6];
    
    % Create all UI controls
    objectHandle.Data.InputGUI.FigureHandle = figure( ...%
        'Tag', class(objectHandle.Data.Value), ...
        'Units', 'normalized', ...
        'Position',figPosition ,...
        'Name', objectHandle.Data.Name, ...
        'MenuBar', 'none', ...
        'NumberTitle', 'off', ...
        'Color', get(0,'DefaultUicontrolBackgroundColor'), ...
        'Resize', 'off','Visible','off');%,...
        %'WindowStyle','Modal');
    objectHandle.Data.InputGUI.btnOk = uicontrol( ...
        'Parent', objectHandle.Data.InputGUI.FigureHandle,...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style','pushbutton',...
        'Tag', 'btnOk', ...
        'String','OK',...
        'Units', 'Normalized', ...
        'Position', [0.55 0.01 0.2 0.07]);
    objectHandle.Data.InputGUI.btnCancel = uicontrol( ...
        'Parent', objectHandle.Data.InputGUI.FigureHandle,...
        'Units', 'Normalized', ...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'Style','pushbutton',...
        'Tag', 'btnCancel', ...
        'String','Cancel', ...
        'Position', [0.77 0.01 0.2 0.07]);
    
    % Add sliders to add/remove data in three dims and popmenu for
    % importing the workspace variables
    % check if the objectHandle.Data.FixedDimensions = [0,0,0]
    for k = 1:3
        objectHandle.Data.InputGUI.btnAdd(k) = uicontrol( ...
            'Parent', objectHandle.Data.InputGUI.FigureHandle,...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','pushbutton',...
            'visible', 'off', ...
            'String','+',...
            'Units', 'Normalized', ...
            'Position', [0.1+(k-1)*0.16 0.01 0.05 0.07]);
        objectHandle.Data.InputGUI.lblDimension(k) = uicontrol( ...
            'Parent', objectHandle.Data.InputGUI.FigureHandle,...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','text',...
            'visible', 'off', ...
            'Tag', 'lblDimension', ...
            'String',['D',num2str(k)],...
            'Units', 'Normalized', ...
            'Position', [0.06+(k-1)*0.16, 0.005, 0.04, 0.05]);
        objectHandle.Data.InputGUI.btnRemove(k) = uicontrol( ...
            'Parent', objectHandle.Data.InputGUI.FigureHandle,...
            'FontSize',fontSize,'FontName', 'FixedWidth',...
            'Style','pushbutton',...
            'visible', 'off', ...
            'String','-',...
            'Units', 'Normalized', ...
            'Position', [0.01+(k-1)*0.16 0.01 0.05 0.07]);
    end

    % display the current object
    displayObject(objectHandle);
    
    set(objectHandle.Data.InputGUI.btnOk,...
        'Callback', {@btnOk_Callback,objectHandle});
    set(objectHandle.Data.InputGUI.btnCancel,...
        'Callback', {@btnCancel_Callback,objectHandle});
    
    for k = 1:3
        set(objectHandle.Data.InputGUI.btnAdd(k),...
            'Callback', {@btnAdd_Callback,k,objectHandle});
        set(objectHandle.Data.InputGUI.btnRemove(k),...
            'Callback', {@btnRemove_Callback,k,objectHandle});
    end
    
    set(objectHandle.Data.InputGUI.FigureHandle,'Visible','on');
    
%     updatedObject = objectHandle.Data.Value;
end

function btnOk_Callback(~,~,objectHandle)
    objFigHandle = objectHandle.Data.InputGUI.FigureHandle; 
    newObject = saveObject(objectHandle);  
    assignin('caller', 'updatedObject', newObject);
%     if isnan(objectHandle.Data.Parent) 
%         % Has no parent to display data
%     else
%          displayObject(objectHandle.Data.ParentHandle);
%     end
%     objectHandle = objectHandle.Data.ParentHandle;
    % just close the window keeping all the changes that have been made
    % to the updatedObject handle
    delete(objFigHandle);   
end
function btnCancel_Callback(~,~,objectHandle)
    objFigHandle = objectHandle.Data.InputGUI.FigureHandle;
    % return the updated object handle to the original one
%     objectHandle = objectHandle.Data.ParentHandle;
    delete(objFigHandle);
end

function btnAdd_Callback(~,~,dimIndex,objectHandle)
%     objectHandle.Data.Value = saveObject(objectHandle);
    % Increase the size of the table in selected dims and intialize to
    % to the 1st value in that dims
    if dimIndex == 1
        objectHandle.Data.Value(end+1,:,:) = objectHandle.Data.Value(1,:,:) ;
    elseif dimIndex == 2
        objectHandle.Data.Value(:,end+1,:) = objectHandle.Data.Value(:,1,:) ;
    elseif dimIndex == 3
        objectHandle.Data.Value(:,:,end+1) = objectHandle.Data.Value(:,:,1) ;
    end
    displayObject(objectHandle);
%     assignin('caller', 'objectHandle', objectHandle);
end
function btnRemove_Callback(~,~,dimIndex,objectHandle)
%      objectHandle.Data.Value = saveObject(objectHandle);
    % Remove the last element in the given direction
    if dimIndex == 1 && size(objectHandle.Data.Value,1) > 1
        objectHandle.Data.Value(end,:,:) = [] ;
    elseif dimIndex == 2 && size(objectHandle.Data.Value,2) > 1
        objectHandle.Data.Value(:,end,:) =  [] ;
    elseif dimIndex == 3 && size(objectHandle.Data.Value,3) > 1
        objectHandle.Data.Value(:,:,end) =  [] ;
    end
    displayObject(objectHandle);
%     assignin('caller', 'objectHandle', objectHandle);    
end

function newObj = saveObject(objectHandle)
    % fill the uitable with initial object
%     [ objectDisplayTable,fieldsExist ] = getObjectDisplayTable( objectHandle.Data.Value,objectHandle.Data.FixedSize );
if isnumeric(objectHandle.Data.Value) || iscell(objectHandle.Data.Value)  || ischar(objectHandle.Data.Value)
            % save the current table values
%         [dim1,dim2,dim3] = size(objectHandle.Data.Value);
        dim3 = length(objectHandle.Data.InputGUI.tblProperties);
            for k = 1:dim3
                tempData = (get( objectHandle.Data.InputGUI.tblProperties(k),'data'));
                if isnumeric (tempData{1,1})
                    objectHandle.Data.Value(:,:,k) = cell2mat(tempData);
                elseif ischar (tempData{1,1})
                    objectHandle.Data.Value = tempData{:};
                else
                    objectHandle.Data.Value(:,:,k) = tempData(:,:);
                end
            end
%             newObj = objectHandle.Data.Value;
%         objectHandle.Data.InitialValue = objectHandle.Data.Value;
%     fieldName = objectHandle.Data.Name;
%     objectHandle.Data.ParentHandle.Data.Value.(fieldName) = objectHandle.Data.Value;           
else
   % each field has been saved iddividually
   
        
end
newObj = objectHandle.Data.Value;
end
function updatedObjectHandle = displayObject(objectHandle)
    % fill the uitable with initial object
    fontName = objectHandle.Data.InputGUI.FontName;
    fontSize = objectHandle.Data.InputGUI.FontSize;
    
    objectHandle.Data.InputGUI.TabGroup = uitabgroup(...
        'Parent', objectHandle.Data.InputGUI.FigureHandle, ...
        'Units', 'Normalized', ...
        'Position', [0 0.1 1 0.9]);
    
    [ objectDisplayTable,fieldsExist ] = getObjectDisplayTable( objectHandle.Data.Value,objectHandle.Data.FixedSize );
    if fieldsExist
        if objectHandle.Data.FixedSize
            % If the object has fixed size in all dimensions then just
            % display the fields of the current object
            nFields = size(objectDisplayTable,1);
            tempTableData = cell(nFields,4);
            tempTableData(:,1:3) = objectDisplayTable;
            tempTableData(:,4) = {'Edit'};
            objectHandle.Data.InputGUI.Tab(1) = ...
                uitab('Parent',objectHandle.Data.InputGUI.TabGroup,...
                'title',['Tab ',num2str(1)]);
            
            objectHandle.Data.InputGUI.tblProperties(1) =  uitable(...
                'Parent', objectHandle.Data.InputGUI.Tab(1),...
                'FontSize',fontSize,'FontName', fontName,...
                'units','normalized','Position',[0 0 1 1]);
            set(objectHandle.Data.InputGUI.tblProperties,...
                'data',tempTableData,...
                'ColumnWidth',{180,120,100,80},...
                'ColumnEditable',[false,false,false,false],...
                'ColumnName',{'Property Name','Property Type','Property Value','Edit'});
        else
            % If the object can be extended in one or more dimensions then
            % display Type of the object in ui table and visible buttons for
            % extension
            for k = 1:3
                set(objectHandle.Data.InputGUI.btnAdd(k),'visible','On');
                set(objectHandle.Data.InputGUI.lblDimension(k),'visible','On');
                set(objectHandle.Data.InputGUI.btnRemove(k),'visible','On');
            end
%             objType = objectHandle.Data.Type;
            % display the objType in the tblProperties which has size equal
            % to theat of
            [dim1,dim2,dim3] = size(objectDisplayTable);
            for k = 1:dim3
                objectHandle.Data.InputGUI.Tab(k) = ...
                    uitab('Parent',objectHandle.Data.InputGUI.TabGroup,...
                    'title',['Tab ',num2str(k)]);
                
                objectHandle.Data.InputGUI.tblProperties(k) =  uitable(...
                    'Parent', objectHandle.Data.InputGUI.Tab(k),...
                    'FontSize',fontSize,'FontName', fontName,...
                    'units','normalized','Position',[0 0 1 1]);
                tableData = objectDisplayTable(:,:,k);
                set( objectHandle.Data.InputGUI.tblProperties(k),...
                    'data',tableData);
            end
            
        end
    else
        % Datas other than User defined objects and structs are assumed to
        % be not fixed in all three dims
        for k = 1:3
            set(objectHandle.Data.InputGUI.btnAdd(k),'visible','On');
            set(objectHandle.Data.InputGUI.lblDimension(k),'visible','On');
            set(objectHandle.Data.InputGUI.btnRemove(k),'visible','On');
        end
        
        
        [dim1,dim2,dim3] = size(objectDisplayTable);
        for k = 1:dim3
            objectHandle.Data.InputGUI.Tab(k) = ...
                uitab('Parent',objectHandle.Data.InputGUI.TabGroup,...
                'title',['Tab ',num2str(k)]);
            
            objectHandle.Data.InputGUI.tblProperties(k) =  uitable(...
                'Parent', objectHandle.Data.InputGUI.Tab(k),...
                'FontSize',fontSize,'FontName', fontName,...
                'units','normalized','Position',[0 0 1 1]);
            tableData = objectDisplayTable(:,:,k);
            set( objectHandle.Data.InputGUI.tblProperties(k),...
                'data',tableData);
        end
    end
    
     set(objectHandle.Data.InputGUI.tblProperties,...
        'CellEditCallback',{@tblProperties_CellEditCallback,objectHandle},...
        'CellSelectionCallback',{@tblProperties_CellSelectionCallback,objectHandle});  
    updatedObjectHandle = objectHandle;
end

% --- Executes when selected cell(s) is changed in aodHandles.tblComponentLis.
function tblProperties_CellSelectionCallback(~, eventdata,objectHandle)
    selectedCellIndex = eventdata.Indices;
    if ~isempty(selectedCellIndex)
        selectedRow = selectedCellIndex(1,1);
        selectedCol = selectedCellIndex(1,2);
    else
        return;
    end
    
    [ objectDisplayTable,fieldsExist ] = getObjectDisplayTable( objectHandle.Data.Value,objectHandle.Data.FixedSize );
    if fieldsExist
        if selectedCol== 4 % Edit column clicked
            tblData = get(objectHandle.Data.InputGUI.tblProperties,'data');
            propertyName = tblData{selectedRow,1};
            
            initialObject = objectHandle.Data.Value.(propertyName);
            objectName = propertyName; inputdlg
            fixedSize = 0;
            
            initialObjectHandle = MyHandle();
            initialObjectHandle.Data.Value = initialObject;
            initialObjectHandle.Data.Name = objectName;
            initialObjectHandle.Data.FixedSize = fixedSize;
            
            objectHandle.Data.Value.(propertyName) =  ObjectInputDialog(initialObjectHandle);
            
%             propertyType = tblData{selectedRow,2};
%             objectHandle(end+1) = MyHandle();
%             objectHandle = objectHandle(end-1).Data;
%             objectHandle.Data.Name = propertyName;
%             objectHandle.Data.Type = propertyType;
%             
%             
%             objectHandle.Data.Value(subCell{:}) = objectHandle(end-1).Data.Value(subCell{:}).(propertyName);
%             
%             objectHandle.Data.ParentHandle = objectHandle(end-1);
%             objectHandle.Data.FixedSize = 0;
%             objectHandle.Data.InputGUI = struct();
%             ObjectInputDialog(objectHandle);
        end
    else
        if isnumeric(objectHandle.Data.Value(selectedRow,selectedCol)) || ...
                iscell(objectHandle.Data.Value(selectedRow,selectedCol)) ||...
                ischar(objectHandle.Data.Value(selectedRow,selectedCol))
            % just make the table columns editable
            for k = 1:length(objectHandle.Data.InputGUI.tblProperties)
                set( objectHandle.Data.InputGUI.tblProperties(k),...
                'ColumnEditable',[true]);
            end
        else
%             subCell = num2cell(objectHandle.Data.CurrentIndices);
            initialObject = objectHandle.Data.Value(selectedRow,selectedCol);
            objectName = objectHandle.Data.Name;
            fixedSize = 1;
            
            initialObjectHandle = MyHandle();
            initialObjectHandle.Data.Value = initialObject;
            initialObjectHandle.Data.Name = objectName;
            initialObjectHandle.Data.FixedSize = fixedSize;
            
            objectHandle.Data.Value(subCell{:}) =  ObjectInputDialog(initialObjectHandle);
            
%             objectHandle(end+1) = MyHandle();
%             tempChildObjectValue = objectHandle(end-1).Data.Value(selectedRow,selectedCol);
%             tempChildObjectValue = objectHandle.Data.Value(selectedRow,selectedCol);
%             [objType,objValDisp] = getObjectTypeValueDisplay(tempChildObjectValue);
%             objectHandle.Data.Name = objType{:};
%             objectHandle.Data.Type = objType{:};
%             objectHandle.Data.Value = tempChildObjectValue;
%             objectHandle.Data.ParentHandle = objectHandle(end-1);
%             objectHandle.Data.FixedSize = 1;
%             objectHandle.Data.InputGUI = struct();
%         objectHandle.Data.CurrentIndices = [selectedRow,selectedCol];
%             ObjectInputDialog(objectHandle);
        end
    end
    
end
% --- Executes when entered data in editable cell(s) in aodHandles.tblComponentLis.
function tblProperties_CellEditCallback(~, eventdata,objectHandle)
    
end
