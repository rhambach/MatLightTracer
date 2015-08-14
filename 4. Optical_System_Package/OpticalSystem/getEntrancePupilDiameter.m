function [EntrancePupilDiameter,EntrancePupilPupilLocation] = getEntrancePupilDiameter(optSystem,wavLen)
    % getEntrancePupilDiameter: returns EP diameter
    
    if nargin < 2
        wavLen = getPrimaryWavelength(optSystem);
    end

    EntrancePupilPupilLocation = getEntrancePupilLocation(optSystem);
    currentSurf = getSurfaceArray(optSystem,1);
    objectRefractiveIndex = getRefractiveIndex(currentSurf.Glass,wavLen);
    if abs(currentSurf.Thickness)>10^10
        objThick = 10^10;
    else
        objThick  = currentSurf.Thickness;
    end
    EntrancePupilDiameter = computeEntrancePupilDiameter...
        (optSystem,EntrancePupilPupilLocation, ...
        objectRefractiveIndex,objThick);
end