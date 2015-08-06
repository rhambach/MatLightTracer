  function paraxMag = getParaxialMagnification(OS)
    % getParaxialMagnification: returns paraxial magnification of
    % the system. Ratio of image height to object height for full field. It
    % is Zero for infinit conjugate system.
    global INF_OBJ_Z;
    givenStopIndex = OS.getStopIndex;


    refIndex = zeros(1,OS.NumberOfSurface);
    thick = zeros(1,OS.NumberOfSurface);
    curv = zeros(1,OS.NumberOfSurface);

     for kk=1:1:OS.NumberOfSurface
        refIndex(kk) = OS.SurfaceArray(kk).Glass...
            .getRefractiveIndex(OS.PrimaryWavelengthIndex);
        thick(kk) = OS.SurfaceArray(kk).Thickness;
        curv(kk) = 1/(OS.SurfaceArray(kk).Radius);                      
     end  
   if abs(thick(1))>10^10 % use INF_OBJ_Z=5 for infinity objects
      thick(1)=INF_OBJ_Z;
   end
   paraxMag = computeParaxialTransverseMagnification(refIndex,thick,curv);         
end