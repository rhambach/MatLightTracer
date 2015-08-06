function [ added ] = addGlassToGlasssCatalogue( glassObject,glassCatalogueFullFileName )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here




%load the glass catalogue file and add the new glass
load(glassCatalogueFullFileName,'AllGlass');

%check that the glass doesnot exsist in the catalogue
name = glassObject.Name;
location = find(strcmpi({AllGlass.Name},name));
if ~isempty(location)
   button = questdlg(strcat(name, ' is already in the catalogue. Do you want to update it?'),'Glass Found','Yes','No','Cancel');
   switch button
       case 'Yes'
            AllGlass(location(1)) = glassObject;
            save(glassCatalogueFullFileName,'AllGlass');
            clear AllGlass;
       case 'No' 
           selRow = getappdata(0,'surfIndexForGlass');
           tblData = get(findobj('Tag','tblStandardData'),'data');
           tblData{selRow,9} = '';     
           set(findobj('Tag','tblStandardData'), 'Data', tblData);            
       case 'Cancel'
           
   end
else
    AllGlass(length(AllGlass)+1) = glassObject;
    save(glassCatalogueFullFileName,'AllGlass');
    clear AllGlass;
end
added = 1;
end

