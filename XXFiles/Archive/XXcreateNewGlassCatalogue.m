% to create a new glass catalog file
function created = createNewGlassCatalogue(catFullFileName)
%check if the catalogue already exsit
if exist(catFullFileName,'file')
    button = questdlg('Glass catalogue already exists, Do you want to replace?','Existing File','Yes Replace','No Just Append','Cancel');
    switch button
        case 'Yes Replace'
            AllGlass = Glass('Air',[0 0 0 0 0 0]);
            save(strcat(catFullFileName),'AllGlass');
            save(strcat(catFullFileName),'AllGlass','-append');
            created = 1;
        case 'No Just Append'
            created = 0;
        case 'Cancel'
            created = 0;
    end
else
    AllGlass = Glass('Air',[0 0 0 0 0 0]);
    save(strcat(catFullFileName),'AllGlass');
    save(strcat(catFullFileName),'AllGlass','-append');
    created = 1;
end
end

