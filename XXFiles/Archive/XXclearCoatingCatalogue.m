function [ cleared ] = clearCoatingCatalogue( coatingCatalogueFullName )
%CLEARCOATINGCATALOGUE Remove all coating except the default 'None' coating
% from the catalogue
if isValidCoatingCatalogue( coatingCatalogueFullName )
    % delete the exsisting and create anew one
    delete(coatingCatalogueFullName);
    cleared = createNewCoatingCatalogue( coatingCatalogueFullName );
else
    cleared = 0;
end
end

