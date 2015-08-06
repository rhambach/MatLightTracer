function [ nonDummySurfaceArray,nNonDummySurface,nonDummySurfaceIndices,...
        surfaceArray,nSurface ] = getNonDummySurfaceArray( optSystem )
    %GETNONDUMMYSURFACEARRAY Returns the surface array which are not dummy
    [nonDummySurfaceIndices,surfaceArray,nSurface ] = (getNonDummySurfaceIndices(optSystem));
    nonDummySurfaceArray = surfaceArray(nonDummySurfaceIndices);
    nNonDummySurface = length(nonDummySurfaceIndices);
end

