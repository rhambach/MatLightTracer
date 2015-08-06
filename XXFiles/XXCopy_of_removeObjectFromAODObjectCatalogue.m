function [ removed ] = removeObjectFromAODObjectCatalogue(objectType, objectName,objectCatalogueFullName )
%REMOVECOATINGTOCOATINGCATALOGUE removes a object to the given
% catalogue.

if isValidAODObjectCatalogue(objectType, objectCatalogueFullName )
    %load the object catalogue file
    load(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
    %check that the object does exsist in the catalogue
    name = objectName;
    location = find(strcmpi({AODObjectArray.Name},name));
    if isempty(location)
        disp(strcat(name, ' is not in the given catalogue.'));
        removed = 0;
        return;
    else
        AODObjectArray = AODObjectArray([1:location(1)-1,location(1)+1:end]);
        save(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
        clear 'AODObjectArray';
        clear 'FileInfoStruct';
        disp(strcat(name, ' is successfully removed from the catalogue.'));
        removed = 1;
    end
else
    removed = 0;
    disp('Error: The catalogue is not valid.');
end
end



