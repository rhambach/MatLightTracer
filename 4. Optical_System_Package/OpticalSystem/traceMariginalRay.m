function [ mariginalRayTraceResult,mariginalRay ] = traceMariginalRay( optSystem,fieldPointXYInSI,wavLenInM,angleFromYinRad,rayTraceOptionStruct )
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
        rayTraceOptionStruct = RayTraceOptionStruct();
        rayTraceOptionStruct.ConsiderSurfAperture = 1;
        rayTraceOptionStruct.RecordIntermediateResult = 1;
    elseif nargin == 2
        % Use the  primary wavelength as default
        wavLenInM = getPrimaryWavelength(optSystem);
        angleFromYinRad = 0;
        rayTraceOptionStruct = RayTraceOptionStruct();
        rayTraceOptionStruct.ConsiderSurfAperture = 1;
        rayTraceOptionStruct.RecordIntermediateResult = 1;
    elseif nargin == 3
        angleFromYinRad = 0;
        rayTraceOptionStruct = RayTraceOptionStruct();
        rayTraceOptionStruct.ConsiderSurfAperture = 1;
        rayTraceOptionStruct.RecordIntermediateResult = 1;
    elseif nargin == 4
        rayTraceOptionStruct = RayTraceOptionStruct();
        rayTraceOptionStruct.ConsiderSurfAperture = 1;
        rayTraceOptionStruct.RecordIntermediateResult = 1;
    elseif nargin == 5
        
    end
    mariginalRay = getMariginalRay(optSystem,fieldPointXYInSI,wavLenInM,angleFromYinRad);
    mariginalRayTraceResult = rayTracer(optSystem,mariginalRay,rayTraceOptionStruct);
    
end

