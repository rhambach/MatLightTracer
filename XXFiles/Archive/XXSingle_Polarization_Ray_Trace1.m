% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);

%% Single Ray Trace
% Initial Ray
objectRay = Ray();
objectRay.Position = [0,1,-OS.SurfaceArray(1).Thickness];
objectRay.Direction = [0.0000000000, -0.0995037190, 0.9950371902];
objectRay.Polarized = 1;
objectRay.JonesVector = [1,10*pi/180;2,20*pi/180];
objectRay.Wavelength = OS.WavelengthMatrix(OS.PrimaryWavelengthIndex);

% Polarized RayTrace
tic
polarizedRayTracerResult = OS.tracePolarizedRay(objectRay);
toc

%% Display the polarization ellipse parameters after each surface
format long;
if isempty(polarizedRayTracerResult)
    msgbox 'Ray trace failed. Look the command window for detail error.';
else
     if objectRay.Polarized
        surfIndex = OS.NumberOfSurface;
        for kk=1:1:surfIndex
            [ellBeforeCoating,ellAfterCoating] = polarizedRayTracerResult. ...
                getPolarizationEllipseParameters(kk);
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
    if ~isempty(polarizedRayTracerResult.RayIntersectionPoint)
        rayPathMatrix(:,:,1) = polarizedRayTracerResult.RayIntersectionPoint;    
    end
    if objectRay.Position(1) == 0 && objectRay.Direction (1) == 0 % the ray is meridional ray and so show 2D layout
         %plot2DLayout(OS,rayPathMatrix,axesHandle);
         OS.plot2DLayout(axesHandle,rayPathMatrix);
    end
    figure;
    axesHandle=axes;
    %plot3DLayout(OS,rayPathMatrix,axesHandle);
    OS.plot3DLayout(axesHandle,rayPathMatrix);    
end
