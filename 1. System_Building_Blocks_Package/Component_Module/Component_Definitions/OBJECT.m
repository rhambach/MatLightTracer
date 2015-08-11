function [ returnData1, returnData2, returnData3] = OBJECT( ...
        returnFlag,componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode)
    %OBJECT COmponent for object surfaces

    %% Default input vaalues
    if nargin == 0
        disp('Error: The function OBJECT() needs atleat the return type.');
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
            returnData1 = {'OBJECT'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            returnData2 = {[pathstr,'\OBJECT.jpg']};  % Image file name
            returnData3 = {['Object surface: is a plane sequence.']};  % Text description
            
        case 2 % 'BasicComponentDataFields' table field names and initial values in COmponent Editor GUI
            returnData1 = {'Unused'}; % parameter names
            returnData2 = {{'numeric'}}; % parameter types ('Boolean','SQS','char','numeric',{'choise 1','choise 2'})
            defaultCompUniqueStruct = struct();
            defaultCompUniqueStruct.Unused = 0;
            returnData3 = defaultCompUniqueStruct; % default value
            
        case 3 % 'Extra Data' table field names and initial values in Component Editor GUI
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            returnData3 = {[0]};
        case 4 % return the surface array of the compont
            surfaceArray = Surface;
            surfaceArray(1).IsObject = 1;
            surfaceArray(1).Tilt = firstTilt;
            surfaceArray(1).Decenter = firstDecenter;
            surfaceArray(1).TiltDecenterOrder = firstTiltDecenterOrder;
            surfaceArray(end).Thickness = lastThickness;
            surfaceArray(end).TiltMode = compTiltMode;
            
            returnData1 = surfaceArray; % surface array
            returnData2 = NaN;
            returnData3 = NaN;
            
            
    end
