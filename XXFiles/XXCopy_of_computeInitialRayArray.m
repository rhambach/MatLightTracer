function [ initialRayArray, pupilSamplingPoints,pupilMeshGrid,...
     outsidePupilIndices  ] = ...
    computeInitialRayArray( optSystem, wavLenInWavUnit,...
    fieldPointXYInLensUnit, nRay1,nRay2,PupSamplingType,polarized,JonesVec)
%computeInitialRayBundleParameters Computes the initial ray positions,
%directions, pupil meshgrid, indices  outside  pupil
    NonDummySurfaceArray =  optSystem.NonDummySurfaceArray ;
    
    if abs(NonDummySurfaceArray(1).Thickness) > 10^10 % object at infinity
        objThick = 0;
    else
        objThick  = NonDummySurfaceArray(1).Thickness;
    end
    
    pupilRadius = (getEntrancePupilDiameter(optSystem))/2;
    pupilZLocation = (getEntrancePupilLocation(optSystem));
    PupSampling = PupSamplingType; 
        
    fieldType = optSystem.FieldType;
    nField = size(fieldPointXYInLensUnit,2);
    nWav  = size(wavLenInWavUnit,2);    
    % Global reference is the 1st surface of the lens
    fieldPoint = [fieldPointXYInLensUnit; repmat(-objThick,[1,nField])];
    [ pupilSamplingPoints,pupilMeshGrid,outsidePupilIndices  ] = ...
        computePupilSamplingPoints(nRay1,nRay2,PupSampling,...
        pupilZLocation,pupilRadius,pupilRadius,'Circular');
   
    % Effective number of rays to be traced through
    nRayTotal = size(pupilSamplingPoints,2);

    % Determine the direction of Cheif ray - for object height field and
    % position of Cheif ray - for field angle input
    % Compute initial ray bundle directions or positions (for afocal) for
    % each field points. The result will be 3 X (nRay*nField) matrices
    switch lower(fieldType) 
        case lower('ObjectHeight')
            if abs(NonDummySurfaceArray(1).Thickness ) > 10^10 
                % Invalid specification
                disp('Error: Object Height can not be used for objects at infinity');
                return;
            else
                [ initialRayBundleDirections ] = computeInitialRayBundleDirections...
                (fieldPoint,pupilSamplingPoints);   
                % repeat each row in fieldPoint nRay times
                allFieldPositions = cellfun(@(x) repmat(x,[1,nRayTotal]),...
                    num2cell(fieldPoint,[1]),'UniformOutput',false);
                initialRayBundlePositions = cell2mat(allFieldPositions);                
            end
        case lower('Angle')
                % The angle given indicates the direction of the cheif ray
                % the field point is angle in degree 
                % Feild points are given by angles
                angX = fieldPoint(1,:)*pi/180;
                angY = fieldPoint(2,:)*pi/180;                

                %convert field angle to ray direction as in Zemax
                dz = sqrt(1./((tan (angX)).^2+(tan (angY)).^2+1));
                dx = dz.*tan (angX);
                dy = dz.*tan (angY); 
                
                cheifRayDirection = [dx;dy;dz];
            if abs(NonDummySurfaceArray(1).Thickness ) > 10^10 
                % object at infinity and 
                % The rays are collimated and the Cheif ray direction 
                % becomes the common ray direction 
                commonRayDirectionCosine = cheifRayDirection;
                [ initialRayBundlePositions ] = computeInitialRayBundlePositions(...
                    commonRayDirectionCosine,pupilSamplingPoints,pupilZLocation,objThick);

                % repeat each row in commonRayDirectionCosine nRay times
                allFieldDirectionCosine = cellfun(@(x) repmat(x,[1,nRayTotal]),...
                    num2cell(commonRayDirectionCosine,[1]),'UniformOutput',false);
                initialRayBundleDirections = [allFieldDirectionCosine{:}];                    
            else
                % Rays are not collimated 
                % The field position can be computed from the cheif ray
                % direction. 
                
                % Field point to the center of entrance pupil
                radFieldToEnP = (objThick + pupilZLocation)./cheifRayDirection(3,:);
                
                cheifRayFieldPoint = ...
                    [-radFieldToEnP.*cheifRayDirection(1,:);...
                    -radFieldToEnP.*cheifRayDirection(2,:);...
                    repmat(-objThick,[1,nField])];
                
                [ initialRayBundleDirections ] = computeInitialRayBundleDirections...
                (cheifRayFieldPoint,pupilSamplingPoints);   
                % repeat each row in fieldPoint nRay times
                allFieldPositions = cellfun(@(x) repmat(x,[1,nRayTotal]),...
                    num2cell(cheifRayFieldPoint,[1]),'UniformOutput',false);
                initialRayBundlePositions = cell2mat(allFieldPositions);                 
            end            
    end
   
    % Now replicate the initial ray bundle position (direction) matrices 
    % in the 2nd dimension for all wavelengths. 
    initialRayBundlePositions = repmat(initialRayBundlePositions,[1,nWav]);
    initialRayBundleDirections = repmat(initialRayBundleDirections,[1,nWav]);    

    % Initialize initial ray bundle using constructor.
    % Convert the position and wavelength from lens unit/wave unit to meter for ray object
    pos = initialRayBundlePositions*getLensUnitFactor(optSystem);
    dir = initialRayBundleDirections;
    wav = arrayfun(@(x) repmat(x,[1,nRayTotal*nField]),wavLenInWavUnit*getWavelengthUnitFactor(optSystem),'UniformOutput',false);
    wav = [wav{:}];
    jonesVect = JonesVec;    
    % construct array of Ray objects
    scalarRayBundle = ScalarRay(pos,dir,wav);
    if polarized
        initialRayArray = PolarizedRay(scalarRayBundle,jonesVect);
    else
        initialRayArray = scalarRayBundle;
    end
end

