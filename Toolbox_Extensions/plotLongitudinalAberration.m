function [ success ] = plotLongitudinalAberration(opticalSystem)
    %PLOTLONGITUDINALABERRATION Plots the longitudinal aberration of the
    %optical system.
    
    % User inputs the wavelength indices and number of ray
    wavIndices_nRay = inputdlg({'Wavelength Index (0 for All)',...
        'Number of Rays',},...
        'Wavelength Index and Number of Rays',1,{'0','100'});
    if ~(isempty(wavIndices_nRay)||...
            isempty(wavIndices_nRay{1})||...
            isempty(wavIndices_nRay{2}))
        
        wavLenIndex = str2double(wavIndices_nRay{1});
        nRay = str2double(wavIndices_nRay{2});
        
        nWavelength = getNumberOfWavelengths(opticalSystem);
        if isnan(nRay)||isnan(wavLenIndex) || ...
                nRay < 1 || wavLenIndex < 0 || wavLenIndex > nWavelength
            disp('Error: All Input should be numeric and valid');
            success = 0;
            return;
        end
    else
        disp('Error: Invalid Input.');
        success = 0;
        return;
    end
    
    
    fieldPointXY = [0;0];
    wavelengthMatrix = opticalSystem.WavelengthMatrix;
    if wavLenIndex == 0
        wavLen = (wavelengthMatrix(:,1))';
    else
        wavLen = wavelengthMatrix(wavLenIndex,1);
    end
    
    nWav = size(wavLen,2);
    nField = size(fieldPointXY,2);
    % trace the tangntial rays
    % polarizedRayTracerResult =  nSurf X nRay X nField X nWav
    % pupil sampling = 5: Tangential Plane
    PupSamplingType = 'Tangential';
    
    endSurface = getNumberOfSurfaces(opticalSystem);
    rayTraceOptionStruct = RayTraceOptionStruct();
    rayTraceOptionStruct.ConsiderPolarization = 0;
    rayTraceOptionStruct.ConsiderSurfAperture = 1;
    rayTraceOptionStruct.RecordIntermediateResults = 0;
    
    [tangentialRayTracerResult] = multipleRayTracer(opticalSystem,wavLen,...
        fieldPointXY,1,nRay,PupSamplingType,rayTraceOptionStruct,endSurface);
    
    % Assign different symbals and colors for lines of d/t wavelengths
    availablelineColor = repmat(['b','k','r','g','c','m','y'],1,20); % 7*20 = 140
    lineColorList = availablelineColor(1:nWav*nField);
    
    % All raytracing are done with out recording intermediate results so the
    % index of last surface will be 2
    rayTraceResultIndexOfLastSurface = 2;
    
    fieldIndex = 1;
    figure;
    for wavIndex = 1:nWav
        tangentialFanIntersectionPoints = getAllSurfaceRayIntersectionPoint(...
            tangentialRayTracerResult(rayTraceResultIndexOfLastSurface),0,fieldIndex,wavIndex);
        
        tangentialFanFinalDirections = getAllSurfaceIncidentRayDirection(...
            tangentialRayTracerResult(rayTraceResultIndexOfLastSurface),0,fieldIndex,wavIndex);
        
        opticalAxisIntersectionZ = (tangentialFanIntersectionPoints(2,:))./...
            (-tan(acos(tangentialFanFinalDirections(3,:))));
        % NaN will result for rays alogn the axis so take the value of the
        % immediate upper field point in this case
        opticalAxisIntersectionZ(find(isnan(opticalAxisIntersectionZ))) = ...
            opticalAxisIntersectionZ(find(isnan(opticalAxisIntersectionZ))-1);
        
        xAxisPoints = opticalAxisIntersectionZ;
        yAxisPoints = linspace(1,-1,size(opticalAxisIntersectionZ,2));
        
        % Only take the upper part of the enterance pupil
        xAxisPointsUpper = xAxisPoints(yAxisPoints >= 0);
        yAxisPointsUpper = yAxisPoints(yAxisPoints >= 0);
        legendText{wavIndex} = [' Wav: ',num2str(wavLen(wavIndex))];
        
        currentLineColor = lineColorList(wavIndex);
        plot(xAxisPointsUpper,yAxisPointsUpper,currentLineColor);
        grid on;
        hold on;
    end
%     axis equal;
    xlabel('\Delta Z (m)','FontSize',12);
    ylabel('PY (Normalized)','FontSize',12);
    legend(legendText)
    title('Logitudinal Aberration');
    success = 1;
end

