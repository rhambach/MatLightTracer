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
% Button Insert Lens as component
[iconImage map] = imread(which('lensIcon.jpg'));
lensIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentSQS = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(1),...
    'CData',lensIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentSQS_Callback,parentWindow});
aodHandles.lblInsertComponentSQS = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(1),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','SQS',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);

% Button Insert Prism as component
[iconImage surfMap] = imread(which('PrismIcon.jpg'));
prismIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentPrism = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(2),...
    'CData',prismIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentPrism_Callback,parentWindow});
aodHandles.lblInsertComponentPrism = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(2),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','Prism',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);

% Button Insert Grating as component
[iconImage surfMap] = imread(which('GratingIcon.jpg'));
gratingIcon=imresize(iconImage, [25 60]);
aodHandles.btnInsertComponentGrating = uicontrol(...
    'Style', 'pushbutton', ...
    'Parent',aodHandles.panelAvailableComponent(3),...
    'CData',gratingIcon,...
    'Units','Normalized',...
    'Position',[0.0,0.3,1.0,0.7],...
    'Callback',{@btnInsertComponentGrating_Callback,parentWindow});
aodHandles.lblInsertComponentGrating = uicontrol(...
    'Style', 'text', ...
    'Parent',aodHandles.panelAvailableComponent(3),...
    'FontSize',fontSize,'FontName', fontName,...
    'String','Grating',...
    'Units','Normalized',...
    'Position',[0.0,0.0,1.0,0.3]);


% Divide the area in to component list panel and component detail panel
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

% Sequence of surface parameters panel
aodHandles.frameSeqOfSurfDefinition = uicontrol( ...
    'Parent',aodHandles.panelComponentDefinition,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.0,0.8,1.0],...
    'CData',imresize(imread(which('SeqOfSurfDefinition.jpg')), [150 600]),...
    'Visible','off');

aodHandles.panelSeqOfSurfParameters = uipanel(...
    'Parent',aodHandles.panelComponentDetail,...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.0,1.0,0.7],...
    'Visible','off');

% Command buttons for adding and removing surfaces
aodHandles.btnInsertSurfToSeqOfSurf = uicontrol( ...
    'Parent',aodHandles.panelSeqOfSurfParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.0,0.91,0.1,0.08],...
    'String','Insert',...
    'Callback',{@btnInsertSurfToSeqOfSurf_Callback,parentWindow});
aodHandles.btnRemoveSurfFromSeqOfSurf = uicontrol( ...
    'Parent',aodHandles.panelSeqOfSurfParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.1,0.91,0.1,0.08],...
    'String','Remove',...
    'Callback',{@btnRemoveSurfFromSeqOfSurf_Callback,parentWindow});
aodHandles.btnStopSurfaceOfSeqOfSurf = uicontrol( ...
    'Parent',aodHandles.panelSeqOfSurfParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.2,0.91,0.15,0.08],...
    'String','Make Stop',...
    'Callback',{@btnStopSurfaceOfSeqOfSurf_Callback,parentWindow});
aodHandles.btnSaveSeqOfSurf = uicontrol( ...
    'Parent',aodHandles.panelSeqOfSurfParameters,...
    'Style', 'pushbutton', ...
    'FontSize',fontSize,'FontName', fontName,...
    'units','normalized',...
    'Position',[0.9,0.91,0.1,0.08],...
    'String','Save',...
    'Callback',{@btnSaveSeqOfSurf_Callback,parentWindow});

aodHandles.seqOfSurfEditorTabGroup = uitabgroup(...
    'Parent', aodHandles.panelSeqOfSurfParameters, ...
    'Units', 'Normalized', ...
    'Position', [0, 0, 1.0, 0.9]); 
aodHandles.seqOfSurfStandardDataTab = ...
    uitab(aodHandles.seqOfSurfEditorTabGroup, 'title','Standard Data');
aodHandles.seqOfSurfApertureDataTab = ...
    uitab(aodHandles.seqOfSurfEditorTabGroup, 'title','Aperture Data');
aodHandles.seqOfSurfAsphericDataTab = ...
    uitab(aodHandles.seqOfSurfEditorTabGroup, 'title','Aspheric Data');
aodHandles.seqOfSurfGratingDataTab = ...
    uitab(aodHandles.seqOfSurfEditorTabGroup, 'title','Grating Data');
aodHandles.seqOfSurfTiltDecenterDataTab = ...
    uitab(aodHandles.seqOfSurfEditorTabGroup, 'title','Tilt Decenter Data');

% Initialize the panel and table for standard data
aodHandles.tblSeqOfSurfStandardData = uitable('Parent',aodHandles.seqOfSurfStandardDataTab,...
    'FontSize',fontSize,'FontName', fontName,'units','normalized','Position',[0 0 1 1]);                    
% Initialize the panel and table for aperture data
aodHandles.tblSeqOfSurfApertureData = ...
    uitable('Parent',aodHandles.seqOfSurfApertureDataTab,'FontSize',fontSize,'FontName', fontName,...
              'units','normalized','Position',[0 0 1 1]); 
% Initialize the panel and table for aspheric data
aodHandles.tblSeqOfSurfAsphericData = ...
    uitable('Parent',aodHandles.seqOfSurfAsphericDataTab,'FontSize',fontSize,'FontName', fontName,...
              'units','normalized','Position',[0 0 1 1]); 
% Initialize the panel and table for grating data
aodHandles.tblSeqOfSurfGratingData = ...
    uitable('Parent',aodHandles.seqOfSurfGratingDataTab,'FontSize',fontSize,'FontName', fontName,...
              'units','normalized','Position',[0 0 1 1]);            
% Initialize the panel and table for tilt decenter data
aodHandles.tblSeqOfSurfTiltDecenterData = ...
    uitable('Parent',aodHandles.seqOfSurfTiltDecenterDataTab,'FontSize',fontSize,'FontName', fontName,...
              'units','normalized','Position',[0 0 1 1]); 

% Give all tables initial data
parentWindow.AODParentHandles = aodHandles;
parentWindow = resetSeqOfSurfEditorPanel(parentWindow);
aodHandles = parentWindow.AODParentHandles;

% Prism parameters panel
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


aodHandles.lblApexAngle1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.72,0.15,0.1],...
    'String', 'Apex Angle 1');
aodHandles.txtApexAngle1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.75,0.2,0.08],...
    'String', '60');
aodHandles.lblSurf1TiltX  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.72,0.15,0.1],...
    'String', 'Tilt X1');
aodHandles.txtSurf1TiltX = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.75,0.2,0.08],...
    'String', '0');



aodHandles.lblApexAngle2  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.62,0.15,0.1],...
    'String', 'Apex Angle 2');
aodHandles.txtApexAngle2 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.65,0.2,0.08],...
    'String', '60');
aodHandles.lblSurf1TiltY  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.62,0.15,0.1],...
    'String', 'Tilt Y1');
aodHandles.txtSurf1TiltY = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.65,0.2,0.08],...
    'String', '0');


aodHandles.lblApertureX1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.52,0.15,0.1],...
    'String', 'Side Length X1');
aodHandles.txtApertureX1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.55,0.2,0.08],...
    'String', '5');
aodHandles.lblSurf1TiltZ  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.52,0.15,0.1],...
    'String', 'Tilt Z1');
aodHandles.txtSurf1TiltZ = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.55,0.2,0.08],...
    'String', '0');

aodHandles.lblApertureY1  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.42,0.15,0.1],...
    'String', 'Side Length Y1');
aodHandles.txtApertureY1 = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.45,0.2,0.08],...
    'String', '5');
aodHandles.lblSurf1DecenterX  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.42,0.15,0.1],...
    'String', 'Decenter X1');
aodHandles.txtSurf1DecenterX = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.45,0.2,0.08],...
    'String', '0');

aodHandles.lblDistnaceToNextComponent  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.01,0.32,0.15,0.1],...
    'String', 'Dist. After');
aodHandles.txtDistnaceToNextComponent = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit', ...
    'units','normalized',...
    'BackgroundColor',[1,1,1],...
    'Position',[0.18,0.35,0.2,0.08],...
    'String', '5');
aodHandles.lblSurf1DecenterY  = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'Style', 'text', ...
    'HorizontalAlignment','Left',...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'units','normalized',...
    'Position',[0.51,0.32,0.15,0.1],...
    'String', 'Decenter Y1');
aodHandles.txtSurf1DecenterY = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'edit',...
    'BackgroundColor',[1,1,1],...
    'units','normalized',...
    'Position',[0.66,0.35,0.2,0.08],...
    'String', '0');


aodHandles.lblMakeSurface1Stop  = uicontrol( ...
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
aodHandles.chkReturnCoordinateToPreviousSurface = uicontrol( ...
    'Parent', aodHandles.panelPrismParameters, ...
    'FontSize',fontSize,'FontName', 'FixedWidth',...
    'Style', 'checkbox', ...
    'String', 'Return Coordinate To Previous Surface',...
    'units','normalized',...
    'Position',[0.51,0.25,0.49,0.08],...
    'Value', 0);

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
set(aodHandles.tblSeqOfSurfStandardData,...
    'CellEditCallback',{@tblSeqOfSurfStandardData_CellEditCallback,parentWindow},...
    'CellSelectionCallback',{@tblSeqOfSurfStandardData_CellSelectionCallback,parentWindow});    

set(aodHandles.tblSeqOfSurfApertureData,...
    'CellEditCallback',{@tblSeqOfSurfApertureData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSeqOfSurfApertureData_CellSelectionCallback,aodHandles});    
set(aodHandles.tblSeqOfSurfAsphericData,...
    'CellEditCallback',{@tblSeqOfSurfAsphericData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSeqOfSurfAsphericData_CellSelectionCallback,aodHandles});
set(aodHandles.tblSeqOfSurfGratingData,...
    'CellEditCallback',{@tblSeqOfSurfGratingData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSeqOfSurfAsphericData_CellSelectionCallback,aodHandles});
set(aodHandles.tblSeqOfSurfTiltDecenterData,...
    'CellEditCallback',{@tblSeqOfSurfTiltDecenterData_CellEditCallback,aodHandles},...
    'CellSelectionCallback',{@tblSeqOfSurfTiltDecenterData_CellSelectionCallback,aodHandles});
   
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
    case {lower('SQS')}
        % Fill the surface parameters to the GUI
        nSurface = currentComponent.Parameters.NumberOfSurfaces;
        surfaceArray = currentComponent.Parameters.SurfaceArray;
        % initializ
        savedStandardData = cell(nSurface,14);
        savedApertureData = cell(nSurface,12);
        savedAsphericData = cell(nSurface,28);
        savedGratingData = cell(nSurface,6);
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
            savedStandardData{k,5} = num2str(surfaceArray(k).Radius);  
            savedStandardData{k,6} = '';
            savedStandardData{k,7} = num2str(surfaceArray(k).Thickness);
            savedStandardData{k,8} = '';

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
            savedStandardData{k,9} = glassDisplayName;
            savedStandardData{k,10} = '';
            savedStandardData{k,11} = num2str(surfaceArray(k).ClearAperture);  
            savedStandardData{k,12} = '';
            savedStandardData{k,13} = upper(num2str(surfaceArray(k).Coating.Name));  
            savedStandardData{k,14} = '';

            % aperture data
            savedApertureData{k,1} = savedStandardData{k,1};
            savedApertureData{k,2} = savedStandardData{k,3};
            savedApertureData{k,3} = char(surfaceArray(k).ApertureType);
            savedApertureData{k,4} = '';
            savedApertureData{k,5} = num2str(surfaceArray(k).ApertureParameter(1));
            savedApertureData{k,6} = '';
            savedApertureData{k,7} = num2str(surfaceArray(k).ApertureParameter(2));
            savedApertureData{k,8} = '';
            savedApertureData{k,9} = num2str(surfaceArray(k).ApertureParameter(3));
            savedApertureData{k,10} = '';
            savedApertureData{k,11} = num2str(surfaceArray(k).ApertureParameter(4));
            savedApertureData{k,12} = '';

            %aspheric data
            savedAsphericData{k,1} = savedStandardData{k,1};
            savedAsphericData{k,2} = savedStandardData{k,3};
            savedAsphericData{k,3} = num2str(surfaceArray(k).ConicConstant);
            savedAsphericData{k,4} = '';
            savedAsphericData{k,5} = num2str(surfaceArray(k).PloynomialCoefficients(1));
            savedAsphericData{k,6} = '';
            savedAsphericData{k,7} = num2str(surfaceArray(k).PloynomialCoefficients(2));
            savedAsphericData{k,8} = '';
            savedAsphericData{k,9} = num2str(surfaceArray(k).PloynomialCoefficients(3));
            savedAsphericData{k,10} = '';
            savedAsphericData{k,11} = num2str(surfaceArray(k).PloynomialCoefficients(4));
            savedAsphericData{k,12} = '';
            savedAsphericData{k,13} = num2str(surfaceArray(k).PloynomialCoefficients(5));
            savedAsphericData{k,14} = '';
            savedAsphericData{k,15} = num2str(surfaceArray(k).PloynomialCoefficients(6));
            savedAsphericData{k,16} = '';
            savedAsphericData{k,17} = num2str(surfaceArray(k).PloynomialCoefficients(7));
            savedAsphericData{k,18} = '';
            savedAsphericData{k,19} = num2str(surfaceArray(k).PloynomialCoefficients(8));
            savedAsphericData{k,20} = '';
            savedAsphericData{k,21} = num2str(surfaceArray(k).PloynomialCoefficients(9));
            savedAsphericData{k,22} = '';
            savedAsphericData{k,23} = num2str(surfaceArray(k).PloynomialCoefficients(10));
            savedAsphericData{k,24} = '';
            savedAsphericData{k,25} = num2str(surfaceArray(k).PloynomialCoefficients(11));
            savedAsphericData{k,26} = '';
            savedAsphericData{k,27} = num2str(surfaceArray(k).PloynomialCoefficients(12));
            savedAsphericData{k,28} = '';

            % grating data
            savedGratingData{k,1} = savedStandardData{k,1};
            savedGratingData{k,2} = savedStandardData{k,3};
            if isprop(surfaceArray(k),'GratingLineDensity')
                savedGratingData{k,3} = num2str(surfaceArray(k).GratingLineDensity);
            end
            savedGratingData{k,4} = '';
            if isprop(surfaceArray(k),'DiffractionOrder')
                savedGratingData{k,5} = num2str(surfaceArray(k).DiffractionOrder);
            end
            savedGratingData{k,6} = '';

            %tilt decenter data
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
            savedTiltDecenterData{k,5} = num2str(surfaceArray(k).DecenterParameter(1));
            savedTiltDecenterData{k,6} = '';
            savedTiltDecenterData{k,7} = num2str(surfaceArray(k).DecenterParameter(2));
            savedTiltDecenterData{k,8} = '';
            savedTiltDecenterData{k,9} = num2str(surfaceArray(k).TiltParameter(1));
            savedTiltDecenterData{k,10} = '';
            savedTiltDecenterData{k,11} = num2str(surfaceArray(k).TiltParameter(2));
            savedTiltDecenterData{k,12} = '';
            savedTiltDecenterData{k,13} = num2str(surfaceArray(k).TiltParameter(3));
            savedTiltDecenterData{k,14} = '';
            savedTiltDecenterData{k,15} = char(surfaceArray(k).TiltMode);
            savedTiltDecenterData{k,16} = '';

        end
        sysTable1 = aodHandles.tblSeqOfSurfStandardData;
        set(sysTable1, 'Data', savedStandardData);

        sysTable2 = aodHandles.tblSeqOfSurfApertureData;
        set(sysTable2, 'Data', savedApertureData);

        sysTable4 = aodHandles.tblSeqOfSurfAsphericData;
        set(sysTable4, 'Data', savedAsphericData);

        sysTable5 = aodHandles.tblSeqOfSurfTiltDecenterData;
        set(sysTable5, 'Data', savedTiltDecenterData);

        sysTable6 = aodHandles.tblSeqOfSurfGratingData;
        set(sysTable6, 'Data', savedGratingData);
    
        % Display the parameters
        set(aodHandles.framePrismDefinition,'visible','off'); 
        set(get(aodHandles.framePrismDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelPrismParameters,'visible','off');
        set(get(aodHandles.panelPrismParameters,'Children'),'Visible', 'off');

        set(aodHandles.frameGratingDefinition,'visible','off'); 
        set(get(aodHandles.frameGratingDefinition,'Children'),'Visible', 'off');        
        set(aodHandles.panelGratingParameters,'visible','off');
        set(get(aodHandles.panelGratingParameters,'Children'),'Visible', 'off');        
        
        set(aodHandles.frameSeqOfSurfDefinition,'visible','on');
        set(get(aodHandles.frameSeqOfSurfDefinition,'Children'),'Visible', 'on');
        set(aodHandles.panelSeqOfSurfParameters,'visible','on');
        set(get(aodHandles.panelSeqOfSurfParameters,'Children'),'Visible', 'on');
    case {lower('Prism')}  
        % Fill the prism parameters to the GUI
        rayPath = currentComponent.Parameters.RayPath;
        currentComponent.Parameters.Surface1TiltDecenterOrder = 'DxDyDzTxTyTz';   
        surf1TiltX = currentComponent.Parameters.Surface1TiltParameter(1);
        surf1TiltY = currentComponent.Parameters.Surface1TiltParameter(2);
        surf1TiltZ = currentComponent.Parameters.Surface1TiltParameter(3);
        surf1DecenterX = currentComponent.Parameters.Surface1DecenterParameter(1);
        surf1DecenterY = currentComponent.Parameters.Surface1DecenterParameter(2);
        
        surf1ApertureX = 2*currentComponent.Parameters.Surface1ApertureParameter(1);
        surf1ApertureY = 2*currentComponent.Parameters.Surface1ApertureParameter(2);
        glassName = currentComponent.Parameters.GlassName;  
        apexAngle1 = currentComponent.Parameters.ApexAngle1; 
        apexAngle2 = currentComponent.Parameters.ApexAngle2;
        distnaceToNextComponent = currentComponent.Parameters.DistanceToNextComponent;
        makeSurf1Stop = currentComponent.Parameters.MakeSurface1Stop;
        returnCoordToPrevSurf = currentComponent.Parameters.ReturnCoordinateToPreviousSurface;
        
        rayPathString = {'S1-S2','S1-S3','S1-S2-S3','S1-S3-S2','S1-S2-S3-S1','S1-S3-S2-S1'};
        rayPathIndex = find(ismember(rayPathString,rayPath));
        set(aodHandles.popPrismRayPath,'value',rayPathIndex);
        set(aodHandles.txtPrismGlassName,'String',glassName);
        set(aodHandles.txtApexAngle1,'String',apexAngle1);
        set(aodHandles.txtApexAngle2,'String',apexAngle2);
        set(aodHandles.txtSurf1TiltX,'String',surf1TiltX);
        set(aodHandles.txtSurf1TiltY,'String',surf1TiltY);
        set(aodHandles.txtSurf1TiltZ,'String',surf1TiltZ);
        set(aodHandles.txtSurf1DecenterX,'String',surf1DecenterX);
        set(aodHandles.txtSurf1DecenterY,'String',surf1DecenterY);
        set(aodHandles.txtApertureX1,'String',surf1ApertureX);
        set(aodHandles.txtApertureY1,'String',surf1ApertureY);
        set(aodHandles.txtDistnaceToNextComponent,'String',distnaceToNextComponent);        
        set(aodHandles.chkMakePrismStop,'Value',makeSurf1Stop);
        set(aodHandles.chkReturnCoordinateToPreviousSurface,'Value',returnCoordToPrevSurf);
        % Display the parameters
        set(aodHandles.frameSeqOfSurfDefinition,'visible','off'); 
        set(get(aodHandles.frameSeqOfSurfDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSeqOfSurfParameters,'visible','off'); 
        set(get(aodHandles.panelSeqOfSurfParameters,'Children'),'Visible', 'off');

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
        glassName = currentComponent.Parameters.GratingGlassName;  
        currentComponent.Parameters.Surface1TiltDecenterOrder = 'DxDyDzTxTyTz';   
        surf1TiltX = currentComponent.Parameters.GratingTiltParameter(1);
        surf1TiltY = currentComponent.Parameters.GratingTiltParameter(2);
        surf1TiltZ = currentComponent.Parameters.GratingTiltParameter(3);
        surf1DecenterX = currentComponent.Parameters.GratingDecenterParameter(1);
        surf1DecenterY = currentComponent.Parameters.GratingDecenterParameter(2);
        
        surf1SideLengthX = 2*currentComponent.Parameters.GratingApertureParameter(1);
        surf1SideLengthY = 2*currentComponent.Parameters.GratingApertureParameter(2);

        distnaceToNextComponent = currentComponent.Parameters.DistanceAfterGrating;
        makeGratingStop = currentComponent.Parameters.MakeGratingStop;   

        tiltMode = currentComponent.Parameters.GratingTiltMode;
        tiltModeString = get(aodHandles.popGratingTiltMode,'String');
        tiltModeIndex = find(ismember(tiltModeString,tiltMode));

        apertureType = currentComponent.Parameters.GratingApertureType;
        apertureTypeString = get(aodHandles.popGratingApertureType,'String');
        apertureTypeIndex = find(ismember(apertureTypeString,apertureType));
        
        set(aodHandles.txtGratingGlassName,'String',glassName);
        set(aodHandles.txtGratingLineDensity,'String',lineDensity);
        set(aodHandles.txtGratingDiffractionOrder,'String',diffractionOrder);
        set(aodHandles.txtGratingTiltX,'String',surf1TiltX);
        set(aodHandles.txtGratingTiltY,'String',surf1TiltY);
        set(aodHandles.txtGratingTiltZ,'String',surf1TiltZ);
        set(aodHandles.txtGratingDecenterX,'String',surf1DecenterX);
        set(aodHandles.txtGratingDecenterY,'String',surf1DecenterY);
        set(aodHandles.txtGratingSideLengthX,'String',surf1SideLengthX);
        set(aodHandles.txtGratingSideLengthY,'String',surf1SideLengthY);
        set(aodHandles.txtDistnaceAfterGrating,'String',distnaceToNextComponent);        
        set(aodHandles.chkMakeGratingStop,'Value',makeGratingStop);        
        set(aodHandles.popGratingTiltMode,'value',tiltModeIndex);
        set(aodHandles.popGratingApertureType,'value',apertureTypeIndex);

        % Display the parameters
        set(aodHandles.frameSeqOfSurfDefinition,'visible','off'); 
        set(get(aodHandles.frameSeqOfSurfDefinition,'Children'),'Visible', 'off');
        set(aodHandles.panelSeqOfSurfParameters,'visible','off'); 
        set(get(aodHandles.panelSeqOfSurfParameters,'Children'),'Visible', 'off');

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

% CellEditCallback
% --- Executes when entered data in editable cell(s) in aodHandles.tblSeqOfSurfStandardData.
function tblSeqOfSurfStandardData_CellEditCallback(~, eventdata,parentWindow)
% hObject    handle to aodHandles.tblSeqOfSurfStandardData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% aodHandles    structure with aodHandles and user data (see GUIDATA)
aodHandles = parentWindow.AODParentHandles;

if eventdata.Indices(2) == 1    %if surface tag  is changed update all tables in the editor
    if (strcmpi(eventdata.PreviousData,'Surf'))
         tblSeqOfSurfData1 = get(aodHandles.tblSeqOfSurfStandardData,'data');
         tblSeqOfSurfData1{eventdata.Indices(1),1} = eventdata.PreviousData;
         set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData1);

    elseif eventdata.Indices(2) == 3 && ~(strcmpi(eventdata.NewData,''))   
     tblSeqOfSurfData2 = get(aodHandles.tblSeqOfSurfApertureData,'data');
     tblSeqOfSurfData2{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(aodHandles.tblSeqOfSurfApertureData, 'Data', tblSeqOfSurfData2);     
     
     tblSeqOfSurfData4 = get(aodHandles.tblSeqOfSurfAsphericData,'data');
     tblSeqOfSurfData4{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(aodHandles.tblSeqOfSurfAsphericData, 'Data', tblSeqOfSurfData4);
     
     tblSeqOfSurfData5 = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
     tblSeqOfSurfData5{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(aodHandles.tblSeqOfSurfTiltDecenterData, 'Data', tblSeqOfSurfData5);
     
     tblSeqOfSurfData6 = get(aodHandles.tblSeqOfSurfGratingData,'data');
     tblSeqOfSurfData6{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(aodHandles.tblSeqOfSurfGratingData, 'Data', tblSeqOfSurfData6);
     
 elseif eventdata.Indices(2) == 5 % if radius field changes    
     if isempty(str2num(eventdata.NewData))||any(imag(str2num(eventdata.NewData)))
         %if the radius field is not a number
         tblSeqOfSurfData1 = get(aodHandles.tblSeqOfSurfStandardData,'data');
         tblSeqOfSurfData1{eventdata.Indices(1),5} = 'Inf';
         set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData1);
     end
elseif eventdata.Indices(1) == 1 && eventdata.Indices(2) == 7 % if first thickness is changed    
    if isValidGeneralInput() % This returns 1 by default, but in the future
        % input validation code shall be defined
    else
         button = questdlg('Invalid input detected. Do you want to restore previous valid object thickness value?','Restore Object Thickness');
         if strcmpi(button,'Yes')
             tblSeqOfSurfData1 = get(aodHandles.tblSeqOfSurfStandardData,'data');
             tblSeqOfSurfData1{eventdata.Indices(1),7} = eventdata.PreviousData;
             set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData1);
         end
    end  
elseif eventdata.Indices(2) == 9 % if glass is changed   
    glassName = eventdata.NewData;
    % Check if the glass name is just Mirror
    if strcmpi(glassName,'Mirror')
        tblSeqOfSurfData{eventdata.Indices(1),9} = 'MIRROR';
        set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);        
        return;         
    % Check if the glass name is just the refractive index of the glass
    elseif ~isnan(str2double(glassName)) % Fixed Index Glass
        tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
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
        tblSeqOfSurfData{eventdata.Indices(1),9} = [num2str(str2double(nd),'%.4f '),',',...
            num2str(str2double(vd),'%.4f '),',',...
            num2str(str2double(pg),'%.4f ')];
        set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);        
        return;        
    end             
                       
    % check for its existance among selected catalogues
    if ~isempty(glassName)
        objectType = 'glass';
        objectName = glassName;
        % Glass Catalogue
        tableData1 = get(aodHandles.tblSeqOfSurfGlassCatalogues,'data');
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
            tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
            tblSeqOfSurfData{eventdata.Indices(1),9} = upper(tblSeqOfSurfData{eventdata.Indices(1),9});
            set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);
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
                    tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
                    tblSeqOfSurfData{eventdata.Indices(1),9} = upper(selectedGlassName);
                    set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);
                case 'No'
                    % Do nothing
                    disp('Warning: Undefined glass used. It may cause problem in the analysis.');
                case 'Cancel'
                    tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
                    tblSeqOfSurfData{eventdata.Indices(1),9} = '';
                    set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);
            end
        end
    end

elseif eventdata.Indices(2) == 13 %if semi diameter is changed update aperture
     % update aperture table if it is Floating Aperture
     tblSeqOfSurfData2 = get(aodHandles.tblSeqOfSurfApertureData,'data');
     if strcmpi(tblSeqOfSurfData2{eventdata.Indices(1),3},'Floating')
        tblSeqOfSurfData2{eventdata.Indices(1),5} = eventdata.NewData; 
        tblSeqOfSurfData2{eventdata.Indices(1),7} = eventdata.NewData;
     end    
     set(aodHandles.tblSeqOfSurfApertureData, 'Data', tblSeqOfSurfData2);
elseif eventdata.Indices(2) == 15 % if coating is changed
    % check for its existance among selected catalogues
    coatName = eventdata.NewData;

    objectType = 'coating';
    objectName = coatName;
    % Coating Catalogue
    tableData1 = get(aodHandles.tblSeqOfSurfCoatingCatalogues,'data');
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
        tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
        tblSeqOfSurfData{eventdata.Indices(1),15} = upper(coatName);
        set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);    
    elseif objectIndex ~= 0
        tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
        tblSeqOfSurfData{eventdata.Indices(1),15} = upper(tblSeqOfSurfData{eventdata.Indices(1),15});
        set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);
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
                tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
                tblSeqOfSurfData{eventdata.Indices(1),15} = upper(selectedCoatingName);
                set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);
            case 'No'
                % Do nothing Just leave it
                disp('Warning: Undefined caoting used. It may cause problem in the analysis.');
            case 'Cancel'
                tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
                tblSeqOfSurfData{eventdata.Indices(1),15} = 'NONE';
                set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfData);
        end
    end
end
end
parentWindow.AODParentHandles = aodHandles;
end

% --- Executes when entered data in editable cell(s) in aodHandles.tblSeqOfSurfAsphericData.
function tblSeqOfSurfAsphericData_CellEditCallback(~, eventdata,aodHandles)
if eventdata.Indices(2) == 3 % if conic constant is changed

elseif eventdata.Indices(2) > 3 % if polynomial coefficnets are changed
     tblSeqOfSurfData4 = get(aodHandles.tblSeqOfSurfAsphericData,'data');
     if ~strcmpi(tblSeqOfSurfData4{eventdata.Indices(1),2},'Even Aspherical')||...
         ~strcmpi(tblSeqOfSurfData4{eventdata.Indices(1),2},'Odd Aspherical')     
         if str2double(strtrim(eventdata.NewData)) ~= 0
             msgbox(['Polynomial coefficients are only defined for Odd or Even ',...
                 'Aspherical surfaces. Please change the surface type first.'],...
                 'Change Surface Type');
             tblSeqOfSurfData4{eventdata.Indices(1),eventdata.Indices(2)} = '0';
         set(aodHandles.tblSeqOfSurfAsphericData, 'Data', tblSeqOfSurfData4);         
     end
     
     end
end
end
% --- Executes when entered data in editable cell(s) in aodHandles.tblSeqOfSurfApertureData.
function tblSeqOfSurfApertureData_CellEditCallback(~, ~,~)
end
% --- Executes when entered data in editable cell(s) in aodHandles.tblSeqOfSurfGratingData.
function tblSeqOfSurfGratingData_CellEditCallback(~, ~,~)
end
% --- Executes when entered data in editable cell(s) in aodHandles.tblSeqOfSurfTiltDecenterData.
function tblSeqOfSurfTiltDecenterData_CellEditCallback(~, eventdata,aodHandles)
if eventdata.Indices(2) == 3  % 3rd row / tiltanddecenter data
    if isempty(eventdata.NewData) || ...
            ~isValidGeneralInput(eventdata.NewData,'TiltDecenterOrder')
        % restore previous data
        tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
        tblSeqOfSurfData{eventdata.Indices(1),3} = eventdata.PreviousData;
        set(aodHandles.tblSeqOfSurfTiltDecenterData, 'Data', tblSeqOfSurfData);
    else
        % valid input so format the text
        orderStr = upper(eventdata.NewData);
        formatedOrder(1:2:11) = upper(orderStr(1:2:11));
        formatedOrder(2:2:12) = lower(orderStr(2:2:12));
        tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
        tblSeqOfSurfData{eventdata.Indices(1),3} = formatedOrder;
        set(aodHandles.tblSeqOfSurfTiltDecenterData, 'Data', tblSeqOfSurfData);
    end
end
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSeqOfSurfStandardData.

function tblSeqOfSurfStandardData_CellSelectionCallback(~, eventdata,parentWindow)
global SELECTED_CELL_SEQOFSURF
global CAN_ADD_SURF_TO_SEQOFSURF
global CAN_REMOVE_SURF_FROM_SEQOFSURF
aodHandles = parentWindow.AODParentHandles;

SELECTED_CELL_SEQOFSURF = cell2mat(struct2cell(eventdata)); %struct to matrix
if isempty(SELECTED_CELL_SEQOFSURF)
    return
end

tblSeqOfSurfData = get(aodHandles.tblSeqOfSurfStandardData,'data');
sizetblSeqOfSurfData = size(tblSeqOfSurfData);

if SELECTED_CELL_SEQOFSURF(2) == 1 && ...
        ~strcmpi(tblSeqOfSurfData{1,1},'OBJECT')&& ...
        ~strcmpi(tblSeqOfSurfData{1,1},'IMAGE') % only when the first column selected
    if sizetblSeqOfSurfData(1) == 1
        CAN_ADD_SURF_TO_SEQOFSURF = 1; 
        CAN_REMOVE_SURF_FROM_SEQOFSURF = 0;       
    else
        CAN_ADD_SURF_TO_SEQOFSURF = 1; 
        CAN_REMOVE_SURF_FROM_SEQOFSURF = 1;   
    end
end
parentWindow.AODParentHandles = aodHandles;
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSeqOfSurfAsphericData.
function tblSeqOfSurfAsphericData_CellSelectionCallback(~, ~,~)
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSeqOfSurfGratingData.
function tblSeqOfSurfGratingData_CellSelectionCallback(~, ~,~)
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSeqOfSurfApertureData.
function tblSeqOfSurfApertureData_CellSelectionCallback(~, ~,~)
end
% --- Executes when selected cell(s) is changed in aodHandles.tblSeqOfSurfTiltDecenterData.
function tblSeqOfSurfTiltDecenterData_CellSelectionCallback(~, ~,~)
end


%% Button Callbacks
function btnInsertComponentSQS_Callback(~,~,myParent)
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'SQS',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertComponentPrism_Callback(~,~,myParent)
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'Prism',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertComponentGrating_Callback(~,~,myParent)
global CURRENT_SELECTED_COMPONENT
global CAN_ADD_COMPONENT
if CAN_ADD_COMPONENT
    insertPosition = CURRENT_SELECTED_COMPONENT;
    InsertNewComponent(myParent,'Grating',insertPosition);
    aodHandles = myParent.AODParentHandles;
end
end
function btnInsertSurfToSeqOfSurf_Callback(~,~,myParent)
        aodHandles = myParent.AODParentHandles;
        InsertNewSurfaceToSeqOfSurf(aodHandles);
end
function btnRemoveSurfFromSeqOfSurf_Callback(~,~,myParent)
        aodHandles = myParent.AODParentHandles;
        RemoveThisSurfaceFromSeqOfSurf(aodHandles);
end
function btnStopSurfaceOfSeqOfSurf_Callback(~,~,myParent)
         aodHandles = myParent.AODParentHandles;
         MakeThisStopSurfaceOfSeqOfSurf (aodHandles) 
end
function btnSaveSeqOfSurf_Callback(~,~,myParent)
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
%Surface Data
tempStandardData = get(aodHandles.tblSeqOfSurfStandardData,'data');
tempAsphericData = get(aodHandles.tblSeqOfSurfAsphericData,'data');
tempApertureData = get(aodHandles.tblSeqOfSurfApertureData,'data');
tempTiltDecenterData = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
tempGratingData = get(aodHandles.tblSeqOfSurfGratingData,'data');

nSurface = size(tempStandardData,1);
surfaceArray(1,nSurface) = Surface;
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
                componentArray(tt).Parameters.MakeSurface1Stop = false;
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
    surfaceArray(k).Radius        = str2double(char(tempStandardData(k,5)));
    
    surfaceArray(k).Thickness     = str2double(char(tempStandardData(k,7)));
    
    % get glass name and then SellmeierCoefficients from file
    glassName = strtrim(char(tempStandardData(k,9)));% text
    if strcmpi(glassName,'Mirror')
            aodObject = Glass('MIRROR','FixedIndex',[1,0,0,0,0,0,0,0,0,0]');
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
    
    surfaceArray(k).ClearAperture  = str2double(char(tempStandardData(k,11)));
    
    % aperture data
    surfaceArray(k).ApertureType      = char(tempApertureData(k,3));
    surfaceArray(k).ApertureParameter = ...
        [str2double(char(tempApertureData(k,5))),str2double(char(tempApertureData(k,7))),...
        str2double(char(tempApertureData(k,9))),str2double(char(tempApertureData(k,11)))];
    
    
    % coating data
    coatName = (char(tempStandardData(k,13)));
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
    
    
    % aspheric data
    surfaceArray(k).ConicConstant          = str2double(char(tempAsphericData(k,3)));
    surfaceArray(k).PloynomialCoefficients = ...
        [str2double(char(tempAsphericData(k,5))),str2double(char(tempAsphericData(k,7))),str2double(char(tempAsphericData(k,9))),...
        str2double(char(tempAsphericData(k,11))),str2double(char(tempAsphericData(k,13))),str2double(char(tempAsphericData(k,15))),...
        str2double(char(tempAsphericData(k,17))),str2double(char(tempAsphericData(k,19))),str2double(char(tempAsphericData(k,21))),...
        str2double(char(tempAsphericData(k,23))),str2double(char(tempAsphericData(k,25))),str2double(char(tempAsphericData(k,27)))];
    
    % grating data
    surfaceArray(k).GratingLineDensity  = str2double(char(tempGratingData(k,3)));
    surfaceArray(k).DiffractionOrder = str2double(char(tempGratingData(k,5)));
    
    % tilt decenter data
    surfaceArray(k).TiltDecenterOrder = char(tempTiltDecenterData(k,3));
    surfaceArray(k).DecenterParameter = ...
        [str2double(char(tempTiltDecenterData(k,5))),str2double(char(tempTiltDecenterData(k,7)))];
    surfaceArray(k).TiltParameter     = ...
        [str2double(char(tempTiltDecenterData(k,9))),str2double(char(tempTiltDecenterData(k,11))),str2double(char(tempTiltDecenterData(k,13)))];
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
function btnSavePrism_Callback(~,~,myParent)
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
currentComponent.Type = 'Prism';
% Read all parameters from the GUI
rayPathString = get(aodHandles.popPrismRayPath,'String');
% {'S1-S2','S1-S3','S1-S2-S3','S1-S3-S2','S1-S2-S3-S1','S1-S3-S2-S1'};
rayPathIndex = get(aodHandles.popPrismRayPath,'value');
rayPath = rayPathString{rayPathIndex};
glassName = get(aodHandles.txtPrismGlassName,'String');
apexAngle1 = str2double(get(aodHandles.txtApexAngle1,'String'));
apexAngle2 = str2double(get(aodHandles.txtApexAngle2,'String'));
surf1TiltX = str2double(get(aodHandles.txtSurf1TiltX,'String'));
surf1TiltY = str2double(get(aodHandles.txtSurf1TiltY,'String'));
surf1TiltZ = str2double(get(aodHandles.txtSurf1TiltZ,'String'));
surf1DecenterX = str2double(get(aodHandles.txtSurf1DecenterX,'String'));
surf1DecenterY = str2double(get(aodHandles.txtSurf1DecenterY,'String'));

surf1ApertureY = 0.5*str2double(get(aodHandles.txtApertureY1,'String'));
surf1ApertureX = 0.5*str2double(get(aodHandles.txtApertureX1,'String'));
distnaceToNextComponent = str2double(get(aodHandles.txtDistnaceToNextComponent,'String'));
makeSurf1Stop = get(aodHandles.chkMakePrismStop,'Value');
returnCoordToPrevSurf = get(aodHandles.chkReturnCoordinateToPreviousSurface,'Value');

if makeSurf1Stop
        % First remove stop from all other surfaces and prisms
        componentArray = aodHandles.ComponentArray;
        nComponent = size(componentArray,2);
        for tt = 1:nComponent
            if strcmpi(componentArray(tt).Type,'Prism')
                componentArray(tt).Parameters.MakeSurface1Stop = false;
            end
            for kk = 1:componentArray(tt).Parameters.NumberOfSurfaces
                componentArray(tt).Parameters.SurfaceArray(kk).Stop = 0;
            end
        end
        aodHandles.ComponentArray = componentArray ;
end
% Assign to component parameters
currentComponent.Parameters.RayPath = rayPath;
currentComponent.Parameters.Surface1TiltDecenterOrder = 'DxDyDzTxTyTz';   
currentComponent.Parameters.Surface1TiltParameter = [surf1TiltX surf1TiltY surf1TiltZ];
currentComponent.Parameters.Surface1DecenterParameter = [surf1DecenterX surf1DecenterY];   
currentComponent.Parameters.Surface1ApertureParameter = [surf1ApertureX surf1ApertureY 0 0];   
currentComponent.Parameters.GlassName = glassName;  
currentComponent.Parameters.ApexAngle1 = apexAngle1; 
currentComponent.Parameters.ApexAngle2 = apexAngle2;
currentComponent.Parameters.DistanceToNextComponent = distnaceToNextComponent;
currentComponent.Parameters.MakeSurface1Stop = makeSurf1Stop;
currentComponent.Parameters.ReturnCoordinateToPreviousSurface = returnCoordToPrevSurf;

currentComponent.Parameters.SurfaceArray = currentComponent.getSurfaceArray;
aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT) = currentComponent;
myParent.AODParentHandles = aodHandles;
end

function btnSaveGrating_Callback(~,~,myParent)
global CURRENT_SELECTED_COMPONENT
aodHandles = myParent.AODParentHandles;
currentComponent = aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT);
currentComponent.Type = 'Grating';
% Read all parameters from the GUI

glassName = get(aodHandles.txtGratingGlassName,'String');
lineDensity = str2double(get(aodHandles.txtGratingLineDensity,'String'));
diffractionOrder = str2double(get(aodHandles.txtGratingDiffractionOrder,'String'));

surf1TiltX = str2double(get(aodHandles.txtGratingTiltX,'String'));
surf1TiltY = str2double(get(aodHandles.txtGratingTiltY,'String'));
surf1TiltZ = str2double(get(aodHandles.txtGratingTiltZ,'String'));
surf1DecenterX = str2double(get(aodHandles.txtGratingDecenterX,'String'));
surf1DecenterY = str2double(get(aodHandles.txtGratingDecenterY,'String'));

surf1ApertureY = 0.5*str2double(get(aodHandles.txtGratingSideLengthY,'String'));
surf1ApertureX = 0.5*str2double(get(aodHandles.txtGratingSideLengthX,'String'));
distnaceToNextComponent = str2double(get(aodHandles.txtDistnaceAfterGrating,'String'));

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
                componentArray(tt).Parameters.MakeSurface1Stop = false;
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
currentComponent.Parameters.GratingGlassName =  glassName;
currentComponent.Parameters.NumberOfSurfaces = 1;
currentComponent.Parameters.SurfaceArray(1) = Surface;
currentComponent.Parameters.GratingTiltDecenterOrder = 'DxDyDzTxTyTz';   
currentComponent.Parameters.GratingTiltParameter = [surf1TiltX surf1TiltY surf1TiltZ];
currentComponent.Parameters.GratingTiltMode = tiltMode;
currentComponent.Parameters.GratingDecenterParameter = [surf1DecenterX surf1DecenterY];  
currentComponent.Parameters.GratingApertureType = apertureType;
currentComponent.Parameters.GratingApertureParameter = [surf1ApertureX surf1ApertureY 0 0];
currentComponent.Parameters.GratingLineDensity = lineDensity; 
currentComponent.Parameters.GratingDiffractionOrder = diffractionOrder; 
currentComponent.Parameters.DistanceAfterGrating = distnaceToNextComponent;
currentComponent.Parameters.MakeGratingStop = makeGratingStop;

currentComponent.Parameters.SurfaceArray = currentComponent.getSurfaceArray;
aodHandles.ComponentArray(CURRENT_SELECTED_COMPONENT) = currentComponent;
myParent.AODParentHandles = aodHandles;
end


%% Local Function
function RemoveThisSurfaceFromSeqOfSurf(aodHandles)
    global SELECTED_CELL_SEQOFSURF
    global CAN_REMOVE_SURF_FROM_SEQOFSURF

    if isempty(SELECTED_CELL_SEQOFSURF)
        return
    end

    if CAN_REMOVE_SURF_FROM_SEQOFSURF
        removePosition = SELECTED_CELL_SEQOFSURF(1);

        %update standard data table
        tblData1 = get(aodHandles.tblSeqOfSurfStandardData,'data');
        sizeTblData1 = size(tblData1);
        parta1 = tblData1(1:removePosition-1,:);
        partb1 = tblData1(removePosition+1:sizeTblData1 ,:);
        newTable1 = [parta1; partb1];
        sysTable1 = aodHandles.tblSeqOfSurfStandardData;
        set(sysTable1, 'Data', newTable1);

         %update aperture table
        tblData3 = get(aodHandles.tblSeqOfSurfApertureData,'data');
        sizeTblData3 = size(tblData3);
        parta3 = tblData3(1:removePosition-1,:);
        partb3 = tblData3(removePosition+1:sizeTblData3 ,:);
        newTable3 = [parta3; partb3];
        sysTable3 = aodHandles.tblSeqOfSurfApertureData;
        set(sysTable3, 'Data', newTable3);

        %update Aspheric table
        tblData4 = get(aodHandles.tblSeqOfSurfAsphericData,'data');
        sizeTblData4 = size(tblData4);
        parta4 = tblData4(1:removePosition-1,:);
        partb4 = tblData4(removePosition+1:sizeTblData4 ,:);
        newTable4 = [parta4; partb4];
        sysTable4 = aodHandles.tblSeqOfSurfAsphericData;
        set(sysTable4, 'Data', newTable4);   

         %update tilt decenter table
        tblData5 = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
        sizeTblData5 = size(tblData5);
        parta5 = tblData5(1:removePosition-1,:);
        partb5 = tblData5(removePosition+1:sizeTblData5 ,:);
        newTable5 = [parta5; partb5];
        sysTable5 = aodHandles.tblSeqOfSurfTiltDecenterData;
        set(sysTable5, 'Data', newTable5);  

        %update grating table
        tblData6 = get(aodHandles.tblSeqOfSurfGratingData,'data');
        sizeTblData6 = size(tblData6);
        parta6 = tblData6(1:removePosition-1,:);
        partb6 = tblData6(removePosition+1:sizeTblData6 ,:);
        newTable6 = [parta6; partb6];
        sysTable6 = aodHandles.tblSeqOfSurfGratingData;
        set(sysTable6, 'Data', newTable6);
    end
    CAN_REMOVE_SURF_FROM_SEQOFSURF = 0;
    SELECTED_CELL_SEQOFSURF = [];
end
function InsertNewSurfaceToSeqOfSurf(aodHandles)
    global SELECTED_CELL_SEQOFSURF
    global CAN_ADD_SURF_TO_SEQOFSURF

    if isempty(SELECTED_CELL_SEQOFSURF)
        return
    end
    if CAN_ADD_SURF_TO_SEQOFSURF
        insertPosition = SELECTED_CELL_SEQOFSURF(1);
        %update standard data table
        tblData1 = get(aodHandles.tblSeqOfSurfStandardData,'data');
        sizeTblData1 = size(tblData1);
        parta1 = tblData1(1:insertPosition-1,:);
        newRow1 =  {'Surf','','Standard','','Inf','','0','','','','+1 Refractive','','0','','',''};
        partb1 = tblData1(insertPosition:sizeTblData1 ,:);
        newTable1 = [parta1; newRow1; partb1];
        sysTable1 = aodHandles.tblSeqOfSurfStandardData;
        set(sysTable1, 'Data', newTable1);

         %update aperture table
        tblData3 = get(aodHandles.tblSeqOfSurfApertureData,'data');
        sizeTblData3 = size(tblData3);
        parta3 = tblData3(1:insertPosition-1,:);
        newRow3 =  {'Surf','Standard','None','','0','','0','','0','','0',''};
        partb3 = tblData3(insertPosition:sizeTblData3 ,:);
        newTable3 = [parta3; newRow3; partb3];
        sysTable3 = aodHandles.tblSeqOfSurfApertureData;
        set(sysTable3, 'Data', newTable3);

        %update Aspheric table
        tblData4 = get(aodHandles.tblSeqOfSurfAsphericData,'data');
        sizeTblData4 = size(tblData4);
        parta4 = tblData4(1:insertPosition-1,:);
        newRow4 =  {'Surf','Standard','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0',''};
        partb4 = tblData4(insertPosition:sizeTblData4 ,:);
        newTable4 = [parta4; newRow4; partb4];
        sysTable4 = aodHandles.tblSeqOfSurfAsphericData;
        set(sysTable4, 'Data', newTable4);   

         %update tilt decenter table
        tblData5 = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
        sizeTblData5 = size(tblData5);
        parta5 = tblData5(1:insertPosition-1,:);
        newRow5 =  {'Surf','Standard','DxDyDzTxTyTz','','0','','0','','0','','0','','0','','DAR',''};
        partb5 = tblData5(insertPosition:sizeTblData5 ,:);
        newTable5 = [parta5; newRow5; partb5];
        sysTable5 = aodHandles.tblSeqOfSurfTiltDecenterData;
        set(sysTable5, 'Data', newTable5);

        %update grating table
        tblData6 = get(aodHandles.tblSeqOfSurfGratingData,'data');
        sizeTblData6 = size(tblData6);
        parta6 = tblData6(1:insertPosition-1,:);
        newRow6 =  {'Surf','Standard','1','','0',''};
        partb6 = tblData6(insertPosition:sizeTblData6 ,:);
        newTable6 = [parta6; newRow6; partb6];
        sysTable6 = aodHandles.tblSeqOfSurfGratingData;
        set(sysTable6, 'Data', newTable6);

        % If possible add here a code to select the first cell of newly added row
        % automatically
    end
    CAN_ADD_SURF_TO_SEQOFSURF = 0;
    SELECTED_CELL_SEQOFSURF = [];
end  
function MakeThisStopSurfaceOfSeqOfSurf (aodHandles) 
global SELECTED_CELL_SEQOFSURF
    if isempty(SELECTED_CELL_SEQOFSURF)
        return
    end    
     surfIndex = SELECTED_CELL_SEQOFSURF(1);
     tblSeqOfSurfTempData1 = get(aodHandles.tblSeqOfSurfStandardData,'data');
     if ~strcmpi(tblSeqOfSurfTempData1{1,1},'OBJECT') &&...
             ~strcmpi(tblSeqOfSurfTempData1{1,1},'IMAGE')&...
             ~strcmpi(tblSeqOfSurfTempData1{1,1},'STOP')
         tblSeqOfSurfTempData2 = get(aodHandles.tblSeqOfSurfApertureData,'data');
         tblSeqOfSurfTempData4 = get(aodHandles.tblSeqOfSurfAsphericData,'data');
         tblSeqOfSurfTempData5 = get(aodHandles.tblSeqOfSurfTiltDecenterData,'data');
         tblSeqOfSurfTempData6 = get(aodHandles.tblSeqOfSurfGratingData,'data');
         for kk = 1:size(tblSeqOfSurfTempData1,1)   
             if kk == surfIndex
                 surfTag = 'STOP';
             else
                 surfTag = 'Surf';
             end
             tblSeqOfSurfTempData1{kk,1} = surfTag;         
             set(aodHandles.tblSeqOfSurfStandardData, 'Data', tblSeqOfSurfTempData1);  

             tblSeqOfSurfTempData2{kk,1} = surfTag;
             set(aodHandles.tblSeqOfSurfApertureData, 'Data', tblSeqOfSurfTempData2);

             tblSeqOfSurfTempData4{kk,1} = surfTag;
             set(aodHandles.tblSeqOfSurfAsphericData, 'Data', tblSeqOfSurfTempData4);

             tblSeqOfSurfTempData5{kk,1} = surfTag;
             set(aodHandles.tblSeqOfSurfTiltDecenterData, 'Data', tblSeqOfSurfTempData5); 

             tblSeqOfSurfTempData6{kk,1} = surfTag;
             set(aodHandles.tblSeqOfSurfGratingData, 'Data', tblSeqOfSurfTempData6);              
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

