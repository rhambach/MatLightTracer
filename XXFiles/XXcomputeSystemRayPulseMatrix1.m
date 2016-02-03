function [ finalRayPulseMatrix, interfaceRayPulseMatrices,mediumRayPulseMatrices ] = computeSystemRayPulseMatrix( optSystem,startSurf,startSurfInclusive,endSurf, endSurfInclusive,pilotRay )
%COMPUTERAYPULSEMATRIX Computes the ray pulse matrix of an optical system
%or part of the optical system

% First trace pilot ray with central wavelength and then compute the matrix
% for each surface and multiply.
c =  299792458;
format longE
format compact

% Default inputs
if nargin == 0
    disp('Error: The function computeSystemRayPulseMatrix requires atleast the optical system object.');
    finalRayPulseMatrix = NaN;
    interfaceRayPulseMatrices = NaN;
    mediumRayPulseMatrices = NaN;
    return;
elseif nargin == 1
    startSurf = 1;
    startSurfInclusive = 0;
    
    endSurf = optSystem.NumberOfSurfaces;
    endSurfInclusive = 0;
    % Take the chief ray as pilot ray
    pilotRay = optSystem.getChiefRay;
elseif nargin == 2
    startSurfInclusive = 0;
    endSurf = optSystem.NumberOfSurfaces;
    endSurfInclusive = 0;
    % Take the chief ray as pilot ray
    pilotRay = optSystem.getChiefRay;    
elseif nargin == 3
    endSurf = optSystem.NumberOfSurfaces;
    endSurfInclusive = 0;
    % Take the chief ray as pilot ray
    pilotRay = optSystem.getChiefRay;   
elseif nargin == 4
    endSurfInclusive = 0;
    % Take the chief ray as pilot ray
    pilotRay = optSystem.getChiefRay; 
elseif nargin == 5
    % Take the chief ray as pilot ray
    pilotRay = optSystem.getChiefRay;     
else
    
end
% Just take the first ray if more than one rays are input
pilotRay = pilotRay(1);

% trace the pilot ray
considerSurfAperture = 1;
pilotRayTraceResult = optSystem.rayTracer(pilotRay, considerSurfAperture);

% Get the path lengths after each surface
pathLengthFromPrevSurf  = [pilotRayTraceResult.PathLength]*optSystem.getLensUnitFactor;
L = [pathLengthFromPrevSurf,0];
% Get the angle of incidence and exit rays for each surface
ang1 = [pilotRayTraceResult.IncidenceAngle];
ang2 = [pilotRayTraceResult.ExitAngle];
% Get the refractive indices, 1st and 2nd order derivatev of n with  
% respect to wavelength for medium after each surface
n = [pilotRayTraceResult.RefractiveIndex];
dndl = [pilotRayTraceResult.RefractiveIndexFirstDerivative];
d2ndl2 = [pilotRayTraceResult.RefractiveIndexSecondDerivative];

% Compute the centeral frequency 
f0 = c/pilotRay.Wavelength;
% Initialize the ray pulse matrix to identity matrix
tempK = eye(4);
nSurface = optSystem.NumberOfSurfaces;
nNonDummySurface = optSystem.NumberOfNonDummySurfaces;
NonDummySurfaceArray = optSystem.NonDummySurfaceArray;
NonDummySurfaceIndices = optSystem.NonDummySurfaceIndices;

startNonDummyIndex = find(NonDummySurfaceIndices>=startSurf);
startNonDummyIndex = startNonDummyIndex(1);
endNonDummyIndex = find(NonDummySurfaceIndices<=endSurf);
endNonDummyIndex = endNonDummyIndex(end);

for surfaceIndex = startNonDummyIndex:1:endNonDummyIndex     
%     surfType = NonDummySurfaceArray(surfaceIndex).Type;
    radius = NonDummySurfaceArray(surfaceIndex).getRadiusOfCurvature*optSystem.getLensUnitFactor;
    if strcmpi(NonDummySurfaceArray(surfaceIndex).Glass.Name,'Mirror')
        reflection = 1;
    else
        reflection = 0;
    end
        
    if (surfaceIndex == startNonDummyIndex &&  ~startSurfInclusive)||surfaceIndex == 1
        interfaceRayPulseMatrices(:,:,surfaceIndex) = eye(4);
    elseif surfaceIndex == endNonDummyIndex &&  ~endSurfInclusive
        interfaceRayPulseMatrices(:,:,surfaceIndex) = eye(4);
    else
        interfaceRayPulseMatrices(:,:,surfaceIndex) = computeInterfaceRayPulseMatrix( ...
            ang1(surfaceIndex),ang2(surfaceIndex),...
            n(surfaceIndex-1),n(surfaceIndex),...
            dndl(surfaceIndex-1),dndl(surfaceIndex),f0,reflection,radius );           
    end   
    
    if surfaceIndex == endNonDummyIndex
        mediumRayPulseMatrices(:,:,surfaceIndex) =  eye(4);
    else
        mediumRayPulseMatrices(:,:,surfaceIndex) = computeMediumRayPulseMatrix( L(surfaceIndex+1),f0,d2ndl2(surfaceIndex) );
    end

    tempK = mediumRayPulseMatrices(:,:,surfaceIndex)*interfaceRayPulseMatrices(:,:,surfaceIndex)*tempK;
    
%     
%     if surfaceIndex == 1
%         KSurf = eye(4);
%         KGlass = computeMediumRayPulseMatrix( L(1+1),f0,d2ndl2(1) );
%     else
%         if surfaceIndex == nNonDummySurface
%             KSurf = eye(4);
%         else
%             KSurf = computeInterfaceRayPulseMatrix( ...
%                 ang1(surfaceIndex),ang2(surfaceIndex),...
%                 n(surfaceIndex-1),n(surfaceIndex),...
%                 dndl(surfaceIndex-1),dndl(surfaceIndex),f0,reflection );
%         end
%         
%         if surfaceIndex == endNonDummyIndex
%             KGlass = eye(4);
%         else
%             KGlass = computeMediumRayPulseMatrix( L(surfaceIndex+1),f0,d2ndl2(surfaceIndex) );
%         end
%         
%     end
%     K = KGlass*KSurf*K;
end
finalRayPulseMatrix = tempK;

end

