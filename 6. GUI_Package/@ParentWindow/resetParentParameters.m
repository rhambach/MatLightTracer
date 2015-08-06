function resetParentParameters( parentWindow )
    % RESETOTHERPARAMETERS resets parameters of the parentWindow
    % Member of ParentWindow class
    set(parentWindow.ParentHandles.FigureHandle,'Name','Untitled');
    parentWindow.ParentHandles.ChildWindows = ChildWindow.empty; 
    parentWindow.ParentHandles.NextChildIndex = 1; 
    parentWindow.ParentHandles.Saved = 0;
    parentWindow.ParentHandles.PathName = '';
    parentWindow.ParentHandles.FileName = '';
end

