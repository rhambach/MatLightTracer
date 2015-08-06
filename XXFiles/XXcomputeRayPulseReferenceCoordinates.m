function [ refCoordinateBeforeSurf,  refCoordinateAfterSurf] = computeRayPulseReferenceCoordinates( optSystem,pilotRay  )
%COMPUTERAYPULSEREFERENCECOORDINATE Returns the ray pulse reference planes
% associated with the pilot ray before and after each surface 

% First trace pilot ray with central wavelength and then compute the coordinate
% transformation matrix describing the refernce plane using the intersection 
% point as orifgin and perpendicular to the pilot ray
c =  299792458;
format short e
 
% Default inputs
if nargin == 0
    disp('Error: The function computeRayPulseReferenceCoordinates requires atleast the optical system object.');
    refCoordinateBeforeSurf = NaN;
    refCoordinateAfterSurf = NaN;
    return;
elseif nargin == 1
    % Take the chief ray as pilot ray
    pilotRay = optSystem.getChiefRay;
end

% Just take the first ray if more than one rays are input
pilotRay = pilotRay(1);

% trace the pilot ray
considerSurfAperture = 1;
pilotRayTraceResult = optSystem.rayTracer(pilotRay, considerSurfAperture);

rayIntersectionPoint = [pilotRayTraceResult.RayIntersectionPoint];
rayIncidentRayDirection = [pilotRayTraceResult.IncidentRayDirection];
rayExitRayDirection = [pilotRayTraceResult.ExitRayDirection];

% Take the ray direction as refZ 
% refY = refZ X (1,0,0)
% refX = refY X refZ

x0 = rayIntersectionPoint(1,:);
y0 = rayIntersectionPoint(2,:);
z0 = rayIntersectionPoint(3,:);

refZBefore = rayIncidentRayDirection;
nSurf = size(refZBefore,2);
refYBefore = compute3dCross(refZBefore,repmat([1,0,0]',[1,nSurf]));
refXBefore = compute3dCross(refYBefore,refZBefore);

refCoordinateBeforeSurf = cat(1,...
    cat(2,permute(refXBefore,[3,1,2]),permute(x0,[3,1,2])),...
    cat(2,permute(refYBefore,[3,1,2]),permute(y0,[3,1,2])),...
    cat(2,permute(refZBefore,[3,1,2]),permute(z0,[3,1,2])),...
    repmat([0,0,0,1],[1,1,nSurf]));

refZAfter = rayExitRayDirection;
refYAfter = compute3dCross(refZAfter,repmat([1,0,0]',[1,size(refZAfter,2)]));
refXAfter = compute3dCross(refYAfter,refZAfter);
refCoordinateAfterSurf = cat(1,...
    cat(2,permute(refXAfter,[3,1,2]),permute(x0,[3,1,2])),...
    cat(2,permute(refYAfter,[3,1,2]),permute(y0,[3,1,2])),...
    cat(2,permute(refZAfter,[3,1,2]),permute(z0,[3,1,2])),...
    repmat([0,0,0,1],[1,1,nSurf]));

end

