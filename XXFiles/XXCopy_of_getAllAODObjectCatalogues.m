function [ aodObjectCatalogueFileList ] = getAllAODObjectCatalogues(objectType, dirName)
%FINDALLCOATINGCATALOGUES Searches for all aodObject catalogue files in the
% given directory. And returns their full file names.

% make the current path the default search path
if nargin < 1
    disp('Error: The getAllAODObjectCatalogues needs atleast objectType as argument');
    return;
elseif nargin == 1
    dirName = [pwd,'\Catalogue_Files'];
    if ~exist(dirName)
        mkdir(dirName);
        addpath(dirName);
        if strcmpi(objectType,'Coating')
            createNewAODObjectCatalogue('coating', ...
            [dirName,'\Coating_Catalogue00.mat'],'replace' );
        elseif strcmpi(objectType,'Glass')
            createNewAODObjectCatalogue('glass', ...
            [dirName,'\Glass_Catalogue00.mat'],'replace' );
        else
        end
    end
end
% get all files
fileList = getAllFiles( dirName );
validFileIndex = 0;
% loop through the file lists and check if they are valid aodObject catalogue
% files. NB. AODObject catalogue files have .MAT extension and have
% AODObjectArrry and FileInfoStruct variables. And FileInfoStruct.Type =
% 'Coating' or 'Glass' or 'OpticalSystem'
aodObjectCatalogueFileList{1,:} = [];
for k = 1:size(fileList,1)
    fullFileName = fileList{k,:};
    [pathstr,name,ext] = fileparts(fullFileName);
    if strcmpi(ext,'.mat') && ~ strcmpi(name(1),'$') % .mat files which are not hidden
        if isValidAODObjectCatalogue(objectType, fullFileName)
            validFileIndex = validFileIndex + 1;
            aodObjectCatalogueFileList{validFileIndex,:} = fullFileName;
        else
            
        end
    else
        
    end
    
end
% disp([num2str(validFileIndex),' Valid AODObject Catalogue Files Found.']);
if ~validFileIndex
    aodObjectCatalogueFileList = [];
end
end

