function [ aodObject,objectIndex,dispInfo ] = extractObjectFromAODObjectCatalogue...
    (objectType,objectName,objectCatalogueFullName )
%EXTRACTCOATINGFROMCOATINGCATALOGUE extracts a AOD object from the catalogue
% given its name

if isValidAODObjectCatalogue(objectType, objectCatalogueFullName )
    % load the AOD object catalogue file
    load(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
    if strcmpi(objectName,'all')
        aodObject = AODObjectArray;
        clear AODObjectArray;
        clear 'FileInfoStruct';
        dispInfo  = (strcat('All objects are succefully extracted from the given catalogue.'));
    else
        %check that the aod object doesnot exsist in the catalogue
        name = objectName;
        location = find(strcmpi({AODObjectArray.Name},name));
        if isempty(location)
            aodObject = NaN;
            objectIndex = 0;
            dispInfo = (strcat(name, ' is not in the given catalogue.'));
            return;
        else
            objectIndex = location(1);
            aodObject = AODObjectArray(objectIndex);
            clear AODObjectArray;
            clear 'FileInfoStruct';
            dispInfo = (strcat(name, ' succefully extracted from the given catalogue.'));
        end
    end
    
else
    aodObject = NaN;
    objectIndex = 0;
    dispInfo = ('Error: The catalogue is not valid.');
    disp(dispInfo);
end

end

