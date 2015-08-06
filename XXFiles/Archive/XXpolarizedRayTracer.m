function polarizedRayTracerResult = polarizedRayTracer(optSystem, objectRay)
    % POLARIZEDRAYTRACER: main function of polarized ray tracer 
    % Inputs
    %   optSystem: data type "OpticalSystem"
    %   ObjectRay: data type "Ray"
    % Output:
    %   polarizedRayTracerResult: datatype "RayTraceResult"

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

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    polarizedRayTracerResult = RayTraceResult;

    nSurface = optSystem.NumberOfSurface;
    currentRay = objectRay;
    polarized = objectRay.Polarized;
    % normalize the given jones vector and convert to Polarization Vector
    normalizedJonesVector = normalizeJonesVector(currentRay.JonesVector);
    currentRay.PolarizationVector = (convertJVToPolVector(normalizedJonesVector,...
        currentRay.Direction));
    % Initialize the total phase to 0, toatl P and Q matrices to unity;
    currentRay.TotalPhase = 0;
    currentRay.TotalPMatrix = eye(3);
    currentRay.TotalQMatrix = eye(3);
    % Add initial ray at the object surface to ray trace result structure 
    if abs(currentRay.Position(3))>10^10
        currentRay.Position(3) = -5;
    end
    recordRayIntersectionPoint(1,:) = currentRay.Position;
    recordSurfaceNormal(1,:) = [0,0,1]; % assume plane object surface.
    recordIncidentRayDirection(1,:) = [NaN NaN NaN]; % no ray is incident to object surface
    recordIncidenceAngle(1,:) = NaN;
    recordExitRayDirection(1,:) = currentRay.Direction;
    recordExitAngle(1,:) = abs (computeIncidenceAngle...
        (recordIncidentRayDirection(1,:),recordSurfaceNormal(1,:)));
    recordPathLength(1,:) = 0;
    initialRayPolVectorInitial = currentRay.PolarizationVector;
    recordRayPolVectorInitial = initialRayPolVectorInitial;
    recordRayPolVectorBeforeCoating(1,:) = [NaN NaN NaN]; %  object surface has no coating
    recordRayPolVectorAfterCoating(1,:) = currentRay.PolarizationVector;

    %no diattenuation defined for object surface 
    diattenuation = NaN;
    recordDiattenuation(1,:) = diattenuation;

    %no retardance defined for object surface 
    retardance = NaN;
    recordRetardance(1,:) = retardance;

    % record the initial total P and Q matrices 
    recordTotalPMatrix(:,:,1) = currentRay.TotalPMatrix;
    recordTotalQMatrix(:,:,1) = currentRay.TotalQMatrix;

    for surfaceIndex = 2:1:nSurface

       % Transfer current ray location, direction and polarization vector 
       % to local coordinates corresponding to kth surface
       % current version considers tilt parameters as successive rotation
       % angle. shall be corrected in future.
       RotationAngles = optSystem.SurfaceArray(surfaceIndex).TiltParameter;
       succRotAngle = [RotationAngles(2) RotationAngles(1) RotationAngles(3)];
       globalVertex = optSystem.SurfaceArray(surfaceIndex).Position;

       globalRayPosition = currentRay.Position;
       globalRayDirection = currentRay.Direction;   
       globalRayData = [globalRayPosition;globalRayDirection];  
       globalRayPolarizationVector = currentRay.PolarizationVector;
       globalRayData = [globalRayData;globalRayPolarizationVector];
       localRayData = globalToLocalCoordinate(globalRayData,polarized,...
           globalVertex,succRotAngle);

       % from this point onward  currentRay become localRay
       currentRay.Position = localRayData(1,:);
       currentRay.Direction = localRayData(2,:);
       currentRay.PolarizationVector = localRayData(3,:);
        % Path length calculation
       surfaceType = optSystem.SurfaceArray(surfaceIndex).Type;
       surfaceRadius = optSystem.SurfaceArray(surfaceIndex).Radius;
       surfaceConic = optSystem.SurfaceArray(surfaceIndex).ConicConstant;

       wavlen  = objectRay.Wavelength;
       refractiveIndexBefore = optSystem.SurfaceArray(surfaceIndex-1).Glass. ...
           getRefractiveIndex(wavlen);  
        rayInitialPosition = currentRay.Position;
        rayDirection = currentRay.Direction;
        [geometricalPathLength, opticalPathLength] = computePathLength ...
            (rayInitialPosition,rayDirection,surfaceType,surfaceRadius,...
            surfaceConic,refractiveIndexBefore);  % 2nd function
        if isnan(geometricalPathLength)
            polarizedRayTracerResult = RayTraceResult.empty;
            return;
        end

        % compute current accumulated phase
        wavelength = currentRay.Wavelength;
        accumulatedPhase = computeAccumulatedPhase(geometricalPathLength,wavelength);
        % add current phase to exsisting total phase 
        currentRay.TotalPhase = currentRay.TotalPhase + accumulatedPhase;

        apertureType = optSystem.SurfaceArray(surfaceIndex).ApertureType;
        apertureParam = optSystem.SurfaceArray(surfaceIndex).ApertureParameter;

        localIntersectionPoint = computeIntersectionPoint(rayInitialPosition,...
            rayDirection, geometricalPathLength,apertureType,apertureParam); % 3rd function
        if isnan(localIntersectionPoint)
            polarizedRayTracerResult = RayTraceResult.empty;
            return;
        end
        currentRay.Position = localIntersectionPoint;
        % phase advancement  
        % Zemax method, just multiply the real part by cos(phase) and imaginary
        % by sin(phase)
        [pc,ps] = computePhasePropagationFactors(geometricalPathLength,wavelength);
        currentRay.PolarizationVector = (currentRay.PolarizationVector)*(pc + 1i *ps);   

        % record resulting polarization vector just before coating
        recordRayPolVectorBeforeCoating(surfaceIndex,:) = currentRay.PolarizationVector;

        % Compute Reflection and Refraction by solving Snells law in 3D    
        surfaceType = optSystem.SurfaceArray(surfaceIndex).Type;
        surfaceRadius = optSystem.SurfaceArray(surfaceIndex).Radius;
        surfaceConic = optSystem.SurfaceArray(surfaceIndex).ConicConstant;

        localSurfaceNormal = computeSurfaceNormal(localIntersectionPoint,...
            surfaceType,surfaceRadius,surfaceConic); % 4th function

        localIncidentRayDirection = currentRay.Direction;
        localIncidenceAngle = computeIncidenceAngle (localIncidentRayDirection,...
            localSurfaceNormal); % 5th function

        if surfaceIndex < nSurface                
           wavlen  = objectRay.Wavelength;
           indexBefore = optSystem.SurfaceArray(surfaceIndex-1).Glass. ...
               getRefractiveIndex(wavlen);    
           indexAfter =  optSystem.SurfaceArray(surfaceIndex).Glass. ...
               getRefractiveIndex(wavlen);   
            coatingType = optSystem.SurfaceArray(surfaceIndex).Coating.Type;

            localReflectedRayDirection = computeReflectedRayDirection ...
                (localIncidentRayDirection,localSurfaceNormal); % 6th function
            localTransmittedRayDirection = computeRefractedRayDirection ...
                (localIncidentRayDirection,localSurfaceNormal,indexBefore,indexAfter); % 7th function

            localTransmittedRayAngle =  acos(dot(localTransmittedRayDirection,...
                localSurfaceNormal));
            localReflectedRayAngle = localIncidenceAngle;

            Kqm1 = localIncidentRayDirection;

            if strcmp(optSystem.SurfaceArray(surfaceIndex).DeviationMode,...
                    '-1 Reflective') % reflection   
                % direction of reflected ray           
                currentRay.Direction = localReflectedRayDirection;
                localExitRayDirection = localReflectedRayDirection;
                localExitAngle = localReflectedRayAngle;
                Kq = currentRay.Direction; 
                % jones matrix        
                jonesMatrix = optSystem.SurfaceArray(surfaceIndex).Coating. ...
                    getJonesReflectionMatrix(wavlen,localIncidenceAngle,...
                    indexBefore,indexAfter); 
            elseif  strcmp(optSystem.SurfaceArray(surfaceIndex).DeviationMode,...
                    '+1 Refractive')% refraction

                if strcmp(localTransmittedRayDirection,'null')==1
                     disp('Error: Total internal reflection\n');
                     break;
                end            
                currentRay.Direction = localTransmittedRayDirection;
                localExitRayDirection = localTransmittedRayDirection;
                localExitAngle = localTransmittedRayAngle;
                Kq = currentRay.Direction; 
                jonesMatrix = optSystem.SurfaceArray(surfaceIndex).Coating. ...
                    getJonesTransmissionMatrix(wavlen,localIncidenceAngle,...
                    indexBefore,indexAfter);             
            else
                disp('Surface must be either reflective or refractive');
            end 
            % compute the new P matrix
            P = convertJonesMatrixToPolarizationMatrix(jonesMatrix,Kqm1,Kq);
            % compute the total P matrix
            currentRay.TotalPMatrix = P*currentRay.TotalPMatrix;
            % compute new Polarization vector
            newLocalPolarizationVector = (P*(currentRay.PolarizationVector)')';
            currentRay.PolarizationVector = newLocalPolarizationVector;

            % compute the parallel ray transport matrix Q
            qJonesMatrix = [1,0;0,1];   % unity jones matrix for non polarizing element
            Q = convertJonesMatrixToPolarizationMatrix(qJonesMatrix,Kqm1,Kq);
            % compute the total Q matrix        
            currentRay.TotalQMatrix = Q*currentRay.TotalQMatrix;

        elseif surfaceIndex==nSurface 
            % for image surface no refraction
            localExitRayDirection  = localIncidentRayDirection;
            localExitAngle = localIncidenceAngle; 

            jonesMatrix = [1,0;0,1];
            P = convertJonesMatrixToPolarizationMatrix(jonesMatrix,...
                localExitRayDirection,localIncidentRayDirection);
            Q = P;
            currentRay.TotalPMatrix = P*currentRay.TotalPMatrix;
            currentRay.TotalQMatrix = Q*currentRay.TotalQMatrix;  
        end   
        % Finally Transfer back to Global coordinate system
       localRayPosition = currentRay.Position;
       localRayDirection = currentRay.Direction;
       localRayData = [localRayPosition;localRayDirection];
       localRayPolarizationVector = currentRay.PolarizationVector;
       localRayData = [localRayData;localRayPolarizationVector];
       [globalRayData,globalSurfaceNormal,globalIncidentRayDirection,...
           globalExitRayDirection] = localToGlobalCoordinate(localRayData,...
           polarized,localSurfaceNormal,localIncidentRayDirection,...
           localExitRayDirection,globalVertex,succRotAngle); 



       % now the currnt ray becomes global ray agin
       currentRay.Position = globalRayData(1,:);
       currentRay.Direction = globalRayData(2,:);
       currentRay.PolarizationVector = globalRayData(3,:);
       globalIncidenceAngle = localIncidenceAngle;
       globalExitAngle = localExitAngle;

        %Record all neccessary outputs to trace the ray 
        recordRayIntersectionPoint(surfaceIndex,:) = currentRay.Position;
        recordIncidentRayDirection(surfaceIndex,:) = globalIncidentRayDirection;
        recordExitRayDirection(surfaceIndex,:) = globalExitRayDirection;

        recordIncidenceAngle(surfaceIndex,:) = globalIncidenceAngle;
        recordExitAngle(surfaceIndex,:) = globalExitAngle;

        recordSurfaceNormal(surfaceIndex,:) = globalSurfaceNormal;
        recordPathLength(surfaceIndex,:) = geometricalPathLength;
        recordRayPolVectorAfterCoating(surfaceIndex,:) = currentRay.PolarizationVector; 

        recordTotalPMatrix(:,:,surfaceIndex) = currentRay.TotalPMatrix;
        recordTotalQMatrix(:,:,surfaceIndex) = currentRay.TotalQMatrix;

       % compute and record Diattenuation
        diattenuation = computeDiattenuation(P);
        recordDiattenuation(surfaceIndex,:) = diattenuation;

       % compute and record proper retardance
        retardance = computeProperRetardance(P,Q);
        recordRetardance(surfaceIndex,:) = retardance;
    end
    polarizedRayTracerResult.RayIntersectionPoint = recordRayIntersectionPoint;
    polarizedRayTracerResult.IncidentRayDirection = recordIncidentRayDirection;
    polarizedRayTracerResult.ExitRayDirection = recordExitRayDirection;
    
    polarizedRayTracerResult.SurfaceNormal = recordSurfaceNormal;
    polarizedRayTracerResult.IncidenceAngle = recordIncidenceAngle*180/(pi);
    polarizedRayTracerResult.ExitAngle = recordExitAngle*180/(pi);
    
    polarizedRayTracerResult.PathLength = recordPathLength;
    
    polarizedRayTracerResult.PolarizationVectorInitial = recordRayPolVectorInitial;
    polarizedRayTracerResult.PolarizationVectorBeforeCoating = recordRayPolVectorBeforeCoating;
    polarizedRayTracerResult.PolarizationVectorAfterCoating = recordRayPolVectorAfterCoating;
       
     polarizedRayTracerResult.Diattenuation = recordDiattenuation;
     polarizedRayTracerResult.Retardance = recordRetardance;
     
     polarizedRayTracerResult.TotalPMatrix = recordTotalPMatrix;
     polarizedRayTracerResult.TotalQMatrix = recordTotalQMatrix;
     
end

