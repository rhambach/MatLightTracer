function rayTracerResult = rayTracer(optSystem, objectRay, considerSurfAperture,...
    recordIntermediateResults,startSurface,endSurface)
% rayTracer: main function of polarized ray tracer
% The function is vectorized so it can work on multiple sets of
% inputs once at the same time. That is array of ray objects.
% Inputs
%   optSystem: data type "OpticalSystem"
%   ObjectRay: data type "Ray" or array of Ray object
%   startSurf,endSurf: Indices of start and end surface. ObjectRay is
%   assumed to be given just after the start surface and it will be traced
%   till end surface (inclusive)
% Output:
%   rayTracerResult: (array if all surface results are recorded) of "RayTraceResult" or can be
%   matrix of RayTraceResult objects if the input is array of Ray
%   object. Size : nSurface X nTotalRay

% <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%

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
% Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs
% Oct 22,2014   Worku, Norman G.     Avoid recording of intermediate surface
%                                    results if not neccessary or stated
% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Deafualt arguments
if nargin < 2
    disp(['Error: Missing Input. The function rayTracer needs '...
        ' atleast the optical system and an object ray as input argument.']);
    rayTracerResult = NaN;
    return;
elseif nargin == 2
    considerSurfAperture = 1;
    recordIntermediateResults = 1;
    startSurface = 1;
    endSurface = optSystem.NumberOfSurfaces;
elseif nargin == 3
    recordIntermediateResults = 1;
    startSurface = 1;
    endSurface = optSystem.NumberOfSurfaces;
elseif nargin == 4
    startSurface = 1;
    endSurface = optSystem.NumberOfSurfaces;
elseif nargin == 5
    endSurface = optSystem.NumberOfSurfaces;
else
    
end

% Determine the tracing method. Polarized objects need polarized ray trace
if strcmpi(class(objectRay),'PolarizedRay')
    polarized = 1;
else
    polarized = 0;
end

% Determine the start and end indeces in non dummy surface array
nSurface = optSystem.NumberOfSurfaces;
nNonDummySurface = optSystem.NumberOfNonDummySurfaces;
NonDummySurfaceArray = optSystem.NonDummySurfaceArray;
NonDummySurfaceIndices = optSystem.NonDummySurfaceIndices;

indicesAfterStartSurf = find(NonDummySurfaceIndices>=startSurface);
startNonDummyIndex = indicesAfterStartSurf(1);
indicesBeforeEndSurf = find(NonDummySurfaceIndices<=endSurface);
endNonDummyIndex = indicesBeforeEndSurf(end);

% Set info to be displayed on the command window
dispTIRStatus = 0;
dispNoIntersectionStatus = 0;
dispOutOfApertureStatus = 0;

% determine the lens units and wavelength units factors
lensUnit = optSystem.LensUnit; % 1:'(mm)',2:'(cm)',3:'(m)'
wavUnit = optSystem.WavelengthUnit; % 1:'(nm)',2:'(um)'

lensUnitFactor = (lensUnit==1)*(10^-3) + (lensUnit==2)*(10^-2) +...
    (lensUnit==3)*(1);
wavUnitFactor = (wavUnit==1)*(10^-9) + (wavUnit==2)*(10^-6);
primaryWavlenInM = getPrimaryWavelength(optSystem);

nRay = length(objectRay);
wavlenInM  = [objectRay.Wavelength]; % wavlen is in m for Ray object
wavlenInWavlenUnit = wavlenInM/wavUnitFactor;
CurrentRayDirection = [objectRay.Direction];
currentRayPositionInM = [objectRay.Position];
% Since all ray tracing is done in lens units convert the object position
% from meter to lens unit.
CurrentRayPosition = currentRayPositionInM/lensUnitFactor;
% Initialize the total phase to 0,
totalPhase = zeros([1,nRay]);

if polarized
    jonesVector = [objectRay.JonesVector];
    % normalize the given jones vector and convert to Polarization Vector
    normalizedJonesVector = normalizeJonesVector(jonesVector);
    % Shall be changed or checked
    currentRayPolarizationVector = (convertJVToPolVector(normalizedJonesVector,...
        CurrentRayDirection));
    % initialize toatl P, Q and coatingJonesMatrix matrices to unity;
    TotalPMatrix = repmat(eye(3),[1,1,nRay]);
    TotalQMatrix = repmat(eye(3),[1,1,nRay]);
    CoatingJonesMatrix = repmat(eye(2),[1,1,nRay]);
    CoatingPMatrix = repmat(eye(3),[1,1,nRay]);
    CoatingQMatrix = repmat(eye(3),[1,1,nRay]);
end


if recordIntermediateResults
    % Initialize the matrix of ray trace result object. Preallocation
    multipleRayTracerResultAll(nNonDummySurface,nRay) = RayTraceResult;
else
    multipleRayTracerResultFinal(1,nRay) = RayTraceResult;
end

% Add initial ray at the first surface to ray trace result structure
% (object)
%  All 1 D array are recorded as 3x1 vertical vector
infThickness = abs(CurrentRayPosition(3,:)) > 10^10;
CurrentRayPosition(3,infThickness) = 0;

currentSurfaceNormal = repmat([0;0;1],[1,nRay]); % assume plane object surface.

RayIntersectionPoint = CurrentRayPosition;
ExitRayPosition = CurrentRayPosition;
IncidentRayDirection = repmat([NaN;NaN;NaN],[1,nRay]); % no ray is incident to object surface
ExitRayDirection = CurrentRayDirection;

SurfaceNormal = currentSurfaceNormal; % [0,0,1]; % assume plane object surface.
IncidenceAngle = NaN([1,nRay]);
ExitAngle = computeAngleBetweenVectors...
    (currentSurfaceNormal,CurrentRayDirection);
PathLength = zeros([1,nRay]);
OpticalPathLength = zeros([1,nRay]);

GroupPathLength = zeros([1,nRay]);
TotalPathLength = zeros([1,nRay]);
TotalOpticalPathLength = zeros([1,nRay]);
TotalGroupPathLength = zeros([1,nRay]);

NoIntersectionPoint = zeros([1,nRay]);
OutOfAperture = zeros([1,nRay]);
TotalInternalReflection = zeros([1,nRay]);

RefractiveIndex = ones([1,nRay]);
RefractiveIndexFirstDerivative  = zeros([1,nRay]);
RefractiveIndexSecondDerivative  = zeros([1,nRay]);
GroupRefractiveIndex  = zeros([1,nRay]);

if polarized
    PolarizationVectorBeforeCoating = repmat([NaN;NaN;NaN],[1,nRay]);
    %  object surface has no coating
    PolarizationVectorAfterCoating = currentRayPolarizationVector;
    
    TotalPMatrix = TotalPMatrix;
    TotalQMatrix = TotalQMatrix;
    
    CoatingJonesMatrix = CoatingJonesMatrix;
    CoatingPMatrix = CoatingPMatrix;
    CoatingQMatrix = CoatingQMatrix;
    if     recordIntermediateResults
        multipleRayTracerResultAll(startNonDummyIndex,:) = RayTraceResult(...
            RayIntersectionPoint,ExitRayPosition,SurfaceNormal,...
            IncidentRayDirection,IncidenceAngle,ExitRayDirection,ExitAngle,...
            NoIntersectionPoint,OutOfAperture,TotalInternalReflection,PathLength,OpticalPathLength,...
            GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
            RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
            GroupRefractiveIndex,...
            PolarizationVectorBeforeCoating,PolarizationVectorAfterCoating,...
            CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix);
    else
        
    end
else
    if recordIntermediateResults
        multipleRayTracerResultAll(startNonDummyIndex,:) = RayTraceResult(...
            RayIntersectionPoint,ExitRayPosition,SurfaceNormal,...
            IncidentRayDirection,IncidenceAngle,ExitRayDirection,ExitAngle,...
            NoIntersectionPoint,OutOfAperture,TotalInternalReflection,PathLength,OpticalPathLength,...
            GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
            RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
            GroupRefractiveIndex);
    else
        
    end
end

% To keep track of mirrored coordinates (after mirror occuring odd times)
mirroredCoordinate = 0;

for surfaceIndex = startNonDummyIndex+1:1:endNonDummyIndex
    surfaceType = NonDummySurfaceArray(surfaceIndex).Type;
    
    % Transfer current ray location, direction and polarization vector
    % to local coordinates corresponding to kth surface
    globalRayExitPosition = CurrentRayPosition;
    globalRayDirection = CurrentRayDirection;
    if polarized
        globalRayPolarizationVector = currentRayPolarizationVector;
    else
        globalRayPolarizationVector = NaN;
    end
        
    %% New Code for Global to Local Coordinate transformation using Coordinate Transfer Matrix
    prevThickness = NonDummySurfaceArray(surfaceIndex-1).Thickness;
    if abs(prevThickness) > 10^10
        prevThickness = 0;
    end
    surfaceCoordinateTM = NonDummySurfaceArray(surfaceIndex).SurfaceCoordinateTM;
    [localRayExitPosition,localRayDirection,...
        localRayPolarizationVector] = globalToLocalCoordinate(globalRayExitPosition,globalRayDirection,...
        surfaceCoordinateTM,polarized,globalRayPolarizationVector);
    
    %% End of New code
    
    % from this point onwards  currentRay become localRay
    CurrentRayPosition = localRayExitPosition;
    CurrentRayDirection = localRayDirection;
    if polarized
        currentRayPolarizationVector = localRayPolarizationVector;
    end
    
    % Path length calculation
    indexBefore =  ...
        getRefractiveIndex(NonDummySurfaceArray(surfaceIndex-1).Glass,wavlenInM);
    indexAfter =   ...
        getRefractiveIndex(NonDummySurfaceArray(surfaceIndex).Glass,wavlenInM);
    groupIndexBefore =  ...
        getGroupRefractiveIndex(NonDummySurfaceArray(surfaceIndex-1).Glass,wavlenInM);
    
    rayInitialPosition = CurrentRayPosition;
    rayDirection = CurrentRayDirection;
    
    % Correction for collimated inclined rays from infinity
    % The ray positions should be shifted bit in such away that the OPL
    % will be the same for all rays initially.
    % It is already included in the computeIntialRayBundlePosition
    % function

    [ GeometricalPathLength, NoIntersectionPoint,additionalPath] = ...
        getPathLength(NonDummySurfaceArray(surfaceIndex),...
        rayInitialPosition,rayDirection,indexBefore,...
        indexAfter,wavlenInM);
    
    OpticalPathLength = indexBefore.*(GeometricalPathLength + additionalPath);    
    GroupPathLength = groupIndexBefore.*(GeometricalPathLength + additionalPath);
    
    TotalPathLength = TotalPathLength + GeometricalPathLength;
    TotalOpticalPathLength = TotalOpticalPathLength + OpticalPathLength;
    TotalGroupPathLength = TotalGroupPathLength + GroupPathLength;

    totalNoIntersection = sum(NoIntersectionPoint);
    if dispNoIntersectionStatus
        if totalNoIntersection > 0
            disp([num2str(totalNoIntersection) , ' rays do not intersect surface ',...
                num2str(surfaceIndex),'. They have no intersection point. They are',...
                ' ignored in other computations.']);
        else
            disp(['All of ',num2str(nRay),' rays intersect surface ',num2str(surfaceIndex),'.']);
        end
    end
    % compute current accumulated phase
    accumulatedPhase = computeAccumulatedPhase...
        (OpticalPathLength*lensUnitFactor,wavlenInM);
    
    % add current phase to exsisting total phase
    totalPhase = totalPhase + accumulatedPhase;
    apertureType = NonDummySurfaceArray(surfaceIndex).ApertureType;
    apertureParam = NonDummySurfaceArray(surfaceIndex).ApertureParameter;
    % Compute the clear aperture
    clearAperture = NonDummySurfaceArray(surfaceIndex).ClearAperture;
    
    clearApertureParameter = [clearAperture*apertureParam(1),...
        clearAperture*apertureParam(2),apertureParam(3),apertureParam(4)];
    
    [ localRayIntersectionPoint, localSurfaceNormal] = ...
        getIntersectionPointAndSurfaceNormal(NonDummySurfaceArray(surfaceIndex),...
        rayInitialPosition,rayDirection);
    
    OutOfAperture = zeros([1,nRay]);
    if considerSurfAperture
        % check whether the intersection point is inside the aperture
        % The region (disk) bounded by the ellipse is given by the equation:
        % (x?h)^2/rx^2+(y?k)^2/ry^2?1. In our case local coordinate => h = 0
        
        pointX = localRayIntersectionPoint(1,:);
        pointY = localRayIntersectionPoint(2,:);

        apertSizeX = apertureParam(1);
        apertSizeY = apertureParam(2);
        apertDecX = apertureParam(3);
        apertDecY = apertureParam(4);
        switch lower(apertureType)
            case lower('None')
                out = zeros([1,nRay]);
            case {lower('Floating'), lower('Circular')}
                out = ((pointX-apertDecX).^2+(pointY-apertDecY).^2) > (apertSizeX)^2;
            case lower('Elliptical')
                out = ((pointX-apertDecX).^2./(apertSizeX^2))+((pointY-apertDecY).^2./...
                    (apertSizeY^2)) > 1 ;
            case lower('Rectangular')
                out = abs(pointX-apertDecX) > apertSizeX|...
                    abs(pointY-apertDecY) > apertSizeY;
        end
        if ~isempty(find(out))
            interPoint(:,find(out)) = NaN;
            OutOfAperture(:,find(out)) = 1;
        end
    end
    
    totalOutOfAperture = sum(OutOfAperture);
    if dispOutOfApertureStatus
        if totalOutOfAperture > 0
            disp([num2str(totalOutOfAperture) , ' rays are vignated at surface ',...
                num2str(surfaceIndex),'. They intersect the surface outside the ' ,...
                'aperture area. They are ignored in other computations.']);
        else
            disp(['All of ',num2str(nRay),' rays pass through surface ',num2str(surfaceIndex),'.']);
        end
    end
    % compute the exit ray position depending on surface type. For most
    % surfaces it is the same but for Kostenbauder matrix it may differ
    if strcmpi(surfaceType,'Kostenbauder')
        [localExitRayPosition] = getExitRayPosition( NonDummySurfaceArray(surfaceIndex),...
                rayDirection,indexBefore,indexAfter,wavlenInM, localSurfaceNormal,localRayIntersectionPoint,primaryWavlenInM );
            CurrentRayDirection = localExitRayDirection;        
    else
        localExitRayPosition = localRayIntersectionPoint;
    end
    CurrentRayPosition = localExitRayPosition;

    if polarized
        % phase advancement
        % Zemax method, just multiply the real part by cos(phase) and imaginary
        % by sin(phase)
        [pc,ps] = computePhasePropagationFactors...
            (GeometricalPathLength*lensUnitFactor,wavlenInM);
        currentRayPolarizationVector = (currentRayPolarizationVector).*repmat((pc + 1i *ps),[3,1]);
        currentRayPolarizationVectorBefore = currentRayPolarizationVector;
    end
    
    % If the current coordinate is mirrored coordinate
    % => Mirrored Z axis => the normal vector shall be in -ve direction
    if mirroredCoordinate
        localSurfaceNormal = -localSurfaceNormal;
    end
    localIncidentRayDirection = CurrentRayDirection;
    localIncidenceAngle = computeAngleBetweenVectors (localSurfaceNormal,...
        localIncidentRayDirection); % new function replacing yi's 5th function
    if surfaceIndex < nNonDummySurface
        if polarized
            coatingType = NonDummySurfaceArray(surfaceIndex).Coating.Type;
        end
        Kqm1 = localIncidentRayDirection;
        
        % Compute the new direction based on the surface types
        
        [ localExitRayDirection,TIR ] = getExitRayDirection( NonDummySurfaceArray(surfaceIndex),...
            rayDirection,indexBefore,indexAfter,wavlenInM, localSurfaceNormal,localRayIntersectionPoint,primaryWavlenInM );
        CurrentRayDirection = localExitRayDirection;
        localExitAngle = computeAngleBetweenVectors(localSurfaceNormal,...
            localExitRayDirection);
        Kq = CurrentRayDirection;
        nTotIR = sum(TIR);
        if dispTIRStatus
            if nTotIR > 0
                disp([num2str(nTotIR) , ' rays encountered Total Internal Reflections at ' ,...
                    'surface ', num2str(surfaceIndex),'.']);
            else
                disp(['All of ',num2str(nRay),' rays refracted through surface ',...
                    num2str(surfaceIndex),' with out Total Internal Reflections.']);
            end
        end
        wavLenInUm = wavlenInM*10^6;
        if strcmpi(NonDummySurfaceArray(surfaceIndex).Glass.Name,'Mirror')
            if polarized
                % jones matrix for multiple rays with localIncidenceAngle
                % Wavelength shall be converted to um
                primaryWaveLenInUm = primaryWavlenInM*10^6;
                [ampRs,ampRp,powRs,powRp,jonesMatrix]=...
                    getReflectionCoefficients(NonDummySurfaceArray(surfaceIndex).Coating,...
                    wavLenInUm,localIncidenceAngle,...
                    indexBefore,indexAfter,primaryWaveLenInUm);
                
            end
            mirroredCoordinate = ~mirroredCoordinate;
        elseif ~strcmpi(NonDummySurfaceArray(surfaceIndex).Glass.Name,'Mirror')
            if polarized
                % new code
                % Wavelength shall be converted to um
                primaryWaveLenInUm = primaryWavlenInM*10^6;
                [ampTs,ampTp,powTs,powTp,jonesMatrix] = ...
                    getTransmissionCoefficients(...
                    NonDummySurfaceArray(surfaceIndex).Coating. ...
                    wavLenInUm,localIncidenceAngle,...
                    indexBefore,indexAfter,primaryWaveLenInUm);
            end
        end
        
        RefractiveIndex = ...
            getRefractiveIndex(NonDummySurfaceArray(surfaceIndex).Glass, wavlenInM);
        RefractiveIndexFirstDerivative =  ...
            getRefractiveIndex(NonDummySurfaceArray(surfaceIndex).Glass,wavlenInM,1);
        RefractiveIndexSecondDerivative =  ...
            getRefractiveIndex(NonDummySurfaceArray(surfaceIndex).Glass,wavlenInM,2);
        
        GroupRefractiveIndex =  ...
            getGroupRefractiveIndex(NonDummySurfaceArray(surfaceIndex).Glass,wavlenInM);
        % compute the new P matrix
        if polarized
            P = convertJonesMatrixToPolarizationMatrix(jonesMatrix,Kqm1,Kq);
            CoatingJonesMatrix = jonesMatrix;
            CoatingPMatrix = P;
            % compute the total P matrix
            TotalPMatrix = multiplySliced3DMatrices(P,TotalPMatrix);
            % compute new Polarization vector
            % Convert to 3D vector to use the slice based 3D multiplier
            % function
            polVector3D = permute(currentRayPolarizationVector,[1,3,2]);
            
            newPolVector3D = multiplySliced3DMatrices...
                (P,polVector3D);
            % change back to 2D matrix
            newLocalPolarizationVector = permute(newPolVector3D,[1,3,2]);
            currentRayPolarizationVector = newLocalPolarizationVector;
            
            % compute the parallel ray transport matrix Q
            qJonesMatrix = repmat([1,0;0,1],[1,1,nRay]);   % unity jones matrix for non polarizing element
            Q = convertJonesMatrixToPolarizationMatrix(qJonesMatrix,Kqm1,Kq);
            CoatingQMatrix = Q;
            % compute the total Q matrix
            TotalQMatrix = multiplySliced3DMatrices(Q,TotalQMatrix);
        end
    elseif surfaceIndex==nNonDummySurface
        % for image surface no refraction
        localExitRayDirection  = localIncidentRayDirection;
        localExitAngle = localIncidenceAngle;
        if polarized
            jonesMatrix = jonesMatrix;
            P = repmat(eye(3),[1,1,nRay]);
            Q = repmat(eye(3),[1,1,nRay]);
            
            CoatingJonesMatrix = jonesMatrix;
            CoatingPMatrix = P;
            CoatingQMatrix = Q;
        end
    end
    % Finally Transfer back to Global coordinate system
    localRayPosition = CurrentRayPosition;
    localRayDirection = CurrentRayDirection;
    if polarized
        localRayPolarizationVector = currentRayPolarizationVector;
        localRayPolarizationVectorBefore = currentRayPolarizationVectorBefore;
    else
        localRayPolarizationVector = NaN;
        localRayPolarizationVectorBefore = NaN;
    end
    
    % Global to Local Coordinate transformation
    [GlobalRayIntersectionPoint,GlobalExitRayPosition,GlobalSurfaceNormal,GlobalIncidentRayDirection,...
        GlobalExitRayDirection,GlobalRayPolarizationVectorBefore,GlobalRayPolarizationVector] = ...
        localToGlobalCoordinate(localRayIntersectionPoint,localExitRayPosition,...
        localSurfaceNormal,localIncidentRayDirection,localExitRayDirection,surfaceCoordinateTM,...
        polarized,localRayPolarizationVectorBefore,localRayPolarizationVector);
        
    % now the currentnt ray becomes global ray agin
    CurrentRayPosition = GlobalExitRayPosition;
    CurrentRayDirection = GlobalExitRayDirection;
    
    globalIncidenceAngle = localIncidenceAngle;
    globalExitAngle = localExitAngle;
    
    
    % Add signs to the angles
    % +Ve angles: CCW when observed from (SurfaceNormal X RayDirection)
    % from direction with -ve x component
    % -Ve angles: CW when observed from (SurfaceNormal X RayDirection)
    % from direction with -ve x component
    % This makes the angles valid for rays in yz planes with conventional sign convention.
    normalToPlaneOfPropagationIncident =  ...
        compute3dCross(GlobalSurfaceNormal,GlobalIncidentRayDirection);
    normalToPlaneOfPropagationExit =  ...
        compute3dCross(GlobalSurfaceNormal,GlobalExitRayDirection);
    
    %     if strcmpi(NonDummySurfaceArray(surfaceIndex).Glass.Name,'Mirror')
    %         % Invert the incidence direction in case of mirrror
    %         %if mirroredCoordinate
    %         signOfIncidence = -1;
    %     else
    %         signOfIncidence = 1;
    %     end
    
    GlobalIncidenceAngleSigned = globalIncidenceAngle.* ...
        -sign(normalToPlaneOfPropagationIncident(1));
    GlobalExitAngleSigned = globalExitAngle.* ...
        -sign(normalToPlaneOfPropagationExit(1));
    
    % Record all neccessary outputs to trace the ray
    if recordIntermediateResults
        if polarized
            multipleRayTracerResultAll(surfaceIndex,:) = RayTraceResult...
                (GlobalRayIntersectionPoint,GlobalExitRayPosition,GlobalSurfaceNormal,...
                GlobalIncidentRayDirection,...
                GlobalIncidenceAngleSigned,GlobalExitRayDirection,GlobalExitAngleSigned,...
                NoIntersectionPoint,OutOfAperture,TIR,GeometricalPathLength,OpticalPathLength,...
                GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
                RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
                GroupRefractiveIndex,...
                GlobalRayPolarizationVectorBefore,GlobalRayPolarizationVector,...
                CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix);
        else
            multipleRayTracerResultAll(surfaceIndex,:) =...
                RayTraceResult(GlobalRayIntersectionPoint,GlobalExitRayPosition,GlobalSurfaceNormal,...
                GlobalIncidentRayDirection,GlobalIncidenceAngleSigned,...
                GlobalExitRayDirection,GlobalExitAngleSigned,NoIntersectionPoint,...
                OutOfAperture,TIR,GeometricalPathLength,OpticalPathLength,...
                GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
                RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
                GroupRefractiveIndex);
        end
    else
        if surfaceIndex == endNonDummyIndex
            if polarized
                multipleRayTracerResultFinal(1,:) = RayTraceResult...
                    (GlobalRayIntersectionPoint,GlobalExitRayPosition,GlobalSurfaceNormal,GlobalIncidentRayDirection,...
                    GlobalIncidenceAngleSigned,GlobalExitRayDirection,GlobalExitAngleSigned,...
                    NoIntersectionPoint,OutOfAperture,TIR,GeometricalPathLength,OpticalPathLength,...
                    GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
                    RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
                    GroupRefractiveIndex,...
                    GlobalRayPolarizationVectorBefore,GlobalRayPolarizationVector,...
                    CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix);
            else
                multipleRayTracerResultFinal(1,:) =...
                    RayTraceResult(GlobalRayIntersectionPoint,GlobalExitRayPosition,GlobalSurfaceNormal,...
                    GlobalIncidentRayDirection,GlobalIncidenceAngleSigned,...
                    GlobalExitRayDirection,GlobalExitAngleSigned,NoIntersectionPoint,...
                    OutOfAperture,TIR,GeometricalPathLength,OpticalPathLength,...
                    GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
                    RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
                    GroupRefractiveIndex);
            end
        end
    end
end
% The ray trace result of the non dummy surfaces only.
if recordIntermediateResults
    rayTracerResult = multipleRayTracerResultAll;
else
    rayTracerResult = multipleRayTracerResultFinal;
end
end
