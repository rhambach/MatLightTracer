function fig_hdl = AODMainWindow
% AODMainWindow: Abbe Optical Designer Main Window
%--------------------------------------------------------------------------
% File name   : AODMainWindow.m
% Generated on: 22-Feb-2014 08:41:57
% Description :
%--------------------------------------------------------------------------

% Define some global parameters
global HANDLES;
% Initialize handles structure
HANDLES = struct();

% Create all UI controls
build_gui();


%% ---------------------------------------------------------------------------
    function build_gui()
        % Creation of all uicontrols
        % --- FIGURE -------------------------------------
        HANDLES.AODMainWindow = figure( ...
            'Tag', 'AODMainWindow', ...
            'Units', 'normalized', ...
            'Position', [0 0.06 1 0.80], ...
            'Name', 'AODMainWindow', ...
            'MenuBar', 'none', ...
            'NumberTitle', 'off', ...
            'Color', get(0,'DefaultUicontrolBackgroundColor'), ...
            'Resize', 'on', ...
            'Visible', 'off',...
            'CreateFcn', @AODMainWindow_CreateFcn, ...
            'ResizeFcn', @AODMainWindow_ResizeFcn);
               
        % Invisible Handles to save some properties related to the main gui
        % save file name and path
        HANDLES.Saved = uicontrol('Style','checkbox','Visible','off','Value',0);
        HANDLES.PathName = uicontrol('Style','text','Visible','off','String','');
        HANDLES.FileName = uicontrol('Style','text','Visible','off','String','');
        % save number of main tabs
        nMainTab = 3;
        HANDLES.nMainTab = uicontrol('Style','text','Visible','off','String',nMainTab);
        % Save global font size
        fontSize = 10;
        HANDLES.fontSize = uicontrol('Style','text','Visible','off','String',fontSize);

        
        
        % -------------------- PANELS -------------------------------------
        HANDLES = InitializePanels(HANDLES);
        %----------------- Initialize Panel Components -------------------
        HANDLES = InitializeOpenedWindowsPanel(HANDLES);
        HANDLES = InitializeWelcomePanel(HANDLES);
        HANDLES = InitializeSystemConfigurationPanel(HANDLES);  
        HANDLES = InitializeSurfaceEditorPanel(HANDLES);
        
         % ---------------- MENU and TOOLBAR ITEMS -------------------------
        HANDLES = InitializeMenuAndToolbarItems(HANDLES);   
        
        % Click Welcome tab programatically
        
        for k = 2:nMainTab
          set(get(HANDLES.panelMainTab(k),'Children'),'Visible', 'off');
          set(HANDLES.btnMainTab(k),'BackgroundColor',[200,200,200]./256);
        end
        set(get(HANDLES.panelMainTab(1),'Children'),'Visible', 'on');
        set(HANDLES.btnMainTab(1),'BackgroundColor',[240,240,240]./256);
        
       % Assign function output
       set(HANDLES.AODMainWindow,'Visible', 'on');
       fig_hdl = HANDLES.AODMainWindow;
       % fig_hdl = HANDLES;     
    end
%% ---------------------------------------------------------------------------
    function AODMainWindow_CreateFcn(hObject,evendata) %#ok<INUSD>

    end

%% ---------------------------------------------------------------------------
    function AODMainWindow_ResizeFcn(hObject,evendata) %#ok<INUSD>
        
    end


end