function [ mariginalRay ] = getMariginalRay(optSystem,fieldPointXYInSI,wavLenInM,angleFromYinRad)
    % getMariginalRay Returns the Mariginal ray (as Ray object)  which starts
    % from a field point  and passes throgh the edge of the entrance pupil at
    % point which makes the given angle from the y axis.
    
    % angleFromY: determines the angle of the point in the rim of the pupul
    % from the y axis so that it will be possible to compute Mariginal rays in any
    % planet(tangential or sagital)
    % fieldPointXYInSI,wavLenInM are measured in SI unit (meter and degree for angles)
    
    
    pupilRadius = (getEntrancePupilDiameter(optSystem))/2;
    pupilZLocation = (getEntrancePupilLocation(optSystem));
    
    if nargin == 0
        disp('Error: The function getMariginalRay needs atleast the optical system object.');
        mariginalRay = NaN;
        return;
    elseif nargin == 1
        % Use the on axis point for field point and primary wavelength as
        % default
        fieldPointXYInSI = [0,0]';
        wavLenInM = getPrimaryWavelength(optSystem);
        angleFromYinRad = 0;
    elseif nargin == 2
        % Use the  primary wavelength as default
        wavLenInM = getPrimaryWavelength(optSystem);
        angleFromYinRad = 0;
    elseif nargin == 3
        angleFromYinRad = 0;
    else
    end
    
    nField = size(fieldPointXYInSI,2);
    nWav  = size(wavLenInM,2);
    if abs(optSystem.getSurfaceArray(1).Thickness) > 10^10 % object at infinity
        objThick = 0;
    else
        objThick  = optSystem.getSurfaceArray(1).Thickness;
    end
    
    pupilSamplingPoint = [pupilRadius*sin(angleFromYinRad);pupilRadius*cos(angleFromYinRad);pupilZLocation];
    
    switch lower(optSystem.FieldType)
        case lower('ObjectHeight')
            fieldPointXYInLensUnit = fieldPointXYInSI/optSystem.getLensUnitFactor;
            % Global reference is the 1st surface of the lens
            fieldPoint = [fieldPointXYInLensUnit; repmat(-objThick,[1,nField])];
            if abs(optSystem.getSurfaceArray(1).Thickness) > 10^10
                % Invalid specification
                disp('Error: Object Height can not be used for objects at infinity');
                return;
            else
                initialDirection = repmat(pupilSamplingPoint,[1,nField]) - fieldPoint;
                initialDirection = initialDirection./repmat(sqrt(sum(initialDirection.^2)),[3,1]);
                initialPosition = fieldPoint;
            end
        case lower('Angle')
            fieldPoint = fieldPointXYInSI;
            % The angle given indicates the direction of the cheif ray
            % Feild points are given by angles
            angX = fieldPoint(1,:)*pi/180;
            angY = fieldPoint(2,:)*pi/180;
            
            %convert field angle to ray direction as in Zemax
            dz = sqrt(1./((tan (angX)).^2+(tan (angY)).^2+1));
            dx = dz.*tan (angX);
            dy = dz.*tan (angY);
            cheifRayDirection = [dx;dy;dz];
            % Field point to the center of entrance pupil
            radFieldToEnP = (objThick + pupilZLocation)./cheifRayDirection(3,:);
            % Initial position of cheif ray
            cheifRayPosition = ...
                [-radFieldToEnP.*cheifRayDirection(1,:);...
                -radFieldToEnP.*cheifRayDirection(2,:);...
                repmat(-objThick,[1,nField])];
            
            if abs(optSystem.getSurfaceArray(1).Thickness) > 10^10
                % collimated ray
                initialDirection = cheifRayDirection;
                % mariginal ray is just shifted ray of the cheif ray.
                initialPosition(1:2,:) = cheifRayPosition(1:2,:) + repmat(pupilSamplingPoint(1:2,:),[1,nField]);
                initialPosition(3,:) = repmat(-objThick,[1,nField]);
            else
                % Initial position of cheif ray = that of mariginal ray
                initialPosition = cheifRayPosition;
                % Now compute the direction of the mariginal rays
                initialDirection = repmat(pupilSamplingPoint,[1,nField]) - initialPosition;
                initialDirection = initialDirection./repmat(sqrt(sum(initialDirection.^2)),[3,1]);
            end
    end
    initialPositionInM = initialPosition*getLensUnitFactor(optSystem);
    mariginalRay = ScalarRay(initialPositionInM,initialDirection,wavLenInM);
end

