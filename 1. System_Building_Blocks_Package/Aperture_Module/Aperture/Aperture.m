function newAperture = Aperture(type,apertDecenter,apertRotInDeg,drawAbsolute,outerShape,additionalEdge,uniqueParameters)
    % Aperture Struct:
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
    
    if nargin < 1
        type = 'FloatingCircularAperture';
    end
    if nargin < 2
        apertDecenter = [0,0];
    end
    if nargin < 3
        apertRotInDeg = 0;
    end
    if nargin < 4
        drawAbsolute = 0;
    end
    if nargin < 5
        if strcmpi(type,'RectangularAperture')||...
                strcmpi(type,'RectangularObstruction')
            outerShape = 'Rectangular';
        else
            outerShape = 'Circular';
        end
    end
    if nargin < 6
        additionalEdge = 0.1;
    end
    if nargin < 7
        apertureDefinitionHandle = str2func(type);
        returnFlag = 1;
        [returnDataStruct] = apertureDefinitionHandle(returnFlag);
        defaultParameters = returnDataStruct.DefaultUniqueParametersStruct;
        uniqueParameters = defaultParameters;
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


