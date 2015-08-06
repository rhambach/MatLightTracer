function updateSystemConfigurationWindow( parentWindow )
    %UPDATESYSTEMCONFIGURATIONWINDOW Updates the system configuration
    %window
    
    aodHandles = parentWindow.ParentHandles;
    [ currentOpticalSystem,saved] = getCurrentOpticalSystem (parentWindow);
    
    %aperture data
    if isnumeric(currentOpticalSystem.SystemApertureType)
        systemApertureTypeIndex = currentOpticalSystem.SystemApertureType;
    else
        switch upper(currentOpticalSystem.SystemApertureType)
            case 'ENPD'
                systemApertureTypeIndex = 1;
            case 'OBNA'
                systemApertureTypeIndex = 2;
            case  'OBFN'
                systemApertureTypeIndex = 3;
            case 'IMNA'
                systemApertureTypeIndex = 4;
            case 'IMFN'
                systemApertureTypeIndex = 5;
        end
    end
    set(aodHandles.popApertureType,'Value',systemApertureTypeIndex);
    set(aodHandles.txtApertureValue,'String',currentOpticalSystem.SystemApertureValue);
    
    %general data
    set(aodHandles.txtLensName,'String',currentOpticalSystem.LensName);
    set(aodHandles.txtLensNote,'String',currentOpticalSystem.LensNote);
    
    if isnumeric(currentOpticalSystem.LensUnit)
        lensUnitIndex = currentOpticalSystem.LensUnit;
    else
        
        switch lower(currentOpticalSystem.LensUnit)
            case 'mm'
                lensUnitIndex = 1;
            case 'cm'
                lensUnitIndex = 2;
            case 'mt'
                lensUnitIndex = 3;
        end
    end
    set(aodHandles.popLensUnit,'Value',lensUnitIndex);
    if isnumeric(currentOpticalSystem.WavelengthUnit)
        wavelengthUnitIndex = currentOpticalSystem.WavelengthUnit;
    else
        switch lower(currentOpticalSystem.WavelengthUnit)
            case 'nm'
                wavelengthUnitIndex = 1;
            case 'um'
                wavelengthUnitIndex = 2;
            case 'mm'
                wavelengthUnitIndex = 3;
        end
    end
    set(aodHandles.popWavelengthUnit,'Value',wavelengthUnitIndex);
    
    if isnumeric(currentOpticalSystem.SystemDefinitionType)
        systemDefinitionTypeIndex = currentOpticalSystem.SystemDefinitionType;
    else
        switch lower(currentOpticalSystem.SystemDefinitionType)
            case 'surfacebased'
                systemDefinitionTypeIndex = 1;
            case 'componentbased'
                systemDefinitionTypeIndex = 2;
        end
    end
    set(aodHandles.popSystemDefinitionType,'Value',systemDefinitionTypeIndex);
    
    %wavelength data
    set(aodHandles.txtTotalWavelengthsSelected,'String',getNumberOfWavelengths(currentOpticalSystem))
    set(aodHandles.popPrimaryWavlenIndex,'String',num2cell(1:getNumberOfWavelengths(currentOpticalSystem)));
    set(aodHandles.popPrimaryWavlenIndex,'Value',currentOpticalSystem.PrimaryWavelengthIndex);
    
    newTable1 = currentOpticalSystem.WavelengthMatrix;
    % add a column for 'selected' and last row which is not selected (if
    % not already there in the WavelengthMatrix)
    if size(newTable1,2) < 3
        newTable1 =  [ones(size(newTable1,1),1),newTable1];
    end
    if newTable1(end,1) == 1
        newTable1 = [newTable1;0,0.55,1];
    end
    newTable1 = mat2cell(newTable1,[ones(1,size(newTable1,1))],[ones(1,size(newTable1,2))]);
    for p = 1:size(newTable1,1)
        newTable1{p,1} = logical(newTable1{p,1});
    end
    set(aodHandles.tblWavelengths, 'Data', newTable1);
    
    % field data
    set(aodHandles.txtTotalFieldPointsSelected,'String',getNumberOfFieldPoints(currentOpticalSystem));
    set(aodHandles.radioAngle,'Value',strcmpi(char(currentOpticalSystem.FieldType),'Angle'));
    set(aodHandles.radioObjectHeight,'Value',strcmpi(char(currentOpticalSystem.FieldType),'ObjectHeight'));
    set(aodHandles.radioImageHeight,'Value',strcmpi(char(currentOpticalSystem.FieldType),'ImageHeight'));
    %
    if isempty(currentOpticalSystem.FieldNormalization)
        currentOpticalSystem.FieldNormalization = 'Rectangular';
        fieldNormalizationIndex = 1;
    else
        fieldNormalizationIndex = find(ismember(get(aodHandles.popFieldNormalization,'String'),...
            currentOpticalSystem.FieldNormalization));
    end
    if ~isempty(fieldNormalizationIndex)
        set(aodHandles.popFieldNormalization,'Value',fieldNormalizationIndex);
    else
        disp(['Error: Apodization type ',...
            currentOpticalSystem.popFieldNormalization,' is not defined.']);
        return;
    end
    
    
    newTable2 = currentOpticalSystem.FieldPointMatrix;
    % add a column for 'selected' and last row which is not selected (if
    % not already there in the WavelengthMatrix)
    if size(newTable2,2) < 4
        newTable2 =  [ones(size(newTable2,1),1),newTable2];
    end
    if newTable2(end,1) == 1
        newTable2 = [newTable2;0,0,0,1];
    end
    newTable2 = mat2cell(newTable2,[ones(1,size(newTable2,1))],[ones(1,size(newTable2,2))]);
    for p = 1:size(newTable2,1)
        newTable2{p,1} = logical(newTable2{p,1});
    end
    set(aodHandles.tblFieldPoints, 'Data', newTable2);
    
    if isprop(currentOpticalSystem,'CoatingCataloguesList')
        % Coating Catalogue
        newTable3 = currentOpticalSystem.CoatingCataloguesList;
        if isempty(newTable3)
            newTable3 = getAllObjectCatalogues('coating');
        end
        % update the path name of each catalogues
        for k = 1: size(newTable3,1)
            catalofueFullFileName = newTable3{k,:};
            addCoatingCatalogue(parentWindow,catalofueFullFileName);
        end
    end
    
    if isprop(currentOpticalSystem,'GlassCataloguesList')
        % glass Catalogue
        newTable3 = currentOpticalSystem.GlassCataloguesList;
        if isempty(newTable3)
            newTable3 = getAllObjectCatalogues('glass');
        end
        % update the path name of each catalogues
        for k = 1: size(newTable3,1)
            catalofueFullFileName = newTable3{k,:};
            addGlassCatalogue(parentWindow,catalofueFullFileName);
        end
    end
    
    
    if isprop(currentOpticalSystem,'ApodizationType')
        % Pupil Apodization data
        if isempty(currentOpticalSystem.ApodizationType)
            currentOpticalSystem.ApodizationType = 'None';
            apodTypeIndex = 1;
        else
            apodTypeIndex = find(ismember(get(aodHandles.popApodizationType,'String'),...
                currentOpticalSystem.ApodizationType));
        end
        if ~isempty(apodTypeIndex)
            set(aodHandles.popApodizationType,'Value',apodTypeIndex);
        else
            disp(['Error: Apodization type ',...
                currentOpticalSystem.ApodizationType,' is not defined.']);
            return;
        end
        switch lower(currentOpticalSystem.ApodizationType)
            case lower('None')
                set(aodHandles.panelSuperGaussParameters,'Visible','off');
                set(get(aodHandles.panelSuperGaussParameters,'Children'),'Visible','off');
                set(aodHandles.popApodizationType,'Value',1);
            case lower('Super Gaussian')
                set(aodHandles.panelSuperGaussParameters,'Visible','on');
                set(get(aodHandles.panelSuperGaussParameters,'Children'),'Visible','on');
                set(aodHandles.popApodizationType,'Value',2);
                
                apodParam = currentOpticalSystem.ApodizationParameters;
                set(aodHandles.txtApodMaximumIntensity,'String',...
                    num2str(apodParam.MaximumIntensity));
                set(aodHandles.txtApodOrder,'String',num2str(apodParam.Order));
                set(aodHandles.txtApodBeamRadius,'String',num2str(apodParam.BeamRadius));
        end
    end
    
    aodHandles.OpticalSystem = currentOpticalSystem;
    parentWindow.ParentHandles = aodHandles;
end

