function rayTracerResult = rayTracer(optSystem, objectRay, considerSurfAperture)
% rayTracer: main function of polarized ray tracer
% The function is vectorized so it can work on multiple sets of
% inputs once at the same time. That is array of ray objects.
% Inputs
%   optSystem: data type "OpticalSystem"
%   ObjectRay: data type "Ray" or array of Ray object
% Output:
%   rayTracerResult: array of "RayTraceResult" or can be
%   matrix of RayTraceResult objects if the input is array of Ray
%   object. Size : nSurface X nTotalRay

% <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%
% 1.	Normalize the jones vector of initial ray and convert to
%       Polarization Vector ()
% 2.	Initialize the total phase to 0, total P and Q matrices to unity
% 3.	Record the initial ray data, (including total phase, total P
%       and Q matrices) at the object surface to ray trace result
%       structure. The initial diattenuation and retardance are not defined.
% 4.	For surface index , k = 2 to Total number of surface, nTotal
%   a)	Transfer current ray location, direction and polarization vector
%       to local coordinates corresponding to kth surface
%   b)	Compute local intersection point with the surface and path length
%       to the intersection point
%   c)	Compute the phase advancement from the path length
%   d)	Compute the local polarization vector before the coating
%   e)	Compute the local surface normal at the intersection point
%   f)	Compute local reflected or refracted ray direction by using
%       Snell’s law in 3D  based on the surface deviation mod
%   g)	Compute the jones matrix (either transmission or reflection) of
%       the coating
%   h)	Convert the coating jones matrix to polarization matrix ()
%   i)	Compute the new local polarization vector after the coating
%   j)	Update the total polarization ray tracing matrix P for the ray
%   k)	Compute the parallel ray transport matrix Q related to the
%       incident and exit directions
%   l)	Update the total parallel ray transport matrix Q for the ray
%   m)	Compute the diattenuation and retardance associated with the coating
%   n)	Transfer  all vectors in local coordinate system back to the
%       global coordinate system
%   o)	Record : Ray Intersection Point, Incident Ray Direction, Exit
%       Ray Direction, Surface Normal , Incidence Angle , Exit Angle ,
%       Path Length , Polarization Vector Initial ,
%       Polarization Vector Before Coating , Polarization Vector After Coating ,
%       Diattenuation, Retardance, Total P Matrix and Total Q Matrix
%       to the ray tracing result object.
% 5.	Go to next surface

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

% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% Deafualt arguments
if nargin < 2
    disp(['Error: Missing Input. The function rayTracer needs '...
        ' atleast the optical system and an object ray as input argument.']);
    return;
elseif nargin == 2
    considerSurfAperture = 1;
else
end

% Set info to be displayed on the command window
dispTIRStatus = 0;
dispNoIntersectionStatus = 0;
dispOutOfApertureStatus = 0;

nSurface = optSystem.NumberOfSurfaces;
% determine the lens units and wavelength units factors
lensUnit = optSystem.LensUnit; % 1:'(mm)',2:'(cm)',3:'(m)'
wavUnit = optSystem.WavelengthUnit; % 1:'(nm)',2:'(um)'

lensUnitFactor = (lensUnit==1)*(10^-3) + (lensUnit==2)*(10^-2) +...
    (lensUnit==3)*(1);
wavUnitFactor = (wavUnit==1)*(10^-9) + (wavUnit==2)*(10^-6);

nRay = length(objectRay);

polarized = [objectRay.Polarized];
% Determine the tracing method. Polarized objects need polarized ray
% trace.
polarized = polarized(1);

wavlen  = [objectRay.Wavelength]; % wavlen is in m for Ray object
currentRayDirection = [objectRay.Direction];
currentRayPosition = [objectRay.Position];
% Initialize the total phase to 0,
totalPhase = zeros([1,nRay]);

if polarized
    jonesVector = [objectRay.JonesVector];
    % normalize the given jones vector and convert to Polarization Vector
    normalizedJonesVector = normalizeJonesVector(jonesVector);
    
    %% Shall be changed or checked
    currentRayPolarizationVector = (convertJVToPolVector(normalizedJonesVector,...
        currentRayDirection));
    
    % initialize toatl P, Q and coatingJonesMatrix matrices to unity;
    totalPMatrix = repmat(eye(3),[1,1,nRay]);
    totalQMatrix = repmat(eye(3),[1,1,nRay]);
    
    coatingJonesMatrix = repmat(eye(2),[1,1,nRay]);
    coatingPMatrix = repmat(eye(3),[1,1,nRay]);
    coatingQMatrix = repmat(eye(3),[1,1,nRay]);
end

% Initialize the matrix of ray trace result object. Preallocation
multipleRayTracerResult(nSurface,nRay) = RayTraceResult;

% Add initial ray at the object surface to ray trace result structure
%  All 1 D array are recorded as 3x1 vertical vector
infThickness = abs(currentRayPosition(3,:)) > 10^10;
currentRayPosition(3,infThickness) = 0;

currentSurfaceNormal = repmat([0;0;1],[1,nRay]); % assume plane object surface.

RayIntersectionPoint = currentRayPosition;
IncidentRayDirection = repmat([NaN;NaN;NaN],[1,nRay]); % no ray is incident to object surface
ExitRayDirection = currentRayDirection;

SurfaceNormal = currentSurfaceNormal; % [0,0,1]; % assume plane object surface.
IncidenceAngle = NaN([1,nRay]);
ExitAngle = computeAngleBetweenVectors...
    (currentRayDirection,currentSurfaceNormal);
PathLength = zeros([1,nRay]);
OpticalPathLength = zeros([1,nRay]);

NoIntersectionPoint = zeros([1,nRay]);
OutOfAperture = zeros([1,nRay]);
TotalInternalReflection = zeros([1,nRay]);

RefractiveIndex = ones([1,nRay]);
RefractiveIndexFirstDerivative  = zeros([1,nRay]);
RefractiveIndexSecondDerivative  = zeros([1,nRay]);

if polarized
    PolarizationVectorBeforeCoating = repmat([NaN;NaN;NaN],[1,nRay]);
    %  object surface has no coating
    PolarizationVectorAfterCoating = currentRayPolarizationVector;
    
    TotalPMatrix = totalPMatrix;
    TotalQMatrix = totalQMatrix;
    
    CoatingJonesMatrix = coatingJonesMatrix;
    CoatingPMatrix = coatingPMatrix;
    CoatingQMatrix = coatingQMatrix;
    
    multipleRayTracerResult(1,:) = RayTraceResult(RayIntersectionPoint,SurfaceNormal,...
        IncidentRayDirection,IncidenceAngle,ExitRayDirection,ExitAngle,...
        NoIntersectionPoint,OutOfAperture,TotalInternalReflection,PathLength,OpticalPathLength,...
        RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
        PolarizationVectorBeforeCoating,PolarizationVectorAfterCoating,...
        CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix);
else
    multipleRayTracerResult(1,:) = RayTraceResult(RayIntersectionPoint,SurfaceNormal,...
        IncidentRayDirection,IncidenceAngle,ExitRayDirection,ExitAngle,...
        NoIntersectionPoint,OutOfAperture,TotalInternalReflection,PathLength,OpticalPathLength,...
        RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative);
end

% To keep track of mirrored coordinates (after mirror occuring odd
% times)
mirroredCoordinate = 0;

NonDummySurfaceArray =  optSystem.SurfaceArray(optSystem.NonDummySurfaceIndices);
nNonDummySurface = size(NonDummySurfaceArray,2);

for surfaceIndex = 2:1:nNonDummySurface
% for surfaceIndex = 2:1:nSurface
    surfType = optSystem.SurfaceArray(surfaceIndex).Type;
    
%     if strcmpi(surfType, 'Dummy')
%         % Just make the ray trace results of previous surface. But
%         % remember to not use these values in any analysis of the
%         % rayTraceResults
%         multipleRayTracerResult(surfaceIndex,:) = ...
%             multipleRayTracerResult(surfaceIndex-1,:);
%         continue;
%     end
    % Transfer current ray location, direction and polarization vector
    % to local coordinates corresponding to kth surface
    globalRayPosition = currentRayPosition;
    globalRayDirection = currentRayDirection;
    if polarized
        globalRayPolarizationVector = currentRayPolarizationVector;
        globalRayData = cat(3,globalRayPosition,globalRayDirection,...
            globalRayPolarizationVector);
    else
        globalRayData = cat(3,globalRayPosition,globalRayDirection);
    end
    
    %% New Code for Global to Local Coordinate transformation using Coordinate Transfer Matrix
%     prevRefCoordinateTM = optSystem.SurfaceArray(surfaceIndex-1).ReferenceCoordinateTM;
%     prevSurfCoordinateTM = optSystem.SurfaceArray(surfaceIndex-1).SurfaceCoordinateTM;
    prevThickness = optSystem.SurfaceArray(surfaceIndex-1).Thickness;
    if abs(prevThickness) > 10^10
        prevThickness = 0;
    end
    
    surfaceCoordinateTM = optSystem.SurfaceArray(surfaceIndex).SurfaceCoordinateTM;
%     referenceCoordinateTM = optSystem.SurfaceArray(surfaceIndex).ReferenceCoordinateTM;
    
    localRayData = globalToLocalCoordinate(globalRayData,polarized,...
        surfaceCoordinateTM);
    
    %% End of New code
    
    % from this point onwards  currentRay become localRay
    currentRayPosition = localRayData(:,:,1);
    currentRayDirection = localRayData(:,:,2);
    if polarized
        currentRayPolarizationVector = localRayData(:,:,3);
    end
    % Path length calculation
    surfaceType = optSystem.SurfaceArray(surfaceIndex).Type;
    surfaceRadius = optSystem.SurfaceArray(surfaceIndex).Radius;
    surfaceConic = optSystem.SurfaceArray(surfaceIndex).ConicConstant;
    
    indexBefore = optSystem.SurfaceArray(surfaceIndex-1).Glass. ...
        getRefractiveIndex(wavlen);
    
    rayInitialPosition = currentRayPosition;
    rayDirection = currentRayDirection;
    
    % Correction for collimated inclined rays from infinity
    % The ray positions should be shifted bit in such away that the OPL
    % will be the same for all rays initially.
    if surfaceIndex == 2 && optSystem.SurfaceArray(1).Thickness > 10^10
        % If any point on a line passing through P and with unit vector u
        % is given by Lp = P + u*t. (t is scalar shift along the line)
        % t for point where a perpendicular line from orign (0,0,0) cross the
        % given line is given by t = -P.u
        t = - compute3dDot(rayInitialPosition,rayDirection);
        rayInitialPosition = rayInitialPosition + rayDirection.*repmat(t,[3,1]);
    end
    
    [geometricalPathLength, opticalPathLength,NoIntersectionPoint] = computePathLength ...
        (rayInitialPosition,rayDirection,surfaceType,surfaceRadius,...
        surfaceConic,indexBefore);  % 2nd function
    
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
        (geometricalPathLength*lensUnitFactor,wavlen);
    
    % add current phase to exsisting total phase
    totalPhase = totalPhase + accumulatedPhase;
    
    apertureType = optSystem.SurfaceArray(surfaceIndex).ApertureType;
    apertureParam = optSystem.SurfaceArray(surfaceIndex).ApertureParameter;
    % Compute the clear aperture
    clearAperture = optSystem.SurfaceArray(surfaceIndex).ClearAperture;
    clearApertureParameter = [clearAperture*apertureParam(1),...
        clearAperture*apertureParam(2),apertureParam(3),apertureParam(4)];
    
    [localIntersectionPoint,outOfAperture] = computeIntersectionPoint(rayInitialPosition,...
        rayDirection, geometricalPathLength,apertureType,clearApertureParameter,considerSurfAperture); % 3rd function
    
    totalOutOfAperture = sum(outOfAperture);
    if dispOutOfApertureStatus
        if totalOutOfAperture > 0
            disp([num2str(totalOutOfAperture) , ' rays are vignated at surface ',...
                num2str(surfaceIndex),'. They intersect the surface outside the ' ,...
                'aperture area. They are ignored in other computations.']);
        else
            disp(['All of ',num2str(nRay),' rays pass through surface ',num2str(surfaceIndex),'.']);
        end
    end
    currentRayPosition = localIntersectionPoint;
    if polarized
        % phase advancement
        % Zemax method, just multiply the real part by cos(phase) and imaginary
        % by sin(phase)
        [pc,ps] = computePhasePropagationFactors...
            (geometricalPathLength*lensUnitFactor,wavlen);
        currentRayPolarizationVector = (currentRayPolarizationVector).*repmat((pc + 1i *ps),[3,1]);
        currentRayPolarizationVectorBefore = currentRayPolarizationVector;
    end
    
    % Compute Reflection and Refraction by solving Snells law in 3D
    surfaceType = optSystem.SurfaceArray(surfaceIndex).Type;
    surfaceRadius = optSystem.SurfaceArray(surfaceIndex).Radius;
    surfaceConic = optSystem.SurfaceArray(surfaceIndex).ConicConstant;
    localSurfaceNormal = computeSurfaceNormal(localIntersectionPoint,...
        surfaceType,surfaceRadius,surfaceConic); % 4th function
    
    % If the current coordinate is mirrored coordinate
    % => Mirrored Z axis => the normal vector shall be in -ve direction
    %
    if mirroredCoordinate
        localSurfaceNormal = -localSurfaceNormal;
    end
    localIncidentRayDirection = currentRayDirection;
    localIncidenceAngle = computeAngleBetweenVectors (localIncidentRayDirection,...
        localSurfaceNormal); % new function replacing yi's 5th function
    if surfaceIndex < nSurface
        
        prevNonDummySurf = previousNonDummySurface(optSystem,surfaceIndex);
        if strcmpi(optSystem.SurfaceArray(prevNonDummySurf).Glass.Name,'Mirror')
            % The index before will be that of the non dummy surface before the mirror
            prevNonDummySurf = previousNonDummySurface(optSystem,prevNonDummySurf);
        end
        
        indexBefore = optSystem.SurfaceArray(prevNonDummySurf).Glass. ...
            getRefractiveIndex(wavlen);
        indexAfter =  optSystem.SurfaceArray(surfaceIndex).Glass. ...
            getRefractiveIndex(wavlen);
        if polarized
            coatingType = optSystem.SurfaceArray(surfaceIndex).Coating.Type;
        end
        Kqm1 = localIncidentRayDirection;
        
        % Compute the new direction based on the surface types
        switch lower(optSystem.SurfaceArray(surfaceIndex).Type)
            case lower('Dummy')
                % Has already been treated at the begining
                % Do nothing
                nRay = size(localIncidentRayDirection,2);
                TIR = ones(1,nRay);
                currentRayDirection = localIncidentRayDirection;
                localExitRayDirection = localIncidentRayDirection;
                localExitAngle = localIncidenceAngle;
                Kq = currentRayDirection;
                if polarized
                    % jones matrix for multiple rays just unity matrix
                    jonesMatrix =  repmat(eye(2),[1,1,nRay]);
                end                
            case lower('Ideal Lens')
                disp ('Error: Ideal Lens is not supported now.');
                return;
            case lower({'Standard','Even Aspheric','Odd Aspheric'})
                if strcmpi(optSystem.SurfaceArray(surfaceIndex).Glass.Name,...
                        'Mirror') % reflection
                    
                    reflection = 1;
                    wavLenInUm = wavlen*10^6;
                    gratingVector1 = [0,2*pi*optSystem.SurfaceArray(surfaceIndex).GratingLineDensity,0]';
                    diffractionOrder1 = optSystem.SurfaceArray(surfaceIndex).DiffractionOrder;
                    
                    if diffractionOrder1 ~= 0 && gratingVector1(2) ~= 0
                        localReflectedRayDirection = computeNewRayDirection ...
                            (localIncidentRayDirection,localSurfaceNormal,...
                            indexBefore,indexAfter,reflection,wavLenInUm,gratingVector1,diffractionOrder1);
                    else
                        localReflectedRayDirection = computeReflectedRayDirection ...
                            (localIncidentRayDirection,localSurfaceNormal); % 6th function
                    end
                    TIR = ones(1,size(localReflectedRayDirection,2));
%                     localReflectedRayAngle = localIncidenceAngle;
                    localReflectedRayAngle =  computeAngleBetweenVectors ...
                        (localReflectedRayDirection,localSurfaceNormal);
    
                    % direction of reflected ray
                    currentRayDirection = localReflectedRayDirection;
                    localExitRayDirection = localReflectedRayDirection;
                    localExitAngle = localReflectedRayAngle;
                    Kq = currentRayDirection;
                    if polarized
                        % jones matrix for multiple rays with localIncidenceAngle
                        % Wavelength shall be converted to um
                        primaryWaveLenInUm = optSystem.getPrimaryWavelength*10^6;
                        wavLenInUm = wavlen*10^6;
                        [ampRs,ampRp,powRs,powRp,jonesMatrix]=...
                            optSystem.SurfaceArray(surfaceIndex).Coating. ...
                            getReflectionCoefficients(wavLenInUm,localIncidenceAngle,...
                            indexBefore,indexAfter,primaryWaveLenInUm);
                    end
                    
                    mirroredCoordinate = ~mirroredCoordinate;
                elseif  ~strcmpi(optSystem.SurfaceArray(surfaceIndex).Glass.Name,'Mirror')
                    reflection = 0;
                    wavLenInUm = wavlen*10^6;
                    gratingVector1 = [0,2*pi*optSystem.SurfaceArray(surfaceIndex).GratingLineDensity,0]';
                    diffractionOrder1 = optSystem.SurfaceArray(surfaceIndex).DiffractionOrder;
                    
                    if diffractionOrder1 ~= 0 && gratingVector1(2) ~= 0
                        [localTransmittedRayDirection,TIR] = computeNewRayDirection ...
                            (localIncidentRayDirection,localSurfaceNormal,...
                            indexBefore,indexAfter,reflection,wavLenInUm,gratingVector1,diffractionOrder1);
                    else
                        [localTransmittedRayDirection,TIR] = computeRefractedRayDirection ...
                            (localIncidentRayDirection,localSurfaceNormal,indexBefore,indexAfter);
                    end% 7th function
                    
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
                    localTransmittedRayAngle = computeAngleBetweenVectors(localTransmittedRayDirection,...
                        localSurfaceNormal);
                    currentRayDirection = localTransmittedRayDirection;
                    localExitRayDirection = localTransmittedRayDirection;
                    localExitAngle = localTransmittedRayAngle;
                    Kq = currentRayDirection;
                    if polarized
                        % new code
                        % Wavelength shall be converted to um
                        primaryWaveLenInUm = optSystem.getPrimaryWavelength*10^6;
                        wavLenInUm = wavlen*10^6;
                        [ampTs,ampTp,powTs,powTp,jonesMatrix] = ...
                            optSystem.SurfaceArray(surfaceIndex).Coating. ...
                            getTransmissionCoefficients(wavLenInUm,localIncidenceAngle,...
                            indexBefore,indexAfter,primaryWaveLenInUm);
                    end
                else
                    disp('Surface must be either reflective or refractive');
                end
                
        end
        %
        RefractiveIndex = optSystem.SurfaceArray(surfaceIndex).Glass. ...
            getRefractiveIndex(wavlen);
        RefractiveIndexFirstDerivative = optSystem.SurfaceArray(surfaceIndex).Glass. ...
            getRefractiveIndex(wavlen,1);
        RefractiveIndexSecondDerivative = optSystem.SurfaceArray(surfaceIndex).Glass. ...
            getRefractiveIndex(wavlen,2);
        
        % compute the new P matrix
        if polarized
            P = convertJonesMatrixToPolarizationMatrix(jonesMatrix,Kqm1,Kq);
            coatingJonesMatrix = jonesMatrix;
            coatingPMatrix = P;
            % compute the total P matrix
            totalPMatrix = multiplySliced3DMatrices(P,totalPMatrix);
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
            coatingQMatrix = Q;
            % compute the total Q matrix
            totalQMatrix = multiplySliced3DMatrices(Q,totalQMatrix);
            %                 end
        end
    elseif surfaceIndex==nSurface
        % for image surface no refraction
        localExitRayDirection  = repmat([NaN;NaN;NaN],[1,nRay]);
        localExitAngle = NaN([1,nRay]);
        if polarized
            jonesMatrix = repmat(NaN*eye(2),[1,1,nRay]);
            P = repmat(NaN*eye(3),[1,1,nRay]);
            Q = repmat(NaN*eye(3),[1,1,nRay]);
            
            coatingJonesMatrix = jonesMatrix;
            coatingPMatrix = P;
            coatingQMatrix = Q;
        end
    end
    % Finally Transfer back to Global coordinate system
    localRayPosition = currentRayPosition;
    localRayDirection = currentRayDirection;
    if polarized
        localRayPolarizationVector = currentRayPolarizationVector;
        localRayPolarizationVectorBefore = currentRayPolarizationVectorBefore;
        localRayData = cat(3,localRayPosition,localRayDirection,...
            localRayPolarizationVectorBefore,localRayPolarizationVector);
    else
        localRayData = cat(3,localRayPosition,localRayDirection);
    end
    
    %% New Code for Global to Local Coordinate transformation
    [globalRayData,globalSurfaceNormal,globalIncidentRayDirection,...
        globalExitRayDirection] = localToGlobalCoordinate(localRayData,...
        polarized,localSurfaceNormal,localIncidentRayDirection,...
        localExitRayDirection,surfaceCoordinateTM);
    
    %% End of New code
    
    % now the currentnt ray becomes global ray agin
    currentRayPosition = globalRayData(:,:,1);
    currentRayDirection = globalRayData(:,:,2);
    if polarized
        globalRayPolarizationVectorBefore = globalRayData(:,:,3);
        globalRayPolarizationVector = globalRayData(:,:,4);
    end
    globalIncidenceAngle = localIncidenceAngle;
    globalExitAngle = localExitAngle;
    
    
    % Add signs to the angles
    % +Ve angles: CCW when observed from (SurfaceNormal X RayDirection)
    % from direction with -ve x component
    % -Ve angles: CW when observed from (SurfaceNormal X RayDirection)
    % from direction with -ve x component
    % This makes the angles valid for rays in yz planes.
    normalToPlaneOfPropagationIncident =  ...
        compute3dCross(globalIncidentRayDirection,globalSurfaceNormal);
    normalToPlaneOfPropagationExit =  ...
        compute3dCross(globalExitRayDirection,globalSurfaceNormal);
    % Invert the direction of normal vectors with +ve x value
    normalToPlaneOfPropagationIncident(:,normalToPlaneOfPropagationIncident(1)>0)=...
        -normalToPlaneOfPropagationIncident(:,normalToPlaneOfPropagationIncident(1)>0);
    normalToPlaneOfPropagationExit(:,normalToPlaneOfPropagationExit(1)>0)=...
        -normalToPlaneOfPropagationExit(:,normalToPlaneOfPropagationExit(1)>0);
    globalIncidenceAngleSigned = globalIncidenceAngle.* ...
        sign(compute3dDot(normalToPlaneOfPropagationIncident,compute3dCross(globalSurfaceNormal,globalIncidentRayDirection)));
    globalExitAngleSigned = globalExitAngle.* ...
        sign(compute3dDot(normalToPlaneOfPropagationExit,compute3dCross(globalSurfaceNormal,globalExitRayDirection)));
    
    % Record all neccessary outputs to trace the ray
    if polarized
        multipleRayTracerResult(surfaceIndex,:) = RayTraceResult...
            (currentRayPosition,globalSurfaceNormal,globalIncidentRayDirection,...
            globalIncidenceAngleSigned,globalExitRayDirection,globalExitAngleSigned,...
            NoIntersectionPoint,outOfAperture,TIR,geometricalPathLength,opticalPathLength,...
            RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
            globalRayPolarizationVectorBefore,globalRayPolarizationVector,...
            coatingJonesMatrix,coatingPMatrix,coatingQMatrix,totalPMatrix,totalQMatrix);
    else
        multipleRayTracerResult(surfaceIndex,:) =...
            RayTraceResult(currentRayPosition,globalSurfaceNormal,...
            globalIncidentRayDirection,globalIncidenceAngleSigned,...
            globalExitRayDirection,globalExitAngleSigned,NoIntersectionPoint,...
            outOfAperture,TIR,geometricalPathLength,opticalPathLength,...
            RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative);
    end
    
end
rayTracerResult = multipleRayTracerResult;
end

function surfIndex  = previousNonDummySurface(optSyst,currentIndex)
surfIndex = 0;
for ss = currentIndex-1:-1:1
    if ~strcmpi(optSyst.SurfaceArray(ss).Type,'Dummy')
        surfIndex = ss;
        return;
    end
end
end