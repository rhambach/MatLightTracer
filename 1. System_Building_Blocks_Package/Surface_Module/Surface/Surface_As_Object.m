classdef Surface
    % Surface Class:
    %
    %   Defines surfaces of optical interfaces. All surfaces
    %   types are defined using external functions and this class makes
    %   calls to the external functions to work with the surfaces.
    %
    % Properties: 3 and Methods: 12
    %
    % Example Calls:
    %
    % newSurface = Surface()
    %   Returns a default STANDARD plane surface with air afterwards.
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
    % Jun 17,2015   Worku, Norman G.     Make Aperture as objects
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    properties
        % Standard data
        ObjectSurface % (Boolean) - 1 object surface 0 else
        ImageSurface % (Boolean) - 1 image surface 0 else
        Stop % (Boolean) - 1 stop surface 0 else
        Comment %(String) - Name or notes on the surface
        Type % (String) - The surface type. It is the same as the surface definition function name.
        
        Thickness % (Numeric) - Thickness directly after the surface to the next surface
        Glass %  (Glass) - The glass object that follows after the current surface to the next surface
        Coating % (Coating) - The coating object of current surface
        
        UniqueParameters % (Structure) - Struct for Surface parameters unique to specific surface type
        Aperture % (Aperture) - The aperture object of current surface
        
        % tilt decenter data
        TiltDecenterOrder %  (Cell Array) - 6 elements showing the order in which
        % tilt and decenter operations are done.
        Tilt % (Vector 3x1) - [Tilt X, Tilt Y, Tilt Z] in degrees
        Decenter % (Vector 2x1) - [Decenter X,Decenter Y]
        TiltMode %  (String) - Coordinate system for subsequent surfaces
        % DAR: Decenter and return, NAX: New axis, BEN: Bend surface
        
        % CoordinateTM = Coordinate transform matrix is a 4x4 matrix
        % with both global vertex vector and coordinate rotation
        % matrix which can be used to perform Global to Local coordinate
        % transformation for the surface and the optical components after the
        % surface
        SurfaceCoordinateTM % (Matrix 4x4) - Surface loacal coordinate
        ReferenceCoordinateTM % (Matrix 4x4) - Reference coordinate after the surface
        % (starts at surface vertex)
        ExtraData % (Vector Nx1) - List of extra data for the surface
        % GlassBefore shall be added to hold for glass data before the surface
        GlassBefore % (Glass) - The glass object that is before the current surface to the next surface
        % Others not yet used
        SurfaceColor % (Vector 3x1) - Color of the surface drawing [R G B](RGB values)
        Hidden % (Boolean) - 1 hidden surface 0 else
        Ignored % (Boolean) - 1 ignored surface 0 else
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects.    

                    %% Unused fields
        OtherStandardData % Struct for Surface data unique to specific surface type
        % For STANDARD surface it has fields
        % {'Radius','Conic','GratingDensity','DiffractionOrder'}
        %aperture data
        ApertureType % {'None' 'Floating' 'Circular' 'Rectangular' 'Elliptical'}
        ApertureParameter %[param1:x half width, param2:y half width, param:x decenter, param4:y decenter]
        ClearAperture % Fraction of the aperture clear for ray passage
        AdditionalEdge % Fraction of aperture to be added as Edge in layout diagrams
        AbsoluteAperture %  = 1 the aperture is drawn exaclty as given, but if 0
         CoatingType % {'None' 'Jones Matrix' 'Multilayer Coating'}
        CoatingParameter % jones matrix of the coating     
        TiltParameter
        DecenterParameter
    end
    
    methods
        % Constructor
        function NewSurface = Surface(surfType)
            if nargin == 0
                % Make single surface component by default
                surfType = 'Standard';
            end
            NewSurface.ObjectSurface = 0;
            NewSurface.ImageSurface = 0;
            NewSurface.Stop = 0;
            NewSurface.Comment = '';
            NewSurface.Type = surfType;
            NewSurface.Thickness = 5;
            NewSurface.Glass = Glass();
            [fieldNames,fieldFormat,defaultUniqueParamStruct] = getSurfaceUniqueParameters(surfType);
            NewSurface.UniqueParameters = defaultUniqueParamStruct;
            NewSurface.ExtraData  = [];
            NewSurface.Aperture = Aperture();
            NewSurface.Coating = Coating();
            NewSurface.TiltDecenterOrder = {'Dx','Dy','Dz','Tx','Ty','Tz'};
            NewSurface.Tilt = [0 0 0];
            NewSurface.Decenter = [0 0];
            NewSurface.TiltMode = 'DAR';
            % TM = transformation Matrix
            NewSurface.SurfaceCoordinateTM = ...
                [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
            NewSurface.ReferenceCoordinateTM = ...
                [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
           NewSurface.GlassBefore  = Glass();
            
            NewSurface.SurfaceColor = '';
            NewSurface.Hidden = 0;
            NewSurface.Ignored = 0;
            NewSurface.ClassName = 'Surface';
        end
    end
    methods(Static)
        function supportedTiltModes = SupportedTiltModes()
            supportedTiltModes = {'DAR' 'NAX' 'BEN'};
        end
        function newObj = InputGUI()
            newObj = ObjectInputDialog(MyHandle(Surface()));
        end
    end
end

