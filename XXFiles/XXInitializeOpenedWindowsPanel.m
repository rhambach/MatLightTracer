function InitializeOpenedWindowsPanel(parentWindow)
% InitializeOpenedWindowsPanel: Define and initialized the uicontrols of the 
% opened window panel
% Member of AODParentWindow class

    aodHandles = parentWindow.AODParentHandles; 
    fontSize = aodHandles.FontSize;
    aodHandles.tblOpenedWindowsList = uitable(...
        'Parent',aodHandles.panelOpenedWindows,...
        'FontSize',fontSize,'FontName', 'FixedWidth',...
        'units','normalized',...
        'Position',[0 0 1 1]);    
    columnName1 =   {'------ Windows Name  ------','Unique Id'};
    ColumnFormat1 = {'char','numeric'};
    columnWidth1 = {'auto',0};
    rowName1 = {'numbered'};
    columnEditable1 =  [false,false];

    set(aodHandles.tblOpenedWindowsList, ...% 'Data', initialTable1,...
        'ColumnEditable', columnEditable1,...
        'ColumnName', columnName1,...
        'ColumnWidth',columnWidth1,...
        'RowName',rowName1,...
        'ButtonDownFcn',{@tblOpenedWindowsList_ButtonDownFcn,aodHandles},...
        'CellSelectionCallback',{@tblOpenedWindowsList_CellSelectionCallback,aodHandles});
    
    % --- Executes when entered data in editable cell(s) in aodHandles.tblOpenedWindowsList.
    function tblOpenedWindowsList_ButtonDownFcn(~, ~,~)

    end
    % --- Executes when selected cell(s) is changed in aodHandles.tblOpenedWindowsList.
    function tblOpenedWindowsList_CellSelectionCallback(~, eventdata,aodHandles)
          selCell = eventdata.Indices;
          if ~isempty(selCell) 
             selRow = selCell(1,1);
             selCol = selCell(1,2);
             if selCol == 1 % Window name column clicked
                 tblData1 = get(aodHandles.tblOpenedWindowsList,'data');
                 childIndex = tblData1{selRow,2};
                 childWin = findChild(parentWindow,childIndex);
                 if strcmpi(get(childWin.AODChildHandles.FigureHandle,'Visible'),'on')
                      figure(childWin.AODChildHandles.FigureHandle);
                 end
              end

          end
    end
parentWindow.AODParentHandles = aodHandles;
end

