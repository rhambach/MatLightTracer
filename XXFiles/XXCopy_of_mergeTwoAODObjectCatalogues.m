function [ merged ] = mergeTwoAODObjectCatalogues...
    (objectType, objCatFullName1,objCatFullName2,objCatFullNameMergedFullName )
%mergeTwoAODObjectCatalogues Merge two AOD object catalogues and save in a
% single file.

% Default inputs
if nargin < 3
    disp(['Error: The mergeTwoAODObjectCatalogues needs atleast objectType ',...
        'objCatFullName1 and objCatFullName2 as argument']);
    return;
elseif nargin == 3
    objCatFullNameMergedFullName = createNewAODObjectCatalogue(objectType);
end
if isValidAODObjectCatalogue(objectType, objCatFullName1 ) && ...
        isValidAODObjectCatalogue(objectType, objCatFullName2 )
    %load the 1st object catalogue file
    load(objCatFullName1,'AODObjectArray','FileInfoStruct');
    objectArray1 = AODObjectArray;
    clear AODObjectArray;
    clear FileInfoStruct;
    %load the 2nd object catalogue file
    load(objCatFullName2,'AODObjectArray','FileInfoStruct');
    objectArray2 = AODObjectArray;
    clear AODObjectArray;
    clear FileInfoStruct;
    addObjectToAODObjectCatalogue(objectType,objectArray1,objCatFullNameMergedFullName );
    addObjectToAODObjectCatalogue(objectType,objectArray2,objCatFullNameMergedFullName );
    merged = 1;
    
    [~,cat1Name,~]  = fileparts(objCatFullName1);
    [~,cat2Name,~]  = fileparts(objCatFullName2);
    [~,mergedCatName,~] = fileparts(objCatFullNameMergedFullName);
    disp(['Merging successful: ',cat1Name,' + ',cat2Name,' = ', mergedCatName]);
else
    merged = 0;
    delete(objCatFullNameMergedFullName);
    disp('Error: The catalogue is not valid.');
end
end

