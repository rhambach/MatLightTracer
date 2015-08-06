function updateOpticalSystemFiles()
    %% Update the OpticalSystemDefinition savedOpticalSystem.SystemDefinitionType
    % from 1 to 'SurfaceBased', from 2 to 'ComponentBased' and
    % Correct some files
    clc;
    clear;
    % Take the path name for saved optical systems
    pathNameOld = uigetdir(pwd);
    
    if pathNameOld == 0
        return;
    end
    % get all files in the old folder
    [ fileList ] = getAllFiles( pathNameOld );
    
    
    % create a new folder
    pathNameNew = [pathNameOld,'_New'];
    mkdir(pathNameNew);
    
    % iterate through all files and if they are valid optical systems then edit
    % them and save to new folder otherwise just copy them
    for k = 1:size(fileList,1)
        fullFileName = fileList{k,:};
        [pathstr,fileName,ext] = fileparts(fullFileName);
        if ~isempty(fileName)
            if strcmpi(ext,'.mat') && ~ strcmpi(fileName(1),'$') % .mat files which are not hidden
                if isValidOpticalSystemFile( fullFileName)
                    load(fullFileName);
                    %% 1 Change the SystemDefinitionType
                    %                     if (SavedOpticalSystem.SystemDefinitionType == 1)
                    %                         SavedOpticalSystem.SystemDefinitionType = 'SurfaceBased';
                    %                     elseif (SavedOpticalSystem.SystemDefinitionType == 2)
                    %                         SavedOpticalSystem.SystemDefinitionType = 'ComponentBased';
                    %                     end
                    %
                    %                     % Construct a questdlg with three options
                    %                     nComp = length(SavedOpticalSystem.ComponentArray);
                    %                     nSurf = length(SavedOpticalSystem.SurfaceArray);
                    %                     choice = questdlg(['Name : ',fileName, 'Comp: ',num2str(nComp),' Surf : ',num2str(nSurf)], ...
                    %                         'System Defn', ...
                    %                         'Surface','Component','Surface');
                    %                     % Handle response
                    %                     switch choice
                    %                         case 'Surface'
                    %                             SavedOpticalSystem.SystemDefinitionType = 'SurfaceBased';
                    %                         case 'Component'
                    %                             SavedOpticalSystem.SystemDefinitionType = 'ComponentBased';
                    %                     end
                    
                    %                     %% 2 Change the WavelngthUnit, LensUnit, SystemApertureType and FastDiameter
                    %                     switch SavedOpticalSystem.WavelengthUnit
                    %                         case 1
                    %                             SavedOpticalSystem.WavelengthUnit = 'nm';
                    %                         case 2
                    %                             SavedOpticalSystem.WavelengthUnit = 'um';
                    %                         case 3
                    %                             SavedOpticalSystem.WavelengthUnit = 'mm';
                    %                         case 4
                    %
                    %                         case 5
                    %                     end
                    %                     switch SavedOpticalSystem.LensUnit
                    %                         case 1
                    %                             SavedOpticalSystem.LensUnit = 'mm';
                    %                         case 2
                    %                             SavedOpticalSystem.LensUnit = 'cm';
                    %                         case 3
                    %                             SavedOpticalSystem.LensUnit = 'mt';
                    %                         case 4
                    %
                    %                         case 5
                    %                     end
                    %                     switch SavedOpticalSystem.SystemApertureType
                    %                         case 1
                    %                             SavedOpticalSystem.SystemApertureType = 'ENPD';
                    %                         case 2
                    %                             SavedOpticalSystem.SystemApertureType = 'OBNA';
                    %                         case 3
                    %                             SavedOpticalSystem.SystemApertureType = 'OBFN';
                    %                         case 4
                    %                             SavedOpticalSystem.SystemApertureType = 'IMNA';
                    %                         case 5
                    %                             SavedOpticalSystem.SystemApertureType = 'IMFN';
                    %                     end
                    
                    %% update  the surface to new defintion wherer
                    %% aperture is trated as object
                    %% Change the OtherStandardData to UniqueParameters
                    %% Remove coating type and coating parameter
                    %% Update tilt and decenter order from simple string to cell array
                    %                                         updatedSurfArray(1,nSurf) = Surface;
                    %                                         for kk = 1:nSurf
                    %                                             updatedSurfArray(kk).ObjectSurface = SavedOpticalSystem.SurfaceArray(kk).ObjectSurface;
                    %                                             updatedSurfArray(kk).ImageSurface = SavedOpticalSystem.SurfaceArray(kk).ImageSurface;
                    %                                             updatedSurfArray(kk).Stop = SavedOpticalSystem.SurfaceArray(kk).Stop;
                    %                                             updatedSurfArray(kk).Comment = SavedOpticalSystem.SurfaceArray(kk).Comment;
                    %                                             updatedSurfArray(kk).Type = SavedOpticalSystem.SurfaceArray(kk).Type;
                    %                                             updatedSurfArray(kk).Thickness =SavedOpticalSystem.SurfaceArray(kk).Thickness;
                    %                                             updatedSurfArray(kk).Glass = SavedOpticalSystem.SurfaceArray(kk).Glass;
                    %                                             updatedSurfArray(kk).Position = SavedOpticalSystem.SurfaceArray(kk).Position;
                    %
                    %                     %                         [fieldNames,fieldFormat,defaultUniqueParamStruct] = updatedSurfArray(kk).getUniqueParameters;
                    %                     %                         currentUniqueParamStruct = SavedOpticalSystem.SurfaceArray(kk).UniqueParameters;
                    %                     %                         if isempty(currentUniqueParamStruct)
                    %                     %                             updatedSurfArray(kk).UniqueParameters = defaultUniqueParamStruct;
                    %                     %                         else
                    %                     %                             updatedSurfArray(kk).UniqueParameters = currentUniqueParamStruct;
                    %                     %                         end
                    %                                             updatedSurfArray(kk).UniqueParameters = SavedOpticalSystem.SurfaceArray(kk).OtherStandardData;
                    %                                             updatedSurfArray(kk).ExtraData  = SavedOpticalSystem.SurfaceArray(kk).ExtraData;
                    %
                    %                                             type = SavedOpticalSystem.SurfaceArray(kk).ApertureType;
                    %                                             switch lower(type)
                    %                                                 case {'floating','floatingaperture','floatingcircularaperture','floatingcircular'}
                    %                                                     type = 'FloatingCircularAperture';
                    %                                                     uniqueParameters = struct;
                    %                                                     uniqueParameters.Diameter = 2*max(SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(1:2));
                    %                                                     outerShape = 'Circular';
                    %                                                 case {'circular','circularaperture'}
                    %                                                     type = 'CircularAperture';
                    %                                                     uniqueParameters = struct;
                    %                                                     uniqueParameters.Diameter = 2*max(SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(1:2));
                    %                                                     outerShape = 'Circular';
                    %                                                 case {'rectangular','rectangularaperture'}
                    %                                                     type = 'RectangularAperture';
                    %                                                     uniqueParameters = struct;
                    %                                                     uniqueParameters.DiameterX = 2*max(SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(1));
                    %                                                     uniqueParameters.DiameterY = 2*max(SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(2));
                    %                                                     outerShape = 'Rectangular';
                    %                                                 case {'elliptical','ellipticalaperture'}
                    %                                                     type = 'EllipticalAperture';
                    %                                                     uniqueParameters = struct;
                    %                                                     uniqueParameters.DiameterX = 2*max(SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(1));
                    %                                                     uniqueParameters.DiameterY = 2*max(SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(2));
                    %                                                     outerShape = 'Elliptical';
                    %                                                 otherwise
                    %                                                     msg('Error: Undefined aperture type');
                    %                                             end
                    %
                    %                                             apertDecenter = SavedOpticalSystem.SurfaceArray(kk).ApertureParameter(3:4);
                    %                                             apertRotInDeg = 0;
                    %                                             drawAbsolute = SavedOpticalSystem.SurfaceArray(kk).AbsoluteAperture;
                    %                                             additionalEdge = SavedOpticalSystem.SurfaceArray(kk).AdditionalEdge;
                    %
                    %                                             updatedSurfArray(kk).Aperture = Aperture(type,apertDecenter,apertRotInDeg,drawAbsolute,outerShape,additionalEdge,uniqueParameters);
                    %
                    %                                             updatedSurfArray(kk).Coating = SavedOpticalSystem.SurfaceArray(kk).Coating;
                    %                                             updatedSurfArray(kk).TiltDecenterOrder = SavedOpticalSystem.SurfaceArray(kk).TiltDecenterOrder;
                    %                                             updatedSurfArray(kk).Tilt = SavedOpticalSystem.SurfaceArray(kk).TiltParameter;
                    %                                             updatedSurfArray(kk).Decenter = SavedOpticalSystem.SurfaceArray(kk).DecenterParameter;
                    %                                             updatedSurfArray(kk).TiltMode = SavedOpticalSystem.SurfaceArray(kk).TiltMode;
                    %                                             % TM = transformation Matrix
                    %                                             updatedSurfArray(kk).SurfaceCoordinateTM = ...
                    %                                                 SavedOpticalSystem.SurfaceArray(kk).SurfaceCoordinateTM;
                    %                                             updatedSurfArray(kk).ReferenceCoordinateTM = ...
                    %                                                 SavedOpticalSystem.SurfaceArray(kk).ReferenceCoordinateTM;
                    %                                             updatedSurfArray(kk).GlassBefore  = SavedOpticalSystem.SurfaceArray(kk).GlassBefore;
                    %
                    %                                             updatedSurfArray(kk).SurfaceColor = SavedOpticalSystem.SurfaceArray(kk).SurfaceColor;
                    %                                             updatedSurfArray(kk).Hidden = SavedOpticalSystem.SurfaceArray(kk).Hidden;
                    %                                             updatedSurfArray(kk).Ignored = SavedOpticalSystem.SurfaceArray(kk).Ignored;
                    %
                    %
                    %                                             updatedSurfArray(kk).TiltDecenterOrder = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                    %
                    %                                         end
                    %
                    % SavedOpticalSystem.SurfaceArray = updatedSurfArray;
                    
                    % %% Change FixedIndex Glass to IdealDispersive
                    % for kk = 1:nSurf
                    %     glassType = SavedOpticalSystem.SurfaceArray(kk).Glass.Type;
                    %      glassName = SavedOpticalSystem.SurfaceArray(kk).Glass.Name;
                    %     if strcmpi(glassType,'FixedIndex')||strcmpi(glassName,'None')||strcmpi(glassName,'None')
                    %         glassParam = struct();
                    %         glassParam.RefractiveIndex = 1;
                    %         glassParam.AbbeNumber = 0;
                    %         glassParam.DeltaRelativePartialDispersion = 0;
                    %         glassParam.ReferenceWavelength = 0.55*10^-6;
                    %
                    %         newGlass = Glass('None','All','IdealDispersive',glassParam);
                    %         SavedOpticalSystem.SurfaceArray(kk).Glass = newGlass;
                    %     else
                    %
                    %     end
                    %
                    % end
                    % %% Update Glass to to support user defined glasses
                    % for kk = 1:nSurf
                    %     glassType = SavedOpticalSystem.SurfaceArray(kk).Glass.Type;
                    %     glassName = SavedOpticalSystem.SurfaceArray(kk).Glass.Name;
                    %     if strcmpi(glassType,'FixedIndex')||strcmpi(glassName,'None')||strcmpi(glassName,'None')
                    % %         glassParam = struct();
                    % %         glassParam.RefractiveIndex = 1;
                    % %         glassParam.AbbeNumber = 0;
                    % %         glassParam.DeltaRelativePartialDispersion = 0;
                    % %         glassParam.ReferenceWavelength = 0.55*10^-6;
                    % %
                    % %         newGlass = Glass('None','All','IdealDispersive',glassParam);
                    % %         SavedOpticalSystem.SurfaceArray(kk).Glass = newGlass;
                    %     else
                    %         newGlass = Glass(glassName);
                    %         SavedOpticalSystem.SurfaceArray(kk).Glass = newGlass;
                    %     end
                    %
                    % end
                    %
                    % %% Change SystemApertureType from numeric to String
                    % apertType = SavedOpticalSystem.SystemApertureType;
                    % if isnumeric(apertType)
                    %     switch apertType
                    %         case 1
                    %             SavedOpticalSystem.SystemApertureType = 'ENPD';
                    %         case 2
                    %             SavedOpticalSystem.SystemApertureType = 'OBNA';
                    %         case 3
                    %             SavedOpticalSystem.SystemApertureType = 'OBFN';
                    %         case 4
                    %             SavedOpticalSystem.SystemApertureType = 'IMNA';
                    %     end
                    % end
                    
                    %% Change OpticalSystem, Surface, Aperture, Glass and Coating from object to struct
                    % from numeric to String
                try
                        SavedOpticalSystem.ClassName = 'OpticalSystem';
                        SavedOpticalSystem2 = struct(SavedOpticalSystem);
                        if IsComponentBased(SavedOpticalSystem)
                            nComp = getNumberOfComponents(SavedOpticalSystem);
                            for cc = 1:nComp
                                SavedOpticalSystem.ComponentArray(cc).ClassName = 'Component';
                                SavedOpticalSystem2.ComponentArray(cc) = struct(SavedOpticalSystem.ComponentArray(cc));
                            end
                        else
                            SavedOpticalSystem2.ComponentArray = struct(Component);
                        end
                        if IsSurfaceBased(SavedOpticalSystem)
                            nSurf = getNumberOfSurfaces(SavedOpticalSystem);
                            newSurfStructArray(nSurf) = struct(Surface);
                            for kk = 1:nSurf
                                SavedOpticalSystem.SurfaceArray(kk).ClassName = 'Surface';
                                newSurfStructArray(kk) = struct(SavedOpticalSystem.SurfaceArray(kk));
                               SavedOpticalSystem.SurfaceArray(kk).Aperture.ClassName = 'Aperture';
                               newSurfStructArray(kk).Aperture = struct(SavedOpticalSystem.SurfaceArray(kk).Aperture);
                               SavedOpticalSystem.SurfaceArray(kk).Glass.ClassName = 'Glass';
                               newSurfStructArray(kk).Glass = struct(SavedOpticalSystem.SurfaceArray(kk).Glass);
                               SavedOpticalSystem.SurfaceArray(kk).Coating.ClassName = 'Coating';
                               newSurfStructArray(kk).Coating = struct(SavedOpticalSystem.SurfaceArray(kk).Coating);
                            end
                            SavedOpticalSystem2.SurfaceArray = newSurfStructArray;
                        else
                            SavedOpticalSystem2.SurfaceArray = struct(Surface);
                        end
                        saveToMATFileNew( SavedOpticalSystem2,pathNameNew,fileName);
                        disp('Success: Optical system updated.');
                catch
                end
                    else
      
                    end   
            else
                
            end
        else
        end
        
    end
    
end

function [ saved ] = saveToMATFileNew( optSystem,pathName,fileName )
    %saveToMATFile: Save the optical system to a MAT file
    FileInfoStruct = struct();
    FileInfoStruct.Type = 'OpticalSystem';
    FileInfoStruct.Date = date;
    SavedOpticalSystem = optSystem;
    save([pathName '\' fileName ], 'SavedOpticalSystem','FileInfoStruct');
    saved  =  1;
end



function [ valid, fileInfoStruct, dispMsg,relatedCatalogueFullFileNames] = isValidOpticalSystemFile...
        ( objectCatalogueFullName )
    %ISVALIDCOATINGCATALOGUE Retruns whether the object catalogue is vlaid or
    % not.
    if nargin < 1
        disp(['Error: The isValidObjectCatalogue needs objectType ',...
            'and objectCatalogueFullName as argument']);
        return;
    end
    [pathstr,name,ext] = fileparts(objectCatalogueFullName);
    
    %load the object array and field info struct from the file
    try
        if exist(objectCatalogueFullName,'file')&&~isempty(name)
            relatedCatalogueFullFileNames = objectCatalogueFullName;
            S = load(objectCatalogueFullName);
            % Variable named FileInfoStruct and ObjectArray does exsist
            if isfield(S,'FileInfoStruct') && isfield(S,'SavedOpticalSystem')
                fileInfo = S.FileInfoStruct;
                objectArray = S.SavedOpticalSystem;
                % Variable named FileInfoStruct is empty
                if isempty(fieldnames(fileInfo))
                    valid = 0;
                    fileInfoStruct = [];
                    dispMsg = 'Error: Invalid Object Catalogue File';
                    return
                else
                    if (strcmpi(fileInfo.Type,'OpticalSystem')&&...
                            strcmpi(class(objectArray),'OpticalSystem'))
                        valid = 1;
                        fileInfoStruct = fileInfo;
                        dispMsg = 'Success: Object Catalogue File is Valid.';
                        return
                    else
                        valid = 0;
                        fileInfoStruct = [];
                        dispMsg = 'Error: Invalid Object Catalogue File';
                        return
                    end
                end
            else
                valid = 0;
                fileInfoStruct = [];
                dispMsg = 'Error: Invalid Object Catalogue File';
                return
            end
        else
            % check if the catalogue exists in another path
            valid = 0;
            fileInfoStruct = [];
            relatedCatalogueFullFileNames = which([name,ext],'-all');
            dispMsg = ['Error:  ',objectCatalogueFullName ,'  does not exists.'];
            return
        end
    catch
        valid = 0;
        fileInfoStruct = [];
        dispMsg = ['Error: Something goes wrong while opening  ',objectCatalogueFullName];
        return
    end
end

