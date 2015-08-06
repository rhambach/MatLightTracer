% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensPolarizationTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);

%% Single Ray Trace
% Initial Ray
objectRay = Ray();
objectRay.Position = [0;1;-OS.SurfaceArray(1).Thickness];
objectRay.Direction = [0.0000000000; -0.0995037190; 0.9950371902];
objectRay.Polarized = 1;
%objectRay.JonesVector = [1*exp(1i*10*pi/180);2*exp(1i*20*pi/180)];
objectRay.JonesVector = [NaN;NaN];
objectRay.Wavelength = OS.WavelengthMatrix(OS.PrimaryWavelengthIndex);

rb(1:1) = objectRay;

% Polarized RayTrace
tic
polarizedRayTracerResult1 = OS.tracePolarizedRay(rb);
toc
polarizedRayTracerResult = polarizedRayTracerResult1(:,1);
%% Display the polarization ellipse parameters after each surface
format long;
if isempty(polarizedRayTracerResult)
    msgbox 'Ray trace failed. Look the command window for detail error.';
else
     if objectRay.Polarized
        surfIndex = OS.NumberOfSurfaces;
        for kk=1:1:surfIndex
            [ellBeforeCoating,ellAfterCoating] = polarizedRayTracerResult(kk). ...
                getPolarizationEllipseParameters;
            disp(['Ellipse Parameters after Surf : ',num2str(kk)]);
            Ellipicity = ellAfterCoating(2)/ellAfterCoating(1)        
            Orientation = ellAfterCoating(4)
            disp(['Rotation (1 CW/-1 CCW) = ',num2str(ellAfterCoating(3))]);
            disp('----------------------------------------------------------');
            disp('----------------------------------------------------------');
        end
     end
    
    %% Display the layout diagram with the ray
    figure;
    axesHandle=axes;
    
    if ~isempty(polarizedRayTracerResult)
        % rayPathMatrix = [x1 y1 z1;x2 y2 z2; ...]
         rayPathMatrix(:,:,1) = [polarizedRayTracerResult.RayIntersectionPoint];    
    end
    if objectRay.Position(1) == 0 && objectRay.Direction (1) == 0 % the ray is meridional ray and so show 2D layout
         OS.plot2DLayout(rayPathMatrix,axesHandle);
    end
    figure;
    axesHandle=axes;
    OS.plot3DLayout(rayPathMatrix,axesHandle);    
end
