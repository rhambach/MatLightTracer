function [ added ] = addCoatingToCoatingCatalogue( coatingObject,coatingCatalogueFullName )
%ADDCOATINGTOCOATINGCATALOGUE Adds the given coating object to the given
% catalogue.

if isValidCoatingCatalogue( coatingCatalogueFullName )
    %load the coating catalogue file
    load(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
    
    %check that the coating doesnot exsist in the catalogue
    name = coatingObject.Name;
    location = find(strcmpi({CoatingArray.Name},name));
    if ~isempty(location)
        alternativeName = [name,'1'];
        button = questdlg(strcat(name, ' is already in the catalogue.',...
            ' Do you want to save with new coating name: ',alternativeName, ' ?'),'New Coating Name','Yes Save','No Replace','Yes Save');
        switch button
            case 'Yes Save'
                newCoatingObject = coatingObject;
                newCoatingObject.Name = alternativeName;
                added = addCoatingToCoatingCatalogue( newCoatingObject,coatingCatalogueFullName );
                clear CoatingArray;
            case 'No Replace'
                CoatingArray(location(1)) = coatingObject;
                save(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
                clear CoatingArray;
                clear 'FileInfoStruct';
                disp(strcat(name, ' is successfully updated in the catalogue.'));
        end
    else
        CoatingArray(length(CoatingArray)+1) = coatingObject;
        save(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
        clear CoatingArray;
        clear 'FileInfoStruct';
        disp(strcat(name, ' is successfully added to the catalogue.'));
    end
    added = 1;
else
    added = 0;
end
end

