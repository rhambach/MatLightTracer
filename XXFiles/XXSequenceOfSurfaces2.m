function [ returnData1, returnData2, returnData3] = SequenceOfSurfaces( ...
        returnFlag,componentParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,compTiltMode)
    
    %SequenceOfSurfaces COmponent composed of a general sequence of surfaces
    
    %% Default input values
    if nargin == 0
        disp('Error: The function SequenceOfSurfaces() needs atleat the return type.');
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
                stopSurfaceIndex = 0;
            elseif nargin == 2
                firstTilt = [0,0,0];
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
                stopSurfaceIndex = 0;
            elseif nargin == 3
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
                stopSurfaceIndex = 0;
            elseif nargin == 4
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                lastThickness = 10;
                compTiltMode = 'NAX';
                stopSurfaceIndex = 0;
            elseif nargin == 5
                lastThickness = 10;
                compTiltMode = 'NAX';
                stopSurfaceIndex = 0;
            elseif nargin == 6
                compTiltMode = 'NAX';
                stopSurfaceIndex = 0;
            else
                stopSurfaceIndex = 0;
            end
        else
            % Continue
        end
    else
    end
    %%
    switch returnFlag(1)
        case 1 % About  component
            returnData1 = {'SQS'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            returnData2 = {[pathstr,'\SequenceOfSurfaces.jpg']};  % Image file name
            returnData3 = {['Sequence of surface: is a general sequence of'...
                ' surface whose tilt, decenter and aperture parameters are',...
                ' determined by that of the primary surface, which is usually',...
                ' the first surface in the sequence. It can be used to',...
                ' represent a single surface, singlet lens, doublet lens ...']};  % Text description
        case 2 % 'BasicComponentDataFields' table field names and initial values in COmponent Editor GUI
            returnData1 = {'SurfaceArray'}; % parameter names
            returnData2 = {{'SQS'}}; % parameter types ('Boolean','SQS','char','numeric',{'choise 1','choise 2'})
            defaultCompUniqueStruct = struct();
            defaultCompUniqueStruct.SurfaceArray = Surface;
            returnData3 = defaultCompUniqueStruct; % default value
        case 3 % 'Extra Data' table field names and initial values in Component Editor GUI
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            returnData3 = {[0]};
        case 4 % return the surface array of the compont
            surfaceArray = componentParameters.SurfaceArray;
            surfaceArray(1).Tilt = firstTilt;
            surfaceArray(1).Decenter = firstDecenter;
            surfaceArray(1).TiltDecenterOrder = firstTiltDecenterOrder;
            surfaceArray(end).Thickness = lastThickness;
            surfaceArray(end).TiltMode = compTiltMode;
            
            
            returnData1 = surfaceArray; % surface array
            returnData2 = NaN;
            returnData3 = NaN;
    end
