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
                compType = 'SQS';
            end
            switch lower(compType)
                case {lower('SQS')} 
                    NewComponent.Type = 'SQS';
                    NewComponent.Parameters.NumberOfSurfaces = 1;
                    NewComponent.Parameters.SurfaceArray = Surface;
                case {lower('Prism')}
                    NewComponent.Type = 'Prism';
                    NewComponent.Parameters.RayPath = 'S1-S2';
                    NewComponent.Parameters.NumberOfSurfaces = 2;
                    NewComponent.Parameters.SurfaceArray(1) = Surface;
                    NewComponent.Parameters.SurfaceArray(2) = Surface;
                    NewComponent.Parameters.Surface1TiltDecenterOrder = 'DxDyDzTxTyTz';   
                    NewComponent.Parameters.Surface1TiltParameter = [0 0 0];
                    NewComponent.Parameters.Surface1DecenterParameter = [0 0];   
                    NewComponent.Parameters.Surface1ApertureParameter = [2.5 2.5 0 0];   
                    NewComponent.Parameters.GlassName = 'BK7';  
                    NewComponent.Parameters.ApexAngle1 = 60; 
                    NewComponent.Parameters.ApexAngle2 = 60;
                    NewComponent.Parameters.DistanceToNextComponent = 5;
                    NewComponent.Parameters.MakeSurface1Stop = false;
                    NewComponent.Parameters.ReturnCoordinateToPreviousSurface = false;
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
        
        % Compute surface parameters of the currentComponent from the give ones
        function mySurfaceArray = getSurfaceArray(currentComponent)
            compType = currentComponent.Type;
            switch lower(compType)
                case {lower('SQS')} 
                    mySurfaceArray = currentComponent.Parameters.SurfaceArray;
                case {lower('Prism')}
                    currentComponent.Parameters.SurfaceArray = Surface;
                    % Set surface1 properties
                    currentComponent.Parameters.SurfaceArray(1) = Surface;
                    currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder = ...
                        currentComponent.Parameters.Surface1TiltDecenterOrder;
                    currentComponent.Parameters.SurfaceArray(1).TiltParameter = ...
                        currentComponent.Parameters.Surface1TiltParameter;
                    currentComponent.Parameters.SurfaceArray(1).DecenterParameter = ...
                        currentComponent.Parameters.Surface1DecenterParameter;
                    currentComponent.Parameters.SurfaceArray(1).TiltMode = 'NAX';                    
                    currentComponent.Parameters.SurfaceArray(1).ApertureType = ...
                        'Rectangular';
                    currentComponent.Parameters.SurfaceArray(1).ApertureParameter = ...
                        currentComponent.Parameters.Surface1ApertureParameter;                    
                    currentComponent.Parameters.SurfaceArray(1).Glass = ...
                        Glass(currentComponent.Parameters.GlassName);
                    % Check wether it is Stop or not
                    if currentComponent.Parameters.MakeSurface1Stop
                        currentComponent.Parameters.SurfaceArray(1).Stop = 1;
                    end
                    
                   % Set surface2 and surface3 properties
                   % Compute the initial tilt and decenters of surf 2 and 3
                   % before applicatio of the tilt and decenter of surf 1
                    apexAngle1InRad = currentComponent.Parameters.ApexAngle1*pi/180;
                    apexAngle2InRad = currentComponent.Parameters.ApexAngle2*pi/180;
                    
                    apexAngle3InRad = pi - (apexAngle1InRad+apexAngle2InRad);
                    % Alpha is the angle formaed by surf 2 and surf 3
                    alpha = pi-apexAngle1InRad-apexAngle2InRad;
                    fullApertureY1 = 2*currentComponent.Parameters.Surface1ApertureParameter(2);
                    % Using sin law of triangles 
                    fullApertureY2 = (sin (apexAngle2InRad)/sin (alpha))*fullApertureY1;
                    fullApertureY3 = (sin (apexAngle1InRad)/sin (alpha))*fullApertureY1;
                    % Using the centers of each side as decenter
                    % parameterrs
                    % Decenter of S2 with respect to S1
                    decenterZ2 = 0.5*fullApertureY2*sin(apexAngle1InRad);
                    decenterY2 = -0.5*fullApertureY2*cos(apexAngle1InRad)+0.5*fullApertureY1;
                    decenterX2 = 0;
                    % Decenter of S3 with respect to S1
                    decenterZ3 = 0.5*fullApertureY3*sin(apexAngle2InRad);
                    decenterY3 = 0.5*fullApertureY3*cos(apexAngle2InRad)-0.5*fullApertureY1;
                    decenterX3 = 0;
                    
                    % Decenter of S1 with respect to S3 or
                    % Decenter of S1 with respect to S2 
                    % Just take negative of the corresponding value
                    
                    % Know set the surface properties based on the RayPath
                    switch currentComponent.Parameters.RayPath
                        case 'S1-S2'
                            currentComponent.Parameters.SurfaceArray(2) = Surface;
                            currentComponent.Parameters.NumberOfSurfaces = 2;                            
                            newDecenter =[decenterX2,decenterY2,decenterZ2];                           
                            currentComponent.Parameters.SurfaceArray(1).Thickness = newDecenter(3);                                                        
                            % 2nd surface parameters
                            currentComponent.Parameters.SurfaceArray(2).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                            
                            currentComponent.Parameters.SurfaceArray(2).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(2).TiltParameter = ...
                                 [-apexAngle1InRad*180/pi,0,0];                            
                             currentComponent.Parameters.SurfaceArray(2).DecenterParameter = newDecenter(1:2);
                             
                            currentComponent.Parameters.SurfaceArray(2).TiltMode = 'NAX'; 
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY2;
                            currentComponent.Parameters.SurfaceArray(2).ApertureType = ...
                                'Rectangular';
                            if currentComponent.Parameters.ReturnCoordinateToPreviousSurface
                                % Add dummy surface to return the
                                % coordinate back (This UNDOs just the
                                % rotation not the decneter)
                                currentComponent.Parameters.SurfaceArray(3) = Surface;
                                currentComponent.Parameters.SurfaceArray(3).Type = 'Dummy';
                                currentComponent.Parameters.SurfaceArray(3).TiltDecenterOrder = 'TzTyTxDzDyDx';
                                 currentComponent.Parameters.SurfaceArray(3).TiltMode = 'NAX';
                                currentComponent.Parameters.SurfaceArray(3).TiltParameter = ...
                                 -[-apexAngle1InRad*180/pi,0,0];
                                currentComponent.Parameters.SurfaceArray(3).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                             
                                currentComponent.Parameters.SurfaceArray(2).Thickness = 0;
                            end
                        case 'S1-S3'
                            currentComponent.Parameters.SurfaceArray(2) = Surface;
                            currentComponent.Parameters.NumberOfSurfaces = 2;                                                        
                            newDecenter = [decenterX3,decenterY3,decenterZ3];                           
                            currentComponent.Parameters.SurfaceArray(1).Thickness = newDecenter(3);    
                           
                            % 2nd surface parameters
                            currentComponent.Parameters.SurfaceArray(2).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                            
                            currentComponent.Parameters.SurfaceArray(2).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
    
                            currentComponent.Parameters.SurfaceArray(2).TiltParameter = ...
                                 [apexAngle2InRad*180/pi,0,0];     
                            currentComponent.Parameters.SurfaceArray(2).DecenterParameter = newDecenter(1:2);
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltMode = 'NAX'; 
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY3;
                            currentComponent.Parameters.SurfaceArray(2).ApertureType = ...
                                'Rectangular';   
                            
                            if currentComponent.Parameters.ReturnCoordinateToPreviousSurface
                                % Add dummy surface to return the
                                % coordinate back (This UNDOs just the
                                % rotation not the decneter)
                                currentComponent.Parameters.SurfaceArray(3) = Surface;
                                currentComponent.Parameters.SurfaceArray(3).Type = 'Dummy';
                                currentComponent.Parameters.SurfaceArray(3).TiltDecenterOrder = 'TzTyTxDzDyDx';
                                 currentComponent.Parameters.SurfaceArray(3).TiltMode = 'NAX';
                                currentComponent.Parameters.SurfaceArray(3).TiltParameter = ...
                                 -[apexAngle1InRad*180/pi,0,0];
                                currentComponent.Parameters.SurfaceArray(3).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                             
                                currentComponent.Parameters.SurfaceArray(2).Thickness = 0;
                            end                            
                            
                        case 'S1-S2-S3'
                            currentComponent.Parameters.SurfaceArray(2) = Surface;
                            currentComponent.Parameters.SurfaceArray(3) = Surface;
                            currentComponent.Parameters.NumberOfSurfaces = 3;
                            currentComponent.Parameters.SurfaceArray(1).Thickness = decenterZ2;
                            
                            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
                            newDecenter3 = [decenterX3,decenterY3,decenterZ3];  
                            % 2nd surface parameters
                            currentComponent.Parameters.SurfaceArray(2).Thickness = ...
                                - 0.5*fullApertureY1*cos(2*apexAngle1InRad-pi/2);  
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(2).TiltParameter = ...
                                 [-apexAngle1InRad*180/pi,0,0];
                            currentComponent.Parameters.SurfaceArray(2).DecenterParameter = newDecenter2(1:2);
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltMode = 'BEN'; 
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY2;
                            currentComponent.Parameters.SurfaceArray(2).ApertureType = ...
                                'Rectangular';       
                            currentComponent.Parameters.SurfaceArray(2).Glass.Name = 'Mirror';
                            % 3rd surface parameters
                            currentComponent.Parameters.SurfaceArray(3).Thickness = ...
                                -currentComponent.Parameters.DistanceToNextComponent;                            
                            currentComponent.Parameters.SurfaceArray(3).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(3).TiltParameter = ...
                                 -[(pi-(2*apexAngle1InRad+apexAngle2InRad))*180/pi,0,0];
                             
                             currentComponent.Parameters.SurfaceArray(3).DecenterParameter = ...
                                 [-newDecenter3(1),0.5*fullApertureY1*sin(2*apexAngle1InRad-pi/2)];
                             
                            currentComponent.Parameters.SurfaceArray(3).TiltMode = 'NAX'; 
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter(2) = 0.5*fullApertureY3;
                            currentComponent.Parameters.SurfaceArray(3).ApertureType = ...
                                'Rectangular'; 
                            if currentComponent.Parameters.ReturnCoordinateToPreviousSurface
                                % Add dummy surface to return the
                                % coordinate back (This UNDOs just the
                                % rotation not the decneter)
                                currentComponent.Parameters.SurfaceArray(4) = Surface;
                                currentComponent.Parameters.SurfaceArray(4).Type = 'Dummy';
                                currentComponent.Parameters.SurfaceArray(4).TiltDecenterOrder = 'TzTyTxDzDyDx';
                                 currentComponent.Parameters.SurfaceArray(4).TiltMode = 'NAX';
                                currentComponent.Parameters.SurfaceArray(4).TiltParameter = ...
                                  [(pi-(2*apexAngle1InRad+apexAngle2InRad))*180/pi,0,0];
                              
                                currentComponent.Parameters.SurfaceArray(4).Thickness = ...
                                -currentComponent.Parameters.DistanceToNextComponent;                             
                                currentComponent.Parameters.SurfaceArray(3).Thickness = 0;
                            end                             
                        case 'S1-S3-S2'
                            currentComponent.Parameters.SurfaceArray(2) = Surface;
                            currentComponent.Parameters.SurfaceArray(3) = Surface;                            
                            currentComponent.Parameters.NumberOfSurfaces = 3;
                            currentComponent.Parameters.SurfaceArray(1).Thickness = decenterZ3;
                            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
                            newDecenter3 = [decenterX3,decenterY3,decenterZ3];  
                                                       
                            % 2nd surface parameters
                            currentComponent.Parameters.SurfaceArray(2).Thickness = ...
                                - 0.5*fullApertureY1*cos(2*apexAngle2InRad-pi/2);  
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(2).TiltParameter = ...
                                 [apexAngle2InRad*180/pi,0,0];  
                             currentComponent.Parameters.SurfaceArray(2).DecenterParameter = newDecenter3(1:2);
                             
                            currentComponent.Parameters.SurfaceArray(2).TiltMode = 'BEN'; 
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY3;
                            currentComponent.Parameters.SurfaceArray(2).ApertureType = ...
                                'Rectangular';       
                            currentComponent.Parameters.SurfaceArray(2).Glass.Name = 'Mirror';
                            % 3rd surface parameters
                            currentComponent.Parameters.SurfaceArray(3).Thickness = ...
                                -currentComponent.Parameters.DistanceToNextComponent;                            
                            currentComponent.Parameters.SurfaceArray(3).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
    
                            currentComponent.Parameters.SurfaceArray(3).TiltParameter = ...
                                 -[(pi-(2*apexAngle2InRad+apexAngle1InRad))*180/pi,0,0];
                             currentComponent.Parameters.SurfaceArray(3).DecenterParameter = ...
                                 [-newDecenter2(1),0.5*fullApertureY1*sin(2*apexAngle2InRad-pi/2)];
                             
                            currentComponent.Parameters.SurfaceArray(3).TiltMode = 'NAX'; 
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter(2) = 0.5*fullApertureY2;
                            currentComponent.Parameters.SurfaceArray(3).ApertureType = ...
                                'Rectangular';  
                            if currentComponent.Parameters.ReturnCoordinateToPreviousSurface
                                % Add dummy surface to return the
                                % coordinate back (This UNDOs just the
                                % rotation not the decneter)
                                currentComponent.Parameters.SurfaceArray(4) = Surface;
                                currentComponent.Parameters.SurfaceArray(4).Type = 'Dummy';
                                currentComponent.Parameters.SurfaceArray(4).TiltDecenterOrder = 'TzTyTxDzDyDx';
                                 currentComponent.Parameters.SurfaceArray(4).TiltMode = 'NAX';
                                currentComponent.Parameters.SurfaceArray(4).TiltParameter = ...
                                  [(pi-(2*apexAngle2InRad+apexAngle1InRad))*180/pi,0,0];
                                currentComponent.Parameters.SurfaceArray(4).Thickness = ...
                                -currentComponent.Parameters.DistanceToNextComponent;                             
                                currentComponent.Parameters.SurfaceArray(3).Thickness = 0;
                            end                               
                        case 'S1-S2-S3-S1'
                            currentComponent.Parameters.SurfaceArray(2) = Surface;
                            currentComponent.Parameters.SurfaceArray(3) = Surface;
                            currentComponent.Parameters.NumberOfSurfaces = 3;
                            currentComponent.Parameters.SurfaceArray(1).Thickness = decenterZ2;
                            
                            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
                            newDecenter3 = [decenterX3,decenterY3,decenterZ3];  
                            % 2nd surface parameters
                            currentComponent.Parameters.SurfaceArray(2).Thickness = ...
                                - 0.5*fullApertureY1*cos(2*apexAngle1InRad-pi/2);  
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(2).TiltParameter = ...
                                 [-apexAngle1InRad*180/pi,0,0];
                            currentComponent.Parameters.SurfaceArray(2).DecenterParameter = newDecenter2(1:2);
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltMode = 'BEN'; 
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY2;
                            currentComponent.Parameters.SurfaceArray(2).ApertureType = ...
                                'Rectangular';       
                            currentComponent.Parameters.SurfaceArray(2).Glass.Name = 'Mirror';
                            
                            % 3rd surface parameters
                            s1s3 = sqrt(decenterZ3^2+decenterY3^2);
                            currentComponent.Parameters.SurfaceArray(3).Thickness = ...
                                s1s3*cos(2*apexAngle3InRad-apexAngle1InRad-pi/2);
                            currentComponent.Parameters.SurfaceArray(3).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(3).TiltParameter = ...
                                 -[(pi-(2*apexAngle1InRad+apexAngle2InRad))*180/pi,0,0];
                             
                             currentComponent.Parameters.SurfaceArray(3).DecenterParameter = ...
                                 [-newDecenter3(1),0.5*fullApertureY1*sin(2*apexAngle1InRad-pi/2)];
                             
                            currentComponent.Parameters.SurfaceArray(3).TiltMode = 'BEN'; 
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter(2) = 0.5*fullApertureY3;
                            currentComponent.Parameters.SurfaceArray(3).ApertureType = ...
                                'Rectangular'; 
                            currentComponent.Parameters.SurfaceArray(3).Glass.Name = 'Mirror';
                            
                            % 4th surface parameters
                            currentComponent.Parameters.SurfaceArray(4).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                            
                            currentComponent.Parameters.SurfaceArray(4).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
    
                            currentComponent.Parameters.SurfaceArray(4).TiltParameter = ...
                                 [(apexAngle3InRad-(apexAngle1InRad+apexAngle2InRad))*180/pi,0,0];
                             
                             currentComponent.Parameters.SurfaceArray(4).DecenterParameter(1) = ...
                                 newDecenter3(1);
                             currentComponent.Parameters.SurfaceArray(4).DecenterParameter(2) = ...
                             -s1s3*sin(2*apexAngle3InRad-apexAngle1InRad-pi/2);
                             
                            currentComponent.Parameters.SurfaceArray(4).TiltMode = 'NAX'; 
                            currentComponent.Parameters.SurfaceArray(4).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(4).ApertureType = ...
                                'Rectangular';                            
                            
                            if currentComponent.Parameters.ReturnCoordinateToPreviousSurface
                                % Add dummy surface to return the
                                % coordinate back (This UNDOs just the
                                % rotation not the decneter)
                                currentComponent.Parameters.SurfaceArray(5) = Surface;
                                currentComponent.Parameters.SurfaceArray(5).Type = 'Dummy';
                                currentComponent.Parameters.SurfaceArray(5).TiltDecenterOrder = 'TzTyTxDzDyDx';
                                 currentComponent.Parameters.SurfaceArray(5).TiltMode = 'NAX';
                                currentComponent.Parameters.SurfaceArray(5).TiltParameter = ...
                                  [(pi-(2*apexAngle1InRad+apexAngle2InRad))*180/pi,0,0];
                              
                                currentComponent.Parameters.SurfaceArray(5).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                             
                                currentComponent.Parameters.SurfaceArray(4).Thickness = 0;
                            end                            
                        case 'S1-S3-S2-S1'
                            currentComponent.Parameters.SurfaceArray(2) = Surface;
                            currentComponent.Parameters.SurfaceArray(3) = Surface;
                            currentComponent.Parameters.NumberOfSurfaces = 3;
                            currentComponent.Parameters.SurfaceArray(1).Thickness = decenterZ2;
                            
                            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
                            newDecenter3 = [decenterX3,decenterY3,decenterZ3];  
                            % 2nd surface parameters
                            currentComponent.Parameters.SurfaceArray(2).Thickness = ...
                                - 0.5*fullApertureY1*cos(2*apexAngle2InRad-pi/2);  
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(2).TiltParameter = ...
                                 [apexAngle2InRad*180/pi,0,0];
                            currentComponent.Parameters.SurfaceArray(2).DecenterParameter = newDecenter3(1:2);
                            
                            currentComponent.Parameters.SurfaceArray(2).TiltMode = 'BEN'; 
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY3;
                            currentComponent.Parameters.SurfaceArray(2).ApertureType = ...
                                'Rectangular';       
                            currentComponent.Parameters.SurfaceArray(2).Glass.Name = 'Mirror';
                            
                            % 3rd surface parameters
                            s1s2 = sqrt(decenterZ2^2+decenterY2^2);
                            currentComponent.Parameters.SurfaceArray(3).Thickness = ...
                                s1s2*cos(2*apexAngle3InRad-apexAngle2InRad-pi/2);
                            currentComponent.Parameters.SurfaceArray(3).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
                            currentComponent.Parameters.SurfaceArray(3).TiltParameter = ...
                                 [(pi-(2*apexAngle2InRad+apexAngle1InRad))*180/pi,0,0];
                             
                             currentComponent.Parameters.SurfaceArray(3).DecenterParameter = ...
                                 [-newDecenter2(1),0.5*fullApertureY1*sin(2*apexAngle2InRad-pi/2)];
                             
                            currentComponent.Parameters.SurfaceArray(3).TiltMode = 'BEN'; 
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(3).ApertureParameter(2) = 0.5*fullApertureY2;
                            currentComponent.Parameters.SurfaceArray(3).ApertureType = ...
                                'Rectangular'; 
                            currentComponent.Parameters.SurfaceArray(3).Glass.Name = 'Mirror';
                            
                            % 4th surface parameters
                            currentComponent.Parameters.SurfaceArray(4).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                            
                            currentComponent.Parameters.SurfaceArray(4).TiltDecenterOrder = ...
                                currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder;
    
                            currentComponent.Parameters.SurfaceArray(4).TiltParameter = ...
                                 [(apexAngle3InRad-(apexAngle2InRad+apexAngle1InRad))*180/pi,0,0];
                             
                             currentComponent.Parameters.SurfaceArray(4).DecenterParameter(1) = ...
                                 newDecenter2(1);
                             currentComponent.Parameters.SurfaceArray(4).DecenterParameter(2) = ...
                                s1s2*sin(2*apexAngle3InRad-apexAngle2InRad-pi/2);
                             
                            currentComponent.Parameters.SurfaceArray(4).TiltMode = 'NAX'; 
                            currentComponent.Parameters.SurfaceArray(4).ApertureParameter = ...
                                currentComponent.Parameters.SurfaceArray(1).ApertureParameter;
                            currentComponent.Parameters.SurfaceArray(4).ApertureType = ...
                                'Rectangular';                            
                            
                            if currentComponent.Parameters.ReturnCoordinateToPreviousSurface
                                % Add dummy surface to return the
                                % coordinate back (This UNDOs just the
                                % rotation not the decneter)
                                currentComponent.Parameters.SurfaceArray(5) = Surface;
                                currentComponent.Parameters.SurfaceArray(5).Type = 'Dummy';
                                currentComponent.Parameters.SurfaceArray(5).TiltDecenterOrder = 'TzTyTxDzDyDx';
                                 currentComponent.Parameters.SurfaceArray(5).TiltMode = 'NAX';
                                currentComponent.Parameters.SurfaceArray(5).TiltParameter = ...
                                  [(pi-(2*apexAngle2InRad+apexAngle1InRad))*180/pi,0,0];
                              
                                currentComponent.Parameters.SurfaceArray(5).Thickness = ...
                                currentComponent.Parameters.DistanceToNextComponent;                             
                                currentComponent.Parameters.SurfaceArray(4).Thickness = 0;
                            end                              
                            
                    end
                    case {lower('Grating')}
                        % Set surface1 properties
                        currentComponent.Parameters.SurfaceArray(1) = Surface;
                        currentComponent.Parameters.SurfaceArray(1).TiltDecenterOrder = ...
                            currentComponent.Parameters.GratingTiltDecenterOrder;
                        currentComponent.Parameters.SurfaceArray(1).TiltParameter = ...
                            currentComponent.Parameters.GratingTiltParameter;
                        currentComponent.Parameters.SurfaceArray(1).DecenterParameter = ...
                            currentComponent.Parameters.GratingDecenterParameter;
                        currentComponent.Parameters.SurfaceArray(1).TiltMode = ...
                            currentComponent.Parameters.GratingTiltMode;
                        currentComponent.Parameters.SurfaceArray(1).ApertureType = ...
                            currentComponent.Parameters.GratingApertureType;
                        currentComponent.Parameters.SurfaceArray(1).ApertureParameter = ...
                            currentComponent.Parameters.GratingApertureParameter;                    
                        currentComponent.Parameters.SurfaceArray(1).Glass = ...
                            Glass(currentComponent.Parameters.GratingGlassName);
                        % Check wether it is Stop or not
                        if currentComponent.Parameters.MakeGratingStop
                            currentComponent.Parameters.SurfaceArray(1).Stop = 1;
                        end      
                        currentComponent.Parameters.SurfaceArray(1).Thickness = ...
                            currentComponent.Parameters.DistanceAfterGrating;
                        
                        currentComponent.Parameters.SurfaceArray(1).GratingLineDensity = ...
                            currentComponent.Parameters.GratingLineDensity;
                        currentComponent.Parameters.SurfaceArray(1).DiffractionOrder = ...
                            currentComponent.Parameters.GratingDiffractionOrder;
            end 
         mySurfaceArray = currentComponent.Parameters.SurfaceArray;
         end
     end
    
end

