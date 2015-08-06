function [NewOpticalSystem] =  OpticalSystem(fullFilePath)
    % Constructs a new Optical system object either from previously
    % saved file or empty
    if nargin < 1
        % default constructor with empty argument. By default it is
        % surface based so 3 surfaces are defined.
        tempSurfaceArray(1) = Surface();
        tempSurfaceArray(2) = Surface();
        tempSurfaceArray(3) = Surface();
        
        tempSurfaceArray(1).ObjectSurface = 1;
        tempSurfaceArray(2).Stop = 1;
        tempSurfaceArray(3).ImageSurface = 1;
        
        NewOpticalSystem.SurfaceArray = tempSurfaceArray;
        
        % Component array will be NaN for surface based defintion
        NewOpticalSystem.ComponentArray = Component();
        
        NewOpticalSystem.SystemApertureType = 'ENPD';
        NewOpticalSystem.SystemApertureValue = 5;
        NewOpticalSystem.ComputeFastSemidiameter = 1;
        
        NewOpticalSystem.LensName = 'Lens 01';
        NewOpticalSystem.LensNote = 'No comment';
        NewOpticalSystem.WavelengthUnit = 'um';
        NewOpticalSystem.LensUnit = 'mm';
        NewOpticalSystem.WavelengthMatrix = [0.55 1];
        NewOpticalSystem.PrimaryWavelengthIndex = 1;
        NewOpticalSystem.FieldType = 'ObjectHeight';   % object height
        NewOpticalSystem.FieldPointMatrix = [0 0 1];
        
        NewOpticalSystem.IsObjectAfocal = 0;
        NewOpticalSystem.IsImageAfocal = 0;
        NewOpticalSystem.IsObjectTelecenteric = 0;
        NewOpticalSystem.IsObjectTelecenteric = 0;
        
        NewOpticalSystem.IsUpdatedSurfaceArray = 0;
        
        NewOpticalSystem.CoatingCataloguesList =  getAllObjectCatalogues('Coating');
        
        NewOpticalSystem.ApodizationType = 'None';
        NewOpticalSystem.ApodizationParameters = '';
        
        NewOpticalSystem.FieldNormalization = 'Rectangular';
        NewOpticalSystem.SystemDefinitionType = 'SurfaceBased';
        NewOpticalSystem.SystemMode = 'SEQ';
        NewOpticalSystem.GlassCataloguesList = getAllObjectCatalogues('Glass');
        NewOpticalSystem.SoftwareVersion = '';
        NewOpticalSystem.Saved = 0;
        NewOpticalSystem.PathName = '';
        NewOpticalSystem.FileName = '';
    else
        % Open previously saved optical system from file
        if ~isempty(fullFilePath)
            load(fullFilePath);
            % load the object SavedOpticalSystem object to new optical
            % system
            NewOpticalSystem = SavedOpticalSystem;
        else
            disp('Error:The file does not exist');
            NewOpticalSystem = OpticalSystem;
        end
        
    end
    NewOpticalSystem.ClassName = 'OpticalSystem';
end

