function [ yc uc ] = computeCheifRay(fieldHeight,entPupilPosition)
%computeCheifRay:  computes paraxial marignal ray of a system

% fieldHeight: height of field point
% entPupilPosition: the z location of enterance pupil
%   Output
% yc,uc,: cheif ray height from the optical axis, y, and its slope (tangent of angle), u
 
yc = fieldHeight;
uc = atan(fieldHeight/entPupilPosition); %assume object surface at origin of the coordinate system
end
