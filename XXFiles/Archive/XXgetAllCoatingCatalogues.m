function [ coatingCatalogueFileList ] = getAllCoatingCatalogues( dirName )
%FINDALLCOATINGCATALOGUES Searches for all coating catalogue files in the
% given directory. And returns their full file names.

if nargin < 1
    dirName = pwd;
end
% get all files 
fileList = getAllFiles( dirName );
validFileIndex = 0;
% loop through the file lists and check if they are valid coating catalogue
% files. NB. Coating catalogue files have .MAT extension and have
% CoatingArrry and FileInfoStruct variables. And FileInfoStruct.Type =
% 'Coaating'
coatingCatalogueFileList{1,:} = [];
for k = 1:size(fileList,1)
    fullFileName = fileList{k,:};
    [pathstr,name,ext] = fileparts(fullFileName);
%     [~,stats] = fileattrib(fullFileName);
    if strcmpi(ext,'.mat') && ~ strcmpi(name(1),'$')% .mat files which are not hidden
        if isValidCoatingCatalogue( fullFileName ,0)
            validFileIndex = validFileIndex + 1;
            coatingCatalogueFileList{validFileIndex,:} = fullFileName;
        else
            
        end
    else
        
    end
    
end
disp([num2str(validFileIndex),' Valid Coating Catalogue Files Found.']);
end

