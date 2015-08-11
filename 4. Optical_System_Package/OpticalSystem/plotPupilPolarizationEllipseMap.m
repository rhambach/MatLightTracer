function drawn = plotPupilPolarizationEllipseMap(optSystem,surfIndex,...
        wavLen,fieldPointXY,sampleGridSize,jonesVector,coordinate,plotPanelHandle)
    % Plot polarization ellipse map in the pupil of the system for given
    % input polarization states. NB. initialPolVector is defined in the global
    % xyz coordinate of the opt system
    % As Jones vector represent only globally polarized light (fully polarized).
    % Locally polarized (partially polarized) light can not be used here.
    
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
    % Jan 21,2014   Worku, Norman G.     Vectorized version
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    % Default Inputs
    if nargin < 6
        disp('Error: The function requires atleast 6 arguments, optSystem,',...
            ' surfIndex, wavLen, fieldPointXY, sampleGridSize and polVector');
        return;
    elseif nargin == 6
        plotPanelHandle = uipanel('Parent',figure('Name','Pupil Polarization Ellipse Map'),...
            'Units','normalized','Position',[0,0,1,1]);
    end
    
    %     cla(axesHandle,'reset')
    nSurf = getNumberOfSurfaces(optSystem);
    PupSamplingType = 'Cartesian';
    numberOfRays = sampleGridSize^2;
    endSurface = surfIndex;
    rayTraceOptionStruct = RayTraceOptionStruct();
    rayTraceOptionStruct.ConsiderPolarization = 1;
    rayTraceOptionStruct.ConsiderSurfAperture = 1;
    rayTraceOptionStruct.RecordIntermediateResults = 0;
    rayTraceOptionStruct.ComputeOpticalPathLength = 1;
    
    [polarizedRayTracerResult,pupilMeshGrid,outsidePupilIndices] = multipleRayTracer(optSystem,wavLen,...
        fieldPointXY,sampleGridSize,sampleGridSize,PupSamplingType,rayTraceOptionStruct,endSurface);%
        
    nRay = polarizedRayTracerResult.TotalNumberOfPupilPoints;
    nField = polarizedRayTracerResult.TotalNumberOfFieldPoints;
    nWav = polarizedRayTracerResult.TotalNumberOfWavelengths;

    % Take the ray trace result at surface 1 and last surface : surfIndex
    rayTracerResultFirstSurf = polarizedRayTracerResult(1);
    rayTracerResultLastSurf = polarizedRayTracerResult(2);
    
    % Spatial Distribution of Polarization Ellipse in a given surface
    entrancePupilRadius = (getEntrancePupilDiameter(optSystem))/2;
    
    % Convert the Jones vector to the polarizationVector in
    % XYZ global coordinate
    rayDirection = [rayTracerResultFirstSurf.ExitRayDirection];
    if strcmpi(coordinate,'SP')
        jonesVectorSP = (jonesVector);
        initialPolVectorXYZ = convertJVToPolVector...
            (jonesVectorSP,rayDirection);
    elseif strcmpi(coordinate,'XY')
        % From dispersion relation the Z component of field can be
        % computed from the x and y components in linear
        % isotropic media+
        kx = rayDirection(1,:);
        ky = rayDirection(2,:);
        kz = rayDirection(3,:);
        
        if size(jonesVector,2) == 1
            jonesVector = jonesVector*ones(1,nRay);
        end
        fieldEx = jonesVector(1,:);
        fieldEy = jonesVector(2,:);
        
        fieldEz = - (kx.*fieldEx + ky.*fieldEy)./(kz);
        
        initialPolVectorXYZ = [fieldEx;fieldEy;fieldEz];
    else
        
    end
    
    [ finalPolarizationVector ] = computeFinalPolarizationVector(...
        rayTracerResultLastSurf,initialPolVectorXYZ, wavLen);
    
    ellipseParametersAfterSurface = computeEllipseParameters...
        ( finalPolarizationVector);
    
    % Plot ellipse
    wavIndex = 1;
    fieldIndex = 1;
    subplotPanel = uipanel('Parent',plotPanelHandle,...
        'Units','Normalized',...
        'Position',[(wavIndex-1)/nWav,(nField-fieldIndex)/nField,...
        min([1/nWav,1/nField]),min([1/nWav,1/nField])],...
        'Title',['WaveLen Index : ', num2str(wavIndex),...
        ' & Field Index : ',num2str(fieldIndex)]);
    subplotAxes = axes('Parent',subplotPanel,...
        'Units','Normalized',...
        'Position',[0,0,1,1]);
    
    a = ellipseParametersAfterSurface(1,:);
    b = ellipseParametersAfterSurface(2,:);
    direction = ellipseParametersAfterSurface(3,:);
    phi = ellipseParametersAfterSurface(4,:);
    
    % center coordinates
    centerX = pupilMeshGrid(:,:,1);
    centerY = pupilMeshGrid(:,:,2);
    centerXLinear = centerX(:);
    centerYLinear = centerY(:);
    % Remove those coordinates outside aperture
    centerXLinear(outsidePupilIndices) = [];
    centerYLinear(outsidePupilIndices) = [];
    % normalize to pupil radius
    cx = (centerXLinear)'*sampleGridSize./entrancePupilRadius;
    cy = (centerYLinear)'*sampleGridSize./entrancePupilRadius;
    plot_ellipse(subplotAxes,a,b,cx,cy,phi,direction);
    
    set(gcf,'Name',['Pupil Polarization Ellipse Map at surface : ',num2str(surfIndex)]);
    drawn = 1;
    % axis equal;
