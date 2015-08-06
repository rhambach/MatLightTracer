function [ valid, fileInfoStruct ] = isValidCoatingCatalogue( coatingCatalogueFullName, dispMsg )
%ISVALIDCOATINGCATALOGUE Retruns whether the coating catalogue is vlaid or
% not.

if nargin < 2
    dispMsg = 1; % Disply messages on the workspace 
end
%load the field info struct file
try
    if exist(coatingCatalogueFullName,'file')
        S = load(coatingCatalogueFullName);
        % Variable named FileInfoStruct and CoatingArray does exsist
        if isfield(S,'FileInfoStruct') && isfield(S,'CoatingArray')
            fileInfo = S.FileInfoStruct;
            % Variable named FileInfoStruct is empty
            if isempty(fieldnames(fileInfo))
                valid = 0;
                fileInfoStruct = [];
                if dispMsg 
                    disp('Error: Invalid Coating Catalogue File'); 
                end
                return
            else
                if strcmpi(fileInfo.Type,'CoatingCatalogue')
                    valid = 1;
                    fileInfoStruct = fileInfo;
                    return
                else
                    valid = 0;
                    fileInfoStruct = [];
                    if dispMsg 
                        disp('Error: Invalid Coating Catalogue File'); 
                    end
                    return
                end
            end
        else
            valid = 0;
            fileInfoStruct = [];
            if dispMsg 
                disp('Error: Invalid Coating Catalogue File'); 
            end
            return
        end
    else
        valid = 0;
        fileInfoStruct = [];
        if dispMsg 
            disp(['Error:  ',coatingCatalogueFullName ,'  does not exists.']); 
        end
        return
    end
catch
    valid = 0;
    fileInfoStruct = [];
    if dispMsg  
        disp(['Error: Something goes wrong while opening  ',coatingCatalogueFullName]);
    end
    return
end

