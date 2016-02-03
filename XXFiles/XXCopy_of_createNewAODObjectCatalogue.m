function [ fullName ] = createNewAODObjectCatalogue(objectType, objectCatalogueFullName,ask_replace )
%CREATENEWCOATINGCATALOGUE Create anew AOD object catalogue and intialize
%empty array of the corresponding object.


%Default values
if nargin < 1
    disp('Error: The function needs atleast objectType as argumet');
elseif nargin == 1
    objectCatalogueFullName = [pwd,'\Catalogue_Files','\New_',objectType,'.mat'];
    ask_replace = 'ask';
elseif nargin == 2
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

%check if the catalogue already exsit
if exist(objectCatalogueFullName,'file')
    [pathstr,name,ext] = fileparts(objectCatalogueFullName);
    alternativeName = fullfile(pathstr,[name,'1',ext]);
    if Ask
        button = questdlg(strcat('There already exists an AODObject catalogue named ', ...
            name, '. Do you want to create the catalogue with new name: ',name, '1 ?'),'New Catalogue Name','Yes Save','No Replace','Yes Save');
        switch button
            case 'Yes Save'
                newAODObjectCatalogueFullName = alternativeName;
                fullName = createNewAODObjectCatalogue(objectType, newAODObjectCatalogueFullName );
            case 'No Replace'
                % delete the exsisting and create anew one
                delete(objectCatalogueFullName);
                fullName = createNewAODObjectCatalogue(objectType, objectCatalogueFullName );
        end
    else
        % delete the exsisting and create anew one
        delete(objectCatalogueFullName);
        fullName = createNewAODObjectCatalogue(objectType, objectCatalogueFullName );
    end
else
    FileInfoStruct =  struct();
    switch lower(objectType)
        case 'coating'
            AODObjectArray = Coating.empty;
            FileInfoStruct.Type = 'Coating';
        case 'glass'
            AODObjectArray = Glass.empty;
            FileInfoStruct.Type = 'Glass';
    end
    FileInfoStruct.Date = fix(clock); % Clock = [YYYY MM DD HH MM SS]
    save(objectCatalogueFullName,'AODObjectArray','FileInfoStruct');
    save(objectCatalogueFullName,'AODObjectArray','FileInfoStruct','-append');
    fullName = objectCatalogueFullName;
end
end

