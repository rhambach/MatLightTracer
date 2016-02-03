function [ Zpoints,Ypoints ] = getMeridionalRayTracePoints(OS, y0,U0)
   % getMeridionalRayTracePoints: returns z and y intersection
   % points by tracing a given intitial ray y0,u0 using meridional
   % ray tracing
  global INF_OBJ_Z;

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
   [ Zpoints,Ypoints ] = traceMeridionalRay( y0,U0,refIndex,thick,curv);
end