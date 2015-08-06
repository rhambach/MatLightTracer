function [ SavedOpticalSystem,saved] = getCurrentOpticalSystem (parentWindow)
% getCurrentOpticalSystem: Constructs an optical system object from the AOD
% Main Window
% Member of AODParentWindow class

aodHandles = parentWindow.AODParentHandles;
button='Yes';

[valid,message] = validateOpticalSystemNew (parentWindow);

if ~ valid
     msgbox(message,'Invalid Input','error');
     SavedOpticalSystem = NaN;
     saved = 0;
     return
end 
if strcmpi(button,'Yes')
    saved = aodHandles.Saved;
    pathName = aodHandles.PathName;
    fileName = aodHandles.FileName;

    % Component array parameters
    componentArray = aodHandles.OpticalSystem.ComponentArray;
    nComponent = size(componentArray,2);
    
    %System Configuration
    %aperture
    tempSystemApertureType=get(aodHandles.popApertureType,'Value');
    tempSystemApertureValue=str2double(get(aodHandles.txtApertureValue,'String'));

    %general
    tempLensName=get(aodHandles.txtLensName,'String');
    tempLensNote=get(aodHandles.txtLensNote,'String');
    tempLensUnit=get(aodHandles.popLensUnit,'Value');
    tempWavelengthUnit=get(aodHandles.popWavelengthUnit,'Value');
    tempSystemDefType = get(aodHandles.popSystemDefinitionType,'Value');
    
    %wavelength
    nWavelength = str2double(get(aodHandles.txtTotalWavelengthsSelected,'String'));
    tempPrimaryWavelengthIndex = get(aodHandles.popPrimaryWavlenIndex,'Value');
    tempPredefinedWavlens      = get(aodHandles.popPredefinedWavlens,'Value');

    tblData = get(aodHandles.tblWavelengths,'data');
    tempWavelengthMatrix = reshape([tblData{:,:}],length([tblData{:,:}])/3,3);
    % Remove the 1st col (Selected Chekbox) and last row (just empty row)
    if tempWavelengthMatrix(end,1)== 0 % checks condn
       tempWavelengthMatrix = tempWavelengthMatrix(1:end-1,2:end);
    end

    %fields
    nFieldPoint = str2double(get(aodHandles.txtTotalFieldPointsSelected,'String'));
    tempAngle = get(aodHandles.radioAngle,'Value');
    tempObjectHeight = get(aodHandles.radioObjectHeight,'Value');
    tempImageHeight = get(aodHandles.radioImageHeight,'Value');
    if tempAngle
        tempFieldType = 'Angle';
    elseif tempObjectHeight
        tempFieldType = 'ObjectHeight';
    elseif tempImageHeight
        % Currently Imageheight is not supported so take as object heigth. 
       tempFieldType = 'ObjectHeight'; 
    end
    
    tempFieldNormalizationList = cellstr (get(aodHandles.popFieldNormalization,'String'));
    tempFieldNormalization = (tempFieldNormalizationList{get(aodHandles.popFieldNormalization,'Value')});
    
    tblData2 = get(aodHandles.tblFieldPoints,'data');
    tempFieldPointMatrix = reshape([tblData2{:,:}],length([tblData2{:,:}])/4,4);
    % Remove the 1st col (Selected Chekbox) and last row (just empty row)
    if tempFieldPointMatrix(end,1)==0 % checks condn
       tempFieldPointMatrix = tempFieldPointMatrix(1:end-1,2:end);
    end

 % Coating Catalogue
 tableData1 = get(aodHandles.tblCoatingCatalogues,'data');
 if ~isempty(tableData1)
     % Take only the selected ones
     selectedRows1 = find(cell2mat(tableData1(:,1)));
     if ~isempty(selectedRows1)
         tempCoatingCataloguesList = tableData1(selectedRows1,3);
     else
         tempCoatingCataloguesList = [];
     end
 else
     tempCoatingCataloguesList = [];
 end
 
 % Glass Catalogue
 tableData2 = get(aodHandles.tblGlassCatalogues,'data');
 if ~isempty(tableData2)
     % Take only the selected ones
     selectedRows2 = find(cell2mat(tableData2(:,1)));
     if ~isempty(selectedRows2)
         tempGlassCataloguesList = tableData2(selectedRows2,3);
     else
         tempGlassCataloguesList = [];
     end
 else
     tempGlassCataloguesList = [];
 end
 
 % Pupil Apodization
 tempApodizationTypeList = cellstr (get(aodHandles.popApodizationType,'String'));
 tempApodizationType = (tempApodizationTypeList{get(aodHandles.popApodizationType,'Value')});
 tempApodizationParameters = struct();
 switch lower(tempApodizationType)
     case lower('None')
         tempApodizationParameters = '';
     case lower('Super Gaussian')
         tempApodizationParameters.MaximumIntensity = str2double(get(aodHandles.txtApodMaximumIntensity,'String'));
         tempApodizationParameters.Order = str2double(get(aodHandles.txtApodOrder,'String'));
         tempApodizationParameters.BeamRadius = str2double(get(aodHandles.txtApodBeamRadius,'String'));
 end
 
    %Surface Data
    tempStandardData = get(aodHandles.tblStandardData,'data');
    tempApertureData= get(aodHandles.tblApertureData,'data');
    tempTiltDecenterData= get(aodHandles.tblTiltDecenterData,'data');
    
    sizeTblData = size(tempStandardData);
    nSurface = sizeTblData(1);
    %% Now write all the data to an optical system object
    % New optical system
    NewOpticalSystem = OpticalSystem;

    NewOpticalSystem.Saved = saved;
    NewOpticalSystem.PathName = pathName;
    NewOpticalSystem.FileName = fileName;    
        
    %Set optical systems properties
    NewOpticalSystem.NumberOfSurfaces = nSurface;
    
    %component parameters
    NewOpticalSystem.NumberOfComponents = nComponent;
    NewOpticalSystem.ComponentArray = componentArray;
    
    %set aperture
    NewOpticalSystem.SystemApertureType=tempSystemApertureType;
    NewOpticalSystem.SystemApertureValue=tempSystemApertureValue;
    %set general
    NewOpticalSystem.LensName=tempLensName;
    NewOpticalSystem.LensNote=tempLensNote;
    NewOpticalSystem.WavelengthUnit = tempWavelengthUnit;
    NewOpticalSystem.LensUnit = tempLensUnit;
    NewOpticalSystem.SystemDefinitionType = tempSystemDefType;
    
    NewOpticalSystem.ObjectAfocal = 0;
    NewOpticalSystem.ImageAfocal = 0;
    NewOpticalSystem.ObjectTelecenteric = 0;
    NewOpticalSystem.ObjectTelecenteric = 0;

    %set wavelength
    NewOpticalSystem.NumberOfWavelengths=nWavelength;
    NewOpticalSystem.WavelengthMatrix=tempWavelengthMatrix;
    NewOpticalSystem.PrimaryWavelengthIndex=tempPrimaryWavelengthIndex;
    %set field
    NewOpticalSystem.FieldType = tempFieldType;
    NewOpticalSystem.NumberOfFieldPoints = nFieldPoint;
    NewOpticalSystem.FieldPointMatrix = tempFieldPointMatrix;
    NewOpticalSystem.CoatingCataloguesList = tempCoatingCataloguesList;
    NewOpticalSystem.GlassCataloguesList = tempGlassCataloguesList;
    
    NewOpticalSystem.ApodizationType = tempApodizationType;
    NewOpticalSystem.ApodizationParameters = tempApodizationParameters;
   
    NewOpticalSystem.FieldNormalization = tempFieldNormalization;
    
    %create empty surface array
    Surface.empty(nSurface,0);

    %Set optical system surfaces. 
    % Assume global ref is 1st surface of the lens  
    NewOpticalSystem.SurfaceArray(1).DecenterParameter = [0 0];
    NewOpticalSystem.SurfaceArray(1).TiltParameter = [0 0 0];

    %NewOpticalSystem.SurfaceArray(1).Position = [0,0,0];
    objLocation = -1*str2double(char(tempStandardData(1,7)));
    if abs(objLocation) > 10^10 % Infinite object distance replaced with 0
        objLocation = 0;
    end
    NonDummySurface = ones(1,nSurface);
    for k = 1:1:nSurface
        %standard data
        surface = tempStandardData(k,1);
        if isequaln(char(surface),'OBJECT')
            NewOpticalSystem.SurfaceArray(k).ObjectSurface = 1;
        elseif isequaln(char(surface),'IMAGE')
            NewOpticalSystem.SurfaceArray(k).ImageSurface = 1;
        elseif isequaln(char(surface),'STOP')
            NewOpticalSystem.SurfaceArray(k).Stop = 1;
            NewOpticalSystem.StopIndex = k;
        else
            NewOpticalSystem.SurfaceArray(k).Stop = 0;
            NewOpticalSystem.SurfaceArray(k).ImageSurface = 0;
            NewOpticalSystem.SurfaceArray(k).ObjectSurface = 0;
        end
        NewOpticalSystem.SurfaceArray(k).Comment       = char(tempStandardData(k,2));%text
        NewOpticalSystem.SurfaceArray(k).Type          = char(tempStandardData(k,3));%text
        if strcmpi(NewOpticalSystem.SurfaceArray(k).Type,'Dummy')
            NonDummySurface(k) = 0;
        end
        NewOpticalSystem.SurfaceArray(k).Thickness     = tempStandardData{k,5};
        
        % get glass name and then SellmeierCoefficients from file
        glassName = strtrim(char(tempStandardData(k,7)));% text
        if strcmpi(glassName,'Mirror')
            % Just take the glass of the non dummy surface before the mirror 
            % but with the new name "MIRROR"
            for pp = k-1:-1:1
                if NonDummySurface(pp)
                    prevNonDummySurface = pp;
                    break;
                end
            end
            Object = NewOpticalSystem.SurfaceArray(prevNonDummySurface).Glass;
            Object.Name = 'MIRROR';            
            NewOpticalSystem.SurfaceArray(k).Glass = Object;            
        elseif ~isempty(glassName)
            % check for its existance and extract the glass among selected catalogues
            objectType = 'glass';
            objectName = glassName;
            if isempty(str2num(glassName)) % If the glass name is specified
                % Glass Catalogue
                tableData1 = get(aodHandles.tblGlassCatalogues,'data');
                if ~isempty(tableData1)
                    % Take only the selected ones
                    selectedRows1 = find(cell2mat(tableData1(:,1)));
                    if ~isempty(selectedRows1)
                        glassCatalogueListFullNames = tableData1(selectedRows1,3);
                    else
                        glassCatalogueListFullNames = '';
                    end
                else
                    glassCatalogueListFullNames = '';
                end
                objectCatalogueListFullNames = glassCatalogueListFullNames;
                objectIndex = 0;
                for pp = 1:size(objectCatalogueListFullNames,1)
                    objectCatalogueFullName = objectCatalogueListFullNames{pp};
                    [ Object,objectIndex ] = extractObjectFromObjectCatalogue...
                        (objectType,objectName,objectCatalogueFullName );
                    if objectIndex ~= 0
                        break;
                    end
                end
                
                if  objectIndex ~= 0
                    NewOpticalSystem.SurfaceArray(k).Glass = Object;
                else
                    disp(['Error: The glass after surface ',num2str(k),' is not found so it is ignored.']);
                    NewOpticalSystem.SurfaceArray(k).Glass = Glass;
                end                
            else
                % Fixed Index Glass
                % str2num can be used to convert array of strings to number.
                ndvdpg = str2num(glassName); 
                if length(ndvdpg) == 1
                    nd = ndvdpg(1);
                    vd = 0;
                    pd = 0;
                elseif length(ndvdpg) == 2
                    nd = ndvdpg(1);
                    vd = ndvdpg(2);
                    pd = 0;
                elseif length(ndvdpg) == 3
                    nd = ndvdpg(1);
                    vd = ndvdpg(2);
                    pd = ndvdpg(3);
                else
                end
                glassName = [num2str((nd),'%.4f '),',',...
                            num2str((vd),'%.4f '),',',...
                            num2str((pd),'%.4f ')];
                Object = Glass(glassName,'FixedIndex',[nd,vd,pd,0,0,0,0,0,0,0]');
                NewOpticalSystem.SurfaceArray(k).Glass = Object;
            end
        else
            NewOpticalSystem.SurfaceArray(k).Glass = Glass;
        end
             
        % coating data
        coatName = (char(tempStandardData(k,9)));
        if ~isempty(coatName)
            % check for its existance and extract the coating among selected catalogues
            objectType = 'coating';
            objectName = coatName;
            % Coating Catalogue
            tableData1 = get(aodHandles.tblCoatingCatalogues,'data');
            if ~isempty(tableData1)
                % Take only the selected ones
                selectedRows1 = find(cell2mat(tableData1(:,1)));
                if ~isempty(selectedRows1)
                    coatingCatalogueListFullNames = tableData1(selectedRows1,3);
                else
                    coatingCatalogueListFullNames = '';
                end
            else
                coatingCatalogueListFullNames = '';
            end
            objectCatalogueListFullNames = coatingCatalogueListFullNames;
            objectIndex = 0;
            for pp = 1:size(objectCatalogueListFullNames,1)
                objectCatalogueFullName = objectCatalogueListFullNames{pp};
                [ Object,objectIndex ] = extractObjectFromObjectCatalogue...
                    (objectType,objectName,objectCatalogueFullName );
                if objectIndex ~= 0
                    break;
                end
            end
            
            if  objectIndex ~= 0
                % change the default wavelength of coating to the current primary wavelength
                primaryWavLenInUm = NewOpticalSystem.getPrimaryWavelength*10^6;
                Object.CoatingParameters.WavelengthInUm = primaryWavLenInUm;
                NewOpticalSystem.SurfaceArray(k).Coating = Object;
            else
                disp(['Error: The coating of surface ',num2str(k),' is not found so it is ignored.']);
                NewOpticalSystem.SurfaceArray(k).Coating = Coating;
            end
        else
            NewOpticalSystem.SurfaceArray(k).Coating = Coating;
        end

        % Other surface type specific standard data
        [fieldNames,fieldFormat,initialData] = NewOpticalSystem.SurfaceArray(k).getOtherStandardDataFields;
        NewOpticalSystem.SurfaceArray(k).OtherStandardData = struct;
        for ff = 1:10
            NewOpticalSystem.SurfaceArray(k).OtherStandardData.(fieldNames{ff}) = ...
                (tempStandardData{k,ff+10});
        end       
        
        % aperture data
        NewOpticalSystem.SurfaceArray(k).ApertureType      = char(tempApertureData(k,3));
        NewOpticalSystem.SurfaceArray(k).ApertureParameter = ...
            [tempApertureData{k,5},tempApertureData{k,7},...
            tempApertureData{k,9},tempApertureData{k,11}]; 
        
        NewOpticalSystem.SurfaceArray(k).ClearAperture = tempApertureData{k,13};       
        NewOpticalSystem.SurfaceArray(k).AdditionalEdge = tempApertureData{k,14};        
        NewOpticalSystem.SurfaceArray(k).AbsoluteAperture = boolean(tempApertureData{k,15});
     
        % tilt decenter data
        NewOpticalSystem.SurfaceArray(k).TiltDecenterOrder = char(tempTiltDecenterData(k,3));
        NewOpticalSystem.SurfaceArray(k).DecenterParameter = ...
            [tempTiltDecenterData{k,5},tempTiltDecenterData{k,7}];    
        NewOpticalSystem.SurfaceArray(k).TiltParameter     = ...
            [tempTiltDecenterData{k,9},tempTiltDecenterData{k,11},tempTiltDecenterData{k,13}];
        NewOpticalSystem.SurfaceArray(k).TiltMode          = char(tempTiltDecenterData(k,15));

        % compute position from decenter and thickness
        if k==1 % Object surface
            objThickness = abs(NewOpticalSystem.SurfaceArray(k).Thickness);
            if objThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for graphing
                objThickness = 0;
            end
            % since global coord but shifted by objThickness
            refCoordinateTM = [1,0,0,0;0,1,0,0;0,0,1,-objThickness;0,0,0,1]; 
            
            surfaceCoordinateTM = refCoordinateTM;
            referenceCoordinateTM = refCoordinateTM;
            % set surface property
            NewOpticalSystem.SurfaceArray(k).SurfaceCoordinateTM = ...
                surfaceCoordinateTM;
            NewOpticalSystem.SurfaceArray(k).ReferenceCoordinateTM = ...
                referenceCoordinateTM;           
       else
            prevRefCoordinateTM = referenceCoordinateTM;
            prevSurfCoordinateTM = surfaceCoordinateTM;
            prevThickness = NewOpticalSystem.SurfaceArray(k-1).Thickness; 
            if prevThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for object distance
                prevThickness = 0;
            end
            [surfaceCoordinateTM,referenceCoordinateTM] = NewOpticalSystem. ...
                    SurfaceArray(k).TiltAndDecenter(prevRefCoordinateTM,...
                    prevSurfCoordinateTM,prevThickness);
            % set surface property
            NewOpticalSystem.SurfaceArray(k).SurfaceCoordinateTM = surfaceCoordinateTM;
            NewOpticalSystem.SurfaceArray(k).ReferenceCoordinateTM = referenceCoordinateTM;
        
        end
        NewOpticalSystem.SurfaceArray(k).Position = (surfaceCoordinateTM (1:3,4))';  
    end
    
    NewOpticalSystem.NonDummySurfaceIndices = find(NonDummySurface);
    NewOpticalSystem.NumberOfNonDummySurfaces = length(NewOpticalSystem.NonDummySurfaceIndices);
    NewOpticalSystem.NonDummySurfaceArray  = NewOpticalSystem.SurfaceArray(NewOpticalSystem.NonDummySurfaceIndices);
                
    SavedOpticalSystem = NewOpticalSystem;
    saved = 1;
else
    SavedOpticalSystem = [];
    saved = 0;
end
end

