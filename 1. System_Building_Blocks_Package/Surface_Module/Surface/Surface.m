function NewSurface = Surface(surfType)
    % Surface Struct:
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
    
    if nargin == 0
        % Make single surface component by default
        surfType = 'Standard';
    end
    NewSurface.ObjectSurface = 0;
    NewSurface.ImageSurface = 0;
    NewSurface.Stop = 0;
    NewSurface.Comment = '';
    NewSurface.Type = surfType;
    NewSurface.Thickness = 10;
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