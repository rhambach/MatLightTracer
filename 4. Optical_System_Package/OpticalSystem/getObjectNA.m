function [NAO,entPupilLocation] = getObjectNA(optSystem,wavLen)
    % getObjectNA: returns object space NA of the optical system
    
    if nargin < 2
        wavLen = optSystem.getPrimaryWavelength;
    end
    systemApertureType = optSystem.SystemApertureType;
    systemApertureValue = optSystem.SystemApertureValue;
    entPupilLocation = getEntrancePupilLocation(optSystem);
    objSurf = getSurfaceArray(optSystem,1);
    objectRefractiveIndex = getRefractiveIndex(objSurf.Glass,wavLen);
    if abs(objSurf.Thickness)>10^10
        objThick = 10^10;
    else
        objThick  = objSurf.Thickness;
    end
    
    NAO = computeObjectNA...
        (systemApertureType,systemApertureValue,entPupilLocation,...
        objectRefractiveIndex,objThick);
end