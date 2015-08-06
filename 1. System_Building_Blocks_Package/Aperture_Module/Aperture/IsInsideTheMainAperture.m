function [ isInsideTheMainAperture ] = IsInsideTheMainAperture( surfAperture, xyVector )
    % IsInsideTheMainAperture: Returns 1 if the xyVector is insied the main aperture and
    % 0 otherwise.
    % Inputs:
    %   ( surfAperture, xyVector )
    %       NB. xyVector is Nx2
    % Outputs:
    %    [isInsideTheMainAperture]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 19,2015   Worku, Norman G.     Original Version
    
    
    apertureType = surfAperture.Type;
    apertDecX = surfAperture.Decenter(1);
    apertDecY = surfAperture.Decenter(2);
    apertRotInDeg = surfAperture.Rotation;
    
    % First decenter and then rotate the given points
    xyVector_Decenter = [xyVector(:,1) - apertDecX , xyVector(:,2) - apertDecY];
    
    initial_r = computeNormOfMatrix( xyVector_Decenter, 2 );
    initial_angleInRad = atan(xyVector_Decenter(:,2)./(xyVector_Decenter(:,1) + eps));
    % For case of xyVector_Decenter(:,1) == 0, add small number in the
    % denominator to avoid NaN
    nanCaseIndices = abs(xyVector_Decenter(:,1)) < eps;
    initial_angleInRad(nanCaseIndices) = atan(xyVector_Decenter(nanCaseIndices,2)./(xyVector_Decenter(nanCaseIndices,1) + eps));
    
    new_angleInRad = initial_angleInRad - apertRotInDeg*pi/180;
    
    xyVector_final = [initial_r.*cos(new_angleInRad), initial_r.*sin(new_angleInRad)];
    
    %     xyVector_final = xyVector;
    % Now connect to the aperture defintion function and compute the
    % isInnsidefunction
    apertureDefinitionHandle = str2func(apertureType);
    returnFlag = 3; % isInsideTheMainAperture
    apertureParameters = surfAperture.UniqueParameters;
    [ isInsideTheMainAperture] = ...
        apertureDefinitionHandle(returnFlag,apertureParameters,xyVector_final);
end

