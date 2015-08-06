function [stopIndex, specified,surfaceArray, nSurface] = getStopSurfaceIndex(optSystem)
    % getStopIndex: gives the stop index surface set by user
    stopIndex = 0;
    specified = 0;
    [nSurface, surfaceArray ] = getNumberOfSurfaces(optSystem);
    for kk=1:1:nSurface
        curentSurf = surfaceArray(kk);
        if curentSurf.Stop
            stopIndex = kk;
            specified = 1;
            return;
        end
    end
    
    specified = 0;
    
    if stopIndex == 0
        % If stop index not given by user then compute it
        nSurf = getNumberOfSurfaces(optSystem);
        refIndex = zeros(1,nSurf);
        thick = zeros(1,nSurf);
        curv = zeros(1,nSurf);
        clearAperture = zeros(1,nSurf);
        
        for kk=1:1:nSurf
            currentSurf = getSurfaceArray(optSystem,kk);
            refIndex(kk) = getRefractiveIndex(currentSurf.Glass,optSystem.PrimaryWavelengthIndex);
            thick(kk) = currentSurf.Thickness;
            try
                curv(kk) = 1/(currentSurf.OtherStandardData.Radius);
            catch
                % If the surface doesn't have Radius data then consider as
                % plane
                curv(kk) = 0;
            end
            
            % clearAperture(kk) = optSystem.getSurfaceArray(kk).getClearAperture;
            [ minApertureRadius ] = getMinimumApertureRadius( currentSurf.Aperture );
            clearAperture(kk) = minApertureRadius;
        end
        
        % For -ve thickness refindex should also be negative
        refIndex = refIndex.*sign(thick);
        % Replace zero index with 1 to avoid division by zero
        refIndex(refIndex==0) = 1;
        
        if abs(thick(1))>10^10
            thick(1)=10^10;
            obj = 'I';
        else
            obj = 'F';
        end
        if optSystem.ImageAfocal
            img = 'I';
        else
            img = 'F';
        end
        obj_img = [obj,img];
        
        [ stopIndex] = computeSystemStopIndex...
            (stopIndex,refIndex,thick,curv,clearAperture,obj_img);
    end
end