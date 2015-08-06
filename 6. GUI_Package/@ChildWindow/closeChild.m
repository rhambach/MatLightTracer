function closeChild(childWindow)
    % Closes the given child window
    % Member of ChildWindow class
    
    % The close window callback removes the child window from the list in
    % the opened menu
    close(childWindow.ChildHandles.FigureHandle);
    childWindow.delete;
end

