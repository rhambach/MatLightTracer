function [ExitPupilLocation, ExitPupilDiameter] = getExitPupilLocationAndDiameterXX(OS)
    % getExitPupilLocationAndDiameter: returns EXP location from image surf as
    % in zemax and its diameter using the maginification.
    global INF_OBJ_Z;
    givenStopIndex = OS.getStopIndex;
    refIndex = zeros(1,OS.NumberOfSurface);
    thick = zeros(1,OS.NumberOfSurface);
    curv = zeros(1,OS.NumberOfSurface);
%     clearAperture = 
    
     for kk=1:1:OS.NumberOfSurface
        refIndex(kk) = OS.SurfaceArray(kk).Glass...
            .getRefractiveIndex(OS.PrimaryWavelengthIndex);
        thick(kk) = OS.SurfaceArray(kk).Thickness;
        curv(kk) = 1/(OS.SurfaceArray(kk).Radius);                      
     end 
    if abs(thick(1))>10^10 % use INF_OBJ_Z for infinity objects
       thick(1)=INF_OBJ_Z;
    end
    
[ExitPupilLocation, ExitPupilDiameter] = computeParaxialExitPupil...
    (givenStopIndex,refIndex,thick,curv,clearAperture);            
end