function [ dy,du,dt,df ] = computeRayPulseVector(optSystem,dy0,du0,dt0,df0,endSurfIndex, endSurfInclusive,centralRay)
%COMPUTERAYPULSEVECTOR Determines the ray pulse vector at refernce plane 
% which is before/after a given surface for given  initial raypulse vector
% @ reference plane just after the Object surface
% endSurf, endSurfInclusive: Indices of the surface array where the
% the final ray pulse vector is required (index including the dummy
% surfaces)
% Inclusive => Use reference before start surface and that after the end
% surface. and vice versa
c =  299792458;

if nargin < 5
    disp('Error: The function computeRayPulseVector requires atleast the optical system object and initial ray pulse vector.');
    dy = NaN;
    du = NaN;
    dt = NaN;
    df = NaN;
    return;    
elseif nargin == 5
    % Use default values    
    endSurfIndex = optSystem.NumberOfSurfaces;
    endSurfInclusive = 0;
    % Take the chief ray as central ray
    cheifRays = optSystem.getChiefRay;
    centralRay = cheifRays(1);
elseif nargin == 6
    endSurfInclusive = 0;   
    % Take the chief ray as central ray
    cheifRays = optSystem.getChiefRay;
    centralRay = cheifRays(1);
elseif nargin == 6
    % Take the chief ray as central ray
    cheifRays = optSystem.getChiefRay;
    centralRay = cheifRays(1);
else
    
end
 
startSurface = 1;
endSurface = optSystem.NumberOfSurfaces;
nSurface = optSystem.NumberOfSurfaces;
nNonDummySurface = optSystem.NumberOfNonDummySurfaces;
NonDummySurfaceArray = optSystem.NonDummySurfaceArray;
NonDummySurfaceIndices = optSystem.NonDummySurfaceIndices;

surfIndicesAfterStartSurface = find(NonDummySurfaceIndices>=startSurface);
startNonDummyIndex = surfIndicesAfterStartSurface(1);
surfIndicesBeforeEndSurface = find(NonDummySurfaceIndices<=endSurface);
endNonDummyIndex = surfIndicesBeforeEndSurface(end);


% Compute the current ray parameter from the ray pulse vector and central ray
% Assume the ray is on the yz plane
% Check the ray is in yz plane
if centralRay.Direction(1)~= 0
    disp('Error: Centeral ray shall be in the yz plane.');
    dy = NaN;
    du = NaN;
    dt = NaN;
    df = NaN;    
    return;
end
% objThickness = optSystem.NonDummySurfaceArray(1).Thickness;
% if objThickness > 10^10
%     objThickness = 0;
% end


u0Central = acos(centralRay.Direction(3));
t0Central = 0;
f0Central = c/centralRay.Wavelength;
y0Centeral = centralRay.Position(2);
z0Central = centralRay.Position(3);

u0Current = u0Central + du0;
t0Current = t0Central + dt0;
f0Current = f0Central + df0;
y0Current = y0Central+dy0*cos(u0Current);
z0Current = z0Central-(dy0*sin(u0Current));

pos = [0,y0Current,z0Current];
dir = [0,sin(u0Current),cos(u0Current)];
wav = c/f0Current;

currentRay = Ray(pos,dir,wav); 

% Additional path due to initial delay time
% initial group index
groupIndex =  1; % Assume air medium
initialPath = t0Current*c/groupIndex;

% trace the current and centeral ray
considerSurfAperture = 1;
recordIntermediateResults = 0;
currentRayTraceResult = optSystem.rayTracer(currentRay, considerSurfAperture,recordIntermediateResults);
centeralRayTraceResult = optSystem.rayTracer(centralRay, considerSurfAperture,recordIntermediateResults);

% Determine the intersection points in the final refernce plane
planePoint = centeralRayTraceResult(:,end).Position;
planeNormalVector = centeralRayTraceResult(:,end).Direction;

centerRayPoint = centeralRayTraceResult(:,end).Position;
centerRayDirection = centeralRayTraceResult(:,end).Direction;

currentRayPoint = currentRayTraceResult(:,end).Position;
currentRayDirection = currentRayTraceResult(:,end).Direction;

centerRayIntersection = computeLinePlaneIntersection(centerRayPoint,centerRayDirection,planePoint,planeNormalVector);
currentRayIntersection = computeLinePlaneIntersection(currentRayPoint,currentRayDirection,planePoint,planeNormalVector);

% Compute the final ray pulse vector parameters
u1Central = acos(centerRayDirection(3));
t1Central = 0;
f1Central = c/centralRay.Wavelength;
y1Centeral = centerRayIntersection(2);
z1Central = centerRayIntersection(3);

u1Current = acos(currentRayDirection(3));
t1Current = t0Central + dt0;
f1Current = c/currentRay.Wavelength;
y1Current = currentRayIntersection(2);
z1Current = currentRayIntersection(3);



% % Determine the final reference plane
% [ refCoordinateBeforeSurf,  refCoordinateAfterSurf] = computeRayPulseReferenceCoordinates( optSystem,centralRay );
% 
% if endSurfInclusive
%    finalRefernceCoordinate =  refCoordinateAfterSurf(:,:,endNonDummyIndex); 
%    % get two points of intersection for nonDummyEndSurfIndex and
%    % nonDummyEndSurfIndex+1
%    point1 = currentRayTraceResult(endNonDummyIndex,:).RayIntersectionPoint;
%    point2 = currentRayTraceResult(endNonDummyIndex+1,:).RayIntersectionPoint;
% else
%    finalRefernceCoordinate =  refCoordinateBeforeSurf(:,:,endNonDummyIndex);
%    % get two points of intersection for nonDummyEndSurfIndex-1 and nonDummyEndSurfIndex
%    point1 = currentRayTraceResult(endNonDummyIndex-1,:).RayIntersectionPoint;
%    point2 = currentRayTraceResult(endNonDummyIndex,:).RayIntersectionPoint;   
% end
% 
% % Compute intersection of the current ray with the final referce plane (the
% % xy plane from the reference coordinate) localPosition,surfaceCoordinateTM
% linePoint1 = point1;
% linePoint2 = point2;
% planePoint1 = localToGlobalPosition([0;0;0],finalRefernceCoordinate);
% planePoint2 = localToGlobalPosition([1;0;0],finalRefernceCoordinate);
% planePoint3 = localToGlobalPosition([0;1;0],finalRefernceCoordinate);
% linePlaneIntersection = computeLinePlaneIntersection(linePoint1,linePoint2,planePoint1,planePoint2,planePoint3);

% % Compute the final ray pulse vector parameters
% Y1Centeral = finalRefernceCoordinate(2,4);
% U1Central = centralRay.Direction(3);
% T1Central = 0;
% F1Central = c/centralRay.Wavelength;
% 
% Y1Current = Y0Centeral + dy0;
% U1Current = U0Central + du0;
% T1Current = T0Central + dt0;
% F1Current = F0Central + df0;


end

