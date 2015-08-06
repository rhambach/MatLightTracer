function [ parentWindow ] = resetOpenedWindowsMenu( parentWindow )
    % resetOpenedWindowsMenu: reset the opened window panel
    % Member of ParentWindow class
    
    aodHandles = parentWindow.ParentHandles;
    handlesAreObjects = ~isnumeric(aodHandles.menuOpenedWindows);
    nOpenedWindows = length(aodHandles.menuOpenedWindows)-2;
    for kk = 3:nOpenedWindows
        if handlesAreObjects && isvalid(aodHandles.menuOpenedWindows(kk))
            delete(aodHandles.menuOpenedWindows(kk));
        else
            try
                delete(aodHandles.menuOpenedWindows(kk));
            catch
            end
        end
    end
%     delete(aodHandles.menuOpenedWindows(2:end));
    parentWindow.ParentHandles = aodHandles;
    
end

