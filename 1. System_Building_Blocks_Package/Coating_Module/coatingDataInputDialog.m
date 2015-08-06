function mainFigHandle = coatingDataInputDialog(referenceWavelength,coatingCatalogueListFullNames,fontName,fontSize)
    %COATINGDATAINPUTDIALOG Displays a dilog box which is used to view, edit
    % and add coating to the existing coating catalogues. It returns a
    % selected coating object as matlab application data.
    % Example usage:
    %   First call the dialog with : coatingDataInputDialog
    %   After selecting a given coating close the dialog by clicking OK
    %   button. Then in the matlab editor or any other functions you can
    %   just get the selected coating by, selectedCoating = getappdata(0,'Coating')
    % Inputs:
    %   ( referenceWavelength,coatingCatalogueListFullNames,fontName,fontSize )
    % Outputs:
    %   [ ]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    
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
    
    figureHandle = ObjectHandle(struct());
    
    figureHandle.Object.MainFigureHandle = figure( ...
        'Tag', 'MainFigureHandle', ...
        'Units','Normalized',...
        'Position', [0.3,0.3,0.5,0.5], ...
        'Name', 'Coating Data Entry', ... %'WindowStyle','Modal',...
        'MenuBar', 'none', ...
        'NumberTitle', 'off', ...%'WindowStyle','Modal',...
        'Color', get(0,'DefaultUicontrolBackgroundColor'),...
        'CloseRequestFcn',{@figureCloseRequestFunction,figureHandle});
    mainFigHandle = figureHandle.Object.MainFigureHandle;
    
    figureHandle.Object.FirstCatalogueFullName =  coatingCatalogueListFullNames{1};
    % Creation of all uicontrols
    % Panel with fixed size is used as window visible while using the
    % slider to scroll through the uicontrols.
    figureHandle.Object.panelParametersTop = uipanel( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'panelParametersTop', ...
        'Units','Normalized',...
        'Position', [0.45,0.12,0.53,0.85], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'Title','Coating Parameters');%,...
    
    figureHandle.Object.panelCoatingListing = uipanel( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'panelCoatingListing', ...
        'Units','Normalized',...
        'Position', [0.02,0.02,0.43,0.94], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'Visible','On');
    
    % -----------------------------------------------------------------
    figureHandle.Object.lblCoatingCatalogueName = uicontrol( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
        'Tag', 'lblCoatingCatalogueName', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.02,0.9,0.48,0.05], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'Catalogue Name');
    
    figureHandle.Object.popCoatingCatalogueName = uicontrol( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
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
    
    figureHandle.Object.lblCoatingName = uicontrol( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
        'Tag', 'lblCoatingName', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.02,0.8,0.48,0.05], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'Coating Name');
    
    
    figureHandle.Object.txtCoatingName = uicontrol( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
        'Tag', 'txtCoatingName', ...
        'Style', 'edit', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.50,0.80,0.48,0.05], ...
        'BackgroundColor', [1 1 1], ...
        'String', 'CoatingName', ...
        'fontSize',fontSize,'FontName',fontName);
    % -----------------------------------------------------------------
    figureHandle.Object.lblCoatingType = uicontrol( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
        'Tag', 'lblCoatingType', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.02,0.7,0.48,0.05], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'Coating Type');
    
    supportedCoatingTypes = GetSupportedCoatingTypes();
    figureHandle.Object.popCoatingType = uicontrol( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
        'Tag', 'popCoatingType', ...
        'Style', 'popupmenu', ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.50,0.7,0.48,0.055], ...
        'BackgroundColor', [1 1 1],...
        'String',supportedCoatingTypes,...
        'Value',1);
    
    %-----------------------------------------------------------------
    figureHandle.Object.tblCoatingList = uitable( ...
        'Parent', figureHandle.Object.panelCoatingListing, ...
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
    set(figureHandle.Object.txtCoatingName,...
        'Callback',{@txtCoatingName_Callback,figureHandle});
    set(figureHandle.Object.popCoatingCatalogueName,...
        'Callback',{@popCoatingCatalogueName_Callback,figureHandle});
    set(figureHandle.Object.popCoatingType,...
        'Callback',{@popCoatingType_Callback,figureHandle});
    set(figureHandle.Object.tblCoatingList,...
        'CellSelectionCallback',{@tblCoatingList_CellSelectionCallback,figureHandle});
    
    figureHandle.Object.cmdDeleteCoating = uicontrol( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'cmdDeleteCoating', ...
        'Style', 'pushbutton', ...
        'Units','Normalized',...
        'Position', [0.45,0.02,0.10,0.065], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'Delete', ...
        'Callback', {@cmdDeleteCoating_Callback,figureHandle});
    
    figureHandle.Object.cmdNewCoating = uicontrol( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'cmdNewCoating', ...
        'Style', 'pushbutton', ...
        'Units','Normalized',...
        'Position', [0.56,0.02,0.10,0.065], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'New', ...
        'Callback', {@cmdNewCoating_Callback,figureHandle});
    
    figureHandle.Object.cmdEditSaveCoating = uicontrol( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'cmdEditSaveCoating', ...
        'Style', 'pushbutton', ...
        'Units','Normalized',...
        'Position', [0.67,0.02,0.10,0.065], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'Edit', ...
        'Callback', {@cmdEditSaveCoating_Callback,figureHandle});
    figureHandle.Object.cmdOk = uicontrol( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'cmdOk', ...
        'Style', 'pushbutton', ...
        'Units','Normalized',...
        'Position', [0.78,0.02,0.10,0.065], ...
        'fontSize',fontSize,...
        'FontName',fontName,...
        'String', 'Ok', ...
        'Callback', {@cmdOk_Callback,figureHandle});
    figureHandle.Object.cmdCancel = uicontrol( ...
        'Parent', figureHandle.Object.MainFigureHandle, ...
        'Tag', 'cmdCancel', ...
        'Style', 'pushbutton', ...
        'Units','Normalized',...
        'Position', [0.89,0.02,0.10,0.065], ...
        'fontSize',fontSize,'FontName',fontName,...
        'String', 'Cancel', ...
        'Callback', {@cmdCancel_Callback,figureHandle});
    
    % Display the first coating data
    refreshCoatingDataInputDialog(figureHandle,1);
    
    %% ---------------------------------------------------------------------------
    function popCoatingCatalogueName_Callback(~,~,figureHandle )
        refreshCoatingDataInputDialog(figureHandle,1);
    end
    function txtCoatingName_Callback(~,~,figureHandle )
        selectedCoatingName =  get(figureHandle.Object.txtCoatingName,'String');
        figureHandle.Object.CoatingName = selectedCoatingName;
    end
    
    
    function refreshCoatingDataInputDialog(figureHandle,selectedCoatingIndex)
        selectedCatalogueFullName = coatingCatalogueListFullNames{get(figureHandle.Object.popCoatingCatalogueName,'Value')};
        % extract the selected catalogue and coating from the catalogue
        selectedCatalogueCoatingArray = extractObjectFromObjectCatalogue...
            ('coating','all',selectedCatalogueFullName);
        if ~isempty(selectedCatalogueCoatingArray)
            selectedCatalogueCoatingNames =  {selectedCatalogueCoatingArray.Name};
            set(figureHandle.Object.tblCoatingList,'Data',selectedCatalogueCoatingNames');
            
            selectedCoatingObject = selectedCatalogueCoatingArray(selectedCoatingIndex(1));
            
            coatingType = selectedCoatingObject.Type;
            coatingName = selectedCoatingObject.Name;
            coatingParameters = selectedCoatingObject.Parameters;
            
            figureHandle.Object.CoatingCatalogueFullName = selectedCatalogueFullName;
            figureHandle.Object.CoatingType = coatingType;
            figureHandle.Object.CoatingName = coatingName;
            figureHandle.Object.Parameters = coatingParameters;
            displayCurrentParameters(figureHandle);
        else
            figureHandle.Object.CoatingCatalogueFullName = selectedCatalogueFullName;
            
            set(figureHandle.Object.txtCoatingName,'String','NoName');
            set(figureHandle.Object.popCoatingType,'Value',1);
            set(figureHandle.Object.tblCoatingList,'Data',[]);
            % Clear the panelParameters
            delete(get(figureHandle.Object.panelParametersTop,'Child'));
            makeUneditable(figureHandle);
            disp('Error: The selected coating catalogue is empty.');
            return;
        end
    end
    
    
    %% ---------------------------------------------------------------------------
    
    
    function tblCoatingList_CellSelectionCallback(hObject,eventdata,figureHandle)
        selCell = eventdata.Indices;
        if ~isempty(selCell)
            selRow = selCell(1,1);
            selCol = selCell(1,2);
            selectedCoatingIndex = selRow;
            selectedCatalogueFullName = coatingCatalogueListFullNames...
                {get(figureHandle.Object.popCoatingCatalogueName,'Value')};
            
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
            coatingName = selectedCoatingObject.Name;
            coatingParameters = selectedCoatingObject.Parameters;
            figureHandle.Object.CoatingCatalogueFullName = selectedCatalogueFullName;
            figureHandle.Object.CoatingType = coatingType;
            figureHandle.Object.CoatingName = coatingName;
            figureHandle.Object.Parameters = coatingParameters;
            
            displayCurrentParameters(figureHandle);
        end
    end
    
    function displayCurrentParameters(figureHandle)
        if nargin == 0
            disp('Error: The function displayCurrentParameters requires figureHandle.');
            return;
        end
        
        coatingType = figureHandle.Object.CoatingType;
        coatingName = figureHandle.Object.CoatingName;
        
        coatingTypeList = get(figureHandle.Object.popCoatingType,'String');
        selectedCoatingTypeIndex = find(strcmpi(coatingType,coatingTypeList));
        
        set(figureHandle.Object.popCoatingType,'Value',selectedCoatingTypeIndex);
        set(figureHandle.Object.txtCoatingName,'String',coatingName);
        
        % connect to coating defintion file and use defualt coating parameter
        coatingDefinitionHandle = str2func(coatingType);
        returnFlag = 1; % coating parameters fields and default values
        [ coatingParameterFields,coatingParameterFormats,defaultParameters] = ...
            coatingDefinitionHandle(returnFlag);
        fontSize = 11;
        fontName = 'FixedWidth';
        
        nPar = length(coatingParameterFields);
        % Clear the panelParameters
        delete(get(figureHandle.Object.panelParametersTop,'Child'));
        coatingParameters = figureHandle.Object.Parameters;
        
        % Handle the multilayer cooating in special case
        if strcmpi(coatingType,'MultilayerCoating')
            figureHandle.Object.panelMultilayerData = uipanel( ...
                'Parent', figureHandle.Object.panelParametersTop, ...
                'Tag', 'panelMultilayerData', ...
                'Units','Normalized',...
                'Position', [0.0,0.0,1.0,1.0], ...
                'fontSize',fontSize,...
                'FontName',fontName);
            
            
            figureHandle.Object.lblReferenceWavelength = uicontrol( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
                'Tag', 'lblReferenceWavelength', ...
                'Style', 'text', ...
                'HorizontalAlignment','left',...
                'Units','Normalized',...
                'Position', [0.0,0.75,0.4,0.1], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Reference Wavelength');
            
            figureHandle.Object.txtReferenceWavelength = uicontrol( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
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
            
            
            figureHandle.Object.chkReverse = uicontrol( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
                'Tag', 'chkReverse', ...
                'Style', 'checkbox', ...
                'Units','Normalized',...
                'Position', [0.7,0.78,0.3,0.1], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Revese Order',...
                'Value',logical(0),...
                'Callback', {@chkReverse_Callback,figureHandle});
            %-----------------------------------------------------------------
            figureHandle.Object.cmdClearAll = uicontrol( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
                'Tag', 'cmdClearAll', ...
                'Style', 'pushbutton', ...
                'Units','Normalized',...
                'Position', [0.02,0.9,0.3,0.07], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Clear All', ...
                'Callback', {@cmdClearAll_Callback,figureHandle});
            figureHandle.Object.cmdAddRow = uicontrol( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
                'Tag', 'cmdAddRow', ...
                'Style', 'pushbutton', ...
                'Units','Normalized',...
                'Position', [0.35,0.9,0.3,0.07], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Add (+)', ...
                'Callback', {@cmdAddRow_Callback,figureHandle});
            figureHandle.Object.cmdRemoveRow = uicontrol( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
                'Tag', 'cmdRemoveRow', ...
                'Style', 'pushbutton', ...
                'Units','Normalized',...
                'Position', [0.67,0.9,0.3,0.07], ...
                'fontSize',fontSize,...
                'FontName',fontName,...
                'String', 'Remove (-)', ...
                'Callback', {@cmdRemoveRow_Callback,figureHandle});
            
            figureHandle.Object.tblMultilayerStack = uitable( ...
                'Parent', figureHandle.Object.panelMultilayerData, ...
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
            
            if isempty(coatingParameters)
                tableData = [];
                useInReverse = 0;
            else
                coatingLayerNames = {coatingParameters.GlassArray.Name}';
                coatingLayerThickness = (coatingParameters.Thickness)';
                coatingRelativeThickness = (logical(coatingParameters.RelativeThickness))';
                tableData = [coatingLayerNames,num2cell(coatingLayerThickness),num2cell(coatingRelativeThickness)];
                useInReverse = coatingParameters.UseInReverse;
            end
            
            set(figureHandle.Object.tblMultilayerStack,'Data',tableData);
            set(figureHandle.Object.chkReverse,'Value',logical(useInReverse));
            set(figureHandle.Object.tblMultilayerStack,...
                'CellEditCallback',{@tblMultilayerStack_CellEditCallback,figureHandle});
            
        else
            figureHandle.Object.panelParametersBottom = uipanel( ...
                'Parent', figureHandle.Object.panelParametersTop, ...
                'Tag', 'panelParameters', ...
                'Units','Normalized',...
                'Position',[0.0,-4.0,0.95,5],...%[0.0,-4,0.95,5],
                'fontSize',fontSize,...
                'FontName',fontName);%,...
            
            figureHandle.Object.sliderParameters = uicontrol('Style','Slider',...
                'Parent', figureHandle.Object.panelParametersTop,...
                'Units','normalized','Position',[0.95 0.0 0.05 1.0],...
                'Value',1);
            set(figureHandle.Object.sliderParameters,...
                'Callback',{@sliderParameters_callback,figureHandle});
            
            panelParametersBottomPosition = get(figureHandle.Object.panelParametersBottom,'Position');
            verticalScaleFactor = panelParametersBottomPosition(4);
            verticalOffset = panelParametersBottomPosition(4)-1;
            
            verticalFreeSpace = 0.025/verticalScaleFactor;% 2.5% of the the visial window height
            controlHeight = 0.06/verticalScaleFactor;% 6% of the visial window height
            topEdge = 0.1/verticalScaleFactor;% 10% of the the visial window height
            
            lastUicontrolBottom = panelParametersBottomPosition(4) - topEdge - 4; %panelParametersBottomPosition(4)
            
            horizontalFreeSpace = 0.05;% 5% of the visial window width
            controlWidth = 0.4;% 40% of the visial window width then two controls per line
            % control arrangement 5% + 40% + 5% + 40% + 5%
            leftEdge = 0.05;%
            
            for pp = 1:nPar
                % Display the parameter name
                figureHandle.Object.lblCoatingParameter(pp,1) = uicontrol( ...
                    'Parent', figureHandle.Object.panelParametersBottom, ...
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
                parName = coatingParameterFields{pp};
                parValue = coatingParameters.(parName);
                if strcmpi(parFormat{1},'logical')
                    nVals = length(parFormat);
                    % The parameter format is logical
                    for vv = 1:nVals
                        figureHandle.Object.chkCoatingParameter(pp,vv) = uicontrol( ...
                            'Parent', figureHandle.Object.panelParametersBottom, ...
                            'Tag', 'chkParameter', ...
                            'Style', 'checkbox', ...
                            'Units','normalized',...
                            'Position', [leftEdge+horizontalFreeSpace+controlWidth,lastUicontrolBottom-verticalFreeSpace,...
                            horizontalFreeSpace,controlHeight], ...
                            'BackgroundColor', [1 1 1],...
                            'HorizontalAlignment','left',...
                            'Visible','On',...
                            'fontSize',fontSize,'FontName',fontName,...
                            'Callback',{@chkCoatingParameter_callback,pp,vv,figureHandle});
                        lastUicontrolBottom = lastUicontrolBottom -verticalFreeSpace -controlHeight;
                        
                        currentValue = parValue(vv);
                        set(figureHandle.Object.txtCoatingParameter(pp,vv),'Value',currentValue);
                    end
                elseif strcmpi(parFormat{1},'numeric')||strcmpi(parFormat{1},'char')
                    nVals = length(parFormat);
                    
                    % The parameter format numeric/char
                    for vv = 1:nVals
                        figureHandle.Object.txtCoatingParameter(pp,vv) = uicontrol( ...
                            'Parent', figureHandle.Object.panelParametersBottom, ...
                            'Tag', 'txtParameter', ...
                            'Style', 'edit', ...
                            'Units','normalized',...
                            'Position', [leftEdge+horizontalFreeSpace+controlWidth,lastUicontrolBottom-verticalFreeSpace,...
                            controlWidth,controlHeight], ...
                            'BackgroundColor', [1 1 1],...
                            'HorizontalAlignment','left',...
                            'Visible','On',...
                            'fontSize',fontSize,'FontName',fontName,...
                            'Callback',{@txtCoatingParameter_callback,pp,vv,figureHandle});
                        lastUicontrolBottom = lastUicontrolBottom -verticalFreeSpace -controlHeight;
                        
                        currentValue = parValue(vv);
                        set(figureHandle.Object.txtCoatingParameter(pp,vv),'String',currentValue);
                    end
                else
                    vv = 1;
                    % The parameter format is list of selection itiems
                    figureHandle.Object.popCoatingParameter(pp,vv) = uicontrol( ...
                        'Parent', figureHandle.Object.panelParametersBottom, ...
                        'Tag', 'popParameter', ...
                        'Style', 'popupmenu', ...
                        'Units','normalized',...
                        'Position', [leftEdge+horizontalFreeSpace+controlWidth,lastUicontrolBottom-verticalFreeSpace,...
                        controlWidth,controlHeight], ...
                        'BackgroundColor', [1 1 1],...
                        'HorizontalAlignment','left',...
                        'Visible','On',...
                        'fontSize',fontSize,'FontName',fontName,...
                        'Callback',{@popCoatingParameter_callback,pp,vv,figureHandle});
                    
                    lastUicontrolBottom = lastUicontrolBottom -verticalFreeSpace -controlHeight;
                    
                    
                    tempCoatingParamList = get(figureHandle.Object.popCoatingParameter(pp,vv) ,'String');
                    currentChoiceIndex = find(ismember(parValue(vv),tempCoatingParamList));
                    currentValue = currentChoiceIndex;
                    set(figureHandle.Object.popCoatingParameter(pp,vv) ,'Value',currentValue);
                end
            end
        end
        % resize the handles.panelSpatialParameters
        %set(handles.panelSpatialParameters,'Position',[0.0,-2.0,0.95,verticalScaleFactor-lastUicontrolBottom]);
        makeUneditable(figureHandle);
    end
    
    function tblMultilayerStack_CellEditCallback(hObject,eventdata,figureHandle)
        % hObject    handle to aodHandles.tblStandardData (see GCBO)
        % eventdata  structure with the following fields (see UITABLE)
        %	Indices: row and column indices of the cell(s) edited
        %	PreviousData: previous data for the cell(s) edited
        %	EditData: string(s) entered by the user
        %	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
        %	Error: error string when failed to convert EditData to appropriate value for Data
        % figureHandle    structure with figureHandle and user data (see GUIDATA)
        
        editedRow = eventdata.Indices(1);
        editedColumn = eventdata.Indices(2);
        
        if editedColumn == 1 % Glass name changed
            glassName = (eventdata.NewData);
            if isempty(glassName)
                msgbox('Error: Please enter valid glass name.');
                glassName = (eventdata.PreviousData);
            end
            usedGlassCatalogueList = {'All'};
            newGlass = Glass(glassName,usedGlassCatalogueList);
            newGlassName = upper(newGlass.Name);
            
            tblData1 = get(figureHandle.Object.tblMultilayerStack,'data');
            tblData1{editedRow,editedColumn} = newGlassName;
            set(figureHandle.Object.tblMultilayerStack, 'Data', tblData1);
            figureHandle.Object.Parameters.GlassArray(editedRow) =  newGlass;
        elseif editedColumn == 2 % Glass thickness changed
            glassThickness = (eventdata.NewData);
            if isempty(glassThickness)
                msgbox('Error: Please enter valid glass name.');
                glassThickness = (eventdata.PreviousData);
            end
            
            newGlassThickness = (glassThickness);
            tblData1 = get(figureHandle.Object.tblMultilayerStack,'data');
            tblData1{editedRow,editedColumn} = newGlassThickness;
            set(figureHandle.Object.tblMultilayerStack, 'Data', tblData1);
            figureHandle.Object.Parameters.Thickness(editedRow) =  newGlassThickness;
        elseif editedColumn == 3 % Relative thickness changed
            relativeThickness = (eventdata.EditData);
            figureHandle.Object.Parameters.RelativeThickness(editedRow) =  logical(relativeThickness);
        else
            
        end
        
    end
    
    function txtCoatingParameter_callback(~,~,paramIndex1,paramIndex2,figureHandle)
        coatingType = figureHandle.Object.CoatingType;
        % connect to coating defintion file and use defualt coating parameter
        coatingDefinitionHandle = str2func(coatingType);
        returnFlag = 1; % coating parameters fields and default values
        [ coatingParameterFields,coatingParameterFormats,defaultCoatingparameters] = ...
            coatingDefinitionHandle(returnFlag);
        
        paramName = coatingParameterFields{paramIndex1};
        paramType = coatingParameterFormats{paramIndex1};
        editedParamValue = get(figureHandle.Object.txtCoatingParameter(paramIndex1,paramIndex2),'String');
        if ischar(editedParamValue)
            editedParamValue = {editedParamValue};
        end
        
        if strcmpi(paramType{1},'numeric')
            editedParamValue = str2double(editedParamValue);
            if isempty(editedParamValue)
                disp('Error: Only numeric values are allowed for the field.');
                return;
            end
        elseif strcmpi(paramType{1},'char')
            
        else
            
        end
        oldParameter = figureHandle.Object.Parameters.(paramName);
        newParameter = oldParameter;
        newParameter(paramIndex2) = editedParamValue;
        figureHandle.Object.Parameters.(paramName) = newParameter;
    end
    
    
    function sliderParameters_callback(src,~,figureHandle)
        val = get(src,'Value');
        panelParametersBottomPosition = get(figureHandle.Object.panelParametersBottom,'Position');
        set(figureHandle.Object.panelParametersBottom,'units','normalized','Position',...
            [panelParametersBottomPosition(1),-4+ panelParametersBottomPosition(4)*(1-val),...
            panelParametersBottomPosition(3) panelParametersBottomPosition(4)]);
    end
    
    function popCoatingType_Callback(hObject,~,figureHandle)
        
        coatingTypeList =  get(figureHandle.Object.popCoatingType,'String');
        selectedCoatingType = coatingTypeList{get(hObject,'Value')};
        
        % connect to coating defintion file and use defualt coating parameter
        coatingDefinitionHandle = str2func(selectedCoatingType);
        returnFlag = 1; % coating parameters fields and default values
        [ ~,~,defaultCoatingparameters] = ...
            coatingDefinitionHandle(returnFlag);
        figureHandle.Object.CoatingType = selectedCoatingType;
        figureHandle.Object.Parameters = defaultCoatingparameters;
        
        displayCurrentParameters(figureHandle)
        makeEditable(figureHandle);
    end
    
    
    
    function chkReverse_Callback(hObject,evendata,figureHandle)
        figureHandle.Object.Parameters.UseInReverse = get(hObject,'Value');
    end
    
    %% ---------------------------------------------------------------------------
    function cmdNewCoating_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        coatingNameCellArray = inputdlg('Enter the new coating name : ','New Coating');
        if isempty(coatingNameCellArray)
            return;
        else
            coatingName = coatingNameCellArray{1};
        end
        
        coatingCatalogueFileList = 'All';
        coatingTypeIndex = listdlg('PromptString','Select the coating type :',...
            'SelectionMode','single',...
            'ListString',supportedCoatingTypes);
        if isempty(coatingTypeIndex)
            coatingType = 'BareGlass';
        else
            coatingType = supportedCoatingTypes{coatingTypeIndex};
        end
        newCoating = Coating(coatingName,coatingCatalogueFileList,coatingType);
        figureHandle.Object.CoatingType = coatingType;        
        figureHandle.Object.CoatingName = coatingName;
        figureHandle.Object.Parameters = newCoating.Parameters;
        
        coatingCatalogueFullName = figureHandle.Object.CoatingCatalogueFullName;
        addedPosition = addObjectToObjectCatalogue('Coating', newCoating,coatingCatalogueFullName,'ask');
        refreshCoatingDataInputDialog(figureHandle,addedPosition);
        makeEditable(figureHandle);
    end
    %% ---------------------------------------------------------------------------
    function cmdDeleteCoating_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        coatingCatalogueIndex = get(figureHandle.Object.popCoatingCatalogueName,'Value');
        CoatingCatalogueFullName = coatingCatalogueListFullNames{coatingCatalogueIndex};
        objectType = 'coating';
        objectName = get(figureHandle.Object.txtCoatingName,'String');
        objectCatalogueFullName = CoatingCatalogueFullName;
        removeObjectFromObjectCatalogue(objectType, objectName,objectCatalogueFullName )
        refreshCoatingDataInputDialog(figureHandle,1);
    end
    
    
    
    %% ---------------------------------------------------------------------------
    function cmdClearAll_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        set(figureHandle.Object.chkReverse,'Value',0);
        
        newGlass = Glass();
        newRow1 =  {newGlass.Name,[0],logical(0)};
        newTable1 = [newRow1];
        set(figureHandle.Object.tblMultilayerStack, 'Data', newTable1);
        
        figureHandle.Object.Parameters.GlassArray = newGlass;
        figureHandle.Object.Parameters.Thickness = 0;
        figureHandle.Object.Parameters.RelativeThickness = 0;
        figureHandle.Object.Parameters.UseInReverse = 0;
    end
    %% ---------------------------------------------------------------------------
    function cmdAddRow_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        newGlass = Glass();
        tblData1 = (get(figureHandle.Object.tblMultilayerStack,'data'));
        newRow1 =  {newGlass.Name,[0],logical(0)};
        newTable1 = [tblData1; newRow1];
        set(figureHandle.Object.tblMultilayerStack, 'Data', newTable1);
        
        nGlass = size(newTable1,1);
        figureHandle.Object.Parameters.GlassArray(nGlass) = newGlass;
        figureHandle.Object.Parameters.Thickness(nGlass) = 0;
        figureHandle.Object.Parameters.RelativeThickness(nGlass) = 0;
    end
    %% ---------------------------------------------------------------------------
    function cmdRemoveRow_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        tblData1 = (get(figureHandle.Object.tblMultilayerStack,'data'));
        newTable1 = tblData1(1:end-1,:);
        set(figureHandle.Object.tblMultilayerStack, 'Data', newTable1);
        
        figureHandle.Object.Parameters.GlassArray(end) = [];
        figureHandle.Object.Parameters.Thickness(end) = [];
        figureHandle.Object.Parameters.RelativeThickness(end) = [];
    end
    
    %% ---------------------------------------------------------------------------
    function cmdEditSaveCoating_Callback(~,~,figureHandle) %#ok<INUSD>
        if strcmpi(get(figureHandle.Object.cmdEditSaveCoating,'String'),'Edit')
            makeEditable(figureHandle);
        else
            objectType = 'coating';
            currentCoating = getCurrentCoating(figureHandle);
            objectCatalogueFullName = figureHandle.Object.CoatingCatalogueFullName;
            addedPosition = addObjectToObjectCatalogue(objectType, currentCoating,objectCatalogueFullName,'replace');
            refreshCoatingDataInputDialog(figureHandle,addedPosition);
            makeUneditable(figureHandle);
        end
    end
    %% ---------------------------------------------------------------------------
    function cmdOk_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        currentCoating = getCurrentCoating(figureHandle);
        setappdata(0,'Coating',currentCoating);
        close(figureHandle.Object.MainFigureHandle);
    end
    
    function currentCoating = getCurrentCoating(figureHandle)
        coatingName = figureHandle.Object.CoatingName;
        coatingCatalogueFileList = figureHandle.Object.CoatingCatalogueFullName;
        coatingType = figureHandle.Object.CoatingType;
        coatingParameters = figureHandle.Object.Parameters;
        currentCoating = Coating(coatingName,coatingCatalogueFileList,coatingType,coatingParameters);
    end
    
    %% ---------------------------------------------------------------------------
    function cmdCancel_Callback(hObject,evendata,figureHandle) %#ok<INUSD>
        currentCoating = Coating;
        setappdata(0,'Coating',currentCoating);
        close(figureHandle.Object.MainFigureHandle);
    end
    
    function makeEditable(figureHandle)
        %         set(figureHandle.Object.txtCoatingName,'Enable','On');
        set(figureHandle.Object.popCoatingType,'Enable','On');
        set(findall(figureHandle.Object.panelParametersTop, '-property', 'enable'), 'enable', 'On');
        set(figureHandle.Object.cmdEditSaveCoating,'String','Save');
    end
    function makeUneditable(figureHandle)
        set(figureHandle.Object.txtCoatingName,'Enable','Off');
        set(figureHandle.Object.popCoatingType,'Enable','Off');
        set(findall(figureHandle.Object.panelParametersTop, '-property', 'enable'), 'enable', 'off');
        set(figureHandle.Object.cmdEditSaveCoating,'String','Edit');
    end
    
    function figureCloseRequestFunction(~,~,figureHandle)
        delete(figureHandle.Object.MainFigureHandle);
    end
end