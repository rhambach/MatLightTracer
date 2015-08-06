function [rayPosition,rayDirection] = computeChiefRayParametersFromFieldIndex(opticalSystem,fieldIndex)
%COMPUTECRAYPARAMETERSFROMFIELDINDEX Returns the initial ray
%direction and positions given the field index
%For objects at inifinity the first thickness is taken to be zero for
%position computation

% % Pupil Normalization is Radial
% pupilNormFactor = opticalSystem.getEntrancePupilDiameter/2;
% pupilZ = opticalSystem.getEntrancePupilLocation;
% pupilX = Px * pupilNormFactor;
% pupilY = Py * pupilNormFactor;
% Field normalization can be either radial or
% rectangular

objZ = -opticalSystem.SurfaceArray(1).Thickness;
fieldMatrix = opticalSystem.FieldPointMatrix;
fieldType = opticalSystem.FieldType;

objFieldX = fieldMatrix(fieldIndex,1);
objFieldY = fieldMatrix(fieldIndex,2);
% pupilPointPosition = [pupilX,pupilY,pupilZ]';
switch lower(fieldType)
    case lower('ObjectHeight')
        % The given obj field values are ray positions
        rayPosition = [objFieldX,objFieldY,objZ]';
        rayDirection = (pupilPointPosition - rayPosition)/(norm(pupilPointPosition - rayPosition));
    case lower('Angle')
        % The given obj field values are ray directions
        
        % The angle given indicates the direction of the cheif ray
        % Feild points are given by angles
        angX = objFieldX*pi/180;
        angY = objFieldY*pi/180;
        
        %convert field angle to ray direction as in Zemax
        dz = sqrt(1./((tan (angX)).^2+(tan (angY)).^2+1));
        dx = dz.*tan (angX);
        dy = dz.*tan (angY);
        cheifRayDirection = [dx;dy;dz];
        % Field point to the center of entrance pupil
        pupilZLocation = (opticalSystem.getEntrancePupilLocation);
        if abs(opticalSystem.SurfaceArray(1).Thickness) > 10^10 % object at infinity
            objThick = 0;
        else
            objThick  = opticalSystem.SurfaceArray(1).Thickness;
        end
        
        radFieldToEnP = (objThick + pupilZLocation)./cheifRayDirection(3,:);
        % Initial position of cheif ray
        cheifRayPosition = ...
            [-radFieldToEnP.*cheifRayDirection(1,:);...
            -radFieldToEnP.*cheifRayDirection(2,:);...
            -objThick];
        
        if abs(opticalSystem.SurfaceArray(1).Thickness) > 10^10
            % collimated ray
            rayDirection = cheifRayDirection;
            % mariginal ray is just shifted ray of the cheif ray.
            rayPosition(1:2,:) = cheifRayPosition(1:2,:) + pupilPointPosition(1:2,:);
            rayPosition(3,:) = -objThick;
        else
            % Initial position of cheif ray = that of mariginal ray
            rayPosition = cheifRayPosition;
            % Now compute the direction of the mariginal rays
            rayDirection = pupilSamplingPoint - rayPosition;
            rayDirection = rayDirection./repmat(sqrt(sum(rayDirection.^2)),[3,1]);
        end
end

end

