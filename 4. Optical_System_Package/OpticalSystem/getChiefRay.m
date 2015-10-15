function [ chiefRay ] = getChiefRay( optSystem,fieldIndices,wavelengthIndices )
    % getChiefRay returns the chief ray (as Ray object) of the optical system
    % starting from a field point and passing through origin of the entrance pupil.
    % wavelengthIndices,fieldIndices: Vectors indicating the wavelength and
    % field indices to be used
    % The fieldIndices and wavelengthIndices are just optional parameters to
    % allow computation for field points and wavelengths which are not
    % specified in the system configuration. By default, all available field
    % for field point and primary wavelength are used.
    
    % Default inputs
    if nargin < 1
        disp('Error: The function getChiefRay needs atleast the optical system object.');
        chiefRay = NaN;
    end
    if nargin < 2
        % Take all field points and primary wavelength
        fieldIndices = [1:size(optSystem.FieldPointMatrix,1)];
    end
    
    if nargin < 3
        % Primary wavelength
        wavelengthIndices = optSystem.PrimaryWavelengthIndex;
    end
    
    fieldPointMatrix = optSystem.FieldPointMatrix;
    fieldPointXY = (fieldPointMatrix(fieldIndices,1:2))';
    switch lower(getSupportedFieldTypes(optSystem.FieldType))
        case lower('ObjectHeight')
            % Change to field points to meter
            fieldPointXYInSI = fieldPointXY*getLensUnitFactor(optSystem);
        case lower('Angle')
            % Field values are in degree so Do nothing.
            fieldPointXYInSI = fieldPointXY;
    end
    wavLenInM = getSystemWavelengths(optSystem,wavelengthIndices);
    pupilRadius = (getEntrancePupilDiameter(optSystem))/2;
    pupilZLocation = (getEntrancePupilLocation(optSystem));
    
    nField = size(fieldPointXYInSI,2);
    nWav  = size(wavLenInM,2);
    
    % check if all field and wavelength is given or a single field or
    % wavelength is to be used
    if nWav == 1
        % Single wavelength is used for all fields
        wavLenInM = repmat(wavLenInM,[1,nField]);
    elseif nField == 1
        % single field is used with all waveleghts
        fieldPointXYInSI = repmat(fieldPointXYInSI,[1,nWav]);
    elseif nWav==nField
        % All field and wavelengths are given
    else
        % invalid input
        disp('Error: The value of nField and nWav should be equal if both are differnt from 1.');
        return;
    end
    firstSurface = getSurfaceArray(optSystem,1);
    if abs(firstSurface.Thickness) > 10^10 % object at infinity
        IsObjectAtInfinity = 1;
        objThick = 0;
    else
        IsObjectAtInfinity = 0;
        objThick  = firstSurface.Thickness;
    end
    
    
    pupilSamplingPoint = [0;0;pupilZLocation];
    
    switch (optSystem.FieldType)
        case 1 %('ObjectHeight')
            fieldPointXYInLensUnit = fieldPointXYInSI/getLensUnitFactor(optSystem);
            % Global reference is the 1st surface of the lens
            fieldPoint = [fieldPointXYInLensUnit; repmat(-objThick,[1,nField])];
            
            if IsObjectAtInfinity
                % Invalid specification
                disp('Error: Object Height can not be used for objects at infinity');
                return;
            else
                initialDirection = repmat(pupilSamplingPoint,[1,nField]) - fieldPoint;
                initialDirection = initialDirection./repmat(sqrt(sum(initialDirection.^2)),[3,1]);
                initialPosition = fieldPoint;
            end
        case 2 %('Angle')
            % The angle given indicates the direction of the chief ray
            fieldPoint = fieldPointXYInSI;
            
            % Feild points are given by angles
            angX = fieldPoint(1,:)*pi/180;
            angY = fieldPoint(2,:)*pi/180;
            
            %convert field angle to ray direction as in Zemax
            dz = sqrt(1./((tan (angX)).^2+(tan (angY)).^2+1));
            dx = dz.*tan (angX);
            dy = dz.*tan (angY);
            
            initialDirection = [dx;dy;dz];
            
            % Field point to the center of entrance pupil
            radFieldToEnP = (objThick + pupilZLocation)./initialDirection(3,:);
            
            initialPosition = ...
                [-radFieldToEnP.*initialDirection(1,:);...
                -radFieldToEnP.*initialDirection(2,:);...
                repmat(-objThick,[1,nField])];
    end
    
    initialPositionInM = initialPosition*getLensUnitFactor(optSystem);
    chiefRay = ScalarRayBundle(initialPositionInM,initialDirection,wavLenInM);
end

