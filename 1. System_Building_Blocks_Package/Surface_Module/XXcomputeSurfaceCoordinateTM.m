function [ surfaceCoordinateTM ] = computeSurfaceCoordinateTM( surfaceArray,surfIndex )
    %COMPUTESURFACECOORDINATETM Summary of this function goes here
    %   Detailed explanation goes here
    
    nSurface = length(surfaceArray);
    refCoordinateTM = eye(4);
    prevThickness = surfaceArray(1).Thickness;
    if abs(prevThickness) > 10^10
        prevThickness = 0;
    end
    % if the first surface is an object surface then use the second surface
    % as gloabl reference otherwise use the first surface itself as global
    % coordinate
    
    if surfIndex == 1
        if surfaceArray(1).ObjectSurface
            surfaceCoordinateTM = eye(4);
            surfaceCoordinateTM(3,4) = -prevThickness;
        else
            surfaceCoordinateTM = eye(4);
        end
    else
        refCoordinateTM = surfaceArray(1).SurfaceCoordinateTM;
        prevThickness = surfaceArray(1).Thickness;
        for kk = 2:surfIndex
            [surfaceCoordinateTM,refCoordinateTM] = TiltAndDecenter...
                (surfaceArray(kk),refCoordinateTM,'',prevThickness);
            prevThickness = surfaceArray(kk).Thickness;
        end
    end
end

