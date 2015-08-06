function [ closed ] = closeAllWindows(aodHandles)
%closeAllWindows: Closes all windows opened except the main window
    tblData1 = get(aodHandles.tblOpenedWindowsList,'data');
    totRow = size(tblData1,1);
    for k = 1:totRow
        figHandle = tblData1{k,3};
        if figHandle > 0
            close(figHandle);
        end
    end
closed = 1;
end

