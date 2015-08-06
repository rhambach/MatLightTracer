function [ output_args ] = transform2DRayDataTo3DCoordinate(  ...
    baseRayDirection,baseRayPoint,localRayPosition,localRayDirection, )
%TRANSFORM2DRAYDATATO3DCOORDINATE COnverts the 2d ray data in local
% coordinate formed by the base ray and plane perpendicular to base ray  to
% 3d coordinate
%  baseRayDirection,baseRayPoint,secondaryRayDirection,secondaryRayPoint:
%  direction cosines and points on the base and secondary ray (3x1 vector)
%  refrencePoint: point through which the plane perpendicular to the base
%  ray passes

end

[ localRayPosition,localRayDirection ] = transform3DRayDataTo2DCoordinate( ...
    baseRayDirection,baseRayPoint,secondaryRayDirection,secondaryRayPoint, refrencePoint,localXDirection,localYDirection)
%TRANSFORM3DRAYDATATO2DCOORDINATE COnverts the 3d ray data to 2d local
%coordinate formed by the base ray and plane perpendicular to base ray
%  baseRayDirection,baseRayPoint,secondaryRayDirection,secondaryRayPoint:
%  direction cosines and points on the base and secondary ray (3x1 vector)
%  refrencePoint: point through which the plane perpendicular to the base
%  ray passes
