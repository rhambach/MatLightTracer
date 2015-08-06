function [ added ] = addLensToLensCatalogue...
    (newLens,lensCatalogueFullName,ask_replace )
    % addLensToLensCatalogue: Adds the given lens to the lens catalogue in matlab.

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%	Optical System Design Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% July 28,2014   Worku, Norman G.     Original Version        

    if nargin == 2
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

    if isValidLensCatalogue(lensCatalogueFullName )
        %load the coating catalogue file
        load(lensCatalogueFullName,'LensArray','FileInfoStruct');   

        % check that the newLens does not exsist in the catalogue
        % Compare the existance of each object on the catalogue
        existingLensFileNames = {LensArray.FileName};
        newLensNames = {newLens.FileName};

        % locations will be cell array of logicals arrays indicating exactly
        % where the new object name exists in the old catalogue
        locations = cellfun(@(x) strcmpi(x,existingLensFileNames),newLensNames,...
            'UniformOutput', false);
        locations = find(cell2mat(locations));

        % Indices of new object which are already exsisting
        alreadyExistingLensIndices = ceil(locations./size(existingLensFileNames,2));
         if ~isempty(alreadyExistingLensIndices)
             for k = 1:size(alreadyExistingLensIndices,1)
                 repeatedName = newLensNames{alreadyExistingLensIndices(k)};
                 alternativeName = [repeatedName,'1'];
                 if Ask
                     button = questdlg(strcat(repeatedName, ...
                         ' is already in the catalogue.',...
                         ' Do you want to save with new object name: ',...
                         alternativeName, ' ?'),'New Object Name',...
                         'Yes Save','No Replace','Yes Save');
                     switch button
                         case 'Yes Save'
                             % Give new name for the new object
                             newLens(alreadyExistingLensIndices(k)).FileName = ...
                                 alternativeFileName;
                         case 'No Replace'
                             % Delete the existing object
                             indexInTheCat = find(strcmpi(existingLensFileNames,...
                                 repeatedName));
                             LensArray(indexInTheCat(1)) = [];
                             save(lensCatalogueFullName,'LensArray','FileInfoStruct');
                     end
                 else
                     % Delete the existing object
                     indexInTheCat = find(strcmpi(existingLensFileNames,repeatedFileName));
                     LensArray(indexInTheCat(1)) = [];
                     save(lensCatalogueFullName,'LensArray','FileInfoStruct');
                 end
             end
            added = addLensToLensCatalogue...
                (newLens,lensCatalogueFullName );
         else

        newLensNames = {newLens.FileName};
        LensArray(end+1:end+size(newLens,2)) = orderfields(newLens);
        save(lensCatalogueFullName,'LensArray','FileInfoStruct');
        clear LensArray;
        clear 'FileInfoStruct';
        disp(char(['Successfully added: ',newLensNames]));
        added = 1;
         end
    else
        added = 0;
        disp('Error: The catalogue is not valid.');
    end
end

