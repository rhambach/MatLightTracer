function newScriptGenerated = generateNewScript( opticalSystem, initialRay )
%generateNewScript Generates script files which is compatable with newer
%version of the toolbox
%   Detailed explanation goes here

if 1 % check for initial ray
    % Generate script file
    disp('clc;');
    disp('clear all;');
    disp('close all;');
    disp('format long;');
    disp('% Initial ray');

    
    
    disp('initialRay = Ray;');
    disp(['initialRay.Position = [',num2str(initialRay.Position),'];']);
    disp(['initialRay.Direction = [',num2str(initialRay.Direction),'];']);
    disp(['initialRay.JonesVector = [',num2str(initialRay.JonesVector(1,:)),';',num2str(initialRay.JonesVector(2,:)),'];']);
    disp(['initialRay.Polarized = [',num2str(initialRay.Polarized),'];']);
    disp(['initialRay.Wavelength = [',num2str(initialRay.Wavelength),'];']);
else
    disp('No initial ray defined');
end

if 1 % check for opticalSystem
        %%Display the optical system script
    disp('newSystem = OpticalSystem;');
    disp(['newSystem.NumberOfSurface = [', num2str(opticalSystem.NumberOfSurface),'];']);
    for k = 1:1:opticalSystem.NumberOfSurface       
        
        
        if opticalSystem.SurfaceArray(k).ObjectSurface
            disp('%Object Surface');
        elseif opticalSystem.SurfaceArray(k).ImageSurface
            disp('%Image Surface');
        elseif opticalSystem.SurfaceArray(k).Stop
            disp('%Stop Surface');
        else
            disp('%Other Surface');
        end
        %standard data
        disp('%standard data');
        disp(['newSystem.SurfaceArray(',num2str(k),').ObjectSurface = [', num2str(opticalSystem.SurfaceArray(k).ObjectSurface),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').ImageSurface = [', num2str(opticalSystem.SurfaceArray(k).ImageSurface),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').Stop = [', num2str(opticalSystem.SurfaceArray(k).Stop),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').Comment = [''', (opticalSystem.SurfaceArray(k).Comment),'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').Type = [''', (opticalSystem.SurfaceArray(k).Type),'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').Radius = [', num2str(opticalSystem.SurfaceArray(k).Radius),'];']);
        %disp(['newSystem.SurfaceArray(',num2str(k),').Thickness = [', num2str(opticalSystem.SurfaceArray(k).Thickness),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').Glass = [''', (opticalSystem.SurfaceArray(k).Glass),'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').DeviationMode = [''', num2str(opticalSystem.SurfaceArray(k).DeviationMode),'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').SemiDiameter = [', num2str(opticalSystem.SurfaceArray(k).SemiDiameter),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').Position = [', num2str(opticalSystem.SurfaceArray(k).Position),'];']);
        
        %aperture data
        disp('%aperture data');
        disp(['newSystem.SurfaceArray(',num2str(k),').ApertureType = [''', num2str(opticalSystem.SurfaceArray(k).ApertureType),'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').ApertureParameter = [', num2str(opticalSystem.SurfaceArray(k).ApertureParameter),'];']);
        
        %coating data  
        disp('%coating data');
        disp(['newSystem.SurfaceArray(',num2str(k),').CoatingType = [''', opticalSystem.SurfaceArray(k).CoatingType,'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').CoatingParameter = [', opticalSystem.SurfaceArray(k).CoatingParameter,'];']);
        %CoatingType % {'None' 'Jones Matrix' 'Multilayer Coating'}
        
        %aspheric data
        disp('%aspheric data');
        disp(['newSystem.SurfaceArray(',num2str(k),').ConicConstant = [', num2str(opticalSystem.SurfaceArray(k).ConicConstant),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').PloynomialCoefficients = [', num2str(opticalSystem.SurfaceArray(k).PloynomialCoefficients),'];']);        
        
        %tilt decenter data
        disp('%tilt decenter data');
        disp(['newSystem.SurfaceArray(',num2str(k),').TiltDecenterOrder = [''', (opticalSystem.SurfaceArray(k).TiltDecenterOrder),'''];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').TiltParameter = [', num2str(opticalSystem.SurfaceArray(k).TiltParameter),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').DecenterParameter = [', num2str(opticalSystem.SurfaceArray(k).DecenterParameter),'];']);
        disp(['newSystem.SurfaceArray(',num2str(k),').TiltMode = [''', num2str(opticalSystem.SurfaceArray(k).TiltMode),'''];']);        
%         
%         %unused datas        
%         disp('%unused datas');
%         disp(['%newSystem.SurfaceArray(',num2str(k),').Thickness = [', (opticalSystem.SurfaceArray(k).SurfaceColor),'];']);
%         disp(['%newSystem.SurfaceArray(',num2str(k),').Thickness = [', num2str(opticalSystem.SurfaceArray(k).Hidden),'];']);
%         disp(['%newSystem.SurfaceArray(',num2str(k),').Thickness = [', num2str(opticalSystem.SurfaceArray(k).Ignored),'];']);   
        

           
    end
        disp('t1=clock;  %start to count the time');
        disp('%================================ RAYTRACE ========================');
        disp('polarizedRayTracerResult = polarizedRayTracer( newSystem, initialRay);');
        disp('disp(''System Data'');');
        disp('disp(newSystem);');
        disp('disp(newSystem.SurfaceArray);');
        disp('disp(''Ray Position'');');
        disp('disp(polarizedRayTracerResult.RayIntersectionPoint);');  
        disp('disp(''Ray Direction'');');
        disp('disp(polarizedRayTracerResult.ExitRayDirection);');
        disp('disp(''Surface Normals'');');
        disp('disp(polarizedRayTracerResult.SurfaceNormal);');
        disp('disp(''Incident Angle'');');
        disp('disp(polarizedRayTracerResult.IncidenceAngle);');
        disp('disp(''Path Length'');');
        disp('disp(polarizedRayTracerResult.PathLength);');   
        disp('disp(polarizedRayTracerResult.PathLength);');
        disp('disp(''Polarization Vector Before Coating'');');
        disp('disp(polarizedRayTracerResult.PolarizationVectorBeforeCoating);');
        disp('disp(''Polarization Vector After Coating'');');
        disp('disp(polarizedRayTracerResult.PolarizationVectorAfterCoating);');
        disp('disp(''Jones Vector Before Coating'');');
        disp('disp(polarizedRayTracerResult.JonesVector);');
        disp('disp(''Jones Vector After Coating'');');
        disp('disp(polarizedRayTracerResult.JonesVector);');
        disp('disp(''Polarization Ellipse Parameters After Coating'');');
        disp('disp(polarizedRayTracerResult.PolarizationEllipseAfterCoating);');

        disp('%=================================== END =============================');
        disp('t2=clock;');
        disp('d = drawSystemLayOut(newSystem);');
        disp('plot3(polarizedRayTracerResult.RayIntersectionPoint(:,2),polarizedRayTracerResult.RayIntersectionPoint(:,3),polarizedRayTracerResult.RayIntersectionPoint(:,1)); hold on;');  
        disp('plot3(polarizedRayTracerResult.RayIntersectionPoint(:,2),polarizedRayTracerResult.RayIntersectionPoint(:,3),polarizedRayTracerResult.RayIntersectionPoint(:,1),''+''); hold off;');
        disp('time=etime(t2,t1);');
        disp('display(time);');
else
        disp('No optical system defined');
end

end

