function [ added ] = addObjectToAODObjectCatalogue...
    (objectType, aodObject,objectCatalogueFullName,ask_replace )
%addObjectToAODObjectCatalogue: Adds the given AOD object to the given
% catalogue.

if nargin == 3
    ask_replace = 'ask';
end
switch lower(ask_replace)
    case lower('ask')
        Ask = 1;
        Replace = 0;
    case lower('replace')
        Ask = 0;
        Replace = 1;
end

if ~strcmpi(class(aodObject),objectType)
    disp('Error: The object to be added and the catalogue type does not match.');
    return;
end

if isValidAODObjectCatalogue(objectType, objectCatalogueFullName )
    %load the coating catalogue file
    load(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
    %check that the AOD Object doesnot exsist in the catalogue
    % Compare the existance of each object on the catalogue
    existingObjectNames = {AODObjectArray.Name};
    newObjectNames = {aodObject.Name};
    % locations will be cell array of logicals arrays indicating exactly
    % where the new object name exists in the old catalogue
    locations = cellfun(@(x) strcmpi(x,existingObjectNames),newObjectNames,'UniformOutput', false);
    locations = find(cell2mat(locations));
    % Indices of new object which are already exsisting
    alreadyExistingObjIndices = ceil(locations./size(existingObjectNames,2));
    
    if ~isempty(alreadyExistingObjIndices)
        for k = 1:size(alreadyExistingObjIndices,1)
            repeatedName = newObjectNames{alreadyExistingObjIndices(k)};
            alternativeName = [repeatedName,'1'];
            if Ask
                button = questdlg(strcat(repeatedName, ' is already in the catalogue.',...
                    ' Do you want to save with new object name: ',alternativeName, ' ?'),'New Object Name','Yes Save','No Replace','Yes Save');
                switch button
                    case 'Yes Save'
                        % Give new name for the new object
                        aodObject(alreadyExistingObjIndices(k)).Name = alternativeName;
                    case 'No Replace'
                        % Delete the existing object
                        indexInTheCat = find(strcmpi(existingObjectNames,repeatedName));
                        AODObjectArray(indexInTheCat(1)) = [];
                        save(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
                end
            else
                % Delete the existing object
                indexInTheCat = find(strcmpi(existingObjectNames,repeatedName));
                AODObjectArray(indexInTheCat(1)) = [];
                save(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
            end
        end
        added = addObjectToAODObjectCatalogue...
            (objectType, aodObject,objectCatalogueFullName );
    else
        
        newObjectNames = {aodObject.Name};
        AODObjectArray(end+1:end+size(aodObject,2)) = aodObject;
        save(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
        clear AODObjectArray;
        clear 'FileInfoStruct';
        disp(char(['Successfully added: ',newObjectNames]));
        added = 1;
    end
else
    added = 0;
    disp('Error: The catalogue is not valid.');
end
end

