function [ chiefRayTraceResult,chiefRay ] = traceChiefRay( optSystem,fieldPointXYInSI,wavLenInM,rayTraceOptionStruct )
    %TRACECHIIFRAY Computes the chief ray and traces it theough the
    % given system
    % fieldPointXYInSI,wavLenInM are measured in SI unit (meter and degree for angles)
    % Deafault inputs
    if nargin < 1
        disp('Error: The function traceChiefRay needs atleast optical system');
        chiefRayTraceResult = NaN;
        chiefRay = NaN;
        return;
    elseif nargin == 1
        % Take all field points and primary wavelength
        nField = optSystem.NumberOfFieldPoints;
        fieldPointMatrix = optSystem.FieldPointMatrix;
        
        fieldPointXY = (fieldPointMatrix(:,1:2))';
        
        switch lower(optSystem.FieldType)
            case lower('ObjectHeight')
                % Change to field points to meter
                fieldPointXYInSI = fieldPointXY*getLensUnitFactor(optSystem);
            case lower('Angle')
                % Field values are in degree so Do nothing.
                fieldPointXYInSI = fieldPointXY;
        end
        primaryWavelength = getPrimaryWavelength(optSystem);
        wavLenInM = primaryWavelength*ones(1,nField);%repmat(getPrimaryWavelength(optSystem),[1,nField]);
        rayTraceOptionStruct = RayTraceOptionStruct();
    elseif nargin == 2
        % Take the primary wavelength
        nField = size(fieldPointXYInSI,2);
        primaryWavelength = getPrimaryWavelength(optSystem);
        wavLenInM = primaryWavelength*ones(1,nField);%repmat(getPrimaryWavelength(optSystem),[1,nField]);
        rayTraceOptionStruct = RayTraceOptionStruct();
    elseif nargin == 3
        rayTraceOptionStruct = RayTraceOptionStruct();
    else
        
    end
    chiefRay = getChiefRay(optSystem,fieldPointXYInSI,wavLenInM);
    endSurface = getNumberOfSurfaces(optSystem);
    nRayPupil = 1;
    nField = size(fieldPointXYInSI,2);
    nWav = length(wavLenInM);
    chiefRayTraceResult = rayTracer(optSystem,chiefRay,rayTraceOptionStruct,...
        endSurface,nRayPupil,nField,nWav);
end

