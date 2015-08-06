function [ valid, fileInfoStruct, dispMsg] = isValidLensCatalogue...
    (lensCatalogueFullName )
    % isValidLensCatalogue Retruns whether the lens catalogue is vlaid or
    % not.
    
	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%	Optical System Design Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% July 28,2014   Worku, Norman G.     Original Version        

    if nargin == 0
        [FileName,PathName] = uigetfile('*.mat','Select MAT Lens Catalogue File');
        if ~isempty(FileName)&&~isempty(PathName) && ...
                ~isnumeric(FileName) && ~isnumeric(PathName)
            lensCatalogueFullName = [PathName,FileName];
        else
            disp(['Error: The isValidLensCatalogue needs lensCatalogueFullName as argument']);
            return;
        end
    end

    [pathstr,name,ext] = fileparts(lensCatalogueFullName);

    %load the lens array and field info struct from the file
    try
        if exist(lensCatalogueFullName,'file')&&~isempty(name)
            S = load(lensCatalogueFullName);

            % Variable named FileInfoStruct and LensArray does exsist
            if isfield(S,'FileInfoStruct') && isfield(S,'LensArray')
                fileInfo = S.FileInfoStruct;
                LensArray = S.LensArray;
                % Variable named FileInfoStruct is empty
                if isempty(fieldnames(fileInfo))
                    valid = 0;
                    fileInfoStruct = [];
                    dispMsg = 'Error: Invalid Glass Catalogue File';
                    return
                else
                    valid = 1;
                    fileInfoStruct = fileInfo;
                    dispMsg = 'Success: Glass Catalogue File is Valid.';
                    return
                end
            else
                valid = 0;
                fileInfoStruct = [];
                dispMsg = 'Error: Invalid Glass Catalogue File';
                return
            end
        else
            valid = 0;
            fileInfoStruct = [];
            dispMsg = ['Error:  ',lensCatalogueFullName ,'  does not exists.'];
            return
        end
    catch
        valid = 0;
        fileInfoStruct = [];
        dispMsg = ['Error: Something goes wrong while opening  ',lensCatalogueFullName];
        return
    end

