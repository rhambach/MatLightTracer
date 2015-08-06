function [ fullName ] = createNewCoatingCatalogue( coatingCatalogueFullName )
%CREATENEWCOATINGCATALOGUE Create anew coating catalogue and save the
%default coating ('None') to the catalogue;

%check if the catalogue already exsit
if exist(coatingCatalogueFullName,'file')
    [pathstr,name,ext] = fileparts(coatingCatalogueFullName);
    alternativeName = fullfile(pathstr,[name,'1',ext]);
    button = questdlg(strcat('There already exists a coating catalogue named ', ...
        name, '. Do you want to create the catalogue with new name: ',name, '1 ?'),'New Catalogue Name','Yes Save','No Replace','Yes Save');
    switch button
        case 'Yes Save'
            newCoatingCatalogueFullName = alternativeName;
            fullName = createNewCoatingCatalogue( newCoatingCatalogueFullName );
        case 'No Replace'
            % delete the exsisting and create anew one
            delete(coatingCatalogueFullName);
            fullName = createNewCoatingCatalogue( coatingCatalogueFullName );
    end
else
    CoatingArray(1) = Coating;
    FileInfoStruct =  struct();
    FileInfoStruct.Type = 'CoatingCatalogue';
    FileInfoStruct.Date = fix(clock); % Clock = [YYYY MM DD HH MM SS]
    save(coatingCatalogueFullName,'CoatingArray','FileInfoStruct');
    save(coatingCatalogueFullName,'CoatingArray','FileInfoStruct','-append');
    fullName = coatingCatalogueFullName;
end
end

