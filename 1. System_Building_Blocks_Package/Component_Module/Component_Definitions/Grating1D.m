function [ returnData1, returnData2, returnData3] = Grating1D( ...
        returnFlag,componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode)
    %Grating1D Component defining a simple 1 dimensional grating
    
    %% Default input vaalues
    if nargin == 0
        disp('Error: The function Grating1D() needs atleat the return type.');
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
                lastThickness = 5;
                compTiltMode = 'NAX';
            elseif nargin == 2
                firstTilt = [0,0,0];
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 5;
                compTiltMode = 'NAX';
            elseif nargin == 3
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 5;
                compTiltMode = 'NAX';
            elseif nargin == 4
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 5;
                compTiltMode = 'NAX';
            elseif nargin == 5
                lastThickness = 5;
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
            returnData1 = {'Grating1D'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            returnData2 = {[pathstr,'\Grating1D.jpg']};  % Image file name
            returnData3 = {['Grating1D: Is a one dimensional grating on a plane',...
                ' surface. If the glass after the grating is set to MIRROR then',...
                ' the grating is used in reflective mode and otherwise it is used',...
                ' in refractive mode. The grating is defined by the grating line',...
                ' density (lines/um) and diffraction order.']};  % Text description
            
        case 2 % 'BasicComponentDataFields' table field names and initial values in COmponent Editor GUI
            returnData1 = {'Glass','LineDensity','DiffractionOrder','LengthX','LengthY'}; % parameter names
            returnData2 = {{'Glass'},{'numeric'},{'numeric'},{'numeric'},{'numeric'}}; % parameter types ('Boolean','SQS','char','numeric',{'choise 1','choise 2'})
            defaultCompUniqueStruct = struct();
            defaultCompUniqueStruct.Glass = Glass('');
            defaultCompUniqueStruct.LineDensity = 100;
            defaultCompUniqueStruct.DiffractionOrder = 1;
            defaultCompUniqueStruct.LengthX = 10;
            defaultCompUniqueStruct.LengthY = 10;
            returnData3 = defaultCompUniqueStruct; % default value
        case 3 % 'Extra Data' table field names and initial values in Component Editor GUI
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            returnData3 = {[0]};
        case 4 % return the surface array of the compont
            returnData1 = computeGrating1DSurfaceArray(componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode); % surface array
            returnData2 = NaN;
            returnData3 = NaN;
    end
end


function surfArray = computeGrating1DSurfaceArray(componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode)
    tempSurfaceArray = Surface;
    tempSurfaceArray(1).Tilt = firstTilt;
    tempSurfaceArray(1).Decenter = firstDecenter;
    tempSurfaceArray(1).TiltDecenterOrder = firstTiltDecenterOrder;
    tempSurfaceArray(end).Thickness = lastThickness;
    tempSurfaceArray(end).TiltMode = compTiltMode;
    
    %     tempSurfaceArray = Surface;
    % Set surface1 properties
    % tempSurfaceArray(1) = Surface;
    % tempSurfaceArray(1).TiltDecenterOrder =  'DxDyDzTxTyTz';
    % tempSurfaceArray(1).TiltParameter = [componentParameters.Tilt_Angle_X,...
    %     componentParameters.Tilt_Angle_Y, componentParameters.Tilt_Angle_Z];
    % tempSurfaceArray(1).DecenterParameter = ...
    %     [componentParameters.Decenter_X, componentParameters.Decenter_Y];
     tempSurfaceArray(1).TiltMode = compTiltMode;
    
    
    
    type = 'RectangularAperture';
    apertDecenter = [0,0];
    apertRotInDeg = 0;
    drawAbsolute = 0;
    outerShape = 'Rectangular';
    additionalEdge = 0;
    uniqueParameters = struct();
    uniqueParameters.DiameterX = componentParameters.LengthX;
    uniqueParameters.DiameterY = componentParameters.LengthY;
    
    tempSurfaceArray(1).Aperture = Aperture(type,apertDecenter,apertRotInDeg,...
        drawAbsolute,outerShape,additionalEdge,uniqueParameters);
    
    % tempSurfaceArray(1).ApertureType = ...
    %     componentParameters.Aperture_Type;
    % tempSurfaceArray(1).ApertureParameter = ...
    %     [componentParameters.Aperture_X, componentParameters.Aperture_Y,0,0];
    % tempSurfaceArray(1).AbsoluteAperture = ...
    %     true;
    % tempSurfaceArray(1).AdditionalEdge = ...
    %     0;
    
    tempSurfaceArray(1).Glass = componentParameters.Glass;
    % % Check wether it is Stop or not
    % if componentParameters.Stop_Surface
    %     tempSurfaceArray(1).Stop = 1;
    % end
    
    tempSurfaceArray(1).Thickness = lastThickness;
    
    tempSurfaceArray(1).UniqueParameters.GratingLineDensity = ...
        componentParameters.LineDensity;
    tempSurfaceArray(1).UniqueParameters.DiffractionOrder = ...
        componentParameters.DiffractionOrder;
    
    surfArray = tempSurfaceArray;
end