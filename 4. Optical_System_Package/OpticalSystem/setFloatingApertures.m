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
    [ nonDummySurfaceIndices] = getNonDummySurfaceIndices( updatedOpticalSystem );
    nNonDummySurf = length(nonDummySurfaceIndices);
    nWav = getNumberOfWavelengths(updatedOpticalSystem);
    
    fieldPointMatrix = updatedOpticalSystem.FieldPointMatrix;
    if updatedOpticalSystem.FieldType == 1
        fieldPointXYInSI = (fieldPointMatrix(:,1:2))'*getLensUnitFactor(updatedOpticalSystem);
    else
        fieldPointXYInSI = (fieldPointMatrix(:,1:2))';
    end
    wavelengthMatrix = updatedOpticalSystem.WavelengthMatrix;
    wavLenInM = (wavelengthMatrix(:,1))'*getWavelengthUnitFactor(updatedOpticalSystem);
    
    % Repeat wavelegths for each field point and vice versa
    fieldPointXYAll = repmat(fieldPointXYInSI,[1,nWav]);
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
    nMarginalRayUsed = 1;
    
    
    for kk = 1:nNonDummySurf
        surfIndex = nonDummySurfaceIndices(kk);
        currentSurface = updatedOpticalSystem.SurfaceArray(surfIndex);
        if strcmpi(currentSurface.Aperture.Type,'FloatingCircularAperture')
            topMariginalIntersection = [topMariginalRayTraceResult(kk).RayIntersectionPoint];
            bottomMariginalIntersection = [bottomMariginalRayTraceResult(kk).RayIntersectionPoint];
            cheifRayIntersection = [cheifRayTraceResult(kk).RayIntersectionPoint];
            
            % If the mariginal rays fail to intersect, then trace N other
            % rays in the tangential plane and take the farthest one
            % intersecting the surface
            if (isnan(topMariginalIntersection)|isnan(bottomMariginalIntersection)) & ...
                    (nMarginalRayUsed == 1)
                N = 100;
                topMariginalRayTraceResult = traceMariginalRay(updatedOpticalSystem,...
                    fieldPointXYAll,wavLenAll,angleFromYinRad1,rayTraceOptionStruct,N);
                bottomMariginalRayTraceResult = traceMariginalRay(updatedOpticalSystem,...
                    fieldPointXYAll,wavLenAll,angleFromYinRad2,rayTraceOptionStruct,N);
                nMarginalRayUsed = N;
                
                topMariginalIntersection = [topMariginalRayTraceResult(kk).RayIntersectionPoint];
                bottomMariginalIntersection = [bottomMariginalRayTraceResult(kk).RayIntersectionPoint];
            end
            
            surfaceVertex = updatedOpticalSystem.SurfaceArray(kk).SurfaceCoordinateTM(1:3,4);
            vertexToTopMariginal = (topMariginalIntersection(1:2,:) - repmat(repmat(surfaceVertex(1:2,:),[1,nField*nWav]),[1,nMarginalRayUsed]));
            vertexToTopMariginalHeight = computeNormOfMatrix(vertexToTopMariginal,1);
            vertexToBottomMariginal = (bottomMariginalIntersection(1:2,:) - repmat(repmat(surfaceVertex(1:2,:),[1,nField*nWav]),[1,nMarginalRayUsed]));
            vertexToBottomMariginalDist = computeNormOfMatrix(vertexToBottomMariginal,1);
            
            % If multiple rays are traced then failing rays will have
            % complex distance so remove those values
            vertexToTopMariginalHeight(imag(vertexToTopMariginalHeight)~=0) = [];
            vertexToBottomMariginalDist(imag(vertexToBottomMariginalDist)~=0) = [];
            
            vertexTocheifRay = (cheifRayIntersection - repmat(surfaceVertex,[1,nField*nWav]));
            vertexTocheifRayDist = computeNormOfMatrix(vertexTocheifRay,1);
            
            maxRadToTopMariginalRay = max(vertexToTopMariginalHeight);
            maxRadToBottomMariginalRay = max(vertexToBottomMariginalDist);
            
            maxRadTocheifRay = max(vertexTocheifRayDist);
            
            maxRadToMariginal_CheifRay = max([maxRadToTopMariginalRay,...
                maxRadToBottomMariginalRay,maxRadTocheifRay]);
            
            floatingApertureDiameter = 2*maxRadToMariginal_CheifRay;
            
            updatedOpticalSystem.SurfaceArray(surfIndex).Aperture.UniqueParameters.Diameter = ...
                floatingApertureDiameter;
        end
    end
end

