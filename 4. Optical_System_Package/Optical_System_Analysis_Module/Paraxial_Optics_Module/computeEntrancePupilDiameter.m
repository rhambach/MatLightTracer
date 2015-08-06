function entPupilDiameter = computeEntrancePupilDiameter...
        (systemApertureType,systemApertureValue,entPupilLocation, objectRefractiveIndex,objThick)
    % computeObjectNA: compute the paraxial object space NA
    % Inputs
    %   systemApertureType: 'ENPD' given enterenace pupil, OBNA given object NA,
    %   ...
    %   systemApertureValue: value of aperture specified
    %   entPupilLocation: location of enterenace pupil from first surface
    %   objectRefractiveIndex: object side refractive index
    %   objThick: thickness from object surface to 1st surface
    
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
    
    systApertureList = {'ENPD','OBNA','OBFN','IMNA','IMFN'};
    if isnumeric(systemApertureType)
        systemApertureType = systApertureList{systemApertureType};
    end
    switch upper(systemApertureType)
        case 'ENPD' % given 'Enterance Pupil Diameter entPupilLocation, objectRefractiveIndex,objThick
            entPupilDiameter  = systemApertureValue;
        case 'OBNA' % given 'Object Space NA'
            U0 = asin(systemApertureValue/objectRefractiveIndex);
            entPupilDiameter = abs(2*tan(U0)* (entPupilLocation + objThick));
        case 'OBFN' % given 'Object Space F#'
            
        case 'IMNA' % given 'Image Space NA'
            
        case 'IMFN' % given 'Image Space F#'
            
        otherwise
            
    end
    
    
