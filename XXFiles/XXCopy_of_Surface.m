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

    
    
    % SURFACE Class
    %   Defines each surface of the optical system
    % Properties
    %         % standard data
    %         ObjectSurface % 1 object surface 0 else
    %         ImageSurface % 1 image surface 0 else
    %         Stop % 1 stop surface 0 else
    %         Comment %name or notes on the surface
    %         Type % Standard,Dummy
    %         Thickness % thickness directly after the surface to the next surface
    %         Glass % type of the glass that follows after the current surface to the next surface
    %         Position % Position of surfaces in Global coordinate
    %         OtherStandardData % Struct for Surface data unique to specific surface type
    %         % For STANDARD surface it has fields
    %         % {'Radius','Conic','GratingDensity','DiffractionOrder'}
    %         %aperture data
    %         ApertureType % {'None' 'Floating' 'Circular' 'Rectangular' 'Elliptical'}
    %         ApertureParameter %[param1:x half width, param2:y half width, param:x decenter, param4:y decenter]
    %         ClearAperture % Fraction of the aperture clear for ray passage
    %         AdditionalEdge % Fraction of aperture to be added as Edge in layout diagrams
    %         AbsoluteAperture %  = 1 the aperture is drawn exaclty as given, but if 0
    %         % the aperture will change depending on the aperture of other
    %         % surface in the singlet.
    %         %coating data
    %         Coating % acoating object
    %         CoatingType % {'None' 'Jones Matrix' 'Multilayer Coating'}
    %         CoatingParameter % jones matrix of the coating
    %         % tilt decenter data
    %         TiltDecenterOrder % 12 character String showing the order in which
    %         % tilt and decenter operations are done.
    %         TiltParameter % [Tilt X, Tilt Y, Tilt Z]
    %         DecenterParameter % [Decenter X,Decenter Y]
    %         TiltMode % coordinate system for subsequent surfaces
    %         % DAR Decenter and return, NAX  New axis.BEN Bend surface
    %         % CoordinateTM = Coordinate transform matrix is a 4x4 matrix
    %         % with both global vertex vector and coordinate rotation
    %         % matrix which can be used to perform Global to Local coordinate
    %         % transformation for the surface and the optical components after the
    %         % surface
    %         SurfaceCoordinateTM % surface loacal coordinate
    %         ReferenceCoordinateTM % reference coordinate after the surface
    %         % (starts at surface vertex)
    %         ExtraData % List of extra data for the surface
    %         % GlassBefore shall be added to hold for glass data before the surface
    %         GlassBefore
    %         % Others not yet used
    %         SurfaceColor %Color of the surface drawing [R G B](RGB values)
    %         Hidden % 1 hidden surface 0 else
    %         Ignored % 1 ignored surface 0 else
    % Properties
    %   No methods yet defined.
    
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
        % Standard data
        ObjectSurface % (Boolean) - 1 object surface 0 else
        ImageSurface % (Boolean) - 1 image surface 0 else
        Stop % (Boolean) - 1 stop surface 0 else
        Comment %(String) - Name or notes on the surface
        Type % (String) - The surface type. It is the same as the surface definition function name.
        
        Thickness % (Numeric) - Thickness directly after the surface to the next surface
        Glass %  (Glass) - The glass object that follows after the current surface to the next surface
        Coating % (Coating) - The coating object of current surface
        
Position %  (Numeric) - Position of surfaces in Global coordinate

         CoatingType % {'None' 'Jones Matrix' 'Multilayer Coating'}
         CoatingParameter % jones matrix of the coating
        OtherStandardData % (Structure) - Struct for Surface parameters unique to specific surface type
%         % For STANDARD surface it has fields
%         % {'Radius','Conic','GratingDensity','DiffractionOrder'}
        

%         Aperture % (Aperture) - The aperture object of current surface
        
% Aperture data
ApertureType % {'None' 'Floating' 'Circular' 'Rectangular' 'Elliptical'}
ApertureParameter %[param1:x half width, param2:y half width, param:x decenter, param4:y decenter]
ClearAperture % Fraction of the aperture clear for ray passage
AdditionalEdge % Fraction of aperture to be added as Edge in layout diagrams
AbsoluteAperture %  = 1 the aperture is drawn exaclty as given, but if 0
% the aperture will change depending on the aperture of other
        % surface in the singlet.
        
        % tilt decenter data
        TiltDecenterOrder % 12 character String showing the order in which
        % tilt and decenter operations are done.
        TiltParameter % [Tilt X, Tilt Y, Tilt Z]
        DecenterParameter % [Decenter X,Decenter Y]
        TiltMode % coordinate system for subsequent surfaces
        % DAR Decenter and return, NAX  New axis.BEN Bend surface
        % CoordinateTM = Coordinate transform matrix is a 4x4 matrix
        % with both global vertex vector and coordinate rotation
        % matrix which can be used to perform Global to Local coordinate
        % transformation for the surface and the optical components after the
        % surface
        SurfaceCoordinateTM % surface loacal coordinate
        ReferenceCoordinateTM % reference coordinate after the surface
        % (starts at surface vertex)
        ExtraData % List of extra data for the surface
        % GlassBefore shall be added to hold for glass data before the surface
        GlassBefore
        % Others not yet used
        SurfaceColor %Color of the surface drawing [R G B](RGB values)
        Hidden % 1 hidden surface 0 else
        Ignored % 1 ignored surface 0 else
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
            NewSurface.Thickness = 0;
            NewSurface.Glass = Glass();
            
            NewSurface.Position = [0 0 0];
            
            [fieldNames,fieldFormat,initialData] = NewSurface.getOtherStandardDataFields;
            NewSurface.OtherStandardData = struct;
            for ff = 1:10
                NewSurface.OtherStandardData.(fieldNames{ff}) = initialData{ff};
            end
            NewSurface.ExtraData  = [];
            
            
            NewSurface.ClearAperture = 1;
            NewSurface.AdditionalEdge = 0.1;
            NewSurface.ApertureType = 'Floating';
            NewSurface.ApertureParameter = [0 0 0 0];
            NewSurface.AdditionalEdge = 0;
            NewSurface.AbsoluteAperture = 1;
            
            NewSurface.Coating = Coating();
            NewSurface.CoatingType = 'NONE';
            NewSurface.CoatingParameter = [0 0;0 0];
            
            NewSurface.TiltDecenterOrder = 'DxDyDzTxTyTz';
            NewSurface.TiltParameter = [0 0 0];
            NewSurface.DecenterParameter = [0 0];
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
        end
    end
    methods(Static)
        function supportedTiltModes = SupportedTiltModes()
            supportedTiltModes = {'DAR' 'NAX' 'BEN'};
        end
        function supportedApertureTypes = SupportedApertureTypes()
            supportedApertureTypes = {'Floating' 'Circular' 'Rectangular' 'Elliptical'};
        end
        function newObj = InputGUI()
            newObj = ObjectInputDialog(MyHandle(Surface()));
        end
    end
end

