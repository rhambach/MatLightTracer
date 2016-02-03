function [ valid, fileInfoStruct, dispMsg] = isValidAODObjectCatalogue...
    (objectType, objectCatalogueFullName )
%ISVALIDCOATINGCATALOGUE Retruns whether the object catalogue is vlaid or
% not.
if nargin < 2
    disp(['Error: The isValidAODObjectCatalogue needs objectType ',...
        'and objectCatalogueFullName as argument']);
    return;
end
validCatalogueTypes = {'CoatingCatalogue','GlassCatalogue','OpticalSystemCatalogue'};
[pathstr,name,ext] = fileparts(objectCatalogueFullName);

%load the object array and field info struct from the file
try
    if exist(objectCatalogueFullName,'file')&&~isempty(name)
        S = load(objectCatalogueFullName);
        % Variable named FileInfoStruct and AODObjectArray does exsist
        if isfield(S,'FileInfoStruct') && isfield(S,'AODObjectArray')
            fileInfo = S.FileInfoStruct;
            objectArray = S.AODObjectArray;
            % Variable named FileInfoStruct is empty
            if isempty(fieldnames(fileInfo))
                valid = 0;
                fileInfoStruct = [];
                dispMsg = 'Error: Invalid AODObject Catalogue File';
                return
            else
                if (strcmpi(fileInfo.Type,objectType)&&...
                        strcmpi(class(objectArray),objectType))
                    valid = 1;
                    fileInfoStruct = fileInfo;
                    dispMsg = 'Success: AODObject Catalogue File is Valid.';
                    return
                else
                    valid = 0;
                    fileInfoStruct = [];
                    dispMsg = 'Error: Invalid AODObject Catalogue File';
                    return
                end
            end
        else
            valid = 0;
            fileInfoStruct = [];
            dispMsg = 'Error: Invalid AODObject Catalogue File';
            return
        end
    else
        valid = 0;
        fileInfoStruct = [];
        dispMsg = ['Error:  ',objectCatalogueFullName ,'  does not exists.'];
        return
    end
catch
    valid = 0;
    fileInfoStruct = [];
    dispMsg = ['Error: Something goes wrong while opening  ',objectCatalogueFullName];
    return
end

