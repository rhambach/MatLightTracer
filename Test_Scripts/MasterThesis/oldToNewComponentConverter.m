function newComponent = oldToNewComponentConverter(oldComponent)
switch lower(oldComponent.Type)
    case {lower('SS')}
        if oldComponent.Parameters.SurfaceArray(1).ObjectSurface
            newComponent = Component('OBJECT');
        elseif oldComponent.Parameters.SurfaceArray(1).ImageSurface
            newComponent = Component('IMAGE');
        else
            newComponent = Component('SequenceOfSurfaces');
        end
        newComponent.Parameters.SurfaceArray =  oldComponent.Parameters.SurfaceArray; 
    case {lower('SQS')}
        newComponent = Component('SequenceOfSurfaces');
        newComponent.Parameters.SurfaceArray =  oldComponent.Parameters.SurfaceArray;
    case lower('Prism')
        newComponent = Component('Prism');
        newComponent.Parameters.Ray_Path =  oldComponent.Parameters.PrismRayPath;
        newComponent.Parameters.Tilt_Decenter_Order_Surf_1 = oldComponent.Parameters.PrismTiltDecenterOrder;
        newComponent.Parameters.Tilt_Angle_X_Surf_1 =  oldComponent.Parameters.PrismTiltParameter(1);
        newComponent.Parameters.Tilt_Angle_Y_Surf_1 =  oldComponent.Parameters.PrismTiltParameter(2);
        newComponent.Parameters.Tilt_Angle_Z_Surf_1 =  oldComponent.Parameters.PrismTiltParameter(3);
        
        newComponent.Parameters.Decenter_X_Surf_1 =  oldComponent.Parameters.PrismDecenterParameter(1);
        newComponent.Parameters.Decenter_Y_Surf_1 =  oldComponent.Parameters.PrismDecenterParameter(2);
        newComponent.Parameters.Aperture_X_Surf_1 =  oldComponent.Parameters.PrismApertureParameter(1);
        newComponent.Parameters.Aperture_Y_Surf_1 =  oldComponent.Parameters.PrismApertureParameter(2);
        newComponent.Parameters.Glass_Name = oldComponent.Parameters.PrismGlassName;
        newComponent.Parameters.Apex_Angle_1 = oldComponent.Parameters.PrismApexAngle1;
        newComponent.Parameters.Apex_Angle_2 = oldComponent.Parameters.PrismApexAngle2;
        newComponent.Parameters.Distance_After_Prism = oldComponent.Parameters.DistanceAfterPrism;
        newComponent.Parameters.Stop_Surf_1 = oldComponent.Parameters.MakePrismStop;
    case lower('Grating')
        
        newComponent = Component('Grating1D');
        newComponent.Parameters.Line_Density =  oldComponent.Parameters.GratingLineDensity;
        newComponent.Parameters.Diffraction_Order =  oldComponent.Parameters.GratingDiffractionOrder;
        newComponent.Parameters.Tilt_Decenter_Order = oldComponent.Parameters.GratingTiltDecenterOrder;
        newComponent.Parameters.Tilt_Angle_X =  oldComponent.Parameters.GratingTiltParameter(1);
        newComponent.Parameters.Tilt_Angle_Y =  oldComponent.Parameters.GratingTiltParameter(2);
        newComponent.Parameters.Tilt_Angle_Z =  oldComponent.Parameters.GratingTiltParameter(3);
        
        newComponent.Parameters.Decenter_X =  oldComponent.Parameters.GratingDecenterParameter(1);
        newComponent.Parameters.Decenter_Y =  oldComponent.Parameters.GratingDecenterParameter(2);
        newComponent.Parameters.Aperture_X =  oldComponent.Parameters.GratingApertureParameter(1);
        newComponent.Parameters.Aperture_Y =  oldComponent.Parameters.GratingApertureParameter(2);
        newComponent.Parameters.Glass_Name = oldComponent.Parameters.GratingGlassName;
        newComponent.Parameters.Tilt_Mode = oldComponent.Parameters.GratingTiltMode;
        
        newComponent.Parameters.Aperture_Type = oldComponent.Parameters.GratingApertureType;
        
        newComponent.Parameters.Distance_After_Grating = oldComponent.Parameters.DistanceAfterGrating;
        newComponent.Parameters.Stop_Surface = oldComponent.Parameters.MakeGratingStop;
                
end

end