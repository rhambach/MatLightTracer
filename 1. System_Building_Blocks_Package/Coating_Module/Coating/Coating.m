function newCoating = Coating(coatingName,coatingCatalogueFileList,coatingType,coatingParameters)
    % Coating Struct:
    %
    %   Defines coating attached to the optical surfaces. All coating
    %   types are defined using external functions and this class makes
    %   calls to the external functions to work with the coating.
    %
    % Properties: 3 and Methods: 12
    %
    % Example Calls:
    %
    % newCoating = Coating()
    %   Returns a null coating which has no optical effect at all.
    %
    % newCoating = Coating(coatingName)
    %   Searchs for coating with given name in all coating catalogues and returns
    %   the coating object if it exists or a coating selection dialog box if not found.
    %
    % newCoating = Coating(coatingName,coatingCatalogueFileList)
    %   Searchs for coating with given name in the specified coating catalogues and returns
    %   the coating object if it exists or a coating selection dialog box if not found.
    %
    % newCoating = Coating(coatingName,coatingCatalogueFileList,coatingType)
    %   Creates a new coating with given name and given type with its default parameters.
    %   The second argument is not used in this case.
    %
    % newCoating = Coating(coatingName,coatingCatalogueFileList,coatingType,coatingParameters)
    %   Creates a new coating with given name and given type with coatingParameters as
    %   its initial parameters. The second argument is not used in this case.
    %
    
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    % Jun 17,2015   Worku, Norman G.     Support the user defined coating
    %                                    definitions
    
    % A method used to construct a new coating object from its parameters.
    
    if nargin == 0 || isempty(coatingName)% Enable construction  with no inputs
        newCoating.Type = 'NullCoating';
        newCoating.Name = '';
    elseif nargin < 3
        if (nargin == 1||strcmpi(coatingCatalogueFileList{1},'All'))
            % get all coating catalogues
            objectType = 'Coating';
            coatingCatalogueFileList = getAllObjectCatalogues(objectType);
        end
        % Look for the coating in the availbale coating catalogues.
        savedCoating = extractCoatingFromAvailableCatalogues(upper(coatingName),coatingCatalogueFileList);
        
        if isempty(savedCoating)
            disp([coatingName,' can not be found in any of the available coating catalogues.']);
            
            button = questdlg('The coating is not found in the catalogues. Do you want to choose another?','Coating Not Found');
            switch button
                case 'Yes'
                    coatingEnteryFig = coatingDataInputDialog(coatingCatalogueFileList);
                    set(coatingEnteryFig,'WindowStyle','Modal');
                    uiwait(coatingEnteryFig);
                    selectedCoating = getappdata(0,'Coating');
                case 'No'
                    selectedCoating = '';
                    % Do nothing
                    disp('Warning: Undefined coating is ignored.');
                case 'Cancel'
                    selectedCoating = '';
                    % Do nothing
                    disp('Warning: Undefined coating is ignored.');
            end
            if isempty(selectedCoating)
                disp(['No coating is selected so empty glass is used.']);
                selectedCoating = Coating();
            else
                disp([selectedCoating.Name,' is extracted from available coating catalogue.']);
            end
            newCoating = selectedCoating;
        else
            newCoating = savedCoating;
            disp([coatingName,' is extracted from available coating catalogue.']);
        end
    elseif nargin == 3
        % connect to coating defintion file and use defualt coating parameter
        coatingDefinitionHandle = str2func(coatingType);
        returnFlag = 1; % coating parameters fields and default values
        [ coatingParameterFields,coatingParameterTypes,defaultCoatingparameters] = ...
            coatingDefinitionHandle(returnFlag);
        
        newCoating.Type = coatingType;
        newCoating.Name = coatingName;
        newCoating.Parameters = defaultCoatingparameters;
    elseif nargin == 4
        newCoating.Type = coatingType;
        newCoating.Name = coatingName;
        newCoating.Parameters = coatingParameters;
    end
    newCoating.ClassName = 'Coating';
end

function savedCoating = extractCoatingFromAvailableCatalogues(coatingName,CoatingCatalogueFileList)
    if nargin == 0
        disp('Error: extractCoatingFromAvailableCatalogues needs atleast one argument. ');
        return;
    elseif nargin == 1
        % get all Coating catalogues
        objectType = 'Coating';
        % dirName = Just use default directory dirName = [pwd,'\Catalogue_Files'];
        [ CoatingCatalogueFileList ] = getAllObjectCatalogues(objectType);
    elseif nargin == 2
        % get all glass catalogues
        objectType = 'Coating';
    end
    % Search for the Coating in all the catalogues
    for kk = 1:size(CoatingCatalogueFileList,1)
        coatingCatalogueFullName = CoatingCatalogueFileList{kk};
        [ coatingObject,objectIndex ] = extractObjectFromObjectCatalogue...
            (objectType,coatingName,coatingCatalogueFullName );
        if objectIndex ~= 0
            break;
        end
    end
    % if exists return the glass
    if objectIndex ~= 0
        savedCoating = coatingObject;
    else
        savedCoating = [];
    end
end