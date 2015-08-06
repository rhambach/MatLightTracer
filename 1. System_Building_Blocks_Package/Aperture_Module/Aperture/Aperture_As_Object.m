classdef Aperture
    % Aperture Class:
    %
    %   Defines aperture attached to an optical surfaces. All aperture
    %   types are defined using external functions and this class makes
    %   calls to the external functions to work with the apertures.
    %
    % Properties: 7 and Methods: 3
    %
    % Example Calls:
    %
    % newAperture = Aperture()
    %   Returns a null coating which has no optical effect at all.
    %
    % newAperture = Aperture(type,apertDecenter,apertRotInDeg,...
    %            drawAbsolute,outerShape,additionalEdge,uniqueParameters)
    %   Returns a new aperture object with the given properties.
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    properties
        Type % (String) - The aperture type. It is the same as the aperture definition function name.
        Decenter % (Vector 2x1) - [Decenter X, Decenter Y]
        Rotation % (Numeric) - Rotation of the aperture about Z axis (in Degreee)
        DrawAbsolute % (Boolean) - 1: Aperture is drawn exaclty as given, 0: Aperture will change depending on the aperture of other surface in the singlet.
        OuterShape % (String) - 'Elliptical' or 'Rectangular' shape of the outer edge used for plotting
        AdditionalEdge % (Numeric) - Fraction of the maximum radius added as edge of the surface for plotting.
        UniqueParameters % (Struct) - Structure containg the parameters used for different types of apertures.
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects. 
    end
    
    methods
        function newAperture = Aperture(type,apertDecenter,apertRotInDeg,drawAbsolute,outerShape,additionalEdge,uniqueParameters)
            if nargin == 0
                type = 'FloatingCircularAperture';
                apertDecenter = [0,0];
                apertRotInDeg = 0;
                drawAbsolute = 0;
                apertureDefinitionHandle = str2func(type);
                returnFlag = 1; % isInsideTheOuterAperture
                [ ~,~,defaultParameters] = ...
                    apertureDefinitionHandle(returnFlag);
                outerShape = 'Circular';
                additionalEdge = 0.1;
                uniqueParameters = defaultParameters;
            elseif nargin == 1
                apertDecenter = [0,0];
                apertRotInDeg = 0;
                drawAbsolute = 0;
                apertureDefinitionHandle = str2func(type);
                returnFlag = 1; % isInsideTheOuterAperture
                [ ~,~,defaultParameters] = ...
                    apertureDefinitionHandle(returnFlag);
                if strcmpi(type,'RectangularAperture')||...
                        strcmpi(type,'RectangularObstruction')
                    outerShape = 'Rectangular';
                else
                    outerShape = 'Circular';
                end
                additionalEdge = 0.1;
                uniqueParameters = defaultParameters;
            elseif nargin == 2
                apertRotInDeg = 0;
                drawAbsolute = 0;
                apertureDefinitionHandle = str2func(type);
                returnFlag = 1; % isInsideTheOuterAperture
                [ ~,~,defaultParameters] = ...
                    apertureDefinitionHandle(returnFlag);
                if strcmpi(type,'RectangularAperture')||...
                        strcmpi(type,'RectangularObstruction')
                    outerShape = 'Rectangular';
                else
                    outerShape = 'Circular';
                end
                additionalEdge = 0.1;
                uniqueParameters = defaultParameters;
            elseif nargin == 3
                drawAbsolute = 0;
                apertureDefinitionHandle = str2func(type);
                returnFlag = 1; % isInsideTheOuterAperture
                [ ~,~,defaultParameters] = ...
                    apertureDefinitionHandle(returnFlag);
                if strcmpi(type,'RectangularAperture')||...
                        strcmpi(type,'RectangularObstruction')
                    outerShape = 'Rectangular';
                else
                    outerShape = 'Circular';
                end
                additionalEdge = 0.1;
                uniqueParameters = defaultParameters;
            elseif nargin == 4
                apertureDefinitionHandle = str2func(type);
                returnFlag = 1; % isInsideTheOuterAperture
                [ ~,~,defaultParameters] = ...
                    apertureDefinitionHandle(returnFlag);
                if strcmpi(type,'RectangularAperture')||...
                        strcmpi(type,'RectangularObstruction')
                    outerShape = 'Rectangular';
                else
                    outerShape = 'Circular';
                end
                additionalEdge = 0.1;
                uniqueParameters = defaultParameters;
            elseif nargin == 5
                if strcmpi(type,'RectangularAperture')||...
                        strcmpi(type,'RectangularObstruction')
                    outerShape = 'Rectangular';
                else
                    outerShape = 'Circular';
                end
                additionalEdge = 0.1;
            elseif nargin == 6
                additionalEdge = 0.1;
            else
            end
            newAperture.Type = type;
            newAperture.Decenter = apertDecenter;
            newAperture.Rotation = apertRotInDeg;
            newAperture.DrawAbsolute = drawAbsolute;
            newAperture.OuterShape = outerShape;
            newAperture.AdditionalEdge = additionalEdge;
            newAperture.UniqueParameters = uniqueParameters;
            newAperture.ClassName = 'Aperture';
        end
    end
    
end

