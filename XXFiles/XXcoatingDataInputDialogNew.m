function [ figureHandle ] = coatingDataInputDialogNew(referenceWavelength,coatingCatalogueListFullNames,fontName,fontSize)
    %COATINGDATAINPUTDIALOG Defines a dilog box which is used to input coating
    % data based on its type. And returns a coating object constructed from the
    % input data.
    
    % Default Input
    if nargin < 1
        % Used as primary wavelength for relative thickness values
        referenceWavelength = 0.55*10^-6;
        % Get all catalogues from current folder
        coatingCatalogueListFullNames = getAllObjectCatalogues('coating');
        fontSize = 9.5;
        fontName = 'FixedWidth';
    elseif nargin < 2
        % Get all catalogues from current folder
        coatingCatalogueListFullNames = getAllObjectCatalogues('coating');
        fontSize = 9.5;
        fontName = 'FixedWidth';
    elseif nargin == 2
        fontSize = 9.5;
        fontName = 'FixedWidth';
    elseif nargin == 3
        fontName = 'FixedWidth';
    end
    
    if isempty(coatingCatalogueListFullNames)
        figureHandle = NaN;
        disp('Error: No coating catalogue is found in the current folder.');
        return;
    else
        [~,catalogueListFileNames,~] = cellfun(@(x) fileparts(x),...
            coatingCatalogueListFullNames,'UniformOutput',false);
        % extract the first catalogue and first coating from the catalogue
        firstCatalogueCoatingArray = extractObjectFromObjectCatalogue...
            ('coating','all',coatingCatalogueListFullNames{1});
        firstCatalogueCoatingNames =  {firstCatalogueCoatingArray.Name};
    end
    % Initialize handles structure
    handles = struct();
    handles.FirstCatalogueFullName =  coatingCatalogueListFullNames{1};
    
    coatingObj = Coating;
    % Create all UI controls
    build_gui();
    
    % Assign function output
    figureHandle = handles.FigureHandle;
    function build_gui()
        % Creation of all uicontrols
        % --- FIGURE -------------------------------------
        handles.FigureHandle = figure( ...
            'Tag', 'FigureHandle', ...
            'Units','Normalized',...
            'Position', [0.3,0.3,0.5,0.5], ...
            'Name', 'Coating Data Entry', ... %'WindowStyle','Modal',...
            'MenuBar', 'none', ...
            'NumberTitle', 'off', ...
            'Color', get(0,'DefaultUicontrolBackgroundColor'));
        
        % Panel with fixed size is used as window visible while using the
        % slider to scroll through the uicontrols.
        handles.panelCoatingParametersTop = uipanel( ...
            'Parent', handles.FigureHandle, ...
            'Tag', 'panelCoatingParametersTop', ...
            'Units','Normalized',...
            'Position', [0.45,0.12,0.53,0.85], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'Title','Coating Parameters');%,...
        
        handles.panelCoatingListing = uipanel( ...
            'Parent', handles.FigureHandle, ...
            'Tag', 'panelCoatingListing', ...
            'Units','Normalized',...
            'Position', [0.02,0.02,0.43,0.94], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'Visible','On');
        
        % -----------------------------------------------------------------
        handles.lblCoatingCatalogueName = uicontrol( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'lblCoatingCatalogueName', ...
            'Style', 'text', ...
            'HorizontalAlignment','left',...
            'Units','Normalized',...
            'Position', [0.02,0.9,0.48,0.05], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'String', 'Catalogue Name');
        
        handles.popCoatingCatalogueName = uicontrol( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'popCoatingCatalogueName', ...
            'Style', 'popupmenu', ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'HorizontalAlignment','left',...
            'Units','Normalized',...
            'Position', [0.50,0.9,0.48,0.055], ...
            'BackgroundColor', [1 1 1],...
            'String',catalogueListFileNames);
        
        %-----------------------------------------------------------------
        
        handles.lblCoatingName = uicontrol( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'lblCoatingName', ...
            'Style', 'text', ...
            'HorizontalAlignment','left',...
            'Units','Normalized',...
            'Position', [0.02,0.8,0.48,0.05], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'String', 'Coating Name');
        
        
        handles.txtCoatingName = uicontrol( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'txtCoatingName', ...
            'Style', 'edit', ...
            'HorizontalAlignment','left',...
            'Units','Normalized',...
            'Position', [0.50,0.80,0.48,0.05], ...
            'BackgroundColor', [1 1 1], ...
            'String', 'CoatingName', ...
            'fontSize',fontSize,'FontName',fontName);
        % -----------------------------------------------------------------
        handles.lblCoatingType = uicontrol( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'lblCoatingType', ...
            'Style', 'text', ...
            'HorizontalAlignment','left',...
            'Units','Normalized',...
            'Position', [0.02,0.7,0.48,0.05], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'String', 'Coating Type');
        
        handles.popCoatingType = uicontrol( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'popCoatingType', ...
            'Style', 'popupmenu', ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'HorizontalAlignment','left',...
            'Units','Normalized',...
            'Position', [0.50,0.7,0.48,0.055], ...
            'BackgroundColor', [1 1 1],...
            'String',{'None','BareGlass','Multilayer','JonesMatrix'},...
            'Value',1);
        
        %-----------------------------------------------------------------
        handles.tblCoatingList = uitable( ...
            'Parent', handles.panelCoatingListing, ...
            'Tag', 'tblCoatingList', ...
            'Units','Normalized',...
            'Position', [0.02,0.02,0.96,0.65], ...
            'fontSize',fontSize,'FontName',fontName,...
            'BackgroundColor', [1 1 1;0.961 0.961 0.961], ...
            'ColumnEditable', [false], ...
            'ColumnFormat', {'char'}, ...
            'ColumnName', {'Coating Names'}, ...
            'ColumnWidth', {220}, ...
            'RowName', 'numbered',...
            'Data',firstCatalogueCoatingNames');
        %-------------------------------------------------------------------
        % Callbacks
        set(handles.popCoatingCatalogueName,...
            'Callback',{@popCoatingCatalogueName_Callback,handles});
        set(handles.popCoatingType,...
            'Callback',{@popCoatingType_Callback,handles});
        set(handles.tblCoatingList,...
            'CellSelectionCallback',{@tblCoatingList_CellSelectionCallback,handles});
        
        handles.cmdDeleteCoating = uicontrol( ...
            'Parent', handles.FigureHandle, ...
            'Tag', 'cmdDeleteCoating', ...
            'Style', 'pushbutton', ...
            'Units','Normalized',...
            'Position', [0.45,0.02,0.12,0.065], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'String', 'Delete', ...
            'Callback', {@cmdDeleteCoating_Callback,handles});
        handles.cmdSaveCoating = uicontrol( ...
            'Parent', handles.FigureHandle, ...
            'Tag', 'cmdSaveCoating', ...
            'Style', 'pushbutton', ...
            'Units','Normalized',...
            'Position', [0.59,0.02,0.12,0.065], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'String', 'Save', ...
            'Callback', {@cmdSaveCoating_Callback,handles});
        handles.cmdOk = uicontrol( ...
            'Parent', handles.FigureHandle, ...
            'Tag', 'cmdOk', ...
            'Style', 'pushbutton', ...
            'Units','Normalized',...
            'Position', [0.73,0.02,0.12,0.065], ...
            'fontSize',fontSize,...
            'FontName',fontName,...
            'String', 'Ok', ...
            'Callback', {@cmdOk_Callback,handles});
        handles.cmdCancel = uicontrol( ...
            'Parent', handles.FigureHandle, ...
            'Tag', 'cmdCancel', ...
            'Style', 'pushbutton', ...
            'Units','Normalized',...
            'Position', [0.87,0.02,0.12,0.065], ...
            'fontSize',fontSize,'FontName',fontName,...
            'String', 'Cancel', ...
            'Callback', {@cmdCancel_Callback,handles});
        
        % Display the first coating data
        % extract the selected coating from the catalogue
        selectedCatalogueFullName = coatingCatalogueListFullNames{get(handles.popCoatingCatalogueName,'Value')};
        catalogueCoatingArray = extractObjectFromObjectCatalogue...
            ('coating','all',selectedCatalogueFullName);
        if isempty(catalogueCoatingArray)
            catalogueCoatingArray = Coating;
            selectedCoatingObject = catalogueCoatingArray;
        else
            selectedCoatingObject = catalogueCoatingArray(1);
        end
        
        
        coatingType = selectedCoatingObject.Type;
        coatingParameters = selectedCoatingObject.CoatingParameters;
        handles = displayCoatingParameters(handles,coatingType,coatingParameters);
        
    end

    %% ---------------------------------------------------------------------------
    function popCoatingCatalogueName_Callback(~,~,handles )
        handles = refreshCoatingDataInputDialog(handles);
        handles.
    end
    
    function updatedHandles = refreshCoatingDataInputDialog(handles)
        selectedCatalogueFullName = coatingCatalogueListFullNames{get(handles.popCoatingCatalogueName,'Value')};
        % extract the selected catalogue and coating from the catalogue
        selectedCatalogueCoatingArray = extractObjectFromObjectCatalogue...
            ('coating','all',selectedCatalogueFullName);
        selectedCatalogueCoatingNames =  {selectedCatalogueCoatingArray.Name};
        set(handles.tblCoatingList,'Data',selectedCatalogueCoatingNames');
        
        selectedCoatingObject = selectedCatalogueCoatingArray(1);
        
        coatingType = selectedCoatingObject.Type;
        coatingParameters = selectedCoatingObject.CoatingParameters; 
        handles = displayCoatingParameters(handles,coatingType,coatingParameters);
        
        updatedHandles = handles;
    end
    
    
    %% ---------------------------------------------------------------------------
    
    
    function tblCoatingList_CellSelectionCallback(hObject,eventdata,handles)
        selCell = eventdata.Indices;
        if ~isempty(selCell)
            selRow = selCell(1,1);
            selCol = selCell(1,2);
            selectedCoatingIndex = selRow;
            selectedCatalogueFullName = coatingCatalogueListFullNames...
                {get(handles.popCoatingCatalogueName,'Value')};
            
            % extract the selected coating from the catalogue
            catalogueCoatingArray = extractObjectFromObjectCatalogue...
                ('coating','all',selectedCatalogueFullName);
            if isempty(catalogueCoatingArray)
                catalogueCoatingArray = Coating;
                selectedCoatingObject = catalogueCoatingArray;
            else
                selectedCoatingObject = catalogueCoatingArray(selectedCoatingIndex);
            end
            
            coatingType = selectedCoatingObject.Type;
            coatingParameters = selectedCoatingObject.CoatingParameters;
            handles = displayCoatingParameters(handles,coatingType,coatingParameters);
        end
    end
    
    function updatedHandles = displayCoatingParameters(handles,coatingType,coatingParameters)
        
        if nargin == 0
            disp('Error: The function displayCoatingParameters requires atleast two inputs.');
            updatedHandles = NaN;
            return;
        elseif nargin == 1
            disp('Error: The function displayCoatingParameters requires atleast two inputs.');
            updatedHandles = handles;
            return;
        else
            % connect to coating defintion file and use defualt coating parameter
            coatingDefinitionHandle = str2func(coatingType);
            returnFlag = 1; % coating parameters fields and default values
            [ coatingParameterFields,coatingParameterFormats,defaultCoatingparameters] = ...
                coatingDefinitionHandle(returnFlag);
            if nargin == 2
                coatingParameters = defaultCoatingparameters;
            elseif nargin == 3
                
            end
        end
        
        fontSize = 11;
        fontName = 'FixedWidth';
        
        nPar = length(coatingParameterFields);
        % Clear the panelCoatingParameters
        delete(get(handles.panelCoatingParametersTop,'Child'));
        
        % Handle the multilayer cooating in special case
        if strcmpi(coatingType,'MultilayerCoating')
            handles.panelMultilayerData = uipanel( ...
                'Parent', handles.panelCoatingParametersTop, ...
                'Tag', 'panelMultilayerData', ...
                'Units','Normalized',...
                'Position', [0.0,0.0,1.0,1.0], ...
                'fontSize',fontSize,...
                'FontName',fontName);
            
            
            handles.lblReferenceWavelength = uicontrol( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'lblReferenceWavelength', ...
                'Style', 'text', ...
                'HorizontalAlignment','left',...
                'Units','Normalized',...
                'Position', [0.0,0.75,0.4,0.1], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Reference Wavelength');
            
            handles.txtReferenceWavelength = uicontrol( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'txtReferenceWavelength', ...
                'Style', 'edit', ...
                'HorizontalAlignment','left',...
                'Units','Normalized',...
                'Position', [0.4,0.81,0.27,0.05], ...
                'BackgroundColor', [1 1 1], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', num2str(referenceWavelength),...
                'Enable','Off');
            
            
            handles.chkReverse = uicontrol( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'chkReverse', ...
                'Style', 'checkbox', ...
                'Units','Normalized',...
                'Position', [0.7,0.78,0.3,0.1], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Revese Order',...
                'Value',logical(0));
            
            %-----------------------------------------------------------------
            handles.cmdClearAll = uicontrol( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'cmdClearAll', ...
                'Style', 'pushbutton', ...
                'Units','Normalized',...
                'Position', [0.02,0.9,0.3,0.07], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Clear All', ...
                'Callback', {@cmdClearAll_Callback,handles});
            handles.cmdAddRow = uicontrol( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'cmdAddRow', ...
                'Style', 'pushbutton', ...
                'Units','Normalized',...
                'Position', [0.35,0.9,0.3,0.07], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Add (+)', ...
                'Callback', {@cmdAddRow_Callback,handles});
            handles.cmdRemoveRow = uicontrol( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'cmdRemoveRow', ...
                'Style', 'pushbutton', ...
                'Units','Normalized',...
                'Position', [0.67,0.9,0.3,0.07], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Remove (-)', ...
                'Callback', {@cmdRemoveRow_Callback,handles});
            
            handles.tblMultilayerStack = uitable( ...
                'Parent', handles.panelMultilayerData, ...
                'Tag', 'tblMultilayerStack', ...
                'UserData', zeros(1,0), ...
                'Units','Normalized',...
                'Position', [0.02,0.05,0.96,0.7], ...
                'fontSize',fontSize,'FontName',fontName,...
                'BackgroundColor', [1 1 1;0.961 0.961 0.961], ...
                'ColumnEditable', [true,true,true], ...
                'ColumnFormat', {'char','numeric','logical'}, ...
                'ColumnName', {'Glass','Thickness','Relative'}, ...
                'ColumnWidth', {150,100,70}, ...
                'RowName', 'numbered');
            
            coatingNames = {coatingParameters.GlassArray.Name}';
            coatingThickness = {coatingParameters.Thickness}';
            coatingRelativeThickness = {coatingParameters.RelativeThickness}';
            
            tableData = [coatingNames,coatingThickness,coatingRelativeThickness];
            set(handles.tblMultilayerStack,'Data',tableData);
            
        else
            handles.panelCoatingParametersBottom = uipanel( ...
                'Parent', handles.panelCoatingParametersTop, ...
                'Tag', 'panelCoatingParameters', ...
                'Units','Normalized',...
                'Position',[0.0,-4.0,0.95,5],...%[0.0,-4,0.95,5],
                'fontSize',fontSize,...
                'FontName',fontName);%,...
            
            handles.sliderCoatingParameters = uicontrol('Style','Slider',...
                'Parent', handles.panelCoatingParametersTop,...
                'Units','normalized','Position',[0.95 0.0 0.05 1.0],...
                'Value',1);
            set(handles.sliderCoatingParameters,...
                'Callback',{@sliderCoatingParameters_callback,handles});
            
            panelCoatingParametersBottomPosition = get(handles.panelCoatingParametersBottom,'Position');
            verticalScaleFactor = panelCoatingParametersBottomPosition(4);
            verticalOffset = panelCoatingParametersBottomPosition(4)-1;
            
            verticalFreeSpace = 0.025/verticalScaleFactor;% 2.5% of the the visial window height
            controlHeight = 0.06/verticalScaleFactor;% 6% of the visial window height
            topEdge = 0.1/verticalScaleFactor;% 10% of the the visial window height
            
            lastUicontrolBottom = panelCoatingParametersBottomPosition(4) - topEdge - 4; %panelCoatingParametersBottomPosition(4)
            
            horizontalFreeSpace = 0.05;% 5% of the visial window width
            controlWidth = 0.4;% 40% of the visial window width then two controls per line
            % control arrangement 5% + 40% + 5% + 40% + 5%
            leftEdge = 0.05;%
            
            for pp = 1:nPar
                % Display the parameter name
                handles.lblCoatingParameter(pp,1) = uicontrol( ...
                    'Parent', handles.panelCoatingParametersBottom, ...
                    'Tag', 'lblParameter', ...
                    'Style', 'text', ...
                    'Units','normalized',...
                    'Position', [leftEdge,lastUicontrolBottom-verticalFreeSpace,...
                    controlWidth,controlHeight], ...
                    'String',coatingParameterFields{pp},...
                    'HorizontalAlignment','right',...
                    'Visible','On',...
                    'fontSize',fontSize,'FontName',fontName);
                
                % Display the parameter value text boxes or popup menu
                parFormat = coatingParameterFormats{pp};
                if strcmpi(parFormat{1},'logical')
                    nVals = length(parFormat);
                    % The parameter format is logical
                    for vv = 1:nVals
                        handles.chkCoatingParameter(pp,vv) = uicontrol( ...
                            'Parent', handles.panelCoatingParametersBottom, ...
                            'Tag', 'chkParameter', ...
                            'Style', 'checkbox', ...
                            'Units','normalized',...
                            'Position', [leftEdge+horizontalFreeSpace+controlWidth,lastUicontrolBottom-verticalFreeSpace,...
                            horizontalFreeSpace,controlHeight], ...
                            'String',parFormat, ...
                            'BackgroundColor', [1 1 1],...
                            'HorizontalAlignment','left',...
                            'Visible','On',...
                            'fontSize',fontSize,'FontName',fontName);
                        lastUicontrolBottom = lastUicontrolBottom -verticalFreeSpace -controlHeight;
                        
                        currentValue = true;
                        set(handles.txtCoatingParameter(pp,vv),'Value',currentValue);
                    end
                elseif strcmpi(parFormat{1},'numeric')||strcmpi(parFormat{1},'char')
                    nVals = length(parFormat);
                    
                    % The parameter format numeric/char
                    for vv = 1:nVals
                        handles.txtCoatingParameter(pp,vv) = uicontrol( ...
                            'Parent', handles.panelCoatingParametersBottom, ...
                            'Tag', 'txtParameter', ...
                            'Style', 'edit', ...
                            'Units','normalized',...
                            'Position', [leftEdge+horizontalFreeSpace+controlWidth,lastUicontrolBottom-verticalFreeSpace,...
                            controlWidth,controlHeight], ...
                            'String',parFormat, ...
                            'BackgroundColor', [1 1 1],...
                            'HorizontalAlignment','left',...
                            'Visible','On',...
                            'fontSize',fontSize,'FontName',fontName);
                        lastUicontrolBottom = lastUicontrolBottom -verticalFreeSpace -controlHeight;
                        
                        currentValue = '1';
                        set(handles.txtCoatingParameter(pp,vv),'String',currentValue);
                    end
                else
                    vv = 1;
                    % The parameter format is list of selection itiems
                    handles.popCoatingParameter(pp,vv) = uicontrol( ...
                        'Parent', handles.panelCoatingParametersBottom, ...
                        'Tag', 'popParameter', ...
                        'Style', 'popupmenu', ...
                        'Units','normalized',...
                        'Position', [leftEdge+horizontalFreeSpace+controlWidth,lastUicontrolBottom-verticalFreeSpace,...
                        controlWidth,controlHeight], ...
                        'String',parFormat, ...
                        'BackgroundColor', [1 1 1],...
                        'HorizontalAlignment','left',...
                        'Visible','On',...
                        'fontSize',fontSize,'FontName',fontName);
                    
                    lastUicontrolBottom = lastUicontrolBottom -verticalFreeSpace -controlHeight;
                    
                    currentValue = 1;
                    set(handles.popCoatingParameter(pp,vv) ,'Value',currentValue);
                end
            end
        end
        updatedHandles = handles;
        
        % resize the handles.panelSpatialParameters
        %set(handles.panelSpatialParameters,'Position',[0.0,-2.0,0.95,verticalScaleFactor-lastUicontrolBottom]);
    end
    
%     function [coatingParameters] =  readCoatingParameters(handles)
%         handles.CoatingType;
%         handles.CoatingName;
%         handles.CoatingParameters;
%         
%         coatingTypeList = get(handles.popCoatingType,'String');
%         coatingType = coatingTypeList{get(handles.popCoatingType,'Value')};
%         
%       coatingParameters = struct();
%         % Handle the multilayer cooating in special case
%         if strcmpi(coatingType,'MultilayerCoating')
%             
%             'GlassArray','Thickness','RelativeThickness','UseInReverse'
% 
%                 coatingParameters.UseInReverse = ...
%                     get(handles.chkReverse,'Value');
%                 tblData1 = get(handles.tblMultilayerStack,'Data');
%                 for kk = 1: size(tblData1,1)
%                     
%                 end
%             
%         else
%         
%         % get the coating parameters from the corresponding
%         % coating function
%         % Connect the coating definition function
%         coatingDefinitionHandle = str2func(coatingType);
%         returnFlag = 1; %
%         [ parameterFields, parameterFormats, intialParameters ] = coatingDefinitionHandle(...
%             returnFlag);
%         % Calculate the size of panelspectralParameters based on the number of
%         % parameters
%         nPar = length(parameterFields);
%         for pp = 1:nPar
%             % Read the parameter value from text boxes or popup menu
%             parFormat = parameterFormats{pp};
%             if strcmpi(parFormat{1},'logical')
%                 nVals = length(parFormat);
%                 % The parameter format is logical
%                 for vv = 1:nVals
%                     parameterValue{pp,vv} = get(handles.txtCoatingParameter(pp,vv),'Value');
%                 end
%             elseif strcmpi(parFormat{1},'char')
%                 nVals = length(parFormat);
%                 
%                 % The parameter format char
%                 for vv = 1:nVals
%                     parameterValue{pp,vv} = get(handles.txtCoatingParameter(pp,vv),'String');
%                 end
%             elseif strcmpi(parFormat{1},'numeric')
%                 nVals = length(parFormat);
%                 
%                 % The parameter format numeric
%                 for vv = 1:nVals
%                     parameterValue{pp,vv} = str2num(get(handles.txtCoatingParameter(pp,vv),'String'));
%                 end
%             else
%                 vv = 1;
%                 CoatingParameterString = get(handles.popCoatingParameter(pp,vv),'String');
%                 parameterValue{pp,vv} = CoatingParameterString{get(handles.popCoatingParameter(pp,vv),'Value')};
%             end
%             coatingParameters.(parameterFields{pp}) = parameterValue{pp,:};
%         end
%         end           
% 
%     end
    
    
    function sliderCoatingParameters_callback(src,~,handles)
        val = get(src,'Value');
        panelCoatingParametersBottomPosition = get(handles.panelCoatingParametersBottom,'Position');
        set(handles.panelCoatingParametersBottom,'units','normalized','Position',...
            [panelCoatingParametersBottomPosition(1),-4+ panelCoatingParametersBottomPosition(4)*(1-val),...
            panelCoatingParametersBottomPosition(3) panelCoatingParametersBottomPosition(4)]);
    end
    
    function popCoatingType_Callback(hObject,~,handles)
        coatingTypeList =  get(handles.popCoatingType,'String');
        selectedCoatingType = coatingTypeList{get(hObject,'Value')};
        switch lower(selectedCoatingType)
            case lower('None')
                multilayerDataPanelVisible = 'off';
                jonesMatrixPanelVisible = 'off';
            case lower('BareGlass')
                multilayerDataPanelVisible = 'off';
                jonesMatrixPanelVisible = 'off';
            case lower('Multilayer')
                multilayerDataPanelVisible = 'on';
                jonesMatrixPanelVisible = 'off';
            case lower('JonesMatrix')
                multilayerDataPanelVisible = 'off';
                jonesMatrixPanelVisible = 'on';
        end
        
        set(handles.panelMultilayerData,...
            'Visible',multilayerDataPanelVisible);
        set(handles.panelJonesMatrixData,...
            'Visible',jonesMatrixPanelVisible);
    end
    
    %% ---------------------------------------------------------------------------
    function cmdDeleteCoating_Callback(hObject,evendata,handles) %#ok<INUSD>
        coatingCatalogueIndex = get(handles.popCoatingCatalogueName,'Value');
        selectedCoatingCatalogueFullName = coatingCatalogueListFullNames{coatingCatalogueIndex};
        objectType = 'coating';
        objectName = get(handles.txtCoatingName,'String');
        objectCatalogueFullName = selectedCoatingCatalogueFullName;
        removeObjectFromObjectCatalogue(objectType, objectName,objectCatalogueFullName )
        refreshCoatingDataInputDialog(handles);
    end
    
    %% ---------------------------------------------------------------------------
    function cmdClearAll_Callback(hObject,evendata,handles) %#ok<INUSD>
        set(handles.txtCoatingName,'String','New');
        set(handles.txtRepetetion,'String','1');
        set(handles.chkReverse,'Value',0);
        set(handles.tblRefractiveIndexProfile,'Data',[]);
        
    end
    %% ---------------------------------------------------------------------------
    function cmdAddRow_Callback(hObject,evendata,handles) %#ok<INUSD>
        if strcmpi(class(get(handles.tblRefractiveIndexProfile,'data')), 'double')
            tblData1 = (get(handles.tblRefractiveIndexProfile,'data'));
        elseif strcmpi(class(get(handles.tblRefractiveIndexProfile,'data')), 'cell')
            tempTblData = (get(handles.tblRefractiveIndexProfile,'data'));
            tblData1 = [cell2mat(tempTblData(:,1:2)) cell2mat(tempTblData(:,3)) cell2mat(tempTblData(:,4))];
        else
            disp('Error: Unknown data type in refractive index profile table.')
            return;
        end
        newRow1 =  [1,0,0,0];
        newTable1 = [tblData1; newRow1];
        newTable1 = mat2cell(newTable1,[ones(1,size(newTable1,1))],[ones(1,size(newTable1,2))]);
        for p = 1:size(newTable1,1)
            newTable1{p,3} = logical(newTable1{p,3});
        end
        set(handles.tblRefractiveIndexProfile, 'Data', newTable1);
    end
    %% ---------------------------------------------------------------------------
    function cmdRemoveRow_Callback(hObject,evendata,handles) %#ok<INUSD>
        if strcmpi(class(get(handles.tblRefractiveIndexProfile,'data')), 'double')
            tblData1 = num2cell(get(handles.tblRefractiveIndexProfile,'data'));
        elseif strcmpi(class(get(handles.tblRefractiveIndexProfile,'data')), 'cell')
            tblData1 = (get(handles.tblRefractiveIndexProfile,'data'));
        else
            disp('Error: Unknown data type in refractive index profile table.')
            return;
        end
        newTable1 = tblData1(1:end-1,:);
        
        set(handles.tblRefractiveIndexProfile, 'Data', newTable1);
    end
    
    %% ---------------------------------------------------------------------------
    function cmdSaveCoating_Callback(~,~,handles) %#ok<INUSD>
        objectType = 'coating';
        Object = getCurrentCoating(handles);
        coatingCatalogueIndex = get(handles.popCoatingCatalogueName,'Value');
        objectCatalogueFullName = coatingCatalogueListFullNames{coatingCatalogueIndex};
        addObjectToObjectCatalogue(objectType, Object,objectCatalogueFullName,'ask');
        refreshCoatingDataInputDialog(handles);
    end
    %% ---------------------------------------------------------------------------
    function cmdOk_Callback(hObject,evendata,handles) %#ok<INUSD>
        objectType = 'coating';
        Object = getCurrentCoating(handles);
        coatingCatalogueIndex = get(handles.popCoatingCatalogueName,'Value');
        objectCatalogueFullName = coatingCatalogueListFullNames{coatingCatalogueIndex};
        addObjectToObjectCatalogue(objectType, Object,objectCatalogueFullName,'replace');
        refreshCoatingDataInputDialog(handles);
        coatingObj = Object;
        save('tempcoating.mat','coatingObj');
        close(handles.FigureHandle);
        
    end
    
    function currentCoating = getCurrentCoating(handles)
        
        coatingType = handles.CoatingType;
        coatingName = handles.CoatingName;
        coatingParameters = handles.CoatingParameters;
        
%         coatingTypeList = get(handles.popCoatingType,'String');
%         coatingType = coatingTypeList{get(handles.popCoatingType,'Value')};
%         coatingName = get(handles.txtCoatingName,'String');
%         
%         [coatingParameters] =  readCoatingParameters(handles);
        
        
%         switch lower(coatingType)
%             case lower({'None','BareGlass'})
%                 coatingParameters = struct();
%                 coatingParameters.TransmissionMatrix = NaN*[1,0;0,1];
%                 coatingParameters.ReflectionMatrix = NaN*[1,0;0,1];
%                 
%                 coatingParameters.RefractiveIndexProfile = [NaN NaN (0) NaN];
%                 coatingParameters.RepetetionNumber = NaN*0;
%                 coatingParameters.UseInReverse = NaN*0;
%             case lower('Multilayer')
%                 coatingParameters = struct();
%                 coatingParameters.TransmissionMatrix = NaN*[1,0;0,1];
%                 coatingParameters.ReflectionMatrix = NaN*[1,0;0,1];
%                 
%                 coatingParameters.RepetetionNumber = ...
%                     str2double(get(handles.txtRepetetion,'String'));
%                 coatingParameters.Wavelength = ...
%                     str2double(get(handles.txtWavelength,'String'));
%                 coatingParameters.UseInReverse = ...
%                     get(handles.chkReverse,'Value');
%                 tblData1 = get(handles.tblRefractiveIndexProfile,'Data');
%                 
%                 % Compute the actual thickness for relative definition
%                 % Change the thickness from relative value to absloute
%                 % The actual thickness of the coating is determined by:
%                 % d = (wavLen0/n0)*T
%                 % where wavLen0 is the primary wavelength in micrometers ,
%                 % n0 is the real part of the index of refraction of the coating at the
%                 % primary wavelength, and T is the "optical thickness" of the coating
%                 % specified in the coating definition.
%                 relativeThicknessFlag = cell2mat(tblData1(:,3));
%                 thicknessValue = cell2mat(tblData1(:,2));
%                 refractiveIndexValue = cell2mat(tblData1(:,1));
%                 relativeThicknessIndices = find(relativeThicknessFlag);
%                 relativeThicknessValue = thicknessValue;
%                 if ~isempty(relativeThicknessIndices)
%                     T = thicknessValue(relativeThicknessIndices,:);
%                     wavLen0 = coatingParameters.Wavelength;
%                     % refractive index at primary wavelength. just take that for the 1st
%                     % wavelength.
%                     n0 = real(refractiveIndexValue(relativeThicknessIndices,1));
%                     relativeThicknessValue(relativeThicknessIndices,:) = (wavLen0/n0).*T;
%                 end
%                 
%                 coatingParameters.RefractiveIndexProfile = ...
%                     [refractiveIndexValue thicknessValue relativeThicknessFlag relativeThicknessValue];
%             case lower('JonesMatrix')
%                 coatingParameters = struct();
%                 tblData2 = get(handles.tblTransmissionMatrix,'Data');
%                 tblData3 = get(handles.tblReflectionMatrix,'Data');
%                 if strcmpi(class(tblData2),'cell')
%                     coatingParameters.TransmissionMatrix = [cell2mat(tblData2(:,:))];
%                     coatingParameters.ReflectionMatrix = [cell2mat(tblData3(:,:))];
%                 else
%                     coatingParameters.TransmissionMatrix = [(tblData2(:,:))];
%                     coatingParameters.ReflectionMatrix = [(tblData3(:,:))];
%                 end
%                 
%                 coatingParameters.RefractiveIndexProfile = [NaN NaN (0) NaN];
%                 coatingParameters.Wavelength = NaN;
%                 coatingParameters.RepetetionNumber = NaN*0;
%                 coatingParameters.UseInReverse = NaN*0;
%         end
        currentCoating = Coating(coatingType,coatingName,coatingParameters);
    end
    
    %% ---------------------------------------------------------------------------
    function cmdCancel_Callback(hObject,evendata,handles) %#ok<INUSD>
        currentCoating = Coating;
        refreshCoatingDataInputDialog(handles);
        %         coatingObj = Coating;
        %         save('tempcoating.mat','coatingObj');
        close(handles.FigureHandle);
    end
end