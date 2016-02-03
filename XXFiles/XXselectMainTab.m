function selectMainTab(parentWindow,ind)
    % Programatically clicks the main tab with the given index
    % Member of AODParentWindow class
    
    selectedTabBtnHeight = 0.045;
    selectedTabBtnWidth = 0.18;
    selectedTabBtnColor = [240,240,240]./256;
    tabBtnHeight = 0.04;
    tabBtnWidth = 0.18;
    tabBtnColor = [200,200,200]./256;
    
    for k = 1:parentWindow.AODParentHandles.nMainTab
        set(parentWindow.AODParentHandles.panelMainTab(k),'Visible', 'off');
        set(get(parentWindow.AODParentHandles.panelMainTab(k),'Children'),'Visible', 'off');
        set(parentWindow.AODParentHandles.btnMainTab(k),...
            'BackgroundColor',tabBtnColor,...
            'Position', [(k-1)*tabBtnWidth, 0.955, tabBtnWidth, tabBtnHeight]);
    end
    set(parentWindow.AODParentHandles.panelMainTab(ind),'Visible', 'on');
    set(get(parentWindow.AODParentHandles.panelMainTab(ind),'Children'),'Visible', 'on');
    set(parentWindow.AODParentHandles.btnMainTab(ind),...
        'BackgroundColor',selectedTabBtnColor,...
        'Position', [(ind-1)*selectedTabBtnWidth, 0.955, selectedTabBtnWidth, selectedTabBtnHeight]);
    
    if ind == 2 && get(parentWindow.AODParentHandles.chkUpdateSurfaceEditorFromComponentEditor,'value')
        % Surface Editor button clicked and Update surface editor checkbox
        % checked, then update the surface editor tbles from component editor
        parentWindow = fromComponentEditorToSurfaceEditor(parentWindow);
    end
end

