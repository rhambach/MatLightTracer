function  InitializeMainWindow( figHandle)
% InitializeMainWindow: Adds toolbar buttons, menus and pannels to a 
% figure which serves as main window 

fontSize = 10;
%% Pannels
panelMain = ...
    uipanel('Parent',figHandle,'FontSize',fontSize,...
              'units','normalized','Position',[0.15,0.04,0.85,1]);
panelLeftSide = ...
    uipanel('Parent',figHandle,'FontSize',fontSize,...
              'units','normalized','Position',[0,0.04,0.15,1]);   
panelTaskBar = ...
    uipanel('Parent',figHandle,'FontSize',fontSize,...
              'units','normalized','Position',[0,0,1,0.04]);            
%% Toolbar Buttons
% Create the toolbar
toolBarHandle = uitoolbar(figHandle);

% Toolbar Icon Images
a = [.20:.05:0.95];
img1(:,:,1) = repmat(a,16,1)';
img1(:,:,2) = repmat(a,16,1);
img1(:,:,3) = repmat(flipdim(a,2),16,1);

% Insert Surface buttons
btnInsertSurface = uipushtool(toolBarHandle,'CData',img1,...
           'TooltipString','Insert Surface');
set(btnInsertSurface,'ClickedCallback',@btnInsertSurface_ClickedCallback);
% Remove Surface buttons       
btnRemoveSurface = uipushtool(toolBarHandle,'CData',img1,...
           'TooltipString','Remove Surface');
set(btnRemoveSurface,'ClickedCallback',@btnRemoveSurface_ClickedCallback);  
       
end

