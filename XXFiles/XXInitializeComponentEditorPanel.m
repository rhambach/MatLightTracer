function InitializeComponentEditorPanel( parentWindow )
%INITIALIZECOMPONENTEDITORPANEL Define and initialized the uicontrols of the
% Component Editor Panel
% Member of AODParentWindow class
aodHandles = parentWindow.AODParentHandles;
fontSize = aodHandles.FontSize;
fontName = aodHandles.FontName;
% Put available components
nComponents = 15;
for k = 1:nComponents
    aodHandles.panelAvailableComponent(k) = uipanel(...
        'Parent',aodHandles.panelMainTab(4),...
        'FontSize',fontSize,'FontName', fontName,...
        'Units','Normalized',...
        'Position',[(k-1)/nComponents,0.92,1/nComponents,0.08]);
end
% Put buttons for the components
% Button Insert Single Surface (SS) as component
[iconImage map] = imread(which('SingleSurfaceIcon.jpg'));
ssIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentSS = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(1),...
    'CData',ssIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentSS_Callback,parentWindow});
aodHandles.lblInsertComponentSS = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(1),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','Surface',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);

% Button Insert Sequence of Surface SQS as component
[iconImage map] = imread(which('LensIcon.jpg'));
sqsIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentSQS = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(2),...
    'CData',sqsIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentSQS_Callback,parentWindow});
aodHandles.lblInsertComponentSQS = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(2),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','SQS',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);

% Button Insert Prism as component
[iconImage surfMap] = imread(which('PrismIcon.jpg'));
prismIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentPrism = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(3),...
    'CData',prismIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentPrism_Callback,parentWindow});
aodHandles.lblInsertComponentPrism = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(3),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','Prism',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);

% Button Insert Grating as component
[iconImage surfMap] = imread(which('GratingIcon.jpg'));
gratingIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentGrating = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(4),...
    'CData',gratingIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentGrating_Callback,parentWindow});
aodHandles.lblInsertComponentGrating = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(4),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','Grating',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);


%% Divide the area in to component list panel and component detail panel
aodHandles.panelComponentList = uipanel(...
    'Parent',aodHandles.panelMainTab(4),...
    'FontSize',fontSize,'FontName', fontName,...
    'Title','Component List',...
    'units','normalized',...
    'Position',[0.0,0.0,0.30,0.91]);
aodHandles.panelComponentDetail = uipanel(...
    'Parent',aodHandles.panelMainTab(4),...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.3,0.0,0.70,0.91]);

aodHandles.chkUpdateSurfaceEditorFromComponentEditor = uicontrol( ...
    'Parent', aodHandles.panelComponentDetail, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'checkbox', ...
    'String', 'Update Surface Editor From Component Editor',...
    'units','normalized',...
    'Position',[0.0,0.95,0.5,0.05],...
    'Value', false);

aodHandles.panelComponentDefinition = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.7,1.0,0.25]);

%% Single surface SS parameters panel
aodHandles.frameSSDefinition = uicontrol( ...
    'Parent',aodHandles.panelComponentDefinition,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.0,0.8,1.0],...
    'CData',imresize(imread(which('SSDefinition.jpg')), [150 600]),...
    'Visible','off');

aodHandles.panelSSParameters = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.0,1.0,0.7],...
    'Visible','off');

% Command buttons for adding and removing surfaces
aodHandles.btnInsertSurfaceToSS = uicontrol( ...
    'Parent',aodHandles.panelSSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.91,0.1,0.08],...
    'String','Insert',...
    'Enable','off');
aodHandles.btnRemoveSurfaceFromSS = uicontrol( ...
    'Parent',aodHandles.panelSSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.91,0.1,0.08],...
    'String','Remove',...
    'Enable','off');
aodHandles.btnStopSurfaceOfSS = uicontrol( ...
    'Parent',aodHandles.panelSSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.2,0.91,0.15,0.08],...
    'String','Make Stop',...
    'Callback',{@btnStopSurfaceOfSS_Callback,parentWindow});
aodHandles.btnSaveSS = uicontrol( ...
    'Parent',aodHandles.panelSSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.9,0.91,0.1,0.08],...
    'String','Save',...
    'Callback',{@btnSaveSS_Callback,parentWindow});

aodHandles.SSEditorTabGroup = uitabgroup(...
    'Parent', aodHandles.panelSSParameters, ...
    'Units', 'Normalized', ...
    'Position', [0, 0, 1.0, 0.9]);
aodHandles.SSStandardDataTab = ...
    uitab(aodHandles.SSEditorTabGroup, 'title','Standard Data');
aodHandles.SSApertureDataTab = ...
    uitab(aodHandles.SSEditorTabGroup, 'title','Aperture Data');
aodHandles.SSTiltDecenterDataTab = ...
    uitab(aodHandles.SSEditorTabGroup, 'title','Tilt Decenter Data');

% Initialize the panel and table for standard data
aodHandles.tblSSStandardData = uitable('Parent',aodHandles.SSStandardDataTab,...
    'FontSize',fontSize,'FontName', fontName,'units','normalized','Position',[0 0 1 1]);
% Initialize the panel and table for aperture data
aodHandles.tblSSApertureData = ...
    uitable('Parent',aodHandles.SSApertureDataTab,'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 1]);
% Initialize the panel and table for tilt decenter data
aodHandles.tblSSTiltDecenterData = ...
    uitable('Parent',aodHandles.SSTiltDecenterDataTab,'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 1]);

% Give all tables initial data
parentWindow.AODParentHandles = aodHandles;
parentWindow = resetSSEditorPanel(parentWindow);
aodHandles = parentWindow.AODParentHandles;

%% Sequence of surface SQS parameters panel
aodHandles.frameSQSDefinition = uicontrol( ...
    'Parent',aodHandles.panelComponentDefinition,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.0,0.8,1.0],...
    'CData',imresize(imread(which('SQSDefinition.jpg')), [150 600]),...
    'Visible','off');

aodHandles.panelSQSParameters = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.0,1.0,0.7],...
    'Visible','off');

% Command buttons for adding and removing surfaces
aodHandles.btnInsertSurfaceToSQS = uicontrol( ...
    'Parent',aodHandles.panelSQSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.91,0.1,0.08],...
    'String','Insert',...
    'Callback',{@btnInsertSurfaceToSQS_Callback,parentWindow});
aodHandles.btnRemoveSurfaceFromSQS = uicontrol( ...
    'Parent',aodHandles.panelSQSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.91,0.1,0.08],...
    'String','Remove',...
    'Callback',{@btnRemoveSurfaceFromSQS_Callback,parentWindow});
aodHandles.btnStopSurfaceOfSQS = uicontrol( ...
    'Parent',aodHandles.panelSQSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.2,0.91,0.15,0.08],...
    'String','Make Stop',...
    'Callback',{@btnStopSurfaceOfSQS_Callback,parentWindow});
aodHandles.btnSaveSQS = uicontrol( ...
    'Parent',aodHandles.panelSQSParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.9,0.91,0.1,0.08],...
    'String','Save',...
    'Callback',{@btnSaveSQS_Callback,parentWindow});

aodHandles.SQSEditorTabGroup = uitabgroup(...
    'Parent', aodHandles.panelSQSParameters, ...
    'Units', 'Normalized', ...
    'Position', [0, 0, 1.0, 0.9]);
aodHandles.SQSStandardDataTab = ...
    uitab(aodHandles.SQSEditorTabGroup, 'title','Standard Data');
aodHandles.SQSApertureDataTab = ...
    uitab(aodHandles.SQSEditorTabGroup, 'title','Aperture Data');
aodHandles.SQSTiltDecenterDataTab = ...
    uitab(aodHandles.SQSEditorTabGroup, 'title','Tilt Decenter Data');

% Initialize the panel and table for standard data
aodHandles.tblSQSStandardData = uitable('Parent',aodHandles.SQSStandardDataTab,...
    'FontSize',fontSize,'FontName', fontName,'units','normalized','Position',[0 0 1 1]);
% Initialize the panel and table for aperture data
aodHandles.tblSQSApertureData = ...
    uitable('Parent',aodHandles.SQSApertureDataTab,'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 1]);
% Initialize the panel and table for tilt decenter data
aodHandles.tblSQSTiltDecenterData = ...
    uitable('Parent',aodHandles.SQSTiltDecenterDataTab,'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 1]);

% Give all tables initial data
parentWindow.AODParentHandles = aodHandles;
parentWindow = resetSQSEditorPanel(parentWindow);
aodHandles = parentWindow.AODParentHandles;

%% Prism parameters panel
aodHandles.framePrismDefinition = uicontrol( ...
    'Parent',aodHandles.panelComponentDefinition,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.0,0.8,1.0],...
    'CData',imresize(imread(which('PrismDefinition.jpg')), [150 600]),...
    'Visible','off');

aodHandles.panelPrismParameters = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.0,1.0,0.7],...
    'Visible','off');
aodHandles.lblPrismRayPath  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.85,0.15,0.1],...
    'String', 'Ray Path');
aodHandles.popPrismRayPath = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'popupmenu', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.85,0.2,0.1],...
    'String', {'S1-S2','S1-S3','S1-S2-S3','S1-S3-S2','S1-S2-S3-S1','S1-S3-S2-S1'},...
    'Value',1);
aodHandles.lblPrismGlassName  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.82,0.15,0.1],...
    'String', 'Glass Name');
aodHandles.txtPrismGlassName = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.85,0.2,0.08],...
    'String', 'BK7');


aodHandles.lblPrismApexAngle1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.72,0.15,0.1],...
    'String', 'Apex Angle 1');
aodHandles.txtPrismApexAngle1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.75,0.2,0.08],...
    'String', '60');
aodHandles.lblPrismTiltX1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.72,0.15,0.1],...
    'String', 'Tilt X1');
aodHandles.txtPrismTiltX1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.75,0.2,0.08],...
    'String', '0');



aodHandles.lblPrismApexAngle2  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.62,0.15,0.1],...
    'String', 'Apex Angle 2');
aodHandles.txtPrismApexAngle2 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.65,0.2,0.08],...
    'String', '60');
aodHandles.lblPrismTiltY1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.62,0.15,0.1],...
    'String', 'Tilt Y1');
aodHandles.txtPrismTiltY1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.65,0.2,0.08],...
    'String', '0');


aodHandles.lblPrismSideLengthX1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.52,0.15,0.1],...
    'String', 'Side Length X1');
aodHandles.txtPrismSideLengthX1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.55,0.2,0.08],...
    'String', '5');
aodHandles.lblPrismTiltZ1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.52,0.15,0.1],...
    'String', 'Tilt Z1');
aodHandles.txtPrismTiltZ1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.55,0.2,0.08],...
    'String', '0');

aodHandles.lblPrismSideLengthY1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.42,0.15,0.1],...
    'String', 'Side Length Y1');
aodHandles.txtPrismSideLengthY1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.45,0.2,0.08],...
    'String', '5');
aodHandles.lblPrismDecenterX1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.42,0.15,0.1],...
    'String', 'Decenter X1');
aodHandles.txtPrismDecenterX1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.45,0.2,0.08],...
    'String', '0');

aodHandles.lblDistnaceAfterPrism  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.32,0.15,0.1],...
    'String', 'Dist. After');
aodHandles.txtDistnaceAfterPrism = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.35,0.2,0.08],...
    'String', '5');
aodHandles.lblPrismDecenterY1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.32,0.15,0.1],...
    'String', 'Decenter Y1');
aodHandles.txtPrismDecenterY1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.35,0.2,0.08],...
    'String', '0');


aodHandles.lblMakePrismStop  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.22,0.15,0.1],...
    'String', 'Make Surf 1 Stop');
aodHandles.chkMakePrismStop = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'checkbox', ...
    'String', 'Make Surf 1 Stop',...
    'units','normalized',...
    'Position',[0.18,0.25,0.2,0.08],...
    'Value', 0);
% aodHandles.chkReturnCoordinateToPreviousSurface = uicontrol( ...
%     'Parent', aodHandles.panelPrismParameters, ...
%     'FontSize',fontSize,'FontName', 'FixedWidth',...
%     'Style', 'checkbox', ...
%     'String', 'Return Coordinate To Previous Surface',...
%     'units','normalized',...
%     'Position',[0.51,0.25,0.49,0.08],...
%     'Value', 0);

aodHandles.btnSavePrism = uicontrol( ...
    'Parent',aodHandles.panelPrismParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.9,0.01,0.1,0.08],...
    'String','Save',...
    'Callback',{@btnSavePrism_Callback,parentWindow});
%%
% Grating parameters panel
aodHandles.frameGratingDefinition = uicontrol( ...
    'Parent',aodHandles.panelComponentDefinition,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.0,0.8,1.0],...
    'CData',imresize(imread(which('GratingDefinition.jpg')), [150 600]),...
    'Visible','off');

aodHandles.panelGratingParameters = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.0,1.0,0.7],...
    'Visible','off');
aodHandles.lblUnused  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.85,0.15,0.1],...
    'String', 'Unused');
aodHandles.popUnused = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'popupmenu', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.85,0.2,0.1],...
    'String', {'Unused'},...
    'Enable','off',...
    'Value',1);
aodHandles.lblGratingGlassName  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.82,0.15,0.1],...
    'String', 'Glass Name');
aodHandles.txtGratingGlassName = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.85,0.2,0.08],...
    'String', 'MIRROR');


aodHandles.lblGratingLineDensity  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.72,0.15,0.1],...
    'String', 'Lines/um ');
aodHandles.txtGratingLineDensity = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.75,0.2,0.08],...
    'String', '60');
aodHandles.lblGratingTiltX  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.72,0.15,0.1],...
    'String', 'Tilt X');
aodHandles.txtGratingTiltX = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.75,0.2,0.08],...
    'String', '0');

aodHandles.lblGratingDiffractionOrder  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.62,0.15,0.1],...
    'String', 'Diff. Order');
aodHandles.txtGratingDiffractionOrder = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.65,0.2,0.08],...
    'String', '60');
aodHandles.lblGratingTiltY  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.62,0.15,0.1],...
    'String', 'Tilt Y');
aodHandles.txtGratingTiltY = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.65,0.2,0.08],...
    'String', '0');


aodHandles.lblGratingSideLengthX  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.52,0.15,0.1],...
    'String', 'Length X');
aodHandles.txtGratingSideLengthX = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.55,0.2,0.08],...
    'String', '5');
aodHandles.lblGratingTiltZ  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.52,0.15,0.1],...
    'String', 'Tilt Z');
aodHandles.txtGratingTiltZ = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.55,0.2,0.08],...
    'String', '0');

aodHandles.lblGratingSideLengthY  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.42,0.15,0.1],...
    'String', 'Length Y');
aodHandles.txtGratingSideLengthY = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.45,0.2,0.08],...
    'String', '5');
aodHandles.lblGratingDecenterX  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.42,0.15,0.1],...
    'String', 'Decenter X');
aodHandles.txtGratingDecenterX = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.45,0.2,0.08],...
    'String', '0');

aodHandles.lblDistnaceAfterGrating  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.32,0.15,0.1],...
    'String', 'Dist. After');
aodHandles.txtDistnaceAfterGrating = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.35,0.2,0.08],...
    'String', '5');
aodHandles.lblGratingDecenterY  = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.32,0.15,0.1],...
    'String', 'Decenter Y');
aodHandles.txtGratingDecenterY = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.35,0.2,0.08],...
    'String', '0');


aodHandles.lblGratingApertureType = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.22,0.15,0.1],...
    'String', 'Aperture Type');

aodHandles.popGratingApertureType = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'popupmenu', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.18,0.25,0.2,0.08],...
    'BackgroundColor',[1,1,1],...
    'String', {'Rectangular' 'Elliptical'},...
    'Value',1);

aodHandles.lblGratingTiltMode = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.22,0.15,0.1],...
    'String', 'Tilt Mode');
aodHandles.popGratingTiltMode = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'Style', 'popupmenu', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.66,0.25,0.2,0.08],...
    'BackgroundColor',[1,1,1],...
    'String', {'DAR' 'NAX' 'BEN'},...
    'Value',3);


aodHandles.chkMakeGratingStop = uicontrol( ...
    'Parent', aodHandles.panelGratingParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'checkbox', ...
    'String', 'Make Stop Surface',...
    'units','normalized',...
    'Position',[0.01,0.12,0.35,0.1],...
    'Value', 0);



aodHandles.btnSaveGrating = uicontrol( ...
    'Parent',aodHandles.panelGratingParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.9,0.01,0.1,0.08],...
    'String','Save',...
    'Callback',{@btnSaveGrating_Callback,parentWindow});

%%

% Set all celledit and cellselection callbacks
set(aodHandles.tblSQSStandardData,...
    'CellEditCallback',{@tblSQSStandardData_CellEditCallback,parentWindow},...
    'CellSelectionCallback',{@tblSQSStandardData_CellSelectionCallback,parentWindow});

set(aodHandles.tblSQSApertureData,...
    'CellEditCallback',{@tblSQSApertureData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSQSApertureData_CellSelectionCallback,aodHandles});
set(aodHandles.tblSQSTiltDecenterData,...
    'CellEditCallback',{@tblSQSTiltDecenterData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSQSTiltDecenterData_CellSelectionCallback,aodHandles});

% Set all celledit and cellselection callbacks
set(aodHandles.tblSSStandardData,...
    'CellEditCallback',{@tblSSStandardData_CellEditCallback,parentWindow},...
    'CellSelectionCallback',{@tblSSStandardData_CellSelectionCallback,parentWindow});

set(aodHandles.tblSSApertureData,...
    'CellEditCallback',{@tblSSApertureData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSSApertureData_CellSelectionCallback,aodHandles});
set(aodHandles.tblSSTiltDecenterData,...
    'CellEditCallback',{@tblSSTiltDecenterData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSSTiltDecenterData_CellSelectionCallback,aodHandles});

%%

% Initialize the ui table for componentlist
aodHandles.tblComponentList = uitable('Parent',aodHandles.panelComponentList,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized','Position',[0 0 1 1]);

% Give all tables initial data
parentWindow.AODParentHandles = aodHandles;
parentWindow = resetComponentEditorPanel(parentWindow);
aodHandles = parentWindow.AODParentHandles ;
%     aodHandles = parentWindow.AODParentHandles;
%
% Set  celledit and cellselection callbacks
set(aodHandles.tblComponentList,...
    'CellSelectionCallback',{@tblComponentList_CellSelectionCallback,parentWindow},...
    'CellEditCallback',{@tblComponentList_CellEditCallback,parentWindow});
%
%     aodHandles = parentWindow.AODParentHandles;

end
% Cell select and % CellEdit Callback
% --- Executes when selected cell(s) is changed in aodHandles.tblComponentLis.
function tblComponentList_CellSelectionCallback(~, eventdata,parentWindow)
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
global CAN_REMOVE_COMPONENT
aodHandles = parentWindow.AODParentHandles;

selectedCell = cell2mat(struct2cell(eventdata)); %struct to matrix
if isempty(selectedCell)
    return
end
CURRENT_SELECTED_COMPONENT = selectedCell(1);

tblData = get(aodHandles.tblComponentList,'data');
sizeTblData = size(tblData);

%     if selectedCell(2)== 1 || selectedCell(2)== 6 %  when the 1st,5th and 6th column selected
if CURRENT_SELECTED_COMPONENT == 1
    CAN_ADD_COMPONENT = 0;
    CAN_REMOVE_COMPONENT = 0;
elseif CURRENT_SELECTED_COMPONENT == sizeTblData(1)
    CAN_ADD_COMPONENT = 1;
    CAN_REMOVE_COMPONENT = 0;
else
    CAN_ADD_COMPONENT = 1;
    CAN_REMOVE_COMPONENT = 1;
end

% Show the component parameters in the component detail window
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
componentType = currentComponent.Type;
totalNumberOfComponent = size(aodHandles.ComponentArray,2);

switch lower(componentType)
    case lower('SS')
        % Fill the surface parameters to the GUI
        nSurface = currentComponent.Parameters.NumberOfSurfaces;
        surfaceArray = currentComponent.Parameters.SurfaceArray;
        % initializ
        savedStandardData = cell(nSurface,20);
        savedApertureData = cell(nSurface,15);
        savedTiltDecenterData = cell(nSurface,16);
        
        for k = 1:1:nSurface
            %standard data
            if surfaceArray(k).ObjectSurface || ...
                    CURRENT_SELECTED_COMPONENT == 1
                savedStandardData{k,1} = 'OBJECT';
                
            elseif surfaceArray(k).ImageSurface || ...
                    CURRENT_SELECTED_COMPONENT == totalNumberOfComponent
                savedStandardData{k,1} = 'IMAGE';
                
            elseif surfaceArray(k).Stop
                savedStandardData{k,1} = 'STOP';
                
            else
                savedStandardData{k,1} = 'Surf';
            end
            savedStandardData{k,2} = char(surfaceArray(k).Comment);
            savedStandardData{k,3} = char(surfaceArray(k).Type);
            savedStandardData{k,4} = '';
            savedStandardData{k,5} = (surfaceArray(k).Thickness);
            savedStandardData{k,6} = '';
            
            switch char(surfaceArray(k).Glass.Name)
                case 'None'
                    glassDisplayName = '';
                case 'FixedIndexGlass'
                    glassDisplayName = ...
                        [num2str(surfaceArray(k).Glass.GlassParameters(1),'%.4f '),',',...
                        num2str(surfaceArray(k).Glass.GlassParameters(2),'%.4f '),',',...
                        num2str(surfaceArray(k).Glass.GlassParameters(3),'%.4f ')];
                otherwise
                    glassDisplayName = upper(char(surfaceArray(k).Glass.Name));
            end
            savedStandardData{k,7} = glassDisplayName;
            savedStandardData{k,8} = '';
            
            savedStandardData{k,9} = upper(num2str(surfaceArray(k).Coating.Name));
            savedStandardData{k,10} = '';
            
            % Other surface type specific standard data
            [fieldNames,fieldFormat,initialData] = surfaceArray(k).getOtherStandardDataFields;
            try
                for ff = 1:10
                    savedStandardData{k,10 + ff} = (surfaceArray(k).OtherStandardData.(fieldNames{ff}));
                end
            catch
                for ff = 1:10
                    savedStandardData{k,10 + ff} = initialData{ff};
                end
            end
            
            % aperture data
            if k == 1
                savedApertureData{k,1} = savedStandardData{k,1};
                savedApertureData{k,2} = savedStandardData{k,3};
                savedApertureData{k,3} = char(surfaceArray(k).ApertureType);
                savedApertureData{k,4} = '';
                savedApertureData{k,5} = (surfaceArray(k).ApertureParameter(1));
                savedApertureData{k,6} = '';
                savedApertureData{k,7} = (surfaceArray(k).ApertureParameter(2));
                savedApertureData{k,8} = '';
                savedApertureData{k,9} = (surfaceArray(k).ApertureParameter(3));
                savedApertureData{k,10} = '';
                savedApertureData{k,11} = (surfaceArray(k).ApertureParameter(4));
                savedApertureData{k,12} = '';
                
                savedApertureData{k,13} = (surfaceArray(k).ClearAperture);
                savedApertureData{k,14} = (surfaceArray(k).AdditionalEdge);
                savedApertureData{k,15} = logical(surfaceArray(k).AbsoluteAperture);
            end
            
            %tilt decenter data
            if k == 1
                savedTiltDecenterData{k,1} = savedStandardData{k,1};
                savedTiltDecenterData{k,2} = savedStandardData{k,3};
                % Validate Data
                order = char(surfaceArray(k).TiltDecenterOrder);
                if isValidGeneralInput(order,'TiltDecenterOrder')
                    savedTiltDecenterData{k,3} = order;
                else
                    % set default
                    savedTiltDecenterData{k,3} = 'DxDyDzTxTyTz';
                end
                savedTiltDecenterData{k,4} = '';
                savedTiltDecenterData{k,5} = (surfaceArray(k).DecenterParameter(1));
                savedTiltDecenterData{k,6} = '';
                savedTiltDecenterData{k,7} = (surfaceArray(k).DecenterParameter(2));
                savedTiltDecenterData{k,8} = '';
                savedTiltDecenterData{k,9} = (surfaceArray(k).TiltParameter(1));
                savedTiltDecenterData{k,10} = '';
                savedTiltDecenterData{k,11} = (surfaceArray(k).TiltParameter(2));
                savedTiltDecenterData{k,12} = '';
                savedTiltDecenterData{k,13} = (surfaceArray(k).TiltParameter(3));
                savedTiltDecenterData{k,14} = '';
                savedTiltDecenterData{k,15} = char(surfaceArray(k).TiltMode);
                savedTiltDecenterData{k,16} = '';
            end
        end
        sysTable1 = aodHandles.tblSSStandardData;
        set(sysTable1, 'Data', savedStandardData);
        
        sysTable2 = aodHandles.tblSSApertureData;
        set(sysTable2, 'Data', savedApertureData);
        
        sysTable5 = aodHandles.tblSSTiltDecenterData;
        set(sysTable5, 'Data', savedTiltDecenterData);
        
        % Display the parameters
        set(aodHandles.framePrismDefinition,'visible','off');
        set(get(aodHandles.framePrismDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelPrismParameters,'visible','off');
        set(get(aodHandles.panelPrismParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameGratingDefinition,'visible','off');
        set(get(aodHandles.frameGratingDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelGratingParameters,'visible','off');
        set(get(aodHandles.panelGratingParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameSQSDefinition,'visible','off');
        set(get(aodHandles.frameSQSDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSQSParameters,'visible','off');
        set(get(aodHandles.panelSQSParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameSSDefinition,'visible','on');
        set(get(aodHandles.frameSSDefinition,'Children'),'Visible', 'on');
        set(aodHandles.panelSSParameters,'visible','on');
        set(get(aodHandles.panelSSParameters,'Children'),'Visible', 'on');
        
    case {lower('SQS')}
        % Fill the surface parameters to the GUI
        nSurface = currentComponent.Parameters.NumberOfSurfaces;
        surfaceArray = currentComponent.Parameters.SurfaceArray;
        % initializ
        savedStandardData = cell(nSurface,20);
        savedApertureData = cell(1,15);
        savedTiltDecenterData = cell(1,16);
        
        for k = 1:1:nSurface
            %standard data
            if surfaceArray(k).ObjectSurface || ...
                    CURRENT_SELECTED_COMPONENT == 1
                savedStandardData{k,1} = 'OBJECT';
                
            elseif surfaceArray(k).ImageSurface || ...
                    CURRENT_SELECTED_COMPONENT == totalNumberOfComponent
                savedStandardData{k,1} = 'IMAGE';
                
            elseif surfaceArray(k).Stop
                savedStandardData{k,1} = 'STOP';
                
            else
                savedStandardData{k,1} = 'Surf';
            end
            
            
            savedStandardData{k,2} = char(surfaceArray(k).Comment);
            savedStandardData{k,3} = char(surfaceArray(k).Type);
            savedStandardData{k,4} = '';
            savedStandardData{k,5} = (surfaceArray(k).Thickness);
            savedStandardData{k,6} = '';
            
            switch char(surfaceArray(k).Glass.Name)
                case 'None'
                    glassDisplayName = '';
                case 'FixedIndexGlass'
                    glassDisplayName = ...
                        [num2str(surfaceArray(k).Glass.GlassParameters(1),'%.4f '),',',...
                        num2str(surfaceArray(k).Glass.GlassParameters(2),'%.4f '),',',...
                        num2str(surfaceArray(k).Glass.GlassParameters(3),'%.4f ')];
                otherwise
                    glassDisplayName = upper(char(surfaceArray(k).Glass.Name));
            end
            savedStandardData{k,7} = glassDisplayName;
            savedStandardData{k,8} = '';
            
            savedStandardData{k,9} = upper(num2str(surfaceArray(k).Coating.Name));
            savedStandardData{k,10} = '';
            
            % Other surface type specific standard data
            [fieldNames,fieldFormat,initialData] = surfaceArray(k).getOtherStandardDataFields;
            try
                for ff = 1:10
                    savedStandardData{k,10 + ff} = (surfaceArray(k).OtherStandardData.(fieldNames{ff}));
                end
            catch
                for ff = 1:10
                    savedStandardData{k,10 + ff} = initialData{ff};
                end
            end
            
            % aperture data
            if k == 1
                savedApertureData{k,1} = savedStandardData{k,1};
                savedApertureData{k,2} = savedStandardData{k,3};
                savedApertureData{k,3} = char(surfaceArray(k).ApertureType);
                savedApertureData{k,4} = '';
                savedApertureData{k,5} = (surfaceArray(k).ApertureParameter(1));
                savedApertureData{k,6} = '';
                savedApertureData{k,7} = (surfaceArray(k).ApertureParameter(2));
                savedApertureData{k,8} = '';
                savedApertureData{k,9} = (surfaceArray(k).ApertureParameter(3));
                savedApertureData{k,10} = '';
                savedApertureData{k,11} = (surfaceArray(k).ApertureParameter(4));
                savedApertureData{k,12} = '';
                
                savedApertureData{k,13} = (surfaceArray(k).ClearAperture);
                savedApertureData{k,14} = (surfaceArray(k).AdditionalEdge);
                savedApertureData{k,15} = logical(surfaceArray(k).AbsoluteAperture);
            end
            
            %tilt decenter data
            if k == 1
                savedTiltDecenterData{k,1} = savedStandardData{k,1};
                savedTiltDecenterData{k,2} = savedStandardData{k,3};
                % Validate Data
                order = char(surfaceArray(k).TiltDecenterOrder);
                if isValidGeneralInput(order,'TiltDecenterOrder')
                    savedTiltDecenterData{k,3} = order;
                else
                    % set default
                    savedTiltDecenterData{k,3} = 'DxDyDzTxTyTz';
                end
                savedTiltDecenterData{k,4} = '';
                savedTiltDecenterData{k,5} = (surfaceArray(k).DecenterParameter(1));
                savedTiltDecenterData{k,6} = '';
                savedTiltDecenterData{k,7} = (surfaceArray(k).DecenterParameter(2));
                savedTiltDecenterData{k,8} = '';
                savedTiltDecenterData{k,9} = (surfaceArray(k).TiltParameter(1));
                savedTiltDecenterData{k,10} = '';
                savedTiltDecenterData{k,11} = (surfaceArray(k).TiltParameter(2));
                savedTiltDecenterData{k,12} = '';
                savedTiltDecenterData{k,13} = (surfaceArray(k).TiltParameter(3));
                savedTiltDecenterData{k,14} = '';
                savedTiltDecenterData{k,15} = char(surfaceArray(k).TiltMode);
                savedTiltDecenterData{k,16} = '';
            end
        end
        sysTable1 = aodHandles.tblSQSStandardData;
        set(sysTable1, 'Data', savedStandardData);
        
        sysTable2 = aodHandles.tblSQSApertureData;
        set(sysTable2, 'Data', savedApertureData);
        
        sysTable5 = aodHandles.tblSQSTiltDecenterData;
        set(sysTable5, 'Data', savedTiltDecenterData);
        
        % Display the parameters
        set(aodHandles.framePrismDefinition,'visible','off');
        set(get(aodHandles.framePrismDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelPrismParameters,'visible','off');
        set(get(aodHandles.panelPrismParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameGratingDefinition,'visible','off');
        set(get(aodHandles.frameGratingDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelGratingParameters,'visible','off');
        set(get(aodHandles.panelGratingParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameSSDefinition,'visible','off');
        set(get(aodHandles.frameSSDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSSParameters,'visible','off');
        set(get(aodHandles.panelSSParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameSQSDefinition,'visible','on');
        set(get(aodHandles.frameSQSDefinition,'Children'),'Visible', 'on');
        set(aodHandles.panelSQSParameters,'visible','on');
        set(get(aodHandles.panelSQSParameters,'Children'),'Visible', 'on');
    case {lower('Prism')}
        % Fill the prism parameters to the GUI
        prismRayPath = currentComponent.Parameters.PrismRayPath;
        currentComponent.Parameters.PrismTiltDecenterOrder = 'DxDyDzTxTyTz';
        prismTiltX1 = currentComponent.Parameters.PrismTiltParameter(1);
        prismTiltY1 = currentComponent.Parameters.PrismTiltParameter(2);
        prismTiltZ1 = currentComponent.Parameters.PrismTiltParameter(3);
        surface1DecenterX = currentComponent.Parameters.PrismDecenterParameter(1);
        surface1DecenterY = currentComponent.Parameters.PrismDecenterParameter(2);
        
        surface1SideLengthX = 2*currentComponent.Parameters.PrismApertureParameter(1);
        surface1SideLengthY = 2*currentComponent.Parameters.PrismApertureParameter(2);
        
        
        prismGlassName = currentComponent.Parameters.PrismGlassName;
        prismApexAngle1 = currentComponent.Parameters.PrismApexAngle1;
        prismApexAngle2 = currentComponent.Parameters.PrismApexAngle2;
        distnaceAfterPrism = currentComponent.Parameters.DistanceAfterPrism;
        makePrismStop = currentComponent.Parameters.MakePrismStop;
        %         returnCoordToPrevSurf = currentComponent.Parameters.ReturnCoordinateToPreviousSurface;
        
        rayPathString = {'S1-S2','S1-S3','S1-S2-S3','S1-S3-S2','S1-S2-S3-S1','S1-S3-S2-S1'};
        rayPathIndex = find(ismember(rayPathString,prismRayPath));
        set(aodHandles.popPrismRayPath,'value',rayPathIndex);
        set(aodHandles.txtPrismGlassName,'String',prismGlassName);
        set(aodHandles.txtPrismApexAngle1,'String',prismApexAngle1);
        set(aodHandles.txtPrismApexAngle2,'String',prismApexAngle2);
        set(aodHandles.txtPrismTiltX1,'String',prismTiltX1);
        set(aodHandles.txtPrismTiltY1,'String',prismTiltY1);
        set(aodHandles.txtPrismTiltZ1,'String',prismTiltZ1);
        set(aodHandles.txtPrismDecenterX1,'String',surface1DecenterX);
        set(aodHandles.txtPrismDecenterY1,'String',surface1DecenterY);
        set(aodHandles.txtPrismSideLengthX1,'String',surface1SideLengthX);
        set(aodHandles.txtPrismSideLengthY1,'String',surface1SideLengthY);
        set(aodHandles.txtDistnaceAfterPrism,'String',distnaceAfterPrism);
        set(aodHandles.chkMakePrismStop,'Value',makePrismStop);
        %         set(aodHandles.chkReturnCoordinateToPreviousSurface,'Value',returnCoordToPrevSurf);
        
        % Display the parameters
        set(aodHandles.frameSSDefinition,'visible','off');
        set(get(aodHandles.frameSSDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSSParameters,'visible','off');
        set(get(aodHandles.panelSSParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameSQSDefinition,'visible','off');
        set(get(aodHandles.frameSQSDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSQSParameters,'visible','off');
        set(get(aodHandles.panelSQSParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameGratingDefinition,'visible','off');
        set(get(aodHandles.frameGratingDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelGratingParameters,'visible','off');
        set(get(aodHandles.panelGratingParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.framePrismDefinition,'visible','on');
        set(get(aodHandles.framePrismDefinition,'Children'),'Visible', 'on');
        set(aodHandles.panelPrismParameters,'visible','on');
        set(get(aodHandles.panelPrismParameters,'Children'),'Visible', 'on');
    case {lower('Grating')}
        % Fill the Grating parameters to the GUI
        lineDensity = currentComponent.Parameters.GratingLineDensity;
        diffractionOrder = currentComponent.Parameters.GratingDiffractionOrder;
        gratingGlassName = currentComponent.Parameters.GratingGlassName;
        currentComponent.Parameters.PrismTiltDecenterOrder = 'DxDyDzTxTyTz';
        gratingTiltX1 = currentComponent.Parameters.GratingTiltParameter(1);
        gratingTiltY1 = currentComponent.Parameters.GratingTiltParameter(2);
        gratingTiltZ1 = currentComponent.Parameters.GratingTiltParameter(3);
        surface1DecenterX = currentComponent.Parameters.GratingDecenterParameter(1);
        surface1DecenterY = currentComponent.Parameters.GratingDecenterParameter(2);
        
        surf1SideLengthX = 2*currentComponent.Parameters.GratingApertureParameter(1);
        surf1SideLengthY = 2*currentComponent.Parameters.GratingApertureParameter(2);
        
        distnaceAfterGrating = currentComponent.Parameters.DistanceAfterGrating;
        makeGratingStop = currentComponent.Parameters.MakeGratingStop;
        
        tiltMode = currentComponent.Parameters.GratingTiltMode;
        tiltModeString = get(aodHandles.popGratingTiltMode,'String');
        tiltModeIndex = find(ismember(tiltModeString,tiltMode));
        
        apertureType = currentComponent.Parameters.GratingApertureType;
        apertureTypeString = get(aodHandles.popGratingApertureType,'String');
        apertureTypeIndex = find(ismember(apertureTypeString,apertureType));
        
        set(aodHandles.txtGratingGlassName,'String',gratingGlassName);
        set(aodHandles.txtGratingLineDensity,'String',lineDensity);
        set(aodHandles.txtGratingDiffractionOrder,'String',diffractionOrder);
        set(aodHandles.txtGratingTiltX,'String',gratingTiltX1);
        set(aodHandles.txtGratingTiltY,'String',gratingTiltY1);
        set(aodHandles.txtGratingTiltZ,'String',gratingTiltZ1);
        set(aodHandles.txtGratingDecenterX,'String',surface1DecenterX);
        set(aodHandles.txtGratingDecenterY,'String',surface1DecenterY);
        set(aodHandles.txtGratingSideLengthX,'String',surf1SideLengthX);
        set(aodHandles.txtGratingSideLengthY,'String',surf1SideLengthY);
        set(aodHandles.txtDistnaceAfterGrating,'String',distnaceAfterGrating);
        set(aodHandles.chkMakeGratingStop,'Value',makeGratingStop);
        set(aodHandles.popGratingTiltMode,'value',tiltModeIndex);
        set(aodHandles.popGratingApertureType,'value',apertureTypeIndex);
        
        % Display the parameters
        set(aodHandles.frameSSDefinition,'visible','off');
        set(get(aodHandles.frameSSDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSSParameters,'visible','off');
        set(get(aodHandles.panelSSParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameSQSDefinition,'visible','off');
        set(get(aodHandles.frameSQSDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSQSParameters,'visible','off');
        set(get(aodHandles.panelSQSParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.framePrismDefinition,'visible','off');
        set(get(aodHandles.framePrismDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelPrismParameters,'visible','off');
        set(get(aodHandles.panelPrismParameters,'Children'),'Visible', 'off');
        
        set(aodHandles.frameGratingDefinition,'visible','on');
        set(get(aodHandles.frameGratingDefinition,'Children'),'Visible', 'on');
        set(aodHandles.panelGratingParameters,'visible','on');
        set(get(aodHandles.panelGratingParameters,'Children'),'Visible', 'on');
        
end
parentWindow.AODParentHandles = aodHandles;
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
% aodHandles    structure with aodHandles and user data (see GUIDATA)

if ~checkTheCurrentSystemDefinitionType(parentWindow.AODParentHandles)
    return
end
global CAN_REMOVE_COMPONENT

aodHandles = parentWindow.AODParentHandles;
if eventdata.Indices(2) == 4 % when the delete column selected
    if CAN_REMOVE_COMPONENT
        if ~eventdata.EditData
            % Confirm action
            % Construct a questdlg with three options
            choice = questdlg('Are you sure to delete the component?', ...
                'Confirm Deletion', ...
                'Yes','No','Yes');
            % Handle response
            switch choice
                case 'Yes'
                    % Delete the component
                    removePosition = eventdata.Indices(1);
                    RemoveComponent(parentWindow,removePosition);
                    aodHandles = parentWindow.AODParentHandles;
                case 'No'
                    % Mark the delete box again
                    tblData1 = get(aodHandles.tblComponentList,'data');
                    tblData1{eventdata.Indices(1),eventdata.Indices(2)} = true;
                    set(aodHandles.tblComponentList,'data',tblData1);
            end
        end
    else
        % Mark the delete box again
        tblData1 = get(aodHandles.tblComponentList,'data');
        tblData1{eventdata.Indices(1),eventdata.Indices(2)} = true;
        set(aodHandles.tblComponentList,'data',tblData1);
    end
end
parentWindow.AODParentHandles = aodHandles;
end


%%
% CellEditCallback
% --- Executes when entered data in editable cell(s) in aodHandles.tblSSStandardData.
function tblSSStandardData_CellEditCallback(~, eventdata,parentWindow)
% hObject    handle to aodHandles.tblSSStandardData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% aodHandles    structure with aodHandles and user data (see GUIDATA)
aodHandles = parentWindow.AODParentHandles;
if ~checkTheCurrentSystemDefinitionType(parentWindow.AODParentHandles)
    return
end
%     if eventdata.Indices(2) == 1    %if surface tag  is changed update all tables in the editor
%         if (strcmpi(eventdata.PreviousData,'Surf'))
%             tblSSData1 = get(aodHandles.tblSSStandardData,'data');
%             tblSSData1{eventdata.Indices(1),1} = eventdata.PreviousData;
%             set(aodHandles.tblSSStandardData, 'Data', tblSSData1);
%
%         else
%         end
%     end
if eventdata.Indices(2) == 3 && ~(strcmpi(eventdata.NewData,''))
    tblSSData2 = get(aodHandles.tblSSApertureData,'data');
    tblSSData2{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
    set(aodHandles.tblSSApertureData, 'Data', tblSSData2);
    
    tblSSData5 = get(aodHandles.tblSSTiltDecenterData,'data');
    tblSSData5{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
    set(aodHandles.tblSSTiltDecenterData, 'Data', tblSSData5);
    
    % Set the Column Names of the Standard data table
    surfaceType = eventdata.NewData;
    setSSStandardDataTableColumnNames(aodHandles,surfaceType);
    
elseif eventdata.Indices(1) == 1 && eventdata.Indices(2) == 5 % if first thickness is changed
    if isValidGeneralInput() % This returns 1 by default, but in the future
        % input validation code shall be defined
    else
        button = questdlg('Invalid input detected. Do you want to restore previous valid object thickness value?','Restore Object Thickness');
        if strcmpi(button,'Yes')
            tblSSData1 = get(aodHandles.tblSSStandardData,'data');
            tblSSData1{eventdata.Indices(1),5} = eventdata.PreviousData;
            set(aodHandles.tblSSStandardData, 'Data', tblSSData1);
        end
    end
elseif eventdata.Indices(2) == 7 % if glass is changed
    glassName = eventdata.NewData;
    % Check if the glass name is just Mirror
    if strcmpi(glassName,'Mirror')
        tblSSData{eventdata.Indices(1),7} = 'MIRROR';
        set(aodHandles.tblSSStandardData, 'Data', tblSSData);
        return;
        % Check if the glass name is just the refractive index of the glass
    elseif ~isnan(str2double(glassName)) % Fixed Index Glass
        tblSSData = get(aodHandles.tblSSStandardData,'data');
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
        tblSSData{eventdata.Indices(1),7} = [num2str((nd),'%.4f '),',',...
            num2str((vd),'%.4f '),',',...
            num2str((pg),'%.4f ')];
        set(aodHandles.tblSSStandardData, 'Data', tblSSData);
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
        % if exists capitalize its name else ask for new coating definition
        if objectIndex ~= 0
            tblSSData = get(aodHandles.tblSSStandardData,'data');
            tblSSData{eventdata.Indices(1),7} = upper(tblSSData{eventdata.Indices(1),7});
            set(aodHandles.tblSSStandardData, 'Data', tblSSData);
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
                    tblSSData = get(aodHandles.tblSSStandardData,'data');
                    tblSSData{eventdata.Indices(1),7} = upper(selectedGlassName);
                    set(aodHandles.tblSSStandardData, 'Data', tblSSData);
                case 'No'
                    % Do nothing
                    disp('Warning: Undefined glass used. It may cause problem in the analysis.');
                case 'Cancel'
                    tblSSData = get(aodHandles.tblSSStandardData,'data');
                    tblSSData{eventdata.Indices(1),7} = '';
                    set(aodHandles.tblSSStandardData, 'Data', tblSSData);
            end
        end
    end
    
    % elseif eventdata.Indices(2) == 13 %if semi diameter is changed update aperture
    %      % update aperture table if it is Floating Aperture
    %      tblSSData2 = get(aodHandles.tblSSApertureData,'data');
    %      if strcmpi(tblSSData2{eventdata.Indices(1),3},'Floating')
    %         tblSSData2{eventdata.Indices(1),5} = eventdata.NewData;
    %         tblSSData2{eventdata.Indices(1),7} = eventdata.NewData;
    %      end
    %      set(aodHandles.tblSSApertureData, 'Data', tblSSData2);
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
        tblSSData = get(aodHandles.tblSSStandardData,'data');
        tblSSData{eventdata.Indices(1),9} = upper(coatName);
        set(aodHandles.tblSSStandardData, 'Data', tblSSData);
    elseif objectIndex ~= 0
        tblSSData = get(aodHandles.tblSSStandardData,'data');
        tblSSData{eventdata.Indices(1),9} = upper(tblSSData{eventdata.Indices(1),9});
        set(aodHandles.tblSSStandardData, 'Data', tblSSData);
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
                tblSSData = get(aodHandles.tblSSStandardData,'data');
                tblSSData{eventdata.Indices(1),9} = upper(selectedCoatingName);
                set(aodHandles.tblSSStandardData, 'Data', tblSSData);
            case 'No'
                % Do nothing Just leave it
                disp('Warning: Undefined caoting used. It may cause problem in the analysis.');
            case 'Cancel'
                tblSSData = get(aodHandles.tblSSStandardData,'data');
                tblSSData{eventdata.Indices(1),9} = 'NONE';
                set(aodHandles.tblSSStandardData, 'Data', tblSSData);
        end
    end
end
%     end
parentWindow.AODParentHandles = aodHandles;
end

% --- Executes when entered data in editable cell(s) in aodHandles.tblSSApertureData.
function tblSSApertureData_CellEditCallback(~, ~,aodHandles)
if ~checkTheCurrentSystemDefinitionType(aodHandles)
    return
end
end
% % --- Executes when entered data in editable cell(s) in aodHandles.tblSSGratingData.
% function tblSSGratingData_CellEditCallback(~, ~,~)
% end
% --- Executes when entered data in editable cell(s) in aodHandles.tblSSTiltDecenterData.
function tblSSTiltDecenterData_CellEditCallback(~, eventdata,aodHandles)
if ~checkTheCurrentSystemDefinitionType(aodHandles)
    return
end
if eventdata.Indices(2) == 3  % 3rd row / tiltanddecenter data
    if isempty(eventdata.NewData) || ...
            ~isValidGeneralInput(eventdata.NewData,'TiltDecenterOrder')
        % restore previous data
        tblSSData = get(aodHandles.tblSSTiltDecenterData,'data');
        tblSSData{eventdata.Indices(1),3} = eventdata.PreviousData;
        set(aodHandles.tblSSTiltDecenterData, 'Data', tblSSData);
    else
        % valid input so format the text
        orderStr = upper(eventdata.NewData);
        formatedOrder(1:2:11) = upper(orderStr(1:2:11));
        formatedOrder(2:2:12) = lower(orderStr(2:2:12));
        tblSSData = get(aodHandles.tblSSTiltDecenterData,'data');
        tblSSData{eventdata.Indices(1),3} = formatedOrder;
        set(aodHandles.tblSSTiltDecenterData, 'Data', tblSSData);
    end
end
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSSStandardData.
function tblSSStandardData_CellSelectionCallback(~, eventdata, parentWindow)
global SELECTED_CELL_SS
SELECTED_CELL_SS = cell2mat(struct2cell(eventdata)); %struct to matrix
if isempty(SELECTED_CELL_SS)
    return
end
aodHandles = parentWindow.AODParentHandles;
tblSSData = get(aodHandles.tblSSStandardData,'data');
% Set the Column Names of the Standard data table
surfaceType = tblSSData{SELECTED_CELL_SS(1),3};
setSSStandardDataTableColumnNames(aodHandles,surfaceType);
end

% --- Executes when selected cell(s) is changed in aodHandles.tblSSApertureData.
function tblSSApertureData_CellSelectionCallback(~, ~,~)
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSSTiltDecenterData.
function tblSSTiltDecenterData_CellSelectionCallback(~, ~,~)
end

%%

% CellEditCallback
% --- Executes when entered data in editable cell(s) in aodHandles.tblSQSStandardData.
function tblSQSStandardData_CellEditCallback(~, eventdata,parentWindow)
% hObject    handle to aodHandles.tblSQSStandardData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% aodHandles    structure with aodHandles and user data (see GUIDATA)
aodHandles = parentWindow.AODParentHandles;
if ~checkTheCurrentSystemDefinitionType(aodHandles)
    return
end
%     if eventdata.Indices(2) == 1    %if surface tag  is changed update all tables in the editor
%         if (strcmpi(eventdata.PreviousData,'Surf'))
%             tblSQSData1 = get(aodHandles.tblSQSStandardData,'data');
%             tblSQSData1{eventdata.Indices(1),1} = eventdata.PreviousData;
%             set(aodHandles.tblSQSStandardData, 'Data', tblSQSData1);
%
%         else
%         end
%     end
if eventdata.Indices(2) == 3 && ~(strcmpi(eventdata.NewData,''))
    %if surface type is changed update all tables in the editor
    tblSQSData2 = get(aodHandles.tblSQSApertureData,'data');
    tblSQSData2{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
    set(aodHandles.tblSQSApertureData, 'Data', tblSQSData2);
    
    tblSQSData5 = get(aodHandles.tblSQSTiltDecenterData,'data');
    tblSQSData5{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
    set(aodHandles.tblSQSTiltDecenterData, 'Data', tblSQSData5);
    
    % Set the Column Names of the Standard data table
    surfaceType = eventdata.NewData;
    setSQSStandardDataTableColumnNames(aodHandles,surfaceType);
    
    %     elseif eventdata.Indices(2) == 5 % if radius field changes
    %         if isempty(str2num(eventdata.NewData))||any(imag(str2num(eventdata.NewData)))
    %             %if the radius field is not a number
    %             tblSQSData1 = get(aodHandles.tblSQSStandardData,'data');
    %             tblSQSData1{eventdata.Indices(1),5} = 'Inf';
    %             set(aodHandles.tblSQSStandardData, 'Data', tblSQSData1);
    %         end
elseif eventdata.Indices(1) == 1 && eventdata.Indices(2) == 5 % if first thickness is changed
    if isValidGeneralInput() % This returns 1 by default, but in the future
        % input validation code shall be defined
    else
        button = questdlg('Invalid input detected. Do you want to restore previous valid object thickness value?','Restore Object Thickness');
        if strcmpi(button,'Yes')
            tblSQSData1 = get(aodHandles.tblSQSStandardData,'data');
            tblSQSData1{eventdata.Indices(1),7} = eventdata.PreviousData;
            set(aodHandles.tblSQSStandardData, 'Data', tblSQSData1);
        end
    end
elseif eventdata.Indices(2) == 7 % if glass is changed
    glassName = eventdata.NewData;
    % Check if the glass name is just Mirror
    if strcmpi(glassName,'Mirror')
        tblSQSData{eventdata.Indices(1),7} = 'MIRROR';
        set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
        return;
        % Check if the glass name is just the refractive index of the glass
    elseif ~isnan(str2double(glassName)) % Fixed Index Glass
        tblSQSData = get(aodHandles.tblSQSStandardData,'data');
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
        tblSQSData{eventdata.Indices(1),7} = [num2str(str2double(nd),'%.4f '),',',...
            num2str(str2double(vd),'%.4f '),',',...
            num2str(str2double(pg),'%.4f ')];
        set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
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
        % if exists capitalize its name else ask for new coating definition
        if objectIndex ~= 0
            tblSQSData = get(aodHandles.tblSQSStandardData,'data');
            tblSQSData{eventdata.Indices(1),7} = upper(tblSQSData{eventdata.Indices(1),7});
            set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
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
                    tblSQSData = get(aodHandles.tblSQSStandardData,'data');
                    tblSQSData{eventdata.Indices(1),7} = upper(selectedGlassName);
                    set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
                case 'No'
                    % Do nothing
                    disp('Warning: Undefined glass used. It may cause problem in the analysis.');
                case 'Cancel'
                    tblSQSData = get(aodHandles.tblSQSStandardData,'data');
                    tblSQSData{eventdata.Indices(1),7} = '';
                    set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
            end
        end
    end
    
    % elseif eventdata.Indices(2) == 13 %if semi diameter is changed update aperture
    %      % update aperture table if it is Floating Aperture
    %      tblSQSData2 = get(aodHandles.tblSQSApertureData,'data');
    %      if strcmpi(tblSQSData2{eventdata.Indices(1),3},'Floating')
    %         tblSQSData2{eventdata.Indices(1),5} = eventdata.NewData;
    %         tblSQSData2{eventdata.Indices(1),7} = eventdata.NewData;
    %      end
    %      set(aodHandles.tblSQSApertureData, 'Data', tblSQSData2);
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
        tblSQSData = get(aodHandles.tblSQSStandardData,'data');
        tblSQSData{eventdata.Indices(1),9} = upper(coatName);
        set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
    elseif objectIndex ~= 0
        tblSQSData = get(aodHandles.tblSQSStandardData,'data');
        tblSQSData{eventdata.Indices(1),9} = upper(tblSQSData{eventdata.Indices(1),15});
        set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
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
                tblSQSData = get(aodHandles.tblSQSStandardData,'data');
                tblSQSData{eventdata.Indices(1),9} = upper(selectedCoatingName);
                set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
            case 'No'
                % Do nothing Just leave it
                disp('Warning: Undefined caoting used. It may cause problem in the analysis.');
            case 'Cancel'
                tblSQSData = get(aodHandles.tblSQSStandardData,'data');
                tblSQSData{eventdata.Indices(1),9} = 'NONE';
                set(aodHandles.tblSQSStandardData, 'Data', tblSQSData);
        end
    end
end
%     end
parentWindow.AODParentHandles = aodHandles;
end

% --- Executes when entered data in editable cell(s) in aodHandles.tblSQSApertureData.
function tblSQSApertureData_CellEditCallback(~, ~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
end

% --- Executes when entered data in editable cell(s) in aodHandles.tblSQSTiltDecenterData.
function tblSQSTiltDecenterData_CellEditCallback(~, eventdata,aodHandles)
if ~checkTheCurrentSystemDefinitionType(aodHandles)
    return
end
if eventdata.Indices(2) == 3  % 3rd row / tiltanddecenter data
    if isempty(eventdata.NewData) || ...
            ~isValidGeneralInput(eventdata.NewData,'TiltDecenterOrder')
        % restore previous data
        tblSQSData = get(aodHandles.tblSQSTiltDecenterData,'data');
        tblSQSData{eventdata.Indices(1),3} = eventdata.PreviousData;
        set(aodHandles.tblSQSTiltDecenterData, 'Data', tblSQSData);
    else
        % valid input so format the text
        orderStr = upper(eventdata.NewData);
        formatedOrder(1:2:11) = upper(orderStr(1:2:11));
        formatedOrder(2:2:12) = lower(orderStr(2:2:12));
        tblSQSData = get(aodHandles.tblSQSTiltDecenterData,'data');
        tblSQSData{eventdata.Indices(1),3} = formatedOrder;
        set(aodHandles.tblSQSTiltDecenterData, 'Data', tblSQSData);
    end
end
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSQSStandardData.

function tblSQSStandardData_CellSelectionCallback(~, eventdata,parentWindow)
global SELECTED_CELL_SQS
global CAN_ADD_SURF_TO_SQS
global CAN_REMOVE_SURF_FROM_SQS
aodHandles = parentWindow.AODParentHandles;

SELECTED_CELL_SQS = cell2mat(struct2cell(eventdata)); %struct to matrix
if isempty(SELECTED_CELL_SQS)
    return
end

tblSQSData = get(aodHandles.tblSQSStandardData,'data');
% Set the Column Names of the Standard data table
surfaceType = tblSQSData{SELECTED_CELL_SQS(1),3};
setSQSStandardDataTableColumnNames(aodHandles,surfaceType);

sizetblSQSData = size(tblSQSData);

if SELECTED_CELL_SQS(2) == 1 && ...
        ~strcmpi(tblSQSData{1,1},'OBJECT')&& ...
        ~strcmpi(tblSQSData{1,1},'IMAGE') % only when the first column selected
    if sizetblSQSData(1) == 1
        CAN_ADD_SURF_TO_SQS = 1;
        CAN_REMOVE_SURF_FROM_SQS = 0;
    else
        CAN_ADD_SURF_TO_SQS = 1;
        CAN_REMOVE_SURF_FROM_SQS = 1;
    end
end
parentWindow.AODParentHandles = aodHandles;
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSQSApertureData.
function tblSQSApertureData_CellSelectionCallback(~, ~,~)
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSQSTiltDecenterData.
function tblSQSTiltDecenterData_CellSelectionCallback(~, ~,~)
end


%% Button Callbacks
function btnInsertComponentSS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'SS',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertComponentSQS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'SQS',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertComponentPrism_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'Prism',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertComponentGrating_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'Grating',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertSurfaceToSQS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
aodHandles = myParent.AODParentHandles;
InsertNewSurfaceToSQS(aodHandles);
end
function btnRemoveSurfaceFromSQS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
aodHandles = myParent.AODParentHandles;
RemoveThisSurfaceFromSQS(aodHandles);
end
function btnStopSurfaceOfSQS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
aodHandles = myParent.AODParentHandles;
MakeThisStopSurfaceOfSQS (aodHandles)
end
function btnStopSurfaceOfSS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
aodHandles = myParent.AODParentHandles;
MakeThisStopSurface (aodHandles)
end
function btnSaveSS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
%Surface Data
tempStandardData = get(aodHandles.tblSSStandardData,'data');
tempApertureData = get(aodHandles.tblSSApertureData,'data');
tempTiltDecenterData = get(aodHandles.tblSSTiltDecenterData,'data');

nSurface = size(tempStandardData,1);
surfaceArray(1,nSurface) = Surface;
NonDummySurface = ones(1,nSurface);
for k = 1:1:nSurface
    %standard data
    surface = tempStandardData{k,1};
    if strcmpi((surface),'OBJECT')
        surfaceArray(k).ObjectSurface = 1;
    elseif strcmpi((surface),'IMAGE')
        surfaceArray(k).ImageSurface = 1;
    elseif strcmpi((surface),'STOP')
        % First remove stop from all other surfaces and prisms
        componentArray = aodHandles.ComponentArray;
        nComponent = size(componentArray,2);
        for tt = 1:nComponent
            if strcmpi(componentArray(tt).Type,'Prism')
                componentArray(tt).Parameters.MakePrismStop = false;
            end
            for kk = 1:componentArray(tt).Parameters.NumberOfSurfaces
                componentArray(tt).Parameters.SurfaceArray(kk).Stop = 0;
            end
        end
        aodHandles.ComponentArray = componentArray ;
        surfaceArray(k).Stop = 1;
        stopIndex = k;
    else
        surfaceArray(k).Stop = 0;
        surfaceArray(k).ImageSurface = 0;
        surfaceArray(k).ObjectSurface = 0;
    end
    surfaceArray(k).Comment       = char(tempStandardData(k,2));%text
    surfaceArray(k).Type          = char(tempStandardData(k,3));%text
    if strcmpi(surfaceArray(k).Type,'Dummy')
        NonDummySurface(k) = 0;
    end
    surfaceArray(k).Thickness     = tempStandardData{k,5};
    
    % get glass name and then SellmeierCoefficients from file
    glassName = strtrim(char(tempStandardData(k,7)));% text
    if strcmpi(glassName,'Mirror')
        % Just take the glass of the non dummy surface before the mirror
        % but with the new name "MIRROR"
        for pp = k-1:-1:1
            if NonDummySurface(pp)
                prevNonDummySurface = pp;
                break;
            end
        end
        aodObject = surfaceArray(prevNonDummySurface).Glass;
        aodObject.Name = 'MIRROR';
        surfaceArray(k).Glass = aodObject;
    elseif ~isempty(glassName)
        % check for its existance and extract the glass among selected catalogues
        objectType = 'glass';
        objectName = glassName;
        if isempty(str2num(glassName)) % If the glass name is specified
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
            for pp = 1:size(objectCatalogueListFullNames,1)
                objectCatalogueFullName = objectCatalogueListFullNames{pp};
                [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                    (objectType,objectName,objectCatalogueFullName );
                if objectIndex ~= 0
                    break;
                end
            end
            
            if  objectIndex ~= 0
                surfaceArray(k).Glass = aodObject;
            else
                disp(['Error: The glass after surface ',num2str(k),' is not found so it is ignored.']);
                surfaceArray(k).Glass = Glass;
            end
        else
            % Fixed Index Glass
            % str2num can be used to convert array of strings to number.
            ndvdpg = str2num(glassName);
            if length(ndvdpg) == 1
                nd = ndvdpg(1);
                vd = 0;
                pd = 0;
            elseif length(ndvdpg) == 2
                nd = ndvdpg(1);
                vd = ndvdpg(2);
                pd = 0;
            elseif length(ndvdpg) == 3
                nd = ndvdpg(1);
                vd = ndvdpg(2);
                pd = ndvdpg(3);
            else
            end
            glassName = [num2str(str2double(nd),'%.4f '),',',...
                num2str(str2double(vd),'%.4f '),',',...
                num2str(str2double(pd),'%.4f ')];
            aodObject = Glass(glassName,'FixedIndex',[nd,vd,pd,0,0,0,0,0,0,0]');
            surfaceArray(k).Glass = aodObject;
        end
    else
        surfaceArray(k).Glass = Glass;
    end
    
    % coating data
    coatName = (char(tempStandardData(k,9)));
    if ~isempty(coatName)
        % check for its existance and extract the coating among selected catalogues
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
        for pp = 1:size(objectCatalogueListFullNames,1)
            objectCatalogueFullName = objectCatalogueListFullNames{pp};
            [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                (objectType,objectName,objectCatalogueFullName );
            if objectIndex ~= 0
                break;
            end
        end
        
        if  objectIndex ~= 0
            surfaceArray(k).Coating = aodObject;
        else
            disp(['Error: The coating of surface ',num2str(k),' is not found so it is ignored.']);
            surfaceArray(k).Coating = Coating;
        end
    else
        surfaceArray(k).Coating = Coating;
    end
    
    % Other surface type specific standard data
    [fieldNames,fieldFormat,initialData] = surfaceArray(k).getOtherStandardDataFields;
    surfaceArray(k).OtherStandardData = struct;
    for ff = 1:10
        surfaceArray(k).OtherStandardData.(fieldNames{ff}) = ...
            (tempStandardData{k,ff+10});
    end
    
    % aperture data
    surfaceArray(k).ApertureType      = char(tempApertureData(k,3));
    surfaceArray(k).ApertureParameter = ...
        [tempApertureData{k,5},tempApertureData{k,7},...
        tempApertureData{k,9},tempApertureData{k,11}];
    
    surfaceArray(k).ClearAperture = tempApertureData{k,13};
    surfaceArray(k).AdditionalEdge = tempApertureData{k,14};
    surfaceArray(k).AbsoluteAperture = boolean(tempApertureData{k,15});
    
    % tilt decenter data
    surfaceArray(k).TiltDecenterOrder = char(tempTiltDecenterData(k,3));
    surfaceArray(k).DecenterParameter = ...
        [tempTiltDecenterData{k,5},tempTiltDecenterData{k,7}];
    surfaceArray(k).TiltParameter     = ...
        [tempTiltDecenterData{k,9},tempTiltDecenterData{k,11},tempTiltDecenterData{k,13}];
    surfaceArray(k).TiltMode          = char(tempTiltDecenterData(k,15));
    
    % compute position from decenter and thickness
    if k==1 % Object surface
        objThickness = abs(surfaceArray(k).Thickness);
        if objThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for graphing
            objThickness = 0;
        end
        % since global coord but shifted by objThickness
        refCoordinateTM = [1,0,0,0;0,1,0,0;0,0,1,-objThickness;0,0,0,1];
        
        surfaceCoordinateTM = refCoordinateTM;
        referenceCoordinateTM = refCoordinateTM;
        % set surface property
        surfaceArray(k).SurfaceCoordinateTM = ...
            surfaceCoordinateTM;
        surfaceArray(k).ReferenceCoordinateTM = ...
            referenceCoordinateTM;
    else
        prevRefCoordinateTM = referenceCoordinateTM;
        prevSurfCoordinateTM = surfaceCoordinateTM;
        prevThickness = surfaceArray(k-1).Thickness;
        if prevThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for object distance
            prevThickness = 0;
        end
        [surfaceCoordinateTM,referenceCoordinateTM] = ...
            surfaceArray(k).TiltAndDecenter(prevRefCoordinateTM,...
            prevSurfCoordinateTM,prevThickness);
        % set surface property
        surfaceArray(k).SurfaceCoordinateTM = surfaceCoordinateTM;
        surfaceArray(k).ReferenceCoordinateTM = referenceCoordinateTM;
        
    end
    surfaceArray(k).Position = (surfaceCoordinateTM (1:3,4))';
end

currentComponent.Parameters.SurfaceArray = surfaceArray;
currentComponent.Parameters.NumberOfSurfaces = nSurface;

aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT) = currentComponent;
myParent.AODParentHandles = aodHandles;
end
function btnSaveSQS_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
%Surface Data
tempStandardData = get(aodHandles.tblSQSStandardData,'data');
tempApertureData = get(aodHandles.tblSQSApertureData,'data');
tempTiltDecenterData = get(aodHandles.tblSQSTiltDecenterData,'data');

nSurface = size(tempStandardData,1);
surfaceArray(1,nSurface) = Surface;
NonDummySurface = ones(1,nSurface);

for k = 1:1:nSurface
    %standard data
    surface = tempStandardData{k,1};
    if strcmpi((surface),'OBJECT')
        surfaceArray(k).ObjectSurface = 1;
    elseif strcmpi((surface),'IMAGE')
        surfaceArray(k).ImageSurface = 1;
    elseif strcmpi((surface),'STOP')
        % First remove stop from all other surfaces and prisms
        componentArray = aodHandles.ComponentArray;
        nComponent = size(componentArray,2);
        for tt = 1:nComponent
            if strcmpi(componentArray(tt).Type,'Prism')
                componentArray(tt).Parameters.MakePrismStop = false;
            end
            for kk = 1:componentArray(tt).Parameters.NumberOfSurfaces
                componentArray(tt).Parameters.SurfaceArray(kk).Stop = 0;
            end
        end
        aodHandles.ComponentArray = componentArray ;
        surfaceArray(k).Stop = 1;
        stopIndex = k;
    else
        surfaceArray(k).Stop = 0;
        surfaceArray(k).ImageSurface = 0;
        surfaceArray(k).ObjectSurface = 0;
    end
    surfaceArray(k).Comment       = char(tempStandardData(k,2));%text
    surfaceArray(k).Type          = char(tempStandardData(k,3));%text
    
    
    if strcmpi(surfaceArray(k).Type,'Dummy')
        NonDummySurface(k) = 0;
    end
    surfaceArray(k).Thickness     = tempStandardData{k,5};
    
    % get glass name and then SellmeierCoefficients from file
    glassName = strtrim(char(tempStandardData(k,7)));% text
    if strcmpi(glassName,'Mirror')
        % Just take the glass of the non dummy surface before the mirror
        % but with the new name "MIRROR"
        for pp = k-1:-1:1
            if NonDummySurface(pp)
                prevNonDummySurface = pp;
                break;
            end
        end
        aodObject = surfaceArray(prevNonDummySurface).Glass;
        aodObject.Name = 'MIRROR';
        surfaceArray(k).Glass = aodObject;
    elseif ~isempty(glassName)
        % check for its existance and extract the glass among selected catalogues
        objectType = 'glass';
        objectName = glassName;
        if isempty(str2num(glassName)) % If the glass name is specified
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
            for pp = 1:size(objectCatalogueListFullNames,1)
                objectCatalogueFullName = objectCatalogueListFullNames{pp};
                [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                    (objectType,objectName,objectCatalogueFullName );
                if objectIndex ~= 0
                    break;
                end
            end
            
            if  objectIndex ~= 0
                surfaceArray(k).Glass = aodObject;
            else
                disp(['Error: The glass after surface ',num2str(k),' is not found so it is ignored.']);
                surfaceArray(k).Glass = Glass;
            end
        else
            % Fixed Index Glass
            % str2num can be used to convert array of strings to number.
            ndvdpg = str2num(glassName);
            if length(ndvdpg) == 1
                nd = ndvdpg(1);
                vd = 0;
                pd = 0;
            elseif length(ndvdpg) == 2
                nd = ndvdpg(1);
                vd = ndvdpg(2);
                pd = 0;
            elseif length(ndvdpg) == 3
                nd = ndvdpg(1);
                vd = ndvdpg(2);
                pd = ndvdpg(3);
            else
            end
            glassName = [num2str(str2double(nd),'%.4f '),',',...
                num2str(str2double(vd),'%.4f '),',',...
                num2str(str2double(pd),'%.4f ')];
            aodObject = Glass(glassName,'FixedIndex',[nd,vd,pd,0,0,0,0,0,0,0]');
            surfaceArray(k).Glass = aodObject;
        end
    else
        surfaceArray(k).Glass = Glass;
    end
    
    % coating data
    coatName = (char(tempStandardData(k,9)));
    if ~isempty(coatName)
        % check for its existance and extract the coating among selected catalogues
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
        for pp = 1:size(objectCatalogueListFullNames,1)
            objectCatalogueFullName = objectCatalogueListFullNames{pp};
            [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                (objectType,objectName,objectCatalogueFullName );
            if objectIndex ~= 0
                break;
            end
        end
        
        if  objectIndex ~= 0
            surfaceArray(k).Coating = aodObject;
        else
            disp(['Error: The coating of surface ',num2str(k),' is not found so it is ignored.']);
            surfaceArray(k).Coating = Coating;
        end
    else
        surfaceArray(k).Coating = Coating;
    end
    
    % Other surface type specific standard data
    [fieldNames,fieldFormat,initialData] = surfaceArray(k).getOtherStandardDataFields;
    surfaceArray(k).OtherStandardData = struct;
    for ff = 1:10
        surfaceArray(k).OtherStandardData.(fieldNames{ff}) = ...
            (tempStandardData{k,ff+10});
    end
    
    % aperture data  taken from the first surrface
    surfaceArray(k).ApertureType      = char(tempApertureData(1,3));
    surfaceArray(k).ApertureParameter = ...
        [tempApertureData{1,5},tempApertureData{1,7},...
        tempApertureData{1,9},tempApertureData{1,11}];
    
    surfaceArray(k).ClearAperture = tempApertureData{1,13};
    surfaceArray(k).AdditionalEdge = tempApertureData{1,14};
    surfaceArray(k).AbsoluteAperture = boolean(tempApertureData{1,15});
    
    
    % tilt decenter data taken from the first surrface
    if k == 1
        surfaceArray(k).TiltDecenterOrder = char(tempTiltDecenterData(1,3));
        surfaceArray(k).DecenterParameter = ...
            [tempTiltDecenterData{1,5},tempTiltDecenterData{1,7}];
        surfaceArray(k).TiltParameter     = ...
            [tempTiltDecenterData{1,9},tempTiltDecenterData{k,11},tempTiltDecenterData{1,13}];
        surfaceArray(k).TiltMode          = 'NAX';
    else
        surfaceArray(k).TiltDecenterOrder = char(tempTiltDecenterData(1,3));
        surfaceArray(k).DecenterParameter = ...
            [0,0];
        surfaceArray(k).TiltParameter     = ...
            [0,0,0];
        surfaceArray(k).TiltMode          = 'DAR';
    end
    
    
    % compute position from decenter and thickness
    if k == 1 %strcmpi((surface),'OBJECT') % Object surface
        objThickness = abs(surfaceArray(k).Thickness);
        if objThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for graphing
            objThickness = 0;
        end
        % since global coord but shifted by objThickness
        refCoordinateTM = [1,0,0,0;0,1,0,0;0,0,1,-objThickness;0,0,0,1];
        
        surfaceCoordinateTM = refCoordinateTM;
        referenceCoordinateTM = refCoordinateTM;
        % set surface property
        surfaceArray(k).SurfaceCoordinateTM = ...
            surfaceCoordinateTM;
        surfaceArray(k).ReferenceCoordinateTM = ...
            referenceCoordinateTM;
    else
        prevRefCoordinateTM = referenceCoordinateTM;
        prevSurfCoordinateTM = surfaceCoordinateTM;
        prevThickness = surfaceArray(k-1).Thickness;
        if prevThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for object distance
            prevThickness = 0;
        end
        [surfaceCoordinateTM,referenceCoordinateTM] = ...
            surfaceArray(k).TiltAndDecenter(prevRefCoordinateTM,...
            prevSurfCoordinateTM,prevThickness);
        % set surface property
        surfaceArray(k).SurfaceCoordinateTM = surfaceCoordinateTM;
        surfaceArray(k).ReferenceCoordinateTM = referenceCoordinateTM;
        
    end
    surfaceArray(k).Position = (surfaceCoordinateTM (1:3,4))';
end

currentComponent.Parameters.SurfaceArray = surfaceArray;
currentComponent.Parameters.NumberOfSurfaces = nSurface;

aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT) = currentComponent;
myParent.AODParentHandles = aodHandles;
end
function btnSavePrism_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
currentComponent.Type = 'Prism';
% Read all parameters from the GUI
rayPathString = get(aodHandles.popPrismRayPath,'String');
% {'S1-S2','S1-S3','S1-S2-S3','S1-S3-S2','S1-S2-S3-S1','S1-S3-S2-S1'};
rayPathIndex = get(aodHandles.popPrismRayPath,'value');
rayPath = rayPathString{rayPathIndex};
prismGlassName = get(aodHandles.txtPrismGlassName,'String');
prismApexAngle1 = str2double(get(aodHandles.txtPrismApexAngle1,'String'));
prismApexAngle2 = str2double(get(aodHandles.txtPrismApexAngle2,'String'));
prismTiltX1 = str2double(get(aodHandles.txtPrismTiltX1,'String'));
prismTiltY1 = str2double(get(aodHandles.txtPrismTiltY1,'String'));
prismTiltZ1 = str2double(get(aodHandles.txtPrismTiltZ1,'String'));
surface1DecenterX = str2double(get(aodHandles.txtPrismDecenterX1,'String'));
surface1DecenterY = str2double(get(aodHandles.txtPrismDecenterY1,'String'));

surface1ApertureY = 0.5*str2double(get(aodHandles.txtPrismSideLengthY1,'String'));
surface1ApertureX = 0.5*str2double(get(aodHandles.txtPrismSideLengthX1,'String'));
distnaceAfterPrism = str2double(get(aodHandles.txtDistnaceAfterPrism,'String'));
makePrismStop = get(aodHandles.chkMakePrismStop,'Value');
% returnCoordToPrevSurf = get(aodHandles.chkReturnCoordinateToPreviousSurface,'Value');

if makePrismStop
    % First remove stop from all other surfaces and prisms
    componentArray = aodHandles.ComponentArray;
    nComponent = size(componentArray,2);
    for tt = 1:nComponent
        if strcmpi(componentArray(tt).Type,'Prism')
            componentArray(tt).Parameters.MakePrismStop = false;
        end
        if strcmpi(componentArray(tt).Type,'Grating')
            componentArray(tt).Parameters.MakeGratingStop = false;
        end
        for kk = 1:componentArray(tt).Parameters.NumberOfSurfaces
            componentArray(tt).Parameters.SurfaceArray(kk).Stop = 0;
        end
    end
    aodHandles.ComponentArray = componentArray ;
end
% Assign to component parameters
currentComponent.Parameters.PrismRayPath = rayPath;
switch lower(rayPath)
    case {lower('S1-S2'),lower('S1-S3')}
        currentComponent.Parameters.NumberOfSurfaces = 2;
    case {lower('S1-S2-S3'),lower('S1-S3-S2')}
        currentComponent.Parameters.NumberOfSurfaces = 3;
    case {lower('S1-S2-S3-S1'),lower('S1-S3-S2-S1')}
        currentComponent.Parameters.NumberOfSurfaces = 4;
end
currentComponent.Parameters.PrismTiltDecenterOrder = 'DxDyDzTxTyTz';
currentComponent.Parameters.PrismTiltParameter = [prismTiltX1 prismTiltY1 prismTiltZ1];
currentComponent.Parameters.PrismDecenterParameter = [surface1DecenterX surface1DecenterY];
currentComponent.Parameters.PrismApertureParameter = [surface1ApertureX surface1ApertureY 0 0];
currentComponent.Parameters.PrismGlassName = prismGlassName;
currentComponent.Parameters.PrismApexAngle1 = prismApexAngle1;
currentComponent.Parameters.PrismApexAngle2 = prismApexAngle2;
currentComponent.Parameters.DistanceAfterPrism = distnaceAfterPrism;
currentComponent.Parameters.MakePrismStop = makePrismStop;
% currentComponent.Parameters.ReturnCoordinateToPreviousSurface = returnCoordToPrevSurf;

currentComponent.Parameters.SurfaceArray = currentComponent.getSurfaceArray;
aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT) = currentComponent;
myParent.AODParentHandles = aodHandles;
end

function btnSaveGrating_Callback(~,~,myParent)
if ~checkTheCurrentSystemDefinitionType(myParent.AODParentHandles)
    return
end
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
currentComponent.Type = 'Grating';
% Read all parameters from the GUI

gratingGlassName = get(aodHandles.txtGratingGlassName,'String');
lineDensity = str2double(get(aodHandles.txtGratingLineDensity,'String'));
diffractionOrder = str2double(get(aodHandles.txtGratingDiffractionOrder,'String'));

gratingTiltX1 = str2double(get(aodHandles.txtGratingTiltX,'String'));
gratingTiltY1 = str2double(get(aodHandles.txtGratingTiltY,'String'));
gratingTiltZ1 = str2double(get(aodHandles.txtGratingTiltZ,'String'));
surface1DecenterX = str2double(get(aodHandles.txtGratingDecenterX,'String'));
surface1DecenterY = str2double(get(aodHandles.txtGratingDecenterY,'String'));

surface1ApertureY = 0.5*str2double(get(aodHandles.txtGratingSideLengthY,'String'));
surface1ApertureX = 0.5*str2double(get(aodHandles.txtGratingSideLengthX,'String'));
distnaceAfterGrating = str2double(get(aodHandles.txtDistnaceAfterGrating,'String'));

tiltModeString = get(aodHandles.popGratingTiltMode,'String');
tiltModeIndex = get(aodHandles.popGratingTiltMode,'value');
tiltMode = tiltModeString{tiltModeIndex};

apertureTypeString = get(aodHandles.popGratingApertureType,'String');
apertureTypeIndex = get(aodHandles.popGratingApertureType,'value');
apertureType = apertureTypeString{apertureTypeIndex};

makeGratingStop = get(aodHandles.chkMakeGratingStop,'Value');
if makeGratingStop
    % First remove stop from all other surfaces, prisms and gratings
    componentArray = aodHandles.ComponentArray;
    nComponent = size(componentArray,2);
    for tt = 1:nComponent
        if strcmpi(componentArray(tt).Type,'Prism')
            componentArray(tt).Parameters.MakePrismStop = false;
        end
        if strcmpi(componentArray(tt).Type,'Grating')
            componentArray(tt).Parameters.MakeGratingStop = false;
        end
        for kk = 1:componentArray(tt).Parameters.NumberOfSurfaces
            componentArray(tt).Parameters.SurfaceArray(kk).Stop = 0;
        end
    end
    aodHandles.ComponentArray = componentArray ;
end

% Assign to component parameters
currentComponent.Type = 'Grating';
currentComponent.Parameters.GratingGlassName =  gratingGlassName;
currentComponent.Parameters.NumberOfSurfaces = 1;
currentComponent.Parameters.SurfaceArray(1) = Surface;
currentComponent.Parameters.GratingTiltDecenterOrder = 'DxDyDzTxTyTz';
currentComponent.Parameters.GratingTiltParameter = [gratingTiltX1 gratingTiltY1 gratingTiltZ1];
currentComponent.Parameters.GratingTiltMode = tiltMode;
currentComponent.Parameters.GratingDecenterParameter = [surface1DecenterX surface1DecenterY];
currentComponent.Parameters.GratingApertureType = apertureType;
currentComponent.Parameters.GratingApertureParameter = [surface1ApertureX surface1ApertureY 0 0];
currentComponent.Parameters.GratingLineDensity = lineDensity;
currentComponent.Parameters.GratingDiffractionOrder = diffractionOrder;
currentComponent.Parameters.DistanceAfterGrating = distnaceAfterGrating;
currentComponent.Parameters.MakeGratingStop = makeGratingStop;

currentComponent.Parameters.SurfaceArray = currentComponent.getSurfaceArray;
aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT) = currentComponent;
myParent.AODParentHandles = aodHandles;
end


%% Local Function
function RemoveThisSurfaceFromSQS(aodHandles)
global SELECTED_CELL_SQS
global CAN_REMOVE_SURF_FROM_SQS

if isempty(SELECTED_CELL_SQS)
    return
end

if CAN_REMOVE_SURF_FROM_SQS
    removePosition = SELECTED_CELL_SQS(1);
    
    %update standard data table
    tblData1 = get(aodHandles.tblSQSStandardData,'data');
    sizeTblData1 = size(tblData1);
    parta1 = tblData1(1:removePosition-1,:);
    partb1 = tblData1(removePosition+1:sizeTblData1 ,:);
    newTable1 = [parta1; partb1];
    sysTable1 = aodHandles.tblSQSStandardData;
    set(sysTable1, 'Data', newTable1);
    
    sysTable6 = aodHandles.tblSQSGratingData;
    %         set(sysTable6, 'Data', newTable6);
end
CAN_REMOVE_SURF_FROM_SQS = 0;
SELECTED_CELL_SQS = [];
end
function InsertNewSurfaceToSQS(aodHandles)
global SELECTED_CELL_SQS
global CAN_ADD_SURF_TO_SQS

if isempty(SELECTED_CELL_SQS)
    return
end
if CAN_ADD_SURF_TO_SQS
    insertPosition = SELECTED_CELL_SQS(1);
    %update standard data table
    tblData1 = get(aodHandles.tblSQSStandardData,'data');
    sizeTblData1 = size(tblData1);
    parta1 = tblData1(1:insertPosition-1,:);
    newRow1 = {'Surf','','Standard','',[0],'','','','','',[Inf],[0],[0],[0],[0],[0],[0],[0],[0],[0]};
    partb1 = tblData1(insertPosition:sizeTblData1 ,:);
    newTable1 = [parta1; newRow1; partb1];
    sysTable1 = aodHandles.tblSQSStandardData;
    set(sysTable1, 'Data', newTable1);
    
    
    % If possible add here a code to select the first cell of newly added row
    % automatically
end
CAN_ADD_SURF_TO_SQS = 0;
SELECTED_CELL_SQS = [];
end
function MakeThisStopSurfaceOfSQS (aodHandles)
global SELECTED_CELL_SQS
if isempty(SELECTED_CELL_SQS)
    return
end
surfIndex = SELECTED_CELL_SQS(1);
tblSQSTempData1 = get(aodHandles.tblSQSStandardData,'data');
if ~strcmpi(tblSQSTempData1{1,1},'OBJECT') &&...
        ~strcmpi(tblSQSTempData1{1,1},'IMAGE')&...
        ~strcmpi(tblSQSTempData1{1,1},'STOP')
    tblSQSTempData2 = get(aodHandles.tblSQSApertureData,'data');
    tblSQSTempData5 = get(aodHandles.tblSQSTiltDecenterData,'data');
    for kk = 1:size(tblSQSTempData1,1)
        if kk == surfIndex
            surfTag = 'STOP';
        else
            surfTag = 'Surf';
        end
        tblSQSTempData1{kk,1} = surfTag;
        set(aodHandles.tblSQSStandardData, 'Data', tblSQSTempData1);
        
        tblSQSTempData2{kk,1} = surfTag;
        set(aodHandles.tblSQSApertureData, 'Data', tblSQSTempData2);
        
        tblSQSTempData5{kk,1} = surfTag;
        set(aodHandles.tblSQSTiltDecenterData, 'Data', tblSQSTempData5);
        
    end
end
end
function MakeThisStopSurface (aodHandles)
global SELECTED_CELL_SS
if isempty(SELECTED_CELL_SS)
    return
end
surfIndex = SELECTED_CELL_SS(1);
tblSSTempData1 = get(aodHandles.tblSSStandardData,'data');
if ~strcmpi(tblSSTempData1{1,1},'OBJECT') &&...
        ~strcmpi(tblSSTempData1{1,1},'IMAGE')&...
        ~strcmpi(tblSSTempData1{1,1},'STOP')
    tblSSTempData2 = get(aodHandles.tblSSApertureData,'data');
    tblSSTempData5 = get(aodHandles.tblSSTiltDecenterData,'data');
    for kk = 1:size(tblSSTempData1,1)
        if kk == surfIndex
            surfTag = 'STOP';
        else
            surfTag = 'Surf';
        end
        tblSSTempData1{kk,1} = surfTag;
        set(aodHandles.tblSSStandardData, 'Data', tblSSTempData1);
        
        tblSSTempData2{kk,1} = surfTag;
        set(aodHandles.tblSSApertureData, 'Data', tblSSTempData2);
        
        tblSSTempData5{kk,1} = surfTag;
        set(aodHandles.tblSSTiltDecenterData, 'Data', tblSSTempData5);
    end
end
end

function UpdateCurrentComponent()
end
function UpdateComponentArray(aodHandles)

end

function InsertNewComponent(parentWindow,componentType,insertPosition)
%update component list table
aodHandles = parentWindow.AODParentHandles;

tblData1 = get(aodHandles.tblComponentList,'data');
sizeTblData1 = size(tblData1);
nComponent = sizeTblData1(1);

partA = tblData1(1:insertPosition-1,:);

newRow =  {componentType,'',true,true};
partB = tblData1(insertPosition:sizeTblData1 ,:);

newTable1 = [partA; newRow; partB];
%sysTable1 = aodHandles.tblComponentList;
set(aodHandles.tblComponentList, 'Data', newTable1);

% Update the component array
for kk = nComponent:-1:insertPosition
    aodHandles.ComponentArray(kk+1) = aodHandles.ComponentArray(kk);
end
aodHandles.ComponentArray(insertPosition) = Component(componentType);
%
% If possible add here a code to select the first cell of newly added row
% automatically

parentWindow.AODParentHandles = aodHandles;
end

function RemoveComponent(parentWindow,removePosition)
aodHandles = parentWindow.AODParentHandles;

%update component list table
tblData1 = get(aodHandles.tblComponentList,'data');
sizeTblData1 = size(tblData1);
partA = tblData1(1:removePosition-1,:);
partB = tblData1(removePosition+1:sizeTblData1 ,:);

newTable1 = [partA; partB];
%sysTable1 = aodHandles.tblComponentList;
set(aodHandles.tblComponentList, 'Data', newTable1);

% Update the component array
aodHandles.ComponentArray = aodHandles.ComponentArray([1:removePosition-1,removePosition+1:end]);

% If possible add here a code to select the first cell of newly added row
% automatically

parentWindow.AODParentHandles = aodHandles;
end



function setSQSStandardDataTableColumnNames (aodHandles,surfaceType)
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
set(aodHandles.tblSQSStandardData, 'ColumnFormat', ...
    {'char', 'char',{supportedSurfaces{:}},'char','numeric', 'char','char', 'char',...
    'char', 'char', columnFormat{:}});
set(aodHandles.tblSQSStandardData,'ColumnEditable', logical(columnEditable1),...
    'ColumnName', columnName1,'ColumnWidth',columnWidth1);

end


function setSSStandardDataTableColumnNames (aodHandles,surfaceType)
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
set(aodHandles.tblSSStandardData, 'ColumnFormat', ...
    {'char', 'char',{supportedSurfaces{:}},'char','numeric', 'char','char', 'char',...
    'char', 'char', columnFormat{:}});
set(aodHandles.tblSSStandardData,'ColumnEditable', logical(columnEditable1),...
    'ColumnName', columnName1,'ColumnWidth',columnWidth1);

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
