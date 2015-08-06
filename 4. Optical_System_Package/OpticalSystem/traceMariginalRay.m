function [ mariginalRayTraceResult,mariginalRay ] = traceMariginalRay( optSystem,fieldPointXYInSI,wavLenInM,angleFromYinRad,considerSurfAperture,recordIntermediateResult )
%TRACEMARIGINALRAY Computes the mariginal ray and traces it theough the
% given system
% fieldPointXYInSI,wavLenInM are measured in SI unit (meter and degree for angles)
% system.
if nargin == 0
    disp('Error: The function getMariginalRay needs atleast the optical system object.');
    mariginalRayTraceResult = NaN;
    mariginalRay = NaN;
    return;
elseif nargin == 1
    % Use the on axis point for field point and primary wavelength as
    % default
    fieldPointXYInSI = [0,0]';
    wavLenInM = getPrimaryWavelength(optSystem);  
    angleFromYinRad = 0;
    considerSurfAperture = 1;
    recordIntermediateResult = 1;
elseif nargin == 2
    % Use the  primary wavelength as default
    wavLenInM = getPrimaryWavelength(optSystem);
    angleFromYinRad = 0;
    considerSurfAperture = 1;
    recordIntermediateResult = 1;    
elseif nargin == 3
    angleFromYinRad = 0;
    considerSurfAperture = 1;
    recordIntermediateResult = 1;    
elseif nargin == 4
    considerSurfAperture = 1;
    recordIntermediateResult = 1;
elseif nargin == 5
    recordIntermediateResult = 1;    
end
considerPolarization = 0;

mariginalRay = getMariginalRay(optSystem,fieldPointXYInSI,wavLenInM,angleFromYinRad);
mariginalRayTraceResult = rayTracer(optSystem,mariginalRay,considerPolarization,considerSurfAperture,recordIntermediateResult);

end

