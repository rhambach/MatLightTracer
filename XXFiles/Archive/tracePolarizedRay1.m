function polarizedRayTracerResult = tracePolarizedRay(optSystem, objectRay)
    % tracePolarizedRay: main function of polarized ray tracer 
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
    global INF_OBJ_Z;
    INF_OBJ_Z = 1;
    
    polarizedRayTracerResult = RayTraceResult;

    nSurface = optSystem.NumberOfSurface;    
    polarized = objectRay.Polarized;
    wavlen  = objectRay.Wavelength;
    currentRayDirection = objectRay.Direction;
    currentRayPosition = objectRay.Position;
    % Initialize the total phase to 0, 
    totalPhase = 0;
    
    if polarized 
        jonesVector = objectRay.JonesVector;
        % normalize the given jones vector and convert to Polarization Vector
        normalizedJonesVector = normalizeJonesVector(jonesVector);
        currentRayPolarizationVector = (convertJVToPolVector(normalizedJonesVector,...
        currentRayDirection));
        % initialize toatl P, Q and coatingJonesMatrix matrices to unity;
        totalPMatrix = eye(3);
        totalQMatrix = eye(3);

        coatingJonesMatrix = eye(2);
        coatingPMatrix = eye(3);
        coatingQMatrix = eye(3);
    end
    

    
    % Add initial ray at the object surface to ray trace result structure 
    if abs(currentRayPosition(3)) > 10^10
        currentRayPosition(3) = -INF_OBJ_Z;
    end
    recordRayIntersectionPoint(1,:) = currentRayPosition;    
    recordSurfaceNormal(1,:) = [0,0,1]; % assume plane object surface.
    recordIncidentRayDirection(1,:) = [NaN NaN NaN]; % no ray is incident to object surface
    recordIncidenceAngle(1,:) = NaN;    
    recordExitRayDirection(1,:) = currentRayDirection;    
    recordExitAngle(1,:) = abs (computeIncidenceAngle...
        (recordIncidentRayDirection(1,:),recordSurfaceNormal(1,:)));
    recordPathLength(1,:) = 0;
    
    if polarized
        recordRayPolVectorInitial = currentRayPolarizationVector; 
        recordRayPolVectorBeforeCoating(1,:) = [NaN NaN NaN]; %  object surface has no coating
        recordRayPolVectorAfterCoating(1,:) = currentRayPolarizationVector;

        %no diattenuation defined for object surface 
        diattenuation = NaN;
        recordDiattenuation(1,:) = diattenuation;

        %no retardance defined for object surface 
        retardance = NaN;
        recordRetardance(1,:) = retardance;

        % record the initial total P and Q matrices 
        recordTotalPMatrix(:,:,1) = totalPMatrix;
        recordTotalQMatrix(:,:,1) = totalQMatrix;

        recordCoatingJonesMatrix(:,:,1) = coatingJonesMatrix;
        recordCoatingPMatrix(:,:,1) = coatingPMatrix;
        recordCoatingQMatrix(:,:,1) = coatingQMatrix;
    end
    
    for surfaceIndex = 2:1:nSurface
       % Transfer current ray location, direction and polarization vector 
       % to local coordinates corresponding to kth surface      
       globalRayPosition = currentRayPosition;
       globalRayDirection = currentRayDirection; 
       if polarized
           globalRayPolarizationVector = currentRayPolarizationVector;
           globalRayData = [globalRayPosition;globalRayDirection;...
               globalRayPolarizationVector];  
       else
           globalRayData = [globalRayPosition;globalRayDirection];            
       end
       
       %% New Code for Global to Local Coordinate transformation using Coordinate Transfer Matrix
       prevRefCoordinateTM = optSystem.SurfaceArray(surfaceIndex-1).ReferenceCoordinateTM;
       prevSurfCoordinateTM = optSystem.SurfaceArray(surfaceIndex-1).SurfaceCoordinateTM;
       prevThickness = optSystem.SurfaceArray(surfaceIndex-1).Thickness;
       if abs(prevThickness) > 10^10
          prevThickness = sign(prevThickness)*INF_OBJ_Z;
       end
    
       [surfaceCoordinateTM,referenceCoordinateTM] = ...
           optSystem.SurfaceArray(surfaceIndex).TiltAndDecenter...
                (prevRefCoordinateTM,prevSurfCoordinateTM,prevThickness);
        localRayData = globalToLocalCoordinate(globalRayData,polarized,...
           surfaceCoordinateTM,referenceCoordinateTM);
            
       %% End of New code

       % from this point onwards  currentRay become localRay
       currentRayPosition = localRayData(1,:);
       currentRayDirection = localRayData(2,:);
       if polarized
            currentRayPolarizationVector = localRayData(3,:);
       end
        % Path length calculation
       surfaceType = optSystem.SurfaceArray(surfaceIndex).Type;
       surfaceRadius = optSystem.SurfaceArray(surfaceIndex).Radius;
       surfaceConic = optSystem.SurfaceArray(surfaceIndex).ConicConstant;
      
       refractiveIndexBefore = optSystem.SurfaceArray(surfaceIndex-1).Glass. ...
           getRefractiveIndex(wavlen); 
       
        rayInitialPosition = currentRayPosition;
        rayDirection = currentRayDirection;
        
        [geometricalPathLength, opticalPathLength,NoIntersectionPoint] = computePathLength ...
            (rayInitialPosition,rayDirection,surfaceType,surfaceRadius,...
            surfaceConic,refractiveIndexBefore);  % 2nd function
        polarizedRayTracerResult.NoIntersectionPoint = NoIntersectionPoint;
        
        if NoIntersectionPoint            
             % code to say no intersection point found and no path calculated
             disp('No Intersection Point: The ray does not intersect the surface');
            return;
        end

        % compute current accumulated phase
        accumulatedPhase = computeAccumulatedPhase(geometricalPathLength,wavlen);
        
        % add current phase to exsisting total phase 
        totalPhase = totalPhase + accumulatedPhase;

        apertureType = optSystem.SurfaceArray(surfaceIndex).ApertureType;
        apertureParam = optSystem.SurfaceArray(surfaceIndex).ApertureParameter;

        [localIntersectionPoint,outOfAperture] = computeIntersectionPoint(rayInitialPosition,...
            rayDirection, geometricalPathLength,apertureType,apertureParam); % 3rd function
        polarizedRayTracerResult.OutOfAperture = outOfAperture;
        if outOfAperture
            % Intersection point out of surface aperture                      
            disp('Vignated Ray: The intersection point is outside the surface aperture area.');
            % let it continue tracing the ray enventhough vignated
            % return;
        end
        currentRayPosition = localIntersectionPoint;
        if polarized
            % phase advancement  
            % Zemax method, just multiply the real part by cos(phase) and imaginary
            % by sin(phase)
            [pc,ps] = computePhasePropagationFactors(geometricalPathLength,wavlen);
            currentRayPolarizationVector = (currentRayPolarizationVector)*(pc + 1i *ps);   
            % record resulting polarization vector just before coating
            recordRayPolVectorBeforeCoating(surfaceIndex,:) = currentRayPolarizationVector;
        end
        % Compute Reflection and Refraction by solving Snells law in 3D    
        surfaceType = optSystem.SurfaceArray(surfaceIndex).Type;
        surfaceRadius = optSystem.SurfaceArray(surfaceIndex).Radius;
        surfaceConic = optSystem.SurfaceArray(surfaceIndex).ConicConstant;
        localSurfaceNormal = computeSurfaceNormal(localIntersectionPoint,...
            surfaceType,surfaceRadius,surfaceConic); % 4th function
        
        % If the thickness is Negative => Mirrored Z axis => the Z
        % compinent of the normal vector shall be in -ve direction
        % and x and y 
        localSurfaceNormal = sign(prevThickness)*localSurfaceNormal;               
        localIncidentRayDirection = currentRayDirection;
        localIncidenceAngle = computeIncidenceAngle (localIncidentRayDirection,...
            localSurfaceNormal); % 5th function
        if surfaceIndex < nSurface                
           indexBefore = optSystem.SurfaceArray(surfaceIndex-1).Glass. ...
               getRefractiveIndex(wavlen);    
           indexAfter =  optSystem.SurfaceArray(surfaceIndex).Glass. ...
               getRefractiveIndex(wavlen);  
           if polarized
                coatingType = optSystem.SurfaceArray(surfaceIndex).Coating.Type;
           end
           Kqm1 = localIncidentRayDirection;
           if strcmp(optSystem.SurfaceArray(surfaceIndex).DeviationMode,...
                    '-1 Reflective') % reflection  
                localReflectedRayDirection = computeReflectedRayDirection ...
                    (localIncidentRayDirection,localSurfaceNormal); % 6th function
                localReflectedRayAngle = localIncidenceAngle;
            
                % direction of reflected ray           
                currentRayDirection = localReflectedRayDirection;
                localExitRayDirection = localReflectedRayDirection;
                localExitAngle = localReflectedRayAngle;
                Kq = currentRayDirection;
                if polarized
                    % jones matrix   
                    [ampRs,ampRp,powRs,powRp]=...
                        optSystem.SurfaceArray(surfaceIndex).Coating. ...
                        getReflectionCoefficients(wavlen,localIncidenceAngle,...
                        indexBefore,indexAfter); 
                     jonesMatrix = [ampRs,0;0,ampRp];
                end
            elseif  strcmp(optSystem.SurfaceArray(surfaceIndex).DeviationMode,...
                    '+1 Refractive')% refraction
                [localTransmittedRayDirection,TIR] = computeRefractedRayDirection ...
                    (localIncidentRayDirection,localSurfaceNormal,indexBefore,indexAfter); % 7th function

                localTransmittedRayAngle =  acos(compute3dDot(localTransmittedRayDirection,...
                    localSurfaceNormal));
                polarizedRayTracerResult.TotalInternalReflection = TIR;
                if TIR                     
                     disp('Error: Total internal reflection\n');
                     break;
                end            
                currentRayDirection = localTransmittedRayDirection;
                localExitRayDirection = localTransmittedRayDirection;
                localExitAngle = localTransmittedRayAngle;
                Kq = currentRayDirection; 
                if polarized
                    % new code
                    [ampTs,ampTp,powTs,powTp,JMCoating] = ...
                        optSystem.SurfaceArray(surfaceIndex).Coating. ...
                        getTransmissionCoefficients(wavlen,localIncidenceAngle,...
                         indexBefore,indexAfter);  
                     jonesMatrix = [ampTs,0;0,ampTp];
                end            
            else
                disp('Surface must be either reflective or refractive');
            end 
            % compute the new P matrix
%            if JMCoating
%                 % ideal coating defined by given jones matrix
%                 Pxx = jonesMatrix(1,1); Pyy = jonesMatrix(2,2);
%                 kx = Kq(1); ky = Kq(2);kz = Kq(3);
%                 ex = currentRayPolarizationVector(1); ey = currentRayPolarizationVector(2); 
%                 P = [Pxx,0,0;0,Pyy,0;0,0,-(Pxx*ex*kx+Pyy*ey*ky)/kz];           
%            else
%                 P = convertJonesMatrixToPolarizationMatrix(jonesMatrix,Kqm1,Kq);
%            end 
            if polarized
                P = convertJonesMatrixToPolarizationMatrix(jonesMatrix,Kqm1,Kq);
                coatingJonesMatrix = jonesMatrix;            
                coatingPMatrix = P;
                % compute the total P matrix
                totalPMatrix = P*totalPMatrix;
                % compute new Polarization vector
                newLocalPolarizationVector = (P*(currentRayPolarizationVector)')';
                currentRayPolarizationVector = newLocalPolarizationVector;
                % compute the parallel ray transport matrix Q
                qJonesMatrix = [1,0;0,1];   % unity jones matrix for non polarizing element
                Q = convertJonesMatrixToPolarizationMatrix(qJonesMatrix,Kqm1,Kq);
                coatingQMatrix = Q;            
                % compute the total Q matrix        
                totalQMatrix = Q*totalQMatrix;
            end
        elseif surfaceIndex==nSurface 
            % for image surface no refraction
            localExitRayDirection  = [NaN,NaN,NaN];
            localExitAngle = NaN; 
            if polarized
                jonesMatrix = NaN*eye(2);
                P = NaN*eye(3);
                Q = NaN*eye(3);

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
           localRayData = [localRayPosition;localRayDirection;localRayPolarizationVector];
       else
           localRayData = [localRayPosition;localRayDirection];          
       end
       
       %% New Code for Global to Local Coordinate transformation
       [globalRayData,globalSurfaceNormal,globalIncidentRayDirection,...
           globalExitRayDirection] = localToGlobalCoordinate(localRayData,...
           polarized,localSurfaceNormal,localIncidentRayDirection,...
           localExitRayDirection,surfaceCoordinateTM,referenceCoordinateTM); 

       %% End of New code       
       
       % now the currnt ray becomes global ray agin
       currentRayPosition = globalRayData(1,:);
       currentRayDirection = globalRayData(2,:);
       if polarized
            currentRayPolarizationVector = globalRayData(3,:);
       end
       globalIncidenceAngle = localIncidenceAngle;
       globalExitAngle = localExitAngle;

        %Record all neccessary outputs to trace the ray 
        recordRayIntersectionPoint(surfaceIndex,:) = currentRayPosition;

        recordIncidentRayDirection(surfaceIndex,:) = globalIncidentRayDirection;
        recordExitRayDirection(surfaceIndex,:) = globalExitRayDirection;

        recordIncidenceAngle(surfaceIndex,:) = globalIncidenceAngle;
        recordExitAngle(surfaceIndex,:) = globalExitAngle;

        recordSurfaceNormal(surfaceIndex,:) = globalSurfaceNormal;
        recordPathLength(surfaceIndex,:) = geometricalPathLength;
        if polarized
            recordRayPolVectorAfterCoating(surfaceIndex,:) = currentRayPolarizationVector; 

            recordTotalPMatrix(:,:,surfaceIndex) = totalPMatrix;
            recordTotalQMatrix(:,:,surfaceIndex) = totalQMatrix;

            recordCoatingJonesMatrix(:,:,surfaceIndex) = coatingJonesMatrix;
            recordCoatingPMatrix(:,:,surfaceIndex) = coatingPMatrix;
            recordCoatingQMatrix(:,:,surfaceIndex) = coatingQMatrix;        

           % compute and record Diattenuation
            diattenuation = computeDiattenuation(P);
            recordDiattenuation(surfaceIndex,:) = diattenuation;

           % compute and record proper retardance
            retardance = computeProperRetardance(P,Q);
            recordRetardance(surfaceIndex,:) = retardance;
        end
    end
    polarizedRayTracerResult.RayIntersectionPoint = recordRayIntersectionPoint;
    polarizedRayTracerResult.IncidentRayDirection = recordIncidentRayDirection;
    polarizedRayTracerResult.ExitRayDirection = recordExitRayDirection;
    
    polarizedRayTracerResult.SurfaceNormal = recordSurfaceNormal;
    polarizedRayTracerResult.IncidenceAngle = recordIncidenceAngle*180/(pi);
    polarizedRayTracerResult.ExitAngle = recordExitAngle*180/(pi);
    
    polarizedRayTracerResult.PathLength = recordPathLength;
    if polarized
        polarizedRayTracerResult.PolarizationVectorInitial = recordRayPolVectorInitial;
        polarizedRayTracerResult.PolarizationVectorBeforeCoating = recordRayPolVectorBeforeCoating;
        polarizedRayTracerResult.PolarizationVectorAfterCoating = recordRayPolVectorAfterCoating;

         polarizedRayTracerResult.Diattenuation = recordDiattenuation;
         polarizedRayTracerResult.Retardance = recordRetardance;

         polarizedRayTracerResult.TotalPMatrix = recordTotalPMatrix;
         polarizedRayTracerResult.TotalQMatrix = recordTotalQMatrix;

         polarizedRayTracerResult.CoatingJonesMatrix = recordCoatingJonesMatrix;
         polarizedRayTracerResult.CoatingPMatrix = recordCoatingPMatrix;
         polarizedRayTracerResult.CoatingQMatrix = recordCoatingQMatrix;
    else
        polarizedRayTracerResult.PolarizationVectorInitial = NaN*[1:3];
        polarizedRayTracerResult.PolarizationVectorBeforeCoating = NaN*[1:3];
        polarizedRayTracerResult.PolarizationVectorAfterCoating = NaN*[1:3];

         polarizedRayTracerResult.Diattenuation = NaN;
         polarizedRayTracerResult.Retardance = NaN;

         polarizedRayTracerResult.TotalPMatrix = NaN*eye(3);
         polarizedRayTracerResult.TotalQMatrix = NaN*eye(3);

         polarizedRayTracerResult.CoatingJonesMatrix = NaN*eye(2);
         polarizedRayTracerResult.CoatingPMatrix = NaN*eye(3);
         polarizedRayTracerResult.CoatingQMatrix = NaN*eye(3);        
    end
end