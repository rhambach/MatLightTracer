classdef Component
    %currentComponent Defines optical components such as interface,lens,prism ...
    % Is used for currentComponent based system entry/analysis
    
    properties
        Type % 'SS','SQS','Grating','Prism'
        Parameters % Struct of all parameters Depends on the type of the currentComponent.
    end
    
    methods
        % Constructor
        function NewComponent = Component(compType)
            if nargin == 0
                % Make single surface component by default
                compType = 'SS';
            end
            switch lower(compType)
                case {lower('SS')} 
                    NewComponent.Type = 'SS';
                    NewComponent.Parameters.NumberOfSurfaces = 1;
                    NewComponent.Parameters.SurfaceArray = Surface;                    
                case {lower('SQS')} 
                    NewComponent.Type = 'SQS';
                    NewComponent.Parameters.NumberOfSurfaces = 1;
                    NewComponent.Parameters.SurfaceArray = Surface;
                    NewComponent.Parameters.SurfaceArray(1).TiltMode = 'NAX';
                case {lower('Prism')}
                    NewComponent.Type = 'Prism';
                    NewComponent.Parameters.PrismRayPath = 'S1-S2';
                    NewComponent.Parameters.NumberOfSurfaces = 2;
                    NewComponent.Parameters.SurfaceArray(1) = Surface;
                    NewComponent.Parameters.SurfaceArray(2) = Surface;
                    NewComponent.Parameters.PrismTiltDecenterOrder = 'DxDyDzTxTyTz';   
                    NewComponent.Parameters.PrismTiltParameter = [0 0 0];
                    NewComponent.Parameters.PrismDecenterParameter = [0 0];   
                    NewComponent.Parameters.PrismApertureParameter = [2.5 2.5 0 0];   
                    NewComponent.Parameters.PrismGlassName = 'BK7';  
                    NewComponent.Parameters.PrismApexAngle1 = 60; 
                    NewComponent.Parameters.PrismApexAngle2 = 60;
                    NewComponent.Parameters.DistanceAfterPrism = 5;
                    NewComponent.Parameters.MakePrismStop = false;
                case {lower('Grating')}
                    NewComponent.Type = 'Grating';
                    NewComponent.Parameters.GratingGlassName =  'MIRROR';
                    NewComponent.Parameters.NumberOfSurfaces = 1;
                    NewComponent.Parameters.SurfaceArray(1) = Surface;
                    NewComponent.Parameters.GratingTiltDecenterOrder = 'DxDyDzTxTyTz';   
                    NewComponent.Parameters.GratingTiltParameter = [0 0 0];
                    NewComponent.Parameters.GratingTiltMode = 'BEN';
                    NewComponent.Parameters.GratingDecenterParameter = [0 0];  
                    NewComponent.Parameters.GratingApertureType = 'Rectangular';
                    NewComponent.Parameters.GratingApertureParameter = [5 5 0 0];   
                    NewComponent.Parameters.GratingLineDensity = 0.1; 
                    NewComponent.Parameters.GratingDiffractionOrder = 1; 
                    NewComponent.Parameters.DistanceAfterGrating = 5;
                    NewComponent.Parameters.MakeGratingStop = false;               
            end
        end
     end
    
end

