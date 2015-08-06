function [ extractedLens,locationIndex,dispInfo ] = extractLensFromCatalogue...
    (lensFileName,lensCatalogueFullName )
    % extractLensFromCatalogue extracts a lens from the catalogue given its file name

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
        disp('Error: The function extractLensFromCatalogue needs atleast the lensName as input parameter.');
        return;
    elseif nargin == 1
        [FileName,PathName] = uigetfile('*.mat','Select MAT Lens Catalogue File');
        if ~isempty(FileName)&&~isempty(PathName) && ...
                ~isnumeric(FileName) && ~isnumeric(PathName)
            lensCatalogueFullName = [PathName,FileName];
        else
            extractedLens = NaN;
            locationIndex = 0;
            dispInfo = ('Error: The catalogue is not valid.');
            disp(dispInfo);
            return;
        end    
    end

    if isValidLensCatalogue(lensCatalogueFullName )
        % load the AOD object catalogue file
        load(lensCatalogueFullName,'LensArray','FileInfoStruct');
        if strcmpi(lensFileName,'all')
            extractedLens = LensArray;
            clear LensArray;
            clear 'FileInfoStruct';
            dispInfo  = (strcat('All lenses are succefully extracted from the given catalogue.'));
        else
            %check that the glass does not exsist in the catalogue
            name = lensFileName;
            location = find(strcmpi({LensArray.FileName},name));
            if isempty(location)
                extractedLens = NaN;
                locationIndex = 0;
                dispInfo = (strcat(name, ' is not in the given catalogue.'));
                disp(dispInfo);
                return;
            else
                locationIndex = location(1);
                extractedLens = LensArray(locationIndex);
                clear LensArray;
                clear 'FileInfoStruct';
                dispInfo = (strcat(name, ' succefully extracted from the given catalogue.'));
            end
        end

    else
        extractedLens = NaN;
        locationIndex = 0;
        dispInfo = ('Error: The catalogue is not valid.');
        disp(dispInfo);
    end

end

