function [ apexAngle,brewsterAngle,tiltX1,tiltX2 ] = compute2DBrewsterPrism( refractiveIndex)
%COMPUTE2DBREWSTERPRISM Calculates the apex angle, surface tilts abt x axis
% needed to design brewster prism for given refractive index

apexAngle = 2*atan(1/refractiveIndex)*180/pi;
brewsterAngle = atan(refractiveIndex)*180/pi;
% tiltX1 = apexAngle/2;
% tiltX2 = -apexAngle/2;
tiltX1 = brewsterAngle;
tiltX2 = brewsterAngle;

end

