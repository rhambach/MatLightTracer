function [ returnData1, returnData2, returnData3] = Prism( ...
        returnFlag,componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode)
    %Prism Component defining a general prism

    %% Default input vaalues
    if nargin == 0
        disp('Error: The function Prism() needs atleat the return type.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    elseif nargin >= 1
        if returnFlag == 4
            if nargin == 1
                % take the defualt componentparameters
                returnFlag = 2;
                [fieldNames,fieldTypes, defaultParameterStruct] = SequenceOfSurfaces(returnFlag);
                componentParameters = defaultParameterStruct;
                firstTilt = [0,0,0];
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
            elseif nargin == 2
                firstTilt = [0,0,0];
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
            elseif nargin == 3
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
            elseif nargin == 4
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
            elseif nargin == 5
                lastThickness = 10;
                compTiltMode = 'NAX';
            elseif nargin == 6
                compTiltMode = 'NAX';
            else
            end
        else
            % Continue
        end
    else
    end
    %%
    switch returnFlag(1)
        case 1 % About  component
            returnData1 = {'Prism'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            returnData2 = {[pathstr,'\Prism.jpg']};  % Image file name
            returnData3 = {['Prism: Is a general prism which can be used as',...
                ' Isosceles Prism, Right angled prism, Rooftop prism by',...
                ' changing the angle and ray path parameters.',...
                ' Example: theta_1 = 90, theta_2 = 45 and Ray path = S1-S3-S2 represents a',...
                ' Right angled prism bending light upwards.']};  % Text description
            
        case 2 % 'BasicComponentDataFields' table field names and initial values in COmponent Editor GUI
            returnData1 = {'RayPath','Glass','BaseAngle1','BaseAngle2','FirstSurfaceLengthX','FirstSurfaceLengthY'}; % parameter names
            returnData2 = {{'S1-S2','S1-S3','S1-S2-S3','S1-S3-S2','S1-S2-S3-S1','S1-S3-S2-S1'},{'Glass'},{'numeric'},{'numeric'},{'numeric'},{'numeric'}}; % parameter types ('Boolean','SQS','char','numeric',{'choise 1','choise 2'})
            defaultCompUniqueStruct = struct();
            defaultCompUniqueStruct.RayPath = 'S1-S2';
            defaultCompUniqueStruct.Glass = Glass('BK7');
            defaultCompUniqueStruct.BaseAngle1 = 60;
            defaultCompUniqueStruct.BaseAngle2 = 60;
            defaultCompUniqueStruct.FirstSurfaceLengthX = 20;
            defaultCompUniqueStruct.FirstSurfaceLengthY = 20;
            returnData3 = defaultCompUniqueStruct; % default value
            
        case 3 % 'Extra Data' table field names and initial values in Component Editor GUI
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            returnData3 = {[0]};
        case 4 % return the surface array of the compont
            returnData1 = computePrismSurfaceArray(componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode); % surface array
            returnData2 = NaN;
            returnData3 = NaN;
    end
end


function surfArray = computePrismSurfaceArray(componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,lastTiltMode)
    tempSurfaceArray = Surface;
    % Set surface1 properties
    tempSurfaceArray(1) = Surface;
    tempSurfaceArray(1).TiltDecenterOrder =  firstTiltDecenterOrder;
    tempSurfaceArray(1).Tilt = firstTilt;
    tempSurfaceArray(1).Decenter = firstDecenter;
    tempSurfaceArray(1).TiltMode = 'NAX';
    
    type = 'RectangularAperture';
    apertDecenter = [0,0];
    apertRotInDeg = 0;
    drawAbsolute = 0;
    outerShape = 'Rectangular';
    additionalEdge = 0;
    uniqueParameters = struct();
    uniqueParameters.DiameterX = componentParameters.FirstSurfaceLengthX;
    uniqueParameters.DiameterY = componentParameters.FirstSurfaceLengthY;
    
    tempSurfaceArray(1).Aperture = Aperture(type,apertDecenter,apertRotInDeg,...
        drawAbsolute,outerShape,additionalEdge,uniqueParameters);
    tempSurfaceArray(1).Glass = componentParameters.Glass;
    
    % Set surface2 and surface3 properties
    % Compute the initial tilt and decenters of surf 2 and 3
    % before applicatio of the tilt and decenter of surf 1
    baseAngle1InRad = componentParameters.BaseAngle1*pi/180;
    baseAngle2InRad = componentParameters.BaseAngle2*pi/180;
    
    baseAngle3InRad = pi - (baseAngle1InRad+baseAngle2InRad);
    % Alpha is the angle formaed by surf 2 and surf 3
    alpha = pi-baseAngle1InRad-baseAngle2InRad;
    %         fullApertureY1 = 2*componentParameters.Aperture_Y_Surf_1;
    fullApertureY1 = componentParameters.FirstSurfaceLengthY;
    % Using sin law of triangles
    fullApertureY2 = (sin (baseAngle2InRad)/sin (alpha))*fullApertureY1;
    fullApertureY3 = (sin (baseAngle1InRad)/sin (alpha))*fullApertureY1;
    % Using the centers of each side as decenter
    % parameterrs
    % Decenter of S2 with respect to S1
    decenterZ2 = 0.5*fullApertureY2*sin(baseAngle1InRad);
    decenterY2 = -0.5*fullApertureY2*cos(baseAngle1InRad)+0.5*fullApertureY1;
    decenterX2 = 0;
    % Decenter of S3 with respect to S1
    decenterZ3 = 0.5*fullApertureY3*sin(baseAngle2InRad);
    decenterY3 = 0.5*fullApertureY3*cos(baseAngle2InRad)-0.5*fullApertureY1;
    decenterX3 = 0;
    
    % Decenter of S1 with respect to S3 or
    % Decenter of S1 with respect to S2
    % Just take negative of the corresponding value
    
    % Know set the surface properties based on the RayPath
    switch componentParameters.RayPath
        case 'S1-S2'
            tempSurfaceArray(2) = Surface;
            newDecenter =[decenterX2,decenterY2,decenterZ2];
            tempSurfaceArray(1).Thickness = newDecenter(3);
            % 2nd surface parameters
            tempSurfaceArray(2).Thickness = lastThickness;
            tempSurfaceArray(2).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(2).Tilt = ...
                [-baseAngle1InRad*180/pi,0,0];
            tempSurfaceArray(2).Decenter = newDecenter(1:2);
            tempSurfaceArray(2).TiltMode = lastTiltMode;
            
            surf2Aperture = tempSurfaceArray(1).Aperture;
            surf2Aperture.UniqueParameters.DiameterY = fullApertureY2;
            tempSurfaceArray(2).Aperture = surf2Aperture;
        case 'S1-S3'
            tempSurfaceArray(2) = Surface;
            newDecenter = [decenterX3,decenterY3,decenterZ3];
            tempSurfaceArray(1).Thickness = newDecenter(3);
            % 2nd surface parameters
            tempSurfaceArray(2).Thickness = lastThickness;
            tempSurfaceArray(2).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(2).Tilt = ...
                [baseAngle1InRad*180/pi,0,0];
            tempSurfaceArray(2).Decenter = newDecenter(1:2);
            tempSurfaceArray(2).TiltMode = lastTiltMode;
            
            surf2Aperture = tempSurfaceArray(1).Aperture;
            surf2Aperture.UniqueParameters.DiameterY = fullApertureY3;
            tempSurfaceArray(2).Aperture = surf2Aperture;
            
        case 'S1-S2-S3'
            tempSurfaceArray(2) = Surface;
            tempSurfaceArray(3) = Surface;
            tempSurfaceArray(1).Thickness = decenterZ2;
            
            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
            newDecenter3 = [decenterX3,decenterY3,decenterZ3];
            
            % 2nd surface parameters
            tempSurfaceArray(2).Thickness = ...
                - 0.5*fullApertureY1*cos(2*baseAngle1InRad-pi/2);
            tempSurfaceArray(2).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(2).Tilt = ...
                [-baseAngle1InRad*180/pi,0,0];
            tempSurfaceArray(2).Decenter = newDecenter2(1:2);
            tempSurfaceArray(2).TiltMode = 'BEN';
            
            surf2Aperture = tempSurfaceArray(1).Aperture;
            surf2Aperture.UniqueParameters.DiameterY = fullApertureY2;
            tempSurfaceArray(2).Aperture = surf2Aperture;
            
            tempSurfaceArray(2).Glass = Glass('MIRROR');
            
            % 3rd surface parameters
            tempSurfaceArray(3).Thickness = -lastThickness;
            tempSurfaceArray(3).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(3).Tilt = ...
                -[(pi-(2*baseAngle1InRad+baseAngle2InRad))*180/pi,0,0];
            tempSurfaceArray(3).Decenter = ...
                [-newDecenter3(1),0.5*fullApertureY1*sin(2*baseAngle1InRad-pi/2)];
            tempSurfaceArray(3).TiltMode = lastTiltMode;
            
            surf3Aperture = tempSurfaceArray(1).Aperture;
            surf3Aperture.UniqueParameters.DiameterY = fullApertureY3;
            tempSurfaceArray(3).Aperture = surf3Aperture;
            
            
        case 'S1-S3-S2'
            tempSurfaceArray(2) = Surface;
            tempSurfaceArray(3) = Surface;
            tempSurfaceArray(1).Thickness = decenterZ3;
            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
            newDecenter3 = [decenterX3,decenterY3,decenterZ3];
            
            % 2nd surface parameters
            tempSurfaceArray(2).Thickness = ...
                - 0.5*fullApertureY1*cos(2*baseAngle2InRad-pi/2);
            tempSurfaceArray(2).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(2).Tilt = ...
                [baseAngle2InRad*180/pi,0,0];
            tempSurfaceArray(2).Decenter = newDecenter3(1:2);
            tempSurfaceArray(2).TiltMode = 'BEN';
            
            surf2Aperture = tempSurfaceArray(1).Aperture;
            surf2Aperture.UniqueParameters.DiameterY = fullApertureY2;
            tempSurfaceArray(2).Aperture = surf2Aperture;
            
            tempSurfaceArray(2).Glass = Glass('MIRROR');
            
            % 3rd surface parameters
            tempSurfaceArray(3).Thickness = -lastThickness;
            tempSurfaceArray(3).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(3).Tilt = ...
                -[(pi-(2*baseAngle2InRad+baseAngle1InRad))*180/pi,0,0];
            tempSurfaceArray(3).Decenter = ...
                [-newDecenter2(1),0.5*fullApertureY1*sin(2*baseAngle2InRad-pi/2)];
            tempSurfaceArray(3).TiltMode = lastTiltMode;
            
            surf3Aperture = tempSurfaceArray(1).Aperture;
            surf3Aperture.UniqueParameters.DiameterY = fullApertureY2;
            tempSurfaceArray(3).Aperture = surf3Aperture;
            
            
        case 'S1-S2-S3-S1'
            tempSurfaceArray(2) = Surface;
            tempSurfaceArray(3) = Surface;
            tempSurfaceArray(4) = Surface;
            tempSurfaceArray(1).Thickness = decenterZ2;
            
            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
            newDecenter3 = [decenterX3,decenterY3,decenterZ3];
            %                 % 2nd surface parameters
            %                 tempSurfaceArray(2).Thickness = ...
            %                     - 0.5*fullApertureY1*cos(2*baseAngle1InRad-pi/2);
            %
            %                 tempSurfaceArray(2).TiltDecenterOrder = ...
            %                     tempSurfaceArray(1).TiltDecenterOrder;
            %                 tempSurfaceArray(2).TiltParameter = ...
            %                     [-baseAngle1InRad*180/pi,0,0];
            %                 tempSurfaceArray(2).DecenterParameter = newDecenter2(1:2);
            %
            %                 tempSurfaceArray(2).TiltMode = 'BEN';
            %                 tempSurfaceArray(2).ApertureParameter = ...
            %                     tempSurfaceArray(1).ApertureParameter;
            %                 tempSurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY2;
            %                 tempSurfaceArray(2).ApertureType = ...
            %                     'Rectangular';
            %                 tempSurfaceArray(2).AbsoluteAperture = ...
            %                     true;
            %                 tempSurfaceArray(2).AdditionalEdge = ...
            %                     0;
            %                 tempSurfaceArray(2).Glass.Name = 'Mirror';
            %
            %                 % 3rd surface parameters
            %                 s1s3 = sqrt(decenterZ3^2+decenterY3^2);
            %                 tempSurfaceArray(3).Thickness = ...
            %                     s1s3*cos(2*baseAngle3InRad-baseAngle1InRad-pi/2);
            %                 tempSurfaceArray(3).TiltDecenterOrder = ...
            %                     tempSurfaceArray(1).TiltDecenterOrder;
            %                 tempSurfaceArray(3).TiltParameter = ...
            %                     -[(pi-(2*baseAngle1InRad+baseAngle2InRad))*180/pi,0,0];
            %
            %                 tempSurfaceArray(3).DecenterParameter = ...
            %                     [-newDecenter3(1),0.5*fullApertureY1*sin(2*baseAngle1InRad-pi/2)];
            %
            %                 tempSurfaceArray(3).TiltMode = 'BEN';
            %                 tempSurfaceArray(3).ApertureParameter = ...
            %                     tempSurfaceArray(1).ApertureParameter;
            %                 tempSurfaceArray(3).ApertureParameter(2) = 0.5*fullApertureY3;
            %                 tempSurfaceArray(3).ApertureType = ...
            %                     'Rectangular';
            %                 tempSurfaceArray(3).AbsoluteAperture = ...
            %                     true;
            %                 tempSurfaceArray(3).AdditionalEdge = ...
            %                     0;
            %                 tempSurfaceArray(3).Glass.Name = 'Mirror';
            % 2nd surface parameters
            tempSurfaceArray(2).Thickness = ...
                - 0.5*fullApertureY1*cos(2*baseAngle1InRad-pi/2);
            tempSurfaceArray(2).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(2).Tilt = ...
                [-baseAngle1InRad*180/pi,0,0];
            tempSurfaceArray(2).Decenter = newDecenter2(1:2);
            tempSurfaceArray(2).TiltMode = 'BEN';
            
            surf2Aperture = tempSurfaceArray(1).Aperture;
            surf2Aperture.UniqueParameters.DiameterY = fullApertureY2;
            tempSurfaceArray(2).Aperture = surf2Aperture;
            
            tempSurfaceArray(2).Glass = Glass('MIRROR');
            
            % 3rd surface parameters
            s1s3 = sqrt(decenterZ3^2+decenterY3^2);
            tempSurfaceArray(3).Thickness = ...
                s1s3*cos(2*baseAngle3InRad-baseAngle1InRad-pi/2);
            tempSurfaceArray(3).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(3).Tilt = ...
                -[(pi-(2*baseAngle1InRad+baseAngle2InRad))*180/pi,0,0];
            tempSurfaceArray(3).Decenter = ...
                [-newDecenter3(1),0.5*fullApertureY1*sin(2*baseAngle1InRad-pi/2)];
            tempSurfaceArray(3).TiltMode = 'BEN';
            tempSurfaceArray(3).Glass = Glass('MIRROR');
            
            surf3Aperture = tempSurfaceArray(1).Aperture;
            surf3Aperture.UniqueParameters.DiameterY = fullApertureY3;
            tempSurfaceArray(3).Aperture = surf3Aperture;
            
            %                 % 4th surface parameters
            %                 tempSurfaceArray(4).Thickness = ...
            %                     componentParameters.Distance_After_Prism;
            %                 tempSurfaceArray(4).TiltDecenterOrder = ...
            %                     tempSurfaceArray(1).TiltDecenterOrder;
            %
            %                 tempSurfaceArray(4).TiltParameter = ...
            %                     [(baseAngle3InRad-(baseAngle1InRad+baseAngle2InRad))*180/pi,0,0];
            %
            %                 tempSurfaceArray(4).DecenterParameter(1) = ...
            %                     newDecenter3(1);
            %                 tempSurfaceArray(4).DecenterParameter(2) = ...
            %                     -s1s3*sin(2*baseAngle3InRad-baseAngle1InRad-pi/2);
            %
            %                 tempSurfaceArray(4).TiltMode = 'NAX';
            %                 tempSurfaceArray(4).ApertureParameter = ...
            %                     tempSurfaceArray(1).ApertureParameter;
            %                 tempSurfaceArray(4).ApertureType = ...
            %                     'Rectangular';
            %                 tempSurfaceArray(4).AbsoluteAperture = ...
            %                     true;
            %                 tempSurfaceArray(4).AdditionalEdge = ...
            %                     0;
            % 4th surface parameters
            tempSurfaceArray(4).Thickness = lastThickness;
            tempSurfaceArray(4).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(4).Tilt = ...
                [(baseAngle3InRad-(baseAngle1InRad+baseAngle2InRad))*180/pi,0,0];
            tempSurfaceArray(4).Decenter = ...
                [newDecenter3(1),-s1s3*sin(2*baseAngle3InRad-baseAngle1InRad-pi/2)];
            tempSurfaceArray(4).TiltMode = lastTiltMode;
            
            surf3Aperture = tempSurfaceArray(1).Aperture;
            tempSurfaceArray(4).Aperture = surf3Aperture;
            
            
        case 'S1-S3-S2-S1'
            tempSurfaceArray(2) = Surface;
            tempSurfaceArray(3) = Surface;
            tempSurfaceArray(4) = Surface;
            tempSurfaceArray(1).Thickness = decenterZ2;
            
            newDecenter2 =[decenterX2,decenterY2,decenterZ2];
            newDecenter3 = [decenterX3,decenterY3,decenterZ3];
            %                 % 2nd surface parameters
            %                 tempSurfaceArray(2).Thickness = ...
            %                     - 0.5*fullApertureY1*cos(2*baseAngle2InRad-pi/2);
            %
            %                 tempSurfaceArray(2).TiltDecenterOrder = ...
            %                     tempSurfaceArray(1).TiltDecenterOrder;
            %                 tempSurfaceArray(2).TiltParameter = ...
            %                     [baseAngle2InRad*180/pi,0,0];
            %                 tempSurfaceArray(2).DecenterParameter = newDecenter3(1:2);
            %
            %                 tempSurfaceArray(2).TiltMode = 'BEN';
            %                 tempSurfaceArray(2).ApertureParameter = ...
            %                     tempSurfaceArray(1).ApertureParameter;
            %                 tempSurfaceArray(2).ApertureParameter(2) = 0.5*fullApertureY3;
            %                 tempSurfaceArray(2).ApertureType = ...
            %                     'Rectangular';
            %                 tempSurfaceArray(2).AbsoluteAperture = ...
            %                     true;
            %                 tempSurfaceArray(2).AdditionalEdge = ...
            %                     0;
            %                 tempSurfaceArray(2).Glass.Name = 'Mirror';
            %
            %                 % 3rd surface parameters
            %                 s1s2 = sqrt(decenterZ2^2+decenterY2^2);
            %                 tempSurfaceArray(3).Thickness = ...
            %                     s1s2*cos(2*baseAngle3InRad-baseAngle2InRad-pi/2);
            %                 tempSurfaceArray(3).TiltDecenterOrder = ...
            %                     tempSurfaceArray(1).TiltDecenterOrder;
            %                 tempSurfaceArray(3).TiltParameter = ...
            %                     [(pi-(2*baseAngle2InRad+baseAngle1InRad))*180/pi,0,0];
            %
            %                 tempSurfaceArray(3).DecenterParameter = ...
            %                     [-newDecenter2(1),0.5*fullApertureY1*sin(2*baseAngle2InRad-pi/2)];
            %
            %                 tempSurfaceArray(3).TiltMode = 'BEN';
            %                 tempSurfaceArray(3).ApertureParameter = ...
            %                     tempSurfaceArray(1).ApertureParameter;
            %                 tempSurfaceArray(3).ApertureParameter(2) = 0.5*fullApertureY2;
            %                 tempSurfaceArray(3).ApertureType = ...
            %                     'Rectangular';
            %                 tempSurfaceArray(3).AbsoluteAperture = ...
            %                     true;
            %                 tempSurfaceArray(3).AdditionalEdge = ...
            %                     0;
            %                 tempSurfaceArray(3).Glass.Name = 'Mirror';
            
            
            % 2nd surface parameters
            tempSurfaceArray(2).Thickness = ...
                - 0.5*fullApertureY1*cos(2*baseAngle2InRad-pi/2);
            tempSurfaceArray(2).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(2).Tilt = ...
                [baseAngle2InRad*180/pi,0,0];
            tempSurfaceArray(2).Decenter = newDecenter3(1:2);
            tempSurfaceArray(2).TiltMode = 'BEN';
            
            surf2Aperture = tempSurfaceArray(1).Aperture;
            surf2Aperture.UniqueParameters.DiameterY = fullApertureY3;
            tempSurfaceArray(2).Aperture = surf2Aperture;
            
            tempSurfaceArray(2).Glass = Glass('MIRROR');
            
            % 3rd surface parameters
            s1s2 = sqrt(decenterZ2^2+decenterY2^2);
            tempSurfaceArray(3).Thickness = ...
                s1s2*cos(2*baseAngle3InRad-baseAngle2InRad-pi/2);
            tempSurfaceArray(3).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(3).Tilt = ...
                [(pi-(2*baseAngle2InRad+baseAngle1InRad))*180/pi,0,0];
            tempSurfaceArray(3).Decenter = ...
                [-newDecenter2(1),0.5*fullApertureY1*sin(2*baseAngle2InRad-pi/2)];
            tempSurfaceArray(3).TiltMode = 'BEN';
            
            surf3Aperture = tempSurfaceArray(1).Aperture;
            surf3Aperture.UniqueParameters.DiameterY = fullApertureY2;
            tempSurfaceArray(3).Aperture = surf3Aperture;
            tempSurfaceArray(3).Glass = Glass('MIRROR');
            
            
            
            %                 % 4th surface parameters
            %                 tempSurfaceArray(4).Thickness = ...
            %                     componentParameters.Distance_After_Prism;
            %                 tempSurfaceArray(4).TiltDecenterOrder = ...
            %                     tempSurfaceArray(1).TiltDecenterOrder;
            %
            %                 tempSurfaceArray(4).TiltParameter = ...
            %                     [(baseAngle3InRad-(baseAngle2InRad+baseAngle1InRad))*180/pi,0,0];
            %
            %                 tempSurfaceArray(4).DecenterParameter(1) = ...
            %                     newDecenter2(1);
            %                 tempSurfaceArray(4).DecenterParameter(2) = ...
            %                     s1s2*sin(2*baseAngle3InRad-baseAngle2InRad-pi/2);
            %
            %                 tempSurfaceArray(4).TiltMode = 'NAX';
            %                 tempSurfaceArray(4).ApertureParameter = ...
            %                     tempSurfaceArray(1).ApertureParameter;
            %                 tempSurfaceArray(4).ApertureType = ...
            %                     'Rectangular';
            %                 tempSurfaceArray(4).AbsoluteAperture = ...
            %                     true;
            %                 tempSurfaceArray(4).AdditionalEdge = ...
            %                     0;
            
            % 4th surface parameters
            tempSurfaceArray(4).Thickness = lastThickness;
            tempSurfaceArray(4).TiltDecenterOrder = ...
                tempSurfaceArray(1).TiltDecenterOrder;
            tempSurfaceArray(4).Tilt = ...
                [(baseAngle3InRad-(baseAngle1InRad+baseAngle2InRad))*180/pi,0,0];
            tempSurfaceArray(4).Decenter = ...
                [newDecenter2(1),s1s2*sin(2*baseAngle3InRad-baseAngle2InRad-pi/2)];
            tempSurfaceArray(4).TiltMode = lastTiltMode;
            
            surf3Aperture = tempSurfaceArray(1).Aperture;
            tempSurfaceArray(4).Aperture = surf3Aperture;
            
    end
    surfArray = tempSurfaceArray;
end