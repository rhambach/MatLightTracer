function added =  addToOpenedWindowsList( parentWindow,childWindow)
%addToOpenedWindowList: adds the current window to opened window list
    aodHandles = parentWindow.AODParentHandles;
    tblData1 = get(aodHandles.tblOpenedWindowsList,'data');
    newRow1 =  {true,childWindow.Name,childWindow.Index};
    newTable1 = [tblData1; newRow1];
    set(aodHandles.tblOpenedWindowsList, 'Data', newTable1); 
    added = 1;
end

