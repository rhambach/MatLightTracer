function [ coatingObject ] = extractCoatingFromCoatingCatalogue( coatingName,coatingCatalogueFullName )
%EXTRACTCOATINGFROMCOATINGCATALOGUE extracts a coating object from the catalogue
% given its name

if isValidCoatingCatalogue( coatingCatalogueFullName )
    %load the coating catalogue file
    load(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
    
    %check that the coating doesnot exsist in the catalogue
    name = coatingName;
    location = find(strcmpi({CoatingArray.Name},name));
    if isempty(location)
        coatingObject = NaN;
        disp(strcat(name, ' is not in the given catalogue.'));
        return;
    else
        coatingObject = CoatingArray(location(1));
        clear CoatingArray;
        clear 'FileInfoStruct';
        disp(strcat(name, ' succefully extracted from the given catalogue.'));
    end
else
    coatingObject = NaN;
end

end

