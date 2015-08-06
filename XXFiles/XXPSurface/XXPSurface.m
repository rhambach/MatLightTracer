classdef PSurface 
    % SURFACE Class
    %   Defines each surface of the optical system
    % Properties
    %     %standard data
    %     ObjectSurface % 1 object surface 0 else
    %     ImageSurface % 1 image surface 0 else
    %     Stop % 1 stop surface 0 else
    %     Comment %name or notes on the surface
    %     Type % Standard, Even Aspherical,Odd Aspherical,Dummy, IdealLens, UserDefined %Plane,Plane+Grating, Spherical, Conic Aspherical,  
    %     Radius % radius of curviture 
    %     Thickness % thickness directly after the surface to the next surface
    %     Glass % type of the glass that follows after the current surface to the next surface
    %     DeviationMode % -1 reflective or 1 refractive surface
    %     SemiDiameter % semidiameter of the surface
    %     Position % Position of surfaces in Global coordinate
    % 
    %     %aperture data
    %     ApertureType % {'None','Floating' 'Circular' 'Rectangular' 'Elliptical'}
    %     ApertureParameter %[param1:x half width, param2:y half width, param:x decenter, param4:y decenter]
    %     ClearAperture % Fraction of the aperture clear for ray passage
    %
    %     %coating data
    %     Coating % acoating object
    % 
    %     CoatingType % {'None' 'Jones Matrix' 'Multilayer Coating'}
    %     CoatingParameter % jones matrix of the coating
    % 
    %     %aspheric data
    %     ConicConstant % conic constant defining the surface
    %     PloynomialCoefficients % array of A1 to A12
    %       
    %     % Grating Data
    %     GratingLineDensity  % lines per micro meter (grating lines parallel to x
    %     axis)
    %     DiffractionOrder % the diffraction order to use
    %
    %     % tilt decenter data
    %     TiltDecenterOrder % 12 character String showing the order in which  
    %                       % tilt and decenter operations are done.   
    %     TiltParameter % [Tilt X, Tilt Y, Tilt Z]
    %     DecenterParameter % [Decenter X,Decenter Y]
    %     TiltMode % coordinate system for subsequent surfaces 
    %              % DAR Decenter and return, NAX New axis.BEN Bend surface
    % 
    %      % CoordinateTM = Coordinate transform matrix is a 4x4 matrix 
    %      % with both global vertex vector and coordinate rotation 
    %      % matrix which can be used to perform Global to Local coordinate 
    %      % transformation for the surface and the optical components after the
    %      % surface
    %     SurfaceCoordinateTM % surface loacal coordinate
    %     ReferenceCoordinateTM % reference coordinate after the surface 
    %                           % (starts at surface vertex)
    % 
    %     % User Defined Surface Data
    %      UserDefinedSurface % File name of the user defined surface which
    %      is a matlab file where all functions neccerssary for UserDefined
    %      surface are placed
    %     % Others not yet used
    %     SurfaceColor %Color of the surface drawing [R G B](RGB values)
    %     Hidden % 1 hidden surface 0 else
    %     Ignored % 1 ignored surface 0 else
    % 
    %     % Are already changed so check for all occurances in the codes
    %     Size % radius of circular or sides of rectangular surface. But now repplaced by Aperture Parameter
    %     SuccessiveRotationAngles % successive rotation angles to get the local coordinate of the surface. But now replaced with Tilt 
    %     % Coating %type of coating of the surface 0 single interface. But now replaced with coating type and coating parameter        
    %     RefractiveIndex % refractive index of the glass that follows after the current surface to the next surface        

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
        %standard data
        ObjectSurface % 1 object surface 0 else
        ImageSurface % 1 image surface 0 else
        Stop % 1 stop surface 0 else
        Comment %name or notes on the surface
        Type % Standard,Even Aspherical,Odd Aspherical,Dummy, IdealLens,UserDefined % Plane, Spherical,Conic Aspherical, 
        Radius % radius of curviture 
        Thickness % thickness directly after the surface to the next surface
        Glass % type of the glass that follows after the current surface to the next surface
%         DeviationMode % -1 reflective or 1 refractive surface
%         SemiDiameter % semidiameter of the surface
        Position % Position of surfaces in Global coordinate
        
        %aperture data
        ApertureType % {'None' 'Floating' 'Circular' 'Rectangular' 'Elliptical'}
        ApertureParameter %[param1:x half width, param2:y half width, param:x decenter, param4:y decenter]
        ClearAperture % Fraction of the aperture clear for ray passage
        
        %coating data
        Coating % acoating object
        
        CoatingType % {'None' 'Jones Matrix' 'Multilayer Coating'}
        CoatingParameter % jones matrix of the coating
        
        %aspheric data
        ConicConstant % conic constant defining the surface
        PloynomialCoefficients % array of A1 to A12
        
        % Grating Data
        GratingLineDensity  % lines per micro meter (grating lines parallel to x axis
        DiffractionOrder % the diffraction order to use   
        
        % tilt decenter data
        TiltDecenterOrder % 12 character String showing the order in which  
                          % tilt and decenter operations are done.   
        TiltParameter % [Tilt X, Tilt Y, Tilt Z]
        DecenterParameter % [Decenter X,Decenter Y]
        TiltMode % coordinate system for subsequent surfaces 
                 % DAR Decenter and return, NAX New axis.BEN Bend surface
         
         % CoordinateTM = Coordinate transform matrix is a 4x4 matrix 
         % with both global vertex vector and coordinate rotation 
         % matrix which can be used to perform Global to Local coordinate 
         % transformation for the surface and the optical components after the
         % surface
        SurfaceCoordinateTM % surface loacal coordinate
        ReferenceCoordinateTM % reference coordinate after the surface 
                              % (starts at surface vertex)

        % Programmable Surface Data
        % We need the programmbale surface definition file which is common 
        % for all suraces of certain type and programmable surface data for current surface
        % Cell array of values for programmble surface fields  of the current surface
        ProgrammableSurfaceData 
        ProgrammableSurfaceFile % File name of the user defined surface which
                                % is a matlab file where all functions neccerssary 
                                % for Programmable surface are placed      
                                
        % GlassBefore shall be added to hold for glass data before the surface
        GlassBefore
        
        % Others not yet used
        SurfaceColor %Color of the surface drawing [R G B](RGB values)
        Hidden % 1 hidden surface 0 else
        Ignored % 1 ignored surface 0 else
        
        % Are already changed so check for all occurances in the codes
        Size % radius of circular or sides of rectangular surface. But now repplaced by Aperture Parameter
        SuccessiveRotationAngles % successive rotation angles to get the local coordinate of the surface. But now replaced with Tilt 
        % Coating %type of coating of the surface 0 single interface. But now replaced with coating type and coating parameter        
        RefractiveIndex % refractive index of the glass that follows after the current surface to the next surface        

    end
    
    methods
        % Constructor
        function NewSurface = Surface()
            NewSurface.ObjectSurface = 0;
            NewSurface.ImageSurface = 0;
            NewSurface.Stop = 0;
            NewSurface.Comment = '';
            NewSurface.Type = 'Standard';
            NewSurface.Radius = 'Inf';
            NewSurface.Thickness = 0;
            NewSurface.Glass = Glass;
            
            NewSurface.Position = [0 0 0];
            
            NewSurface.ClearAperture = 1;
            
            NewSurface.ApertureType = 'None';
            NewSurface.ApertureParameter = [0 0 0 0];
            NewSurface.Coating = Coating;
            NewSurface.CoatingType = 'NONE';
            NewSurface.CoatingParameter = [0 0;0 0];    
            NewSurface.ConicConstant = 0;
            NewSurface.PloynomialCoefficients = ...
                [0 0 0 0 0 0 0 0 0 0 0 0];
            
            NewSurface.GratingLineDensity = 0;    
            NewSurface.DiffractionOrder = 0;
            
            NewSurface.TiltDecenterOrder = 'DxDyDzTxTyTz';   
            NewSurface.TiltParameter = [0 0 0];
            NewSurface.DecenterParameter = [0 0];
            NewSurface.TiltMode = 'DAR'; 
            % TM = transformation Matrix
            NewSurface.SurfaceCoordinateTM = ... 
                [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
            NewSurface.ReferenceCoordinateTM = ...
                [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];            
            NewSurface.SurfaceColor = '';
            NewSurface.Hidden = 0;
            NewSurface.Ignored = 0;      
            NewSurface.Size = 0; 
            NewSurface.SuccessiveRotationAngles = [0 0 0];      
            NewSurface.RefractiveIndex = 0;                         
        end
        % Signatures of functions in separate files
        [surfaceCoordinateTM,nextReferenceCoordinateTM] = TiltAndDecenter...
                (surf,refCoordinateTM,prevSurfCoordinateTM,prevThickness)
    end
    
end

