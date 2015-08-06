function newGlass = Glass(glassName,glassCatalogueFileList,glassType,glassParameters,...
        internalTransmittance,thermalData,wavelengthRange,resistanceData,otherData,glassComment)
    % Glass Struct:
    %   Glass Defines optical glass in the optical system. The temprature dependance
    %   of refractive index of the glass is ignored in the current version
    %
    % Properties: 3 and Methods: 12
    %
    % Example Calls:
    %
    %   newGlass = Glass()
    %   newGlass = Glass('MyGlassName')
    %   newGlass = Glass('1.70')
    %   newGlass = Glass('1.50 54.00 0.00')
    %   newGlass = Glass('MyGlassName','All','IdealNonDispersive')
    %
    %   glassParamStruct.FormulaType = 'Sellmeir1';
    %   glassParamStruct.CoefficientData = [1,2,3,4,5,2,3,4,2,1];
    %   glassParamStruct.ReferenceWavelength = 0.55*10^-6;
    %   newGlass = Glass('MyGlassName','All','ZemaxFormula',glassParamStruct)
    %   ...
    
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
    
    % Glass: A function used to constract a new Glass object
    if  nargin == 0 || isempty(glassName)% Enable construction  with no inputs
        glassName = '';
        glassCatalogueFileList = {'All'};
        glassType = 'IdealNonDispersive';
        % Connect to glass definition function and get the default
        % glassParameters
        % Connect to glass Defintion function
        glassDefinitionHandle = str2func(glassType);
        returnFlag = 1; % refractive index
        [ paramName,paramType,defaultParamStruct] = ...
            glassDefinitionHandle(returnFlag);
        
        glassParameters = defaultParamStruct;
        internalTransmittance  = zeros(1,3);
        thermalData  = zeros(10,1);
        wavelengthRange  = zeros(2,1);
        resistanceData  = zeros(5,1);
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
        
    elseif (nargin == 1||nargin == 2)
        if strcmpi(glassName,'Mirror')
            glassCatalogueFileList = {'All'};
            
            glassType = 'IdealNonDispersive';
            % Connect to glass definition function and get the default
            % glassParameters
            % Connect to glass Defintion function
            glassDefinitionHandle = str2func(glassType);
            returnFlag = 1; % refractive index
            [ paramName,paramType,defaultParamStruct] = ...
                glassDefinitionHandle(returnFlag);
            
            glassParameters = defaultParamStruct;
            internalTransmittance  = zeros(1,3);
            thermalData  = zeros(10,1);
            wavelengthRange  = zeros(2,1);
            resistanceData  = zeros(5,1);
            otherData  = zeros(6,1);
            glassComment  = 'No comment';
        else
            if (nargin == 1||strcmpi(glassCatalogueFileList{1},'All'))
                % get all glass catalogues
                objectType = 'Glass';
                glassCatalogueFileList = getAllObjectCatalogues(objectType);
            end
            % Look for the glass in the availbale glass catalogues.
            savedGlass = extractGlassFromAvailableCatalogues(upper(glassName),glassCatalogueFileList);
            
            
            if isempty(savedGlass)
                
                % Check if glassName is just the refractive index
                % as in the case of IdealDispersive and
                % IdealNonDispersive glass types
                fixedIndexData = str2num(glassName);
                
                if isempty(fixedIndexData)
                    disp([glassName,' can not be found in any of the available glass catalogues.']);
                    button = questdlg('The glass is not found in the catalogues. Do you want to choose another?','Glass Not Found');
                    switch button
                        case 'Yes'
                            glassEnteryFig = glassDataInputDialog(glassCatalogueFileList);
                            set(glassEnteryFig,'WindowStyle','Modal');
                            uiwait(glassEnteryFig);
                            selectedGlass = getappdata(0,'Glass');
                        case 'No'
                            selectedGlass = '';
                            % Do nothing
                            disp('Warning: Undefined glass is ignored.');
                        case 'Cancel'
                            selectedGlass = '';
                            % Do nothing
                            disp('Warning: Undefined glass is ignored.');
                    end
                    if isempty(selectedGlass)
                        disp(['No glass is selected so empty glass is used.']);
                        selectedGlass = Glass();
                    else
                        disp([selectedGlass.Name,' is extracted from available glass catalogue.']);
                    end
                    newGlass = selectedGlass;
                    return;
                else
                    nFixedIndexData = length(fixedIndexData);
                    if nFixedIndexData == 1
                        glassName = [num2str((fixedIndexData(1)),'%.4f ')];
                        glassType = 'IdealNonDispersive';
                        glassParameters = struct();
                        glassParameters.RefractiveIndex = fixedIndexData(1);
                        
                        disp([glassName,' is IdealNonDispersive glass.']);
                    elseif nFixedIndexData == 2
                        glassName = [num2str((fixedIndexData(1)),'%.4f '),',',...
                            num2str((fixedIndexData(2)),'%.4f '),',',...
                            num2str((0),'%.4f ')];
                        glassType = 'IdealDispersive';
                        glassParameters = struct();
                        glassParameters.RefractiveIndex = fixedIndexData(1);
                        glassParameters.AbbeNumber = fixedIndexData(2);
                        glassParameters.DeltaRelativePartialDispersion = 0;
                        
                        disp([glassName,' is IdealDispersive glass.']);
                    else
                        glassName = [num2str((fixedIndexData(1)),'%.4f '),',',...
                            num2str((fixedIndexData(2)),'%.4f '),',',...
                            num2str((fixedIndexData(3)),'%.4f ')];
                        glassType = 'IdealDispersive';
                        glassParameters = struct();
                        glassParameters.RefractiveIndex = fixedIndexData(1);
                        glassParameters.AbbeNumber = fixedIndexData(2);
                        glassParameters.DeltaRelativePartialDispersion = fixedIndexData(3);
                        
                        disp([glassName,' is IdealDispersive glass.']);
                    end
                    internalTransmittance  = zeros(1,3);
                    thermalData  = zeros(10,1);
                    wavelengthRange  = zeros(2,1);
                    resistanceData  = zeros(5,1);
                    otherData  = zeros(6,1);
                    glassComment  = 'No comment';
                end
            else
                newGlass = savedGlass;
                disp([glassName,' is extracted from available glass catalogue.']);
                return;
            end
        end
    elseif nargin == 3
        % Connect to glass definition function and get the default
        % glassParameters
        % Connect to glass Defintion function
        glassDefinitionHandle = str2func(glassType);
        returnFlag = 1; % refractive index
        [ paramName,paramType,defaultParamStruct] = ...
            glassDefinitionHandle(returnFlag);
        
        glassParameters = defaultParamStruct;
        internalTransmittance  = zeros(1,3);
        thermalData  = zeros(10,1);
        wavelengthRange  = zeros(2,1);
        resistanceData  = zeros(5,1);
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
    elseif nargin == 4
        internalTransmittance  = zeros(1,3);
        thermalData  = zeros(10,1);
        wavelengthRange  = zeros(2,1);
        resistanceData  = zeros(5,1);
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
    elseif nargin == 5
        thermalData  = zeros(10,1);
        wavelengthRange  = zeros(2,1);
        resistanceData  = zeros(5,1);
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
    elseif nargin == 6
        wavelengthRange  = zeros(2,1);
        resistanceData  = zeros(5,1);
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
    elseif nargin == 7
        resistanceData  = zeros(5,1);
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
    elseif nargin == 8
        otherData  = zeros(6,1);
        glassComment  = 'No comment';
    elseif nargin == 9
        glassComment  = 'No comment';
    elseif nargin == 10
        
    end
    
    newGlass.Name = glassName;
    newGlass.Type = glassType;
    newGlass.Parameters = glassParameters;
    newGlass.InternalTransmittance = internalTransmittance;
    newGlass.ResistanceData = resistanceData;
    newGlass.ThermalData = thermalData;
    newGlass.OtherData = otherData;
    newGlass.WavelengthRange  = wavelengthRange;
    newGlass.Comment = glassComment; %
    newGlass.ClassName = 'Glass';
end


function savedGlass = extractGlassFromAvailableCatalogues(glassName,GlassCatalogueFileList)
    if nargin == 0
        disp('Error: extractGlassFromAvailableCatalogues needs atleast one argument. ');
        return;
    elseif nargin == 1
        % get all glass catalogues
        objectType = 'Glass';
        % dirName = Just use default directory dirName = [pwd,'\Catalogue_Files'];
        [ GlassCatalogueFileList ] = getAllObjectCatalogues(objectType);
    elseif nargin == 2
        % get all glass catalogues
        objectType = 'Glass';
    end
    % Search for the glass in all the catalogues
    for kk = 1:size(GlassCatalogueFileList,1)
        glassCatalogueFullName = GlassCatalogueFileList{kk};
        [ glassObject,objectIndex ] = extractObjectFromObjectCatalogue...
            (objectType,glassName,glassCatalogueFullName );
        if objectIndex ~= 0
            break;
        end
    end
    % if exists return the glass
    if objectIndex ~= 0
        savedGlass = (glassObject);
    else
        savedGlass = [];
    end
end

