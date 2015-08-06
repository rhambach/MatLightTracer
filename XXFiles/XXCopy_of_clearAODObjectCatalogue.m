function [ cleared ] = clearAODObjectCatalogue(objectType, objectCatalogueFullName )
%CLEARCOATINGCATALOGUE Remove all AODobject from the catalogue
if isValidAODObjectCatalogue(objectType, objectCatalogueFullName )
    % delete the exsisting and create anew one
    delete(objectCatalogueFullName);
    cleared = createNewAODObjectCatalogue(objectType, objectCatalogueFullName );
    disp('The catalogue is successfully cleared.');
else
    cleared = 0;
    disp('Error: The catalogue is not valid.');
end
end

