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


