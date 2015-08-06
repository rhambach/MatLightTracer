function [multipleRayTracerResult,pupilCoordinates,pupilGridIndices] = ...
        multipleRayTracer(optSystem,wavLen,...
        fieldPointXY,nRay,PupSamplingType,JonesVec,considerSurfAperture) %
    % Trace bundle of rays through an optical system based on the pupil 
    % sampling specified. Multiple rays can be defined with wavLen (1XnWav),
    % fieldPointXY (2XnField) and the total number of ray will be nRay*nWav*nField
    % That is all rays from each field point with each of wavelegths will be
    % traced. And the result will be 4 dimensional matrix (nSurf X nRay X nField X nWav). 

    
	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    % Jan 18,2014   Worku, Norman G.     Vectorized version
    
	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    % Deafault inputs
    if nargin < 1
        disp('Error: The function multipleRayTracer needs atleast optical system');
        return;
    elseif nargin == 1
        % Take all field points and primary wavelength   
        nField = optSystem.NumberOfFieldPoints;
        fieldPointMatrix = optSystem.FieldPointMatrix;
        fieldPointXY = (fieldPointMatrix(:,1:2))';
        wavLen = repmat(optSystem.getPrimaryWavelength,[1,nField]);

        nRay = 3;
        PupSamplingType = 1;
        JonesVec = [NaN;NaN];
        considerSurfAperture = 1;        
    elseif nargin == 2 
        % Take all field points and given wavelength   
        nField = optSystem.NumberOfFieldPoints;
        fieldPointMatrix = optSystem.FieldPointMatrix;
        fieldPointXY = (fieldPointMatrix(:,1:2))';
        wavLen = repmat(wavLen(1),[1,nField]);
        
        nRay = 3;
        PupSamplingType = 1;
        JonesVec = [NaN;NaN];
        considerSurfAperture = 1;  
    elseif nargin == 3
        nRay = 3;
        PupSamplingType = 1;
        JonesVec = [NaN;NaN];
        considerSurfAperture = 1;   
    elseif nargin == 4
        PupSamplingType = 1;
        JonesVec = [NaN;NaN];
        considerSurfAperture = 1;  
    elseif nargin == 5
        JonesVec = [NaN;NaN];
        considerSurfAperture = 1; 
    elseif nargin == 6
        considerSurfAperture = 1; 
    elseif nargin == 7
        
    end
    
    tic
    pupilRadius = (optSystem.getEntrancePupilDiameter)/2;
    pupilZLocation = (optSystem.getEntrancePupilLocation);
    PupSampling = PupSamplingType; 
    
    nSurf = optSystem.NumberOfSurfaces;
    nField = size(fieldPointXY,2);
    nWav  = size(wavLen,2);
    if abs(optSystem.SurfaceArray(1).Thickness) > 10^10 % object at infinity
        objThick = 0;
    else
        objThick  = optSystem.SurfaceArray(1).Thickness;
    end

    % Global reference is the 1st surface of the lens
    fieldPoint = [fieldPointXY; repmat(-objThick,[1,nField])];
    [ pupilSamplingPoints,pupilGridIndices ] = ...
        computePupilSamplingPoints(nRay,...
        pupilZLocation,pupilRadius,PupSampling,objThick);
    
    % Effective number of rays to be traced through
    nRay = size(pupilSamplingPoints,2);

    % Determine the direction of Cheif ray - for object height field and
    % position of Cheif ray - for field angle input
    % Compute initial ray bundle directions or positions (for afocal) for
    % each field points. The result will be 3 X (nRay*nField) matrices
    switch lower(optSystem.FieldType) 
        case lower('ObjectHeight')
            if abs(optSystem.SurfaceArray(1).Thickness) > 10^10 
                % Invalid specification
                disp('Error: Object Height can not be used for objects at infinity');
                return;
            else
                [ initialRayBundleDirections ] = computeInitialRayBundleDirections...
                (fieldPoint,pupilSamplingPoints);   
                % repeat each row in fieldPoint nRay times
                allFieldPositions = cellfun(@(x) repmat(x,[1,nRay]),...
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
            if abs(optSystem.SurfaceArray(1).Thickness) > 10^10 
                % object at infinity and 
                % The rays are collimated and the Cheif ray direction 
                % becomes the common ray direction 
                commonRayDirectionCosine = cheifRayDirection;
                [ initialRayBundlePositions ] = computeInitialRayBundlePositions(...
                    commonRayDirectionCosine,pupilSamplingPoints,pupilZLocation,objThick);

                % repeat each row in commonRayDirectionCosine nRay times
                allFieldDirectionCosine = cellfun(@(x) repmat(x,[1,nRay]),...
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
                allFieldPositions = cellfun(@(x) repmat(x,[1,nRay]),...
                    num2cell(cheifRayFieldPoint,[1]),'UniformOutput',false);
                initialRayBundlePositions = cell2mat(allFieldPositions);                 
            end            
    end
    
    if isnan(JonesVec(1))
        pol = 0;
    else
        pol = 1;
    end
    
    % Now replicate the initial ray bundle position (direction) matrices 
    % in the 2nd dimension for all wavelengths. 
    initialRayBundlePositions = repmat(initialRayBundlePositions,[1,nWav]);
    initialRayBundleDirections = repmat(initialRayBundleDirections,[1,nWav]);
    
    
    % Initialize initial ray bundle using constructor.
    pos = initialRayBundlePositions;
    dir = initialRayBundleDirections;
    wav = arrayfun(@(x) repmat(x,[1,nRay*nField]),wavLen*optSystem.getWavelengthUnitFactor,'UniformOutput',false);
    wav = [wav{:}];
    pol = pol;
    jonesVect = JonesVec;    
    % construct array of Ray objects
    initialRayBundle = Ray(pos,dir,wav,pol,jonesVect);
    
    %===============RAYTRACE For Bundle of Ray========================
    rayTraceResult = optSystem.rayTracer(initialRayBundle,considerSurfAperture); 
    
    multipleRayTracerResult = reshape(rayTraceResult,[nSurf,nRay,nField,nWav]); %(nSurf X nRay X nField X nWav)
    pupilCoordinates = pupilSamplingPoints;
    pupilGridIndices = pupilGridIndices;
    timeElapsed =  toc;
    disp(['Ray Bundle Trace Completed. Polarized  = ',num2str(pol), ...
        ', Total Number  = ', num2str(nRay), ', Time Elapsed = ', ...
        num2str(timeElapsed)]); 
end  