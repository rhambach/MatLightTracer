function updatedOpticalSystem = setFloatingApertures( currentOpticalSystem )
    % setFloatingApertures: Computes and sets the apertures values of
    % floating apertures of each surface by tracing cheif ray + top and bottom
    % mariginal rays of each field and each wavelength and taking the maximum
    % radial interesection of the rays with the surfaces.
    
    updatedOpticalSystem = currentOpticalSystem;
    if (isfield(currentOpticalSystem,'IsUpdatedSurfaceArray') && ...
            currentOpticalSystem.IsUpdatedSurfaceArray)|| ...
            IsComponentBased(currentOpticalSystem) 
        return;
    end
 
    nField = getNumberOfFieldPoints(updatedOpticalSystem);
    nSurf = getNumberOfSurfaces(updatedOpticalSystem);
    nWav = getNumberOfWavelengths(updatedOpticalSystem);
    
    fieldPointMatrix = updatedOpticalSystem.FieldPointMatrix;
    fieldPointXY = (fieldPointMatrix(:,1:2))';
    wavelengthMatrix = updatedOpticalSystem.WavelengthMatrix;
    wavLenInM = (wavelengthMatrix(:,1))'*getWavelengthUnitFactor(updatedOpticalSystem);
    
    % Repeat wavelegths for each field point and vice versa
    fieldPointXYAll = repmat(fieldPointXY,[1,nWav]);
    wavLenAll = cell2mat(arrayfun(@(x) x*ones(1,nField),wavLenInM,'UniformOutput',false));
        
    angleFromYinRad1 = 0;
    angleFromYinRad2 = pi;
    % Ignore current apertures in the computation of flaoting
    rayTraceOptionStruct = RayTraceOptionStruct( );
    rayTraceOptionStruct.ConsiderSurfAperture = 0;
    rayTraceOptionStruct.RecordIntermediateResults = 1;
    
    topMariginalRayTraceResult = traceMariginalRay(updatedOpticalSystem,...
        fieldPointXYAll,wavLenAll,angleFromYinRad1,rayTraceOptionStruct);
    bottomMariginalRayTraceResult = traceMariginalRay(updatedOpticalSystem,...
        fieldPointXYAll,wavLenAll,angleFromYinRad2,rayTraceOptionStruct);
    cheifRayTraceResult = traceChiefRay(updatedOpticalSystem,...
        fieldPointXYAll,wavLenAll,rayTraceOptionStruct);
    
    for kk = 1:nSurf
        currentSurface = updatedOpticalSystem.SurfaceArray(kk);
        if strcmpi(currentSurface.Aperture.Type,'FloatingCircularAperture')
        topMariginalIntersection = [topMariginalRayTraceResult(kk).RayIntersectionPoint];
        bottomMariginalIntersection = [bottomMariginalRayTraceResult(kk).RayIntersectionPoint];
        cheifRayIntersection = [cheifRayTraceResult(kk).RayIntersectionPoint];
        
        surfaceVertex = updatedOpticalSystem.SurfaceArray(kk).SurfaceCoordinateTM(1:3,4);
        
        vertexToTopMariginal = (topMariginalIntersection - repmat(surfaceVertex,[1,nField*nWav]));
        vertexToTopMariginalDist = computeNormOfMatrix(vertexToTopMariginal,1);
        vertexToBottomMariginal = (bottomMariginalIntersection - repmat(surfaceVertex,[1,nField*nWav]));
        vertexToBottomMariginalDist = computeNormOfMatrix(vertexToBottomMariginal,1);
        
        vertexTocheifRay = (cheifRayIntersection - repmat(surfaceVertex,[1,nField*nWav]));
        vertexTocheifRayDist = computeNormOfMatrix(vertexTocheifRay,1);

        maxRadToTopMariginalRay = max(vertexToTopMariginalDist);
        maxRadToBottomMariginalRay = max(vertexToBottomMariginalDist);
        
        maxRadTocheifRay = max(vertexTocheifRayDist);
        
        maxRadToMariginal_CheifRay = max([maxRadToTopMariginalRay,...
            maxRadToBottomMariginalRay,maxRadTocheifRay]);
        
        floatingApertureDiameter = 2*maxRadToMariginal_CheifRay;
        
        updatedOpticalSystem.SurfaceArray(kk).Aperture.UniqueParameters.Diameter = ...
            floatingApertureDiameter;
        end
    end
end

