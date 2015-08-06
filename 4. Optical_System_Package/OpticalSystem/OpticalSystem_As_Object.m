classdef OpticalSystem
    % OPTICALSYSTEM Class:
    %   Defines the whole optical system
    % Properties: 30
    %     % Basic Components
    %     NumberOfSurfaces % total number of surfaces including the object,
    %                      % image and stop and all dummy surfaces
    %     SurfaceArray % Array of surfaces starting from Object->Image surface
    %     NumberOfNonDummySurfaces % total number of surfaces including the object,
    %                              % image and stop but with out dummy surfaces 
    %     NonDummySurfaceArray % Array of non dummy surfaces starting from Object->Image surface 
    %     NonDummySurfaceIndices % Indices of non dummy surfaces in the total surface array.    
    % (newly added field)
    %     NumberOfComponents % total number of Components including the object & image 
    %     ComponentArray % Array of components starting from Object->Image
    %                      surface component 
    % 
    %     % General System Properties
    %     SystemApertureType % {1:'Enterance Pupil Diameter',2:'Object Space NA',...
    %                        % 3:'Object Space F#',4:'Image Space NA',5:'Image Space F#'}
    %     SystemApertureValue % Value of the system aperture specified
    %   
    %     FastSemidiameter % 1 if fast semidiameters shall be calculated
    %                        for Floating aperture
    %     SurfaceMarginPercent % Percentage of aperture value added to the
    %                          clear aperture of each surface
    %     SurfaceMarginAdditional % Additional length  added to the
    %                          clear aperture of each surface    
    %     StopIndex % index of stop surface
    %     StopHeight % stop height (radius)
    % 
    %     LensName % Lens Name
    %     LensNote % Notes about the Lens
    %     WavelengthUnit % Units of wavelengths used, {1:'nanometer(nm)',
    %                    % 2:'micrometer(um)'}
    %     LensUnit % Unit of dimesnsions of the lens {1:'milimeter(mm)',
    %              % 2:'centimeter(cm)',3:'meter(m)'}
    % 
    %     NumberOfWavelengths % total number of wavelengths used
    %     WavelengthMatrix % matrix , wavelength, weight of Wavelength Used
    %     PrimaryWavelengthIndex % Index of the primary wavelength
    % 
    %     FieldType % Type of field specified either 'ObjectHeight' or 'Angle'
    %     NumberOfFieldPoints % total number of field points used
    %     FieldPointMatrix % matrix of X field, Y field & Weight
    %                      % (either object height or angle)
    %     % Boolean to show image and object side afocal and telecentric side afocal system.
    %     ObjectAfocal
    %     ImageAfocal
    %     ObjectTelecenteric
    %     ImageTelecenetric
    % 
    %     % Coating Catalogue Files
    %     CoatingCataloguesList
    %     % Array of Glass Catalogues Used in the system
    %     GlassCataloguesList
    % 
    %     % Pupil Apodization parameters
    %     ApodizationType % String 'Super Gaussian','None',...
    %     ApodizationParameters % Struct with apodization parameters
    %     % Eg. For 'Super Gaussian' it will have fields
    %     % MaximumIntensity , Order and BeamRadius
    % 
    %     FieldNormalization % 'Radial', 'Rectangular'
    %     % Others
    %     SystemMode % "SEQ" Sequential or "NSQ" Non Sequential system
    %     SoftwareVersion % String Version of the software created the system
    % 
    %     Saved % boolean showing whether the optical system is already saved or not
    %     PathName % full path name of saved optical system
    %     FileName % file name of saved optical system
    % Methods: 39
    %     All functions which operate on the optical system object are
    %     included here
    
    % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    properties
        % Basic Components        
        SurfaceArray % Array of surfaces starting from Object->Image surface
        % (newly added field)
        ComponentArray % Array of components starting from Object->Image
                       %surface component    
        % General System Properties
        SystemApertureType % {ENPD:'Enterance Pupil Diameter',OBNA:'Object Space NA',...
        % OBFN:'Object Space F#',IMNA:'Image Space NA',IMFN:'Image Space F#'}
        SystemApertureValue % Value of the system aperture specified
        ComputeFastSemidiameter % 1 if fast semidiameters shall be calculated
                         % for Floating aperture
        SurfaceMarginPercent % Percentage of aperture value added to the
                             % clear aperture of each surface
        SurfaceMarginAdditional % Additional length  added to the
                             % clear aperture of each surface                
        LensName % Lens Name
        LensNote % Notes about the Lens
        
        WavelengthUnit % Units of wavelengths used, {nm:'nanometer(nm)',
        % um:'micrometer(um) mm:milimeter(mm)'}
        LensUnit % Unit of dimesnsions of the lens {mm:'milimeter(mm)',
        %cm:'centimeter(cm)',m:'meter(m)'}
        
        % Source definitions
        
        WavelengthMatrix % matrix , wavelength, weight of Wavelength Used
        PrimaryWavelengthIndex % Index of the primary wavelength
        
        FieldType % Type of field specified either 'ObjectHeight' or 'Angle'
        FieldPointMatrix % matrix of X field, Y field & Weight
        % (either object height or angle)
        
        % Source
        Source
        
        
        % Boolean to show image and object side afocal and telecentric side afocal system.
        ObjectAfocal
        ImageAfocal
        ObjectTelecenteric
        ImageTelecenetric
        
        % Array of Coating Catalogue Files Used in the system
        CoatingCataloguesList
        % Array of Glass Catalogues Used in the system
        GlassCataloguesList
        
        % Pupil Apodization parameters
        ApodizationType % String 'None','Super Gaussian'...
        ApodizationParameters % Struct with apodization parameters
        % Eg. For 'Super Gaussian' it will have fields
        % MaximumIntensity , Order and BeamRadius
        
        FieldNormalization % 'Radial', 'Rectangular'

        % Others
        SystemDefinitionType % System definition type 'SurfaceBased','ComponentBased'
        SystemMode % "SEQ" Sequential or "NSQ" Non Sequential system
        SoftwareVersion % String Version of the software created the system
        
        Saved % boolean showing whether the optical system is already saved or not
        PathName % full path name of saved optical system
        FileName % file name of saved optical system
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects.    

    end
    
    methods
        % Constructor Methods
        function NewOpticalSystem = OpticalSystem(fullFilePath)
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
                NewOpticalSystem.ComponentArray = Component.empty;
                
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
                
                NewOpticalSystem.ObjectAfocal = 0;
                NewOpticalSystem.ImageAfocal = 0;
                NewOpticalSystem.ObjectTelecenteric = 0;
                NewOpticalSystem.ObjectTelecenteric = 0;
                
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
    end
    
    methods(Static)
        function newObj = InputGUI()
            newObj = ObjectInputDialog(MyHandle(OpticalSystem()));
        end
    end 
end

