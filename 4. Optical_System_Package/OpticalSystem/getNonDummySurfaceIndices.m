function [ NonDummySurfaceIndices,surfaceArray,nSurface ] = getNonDummySurfaceIndices( optSystem )
%getNonDummySurfaceIndices Returns the surface array which are not dummy
[nSurface, surfaceArray ] = getNumberOfSurfaces(optSystem);
NonDummySurfaceIndices = [];
for kk = 1:nSurface
    if ~strcmpi(surfaceArray(kk).Type,'Dummy')
        NonDummySurfaceIndices = [NonDummySurfaceIndices,kk];
    end
end
end

