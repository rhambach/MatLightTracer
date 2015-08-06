function [ rayPulseMatrix ] = computeSystemRayPulseMatrix( optSystem, pilotRay )
%COMPUTERAYPULSEMATRIX Computes the ray pulse matrix of an optical system
% First trace pilot ray with central wavelength and then compute the matrix
% for each surface and multiply.
c =  299792458;
format short e
 
% Default inputs
if nargin == 0
    disp('Error: The function computeSystemRayPulseMatrix requires atleast the optical system object.');
    rayPulseMatrix = NaN;
    return;
elseif nargin == 1
    % Take the cheif ray as pilot ray
    pilotRay = optSystem.getCheifRay;
else
    
end
% Just take the first ray if more than one rays are input
pilotRay = pilotRay(1);

% trace the pilot ray
considerSurfAperture = 1;
pilotRayTraceResult = optSystem.rayTracer(pilotRay, considerSurfAperture);

% Get the path lengths after each surface
pathLengthFromPrevSurf  = [pilotRayTraceResult.PathLength]*optSystem.getLensUnitFactor;
L = pathLengthFromPrevSurf;
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
K = eye(4);
nSurface = optSystem.NumberOfSurfaces;
nNonDummySurface = optSystem.NumberOfNonDummySurfaces;
NonDummySurfaceArray = optSystem.NonDummySurfaceArray;

for surfaceIndex = 1:1:nNonDummySurface-1
    surfType = NonDummySurfaceArray(surfaceIndex).Type;
    if strcmpi(NonDummySurfaceArray(surfaceIndex).Glass.Name,'Mirror')
        reflection = 1;
    else
        reflection = 0;
    end
    if surfaceIndex == 1
        KSurf = eye(4);
        KGlass = computeMediumRayPulseMatrix( L(1+1),f0,d2ndl2(1) );
    else
        KSurf = computeInterfaceRayPulseMatrix( ...
            ang1(surfaceIndex),ang2(surfaceIndex),...
            n(surfaceIndex-1),n(surfaceIndex),...
            dndl(surfaceIndex-1),dndl(surfaceIndex),f0,reflection );
        KGlass = computeMediumRayPulseMatrix( L(surfaceIndex+1),f0,d2ndl2(surfaceIndex) );        
    end
    K = KGlass*KSurf*K;
end
rayPulseMatrix = K;

end

