function [outerApertShape,outerApertureRadiusXY] = ...
        getOuterAperture( surfAperture )
    %getOuterAperture Returns the outer aperture including additional edge
    %if it is defined.
    % Inputs:
    %   ( surfAperture )
    % Outputs:
    %    [outerApertShape,maximumRadiusXY]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 19,2015   Worku, Norman G.     Original Version
    
    outerApertShape = surfAperture.OuterShape;
    
    % Now connect to the aperture defintion function and compute the
    % OuterAperture
    apertureType = surfAperture.Type;
    apertureDefinitionHandle = str2func(apertureType);
    returnFlag = 2;
    apertureParameters = surfAperture.UniqueParameters;
    [ returnDataStruct] = apertureDefinitionHandle(returnFlag,apertureParameters);
     maximumRadiusXY = returnDataStruct.MaximumRadiusXY;
      
    % If both outer and inner apertures are similar then the maximumRadiusXY
    % can be taken as the the outerApertureRadiusXY otherwise it will be
    % computed using the hypothenous of the two radii
    if ((strcmpi(apertureType,'CircularAperture')||...
            strcmpi(apertureType,'CircularObstruction')||...
            strcmpi(apertureType,'FloatingCircularAperture'))&&...
            (strcmpi(outerApertShape,'Circular')))||...
            ((strcmpi(apertureType,'RectangularAperture')&&...
            (strcmpi(outerApertShape,'Rectangular'))))
        outerApertureRadiusXY = maximumRadiusXY;
    elseif ((strcmpi(apertureType,'EllipticalAperture'))&&...
            (strcmpi(outerApertShape,'Circular')))
        outerApertureRadiusXY(1) = max(maximumRadiusXY);   
        outerApertureRadiusXY(2) = outerApertureRadiusXY(1);
    else
        outerApertureRadiusXY(1) = sqrt(maximumRadiusXY(1)^2+maximumRadiusXY(2)^2);
        outerApertureRadiusXY(2) = outerApertureRadiusXY(1);
    end
end

