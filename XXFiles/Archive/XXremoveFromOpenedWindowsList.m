function removed =  removeFromOpenedWindowsList( parentWindow,childWindow)
%removeFromOpenedWindowList: remove the current window from opened window list 

    childWindowIndex = childWindow.AODChildHandles.Index;  
    tblData1 = get(parentWindow.AODParentHandles.tblOpenedWindowsList,'data');
    [isMem,selRow] = ismember(childWindowIndex,tblData1{:,3});
    
    totRow = size(tblData1,1);
    parta1 = tblData1(1:selRow-1,:);
    partb1 = tblData1(selRow+1:totRow ,:);
    newTable1 = [parta1; partb1];
    set(parentWindow.AODParentHandles.tblOpenedWindowsList, 'Data', newTable1);
    removed = 1;
end

