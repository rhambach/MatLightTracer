function [multipleRayTracerResult,pupilCoordinates,pupilGridIndices] = multipleRayTracer(optSystem,wavLen,...
        fieldPoint,numberOfRays,PupSamplingType,JonesVec)
    % trace bundle of rays 
    % NB. multipleRayTracerResult: (rayIndex, SurfIndex)
    tic
    pupilRadius = (optSystem.getEntrancePupilDiameter)/2;
    pupilZLocation = (optSystem.getEntrancePupilLocation);
    PupSampling = PupSamplingType; 

    global INF_OBJ_Z;
    if abs(optSystem.SurfaceArray(1).Thickness) > 10^10 %object at infinity
        objThick = INF_OBJ_Z;
    else
        objThick  = optSystem.SurfaceArray(1).Thickness;
    end
    % Global reference is the 1st surface of the lens
    fieldPoint = [fieldPoint, -objThick];
    [ pupilSamplingPoints,pupilGridIndices ] = computePupilSamplingPoints(numberOfRays,...
        pupilZLocation,pupilRadius,PupSampling,objThick);

    if abs(optSystem.SurfaceArray(1).Thickness) > 10^10 
        %object at infinity and the field point is angle in degree 

        % Feild points are given by angles
        angX = fieldPoint(1)*pi/180;
        angY = fieldPoint(2)*pi/180;                

        %convert field angle to ray direction as in Zemax
        dz = sqrt(1/((tan (angX))^2+(tan (angY))^2+1));
        dx = dz*tan (angX);
        dy = dz*tan (angY);    

        commonRayDirectionCosine = [dx,dy,dz];
        [ initialRayBundlePositions ] = computeInitialRayBundlePositions(...
            commonRayDirectionCosine,pupilSamplingPoints,pupilZLocation,objThick);
        nRay = size(initialRayBundlePositions);
        nRay = nRay(1);
        initialRayBundleDirections =  repmat(commonRayDirectionCosine,nRay,1);    
    else
        [ initialRayBundleDirections ] = computeInitialRayBundleDirections...
        (fieldPoint,pupilSamplingPoints);
        nRay=size(initialRayBundleDirections);
        nRay = nRay(1);
        initialRayBundlePositions =  repmat(fieldPoint,nRay,1);
    end

    if isnan(JonesVec(1))
        pol = 0;
    else
        pol = 1;
    end
    % initialize the intial ray bundle array
    initialRayBundle(1,1:nRay) = Ray;
    for ri = 1:1:nRay                
        initialRayBundle(ri).Position = initialRayBundlePositions(ri,:);
        initialRayBundle(ri).Direction = initialRayBundleDirections(ri,:);

        initialRayBundle(ri).JonesVector = JonesVec;
        initialRayBundle(ri).Polarized = pol;
        initialRayBundle(ri).Wavelength = wavLen;
    end
    %===============RAYTRACE For Bundle of Ray========================

    % initialize ray trace result array
    polarizedRayTracerResult(1,nRay) = RayTraceResult;
    for rayIndex = 1:1:nRay    
        rayTraceResult = optSystem.tracePolarizedRay(initialRayBundle(rayIndex));
        if rayTraceResult.NoIntersectionPoint || rayTraceResult.TotalInternalReflection
            continue;
        end
        polarizedRayTracerResult(rayIndex) = rayTraceResult;
    end
    multipleRayTracerResult = polarizedRayTracerResult;
    pupilCoordinates = pupilSamplingPoints;
    pupilGridIndices = (pupilGridIndices);
    timeElapsed =  toc;
    disp(['Bundle of Ray Traced. Polarized Trace = ',num2str(pol), ...
        ', Total Number of Rays = ', num2str(nRay), ', Time Elapsed = ', num2str(timeElapsed)]); 
end  