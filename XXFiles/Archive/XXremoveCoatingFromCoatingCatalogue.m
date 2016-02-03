function [ removed ] = removeCoatingFromCoatingCatalogue( coatingName,coatingCatalogueFullName )
%REMOVECOATINGTOCOATINGCATALOGUE removes a coating object to the given
% catalogue.

if isValidCoatingCatalogue( coatingCatalogueFullName )
    %load the coating catalogue file
    load(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
    
    %check that the coating does exsist in the catalogue
    name = coatingName;
    location = find(strcmpi({CoatingArray.Name},name));
    if isempty(location)
        disp(strcat(name, ' is not in the given catalogue.'));
        removed = 0;
        return;
    else
        CoatingArray = CoatingArray([1:location(1)-1,location(1)+1:end]);
        save(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
        clear CoatingArray;
        clear 'FileInfoStruct';
        disp(strcat(name, ' is successfully removed from the catalogue.'));
        removed = 1;
    end
else
    removed = 0;
end
end



