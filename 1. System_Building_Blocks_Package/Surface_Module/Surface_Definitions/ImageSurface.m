function [ returnDataStruct] = ImageSurface(returnFlag,surfaceParameters,inputDataStruct)
    %ImageSurface: Image surface (assumed to be plane)
    % surfaceParameters = values of {'Unused'}
    % inputDataStruct : Struct of all additional inputs (not included in the surface parameters)
    % required for computing the return. (Vary depending on the returnFlag)
    % returnFlag : An integer indicating what is requested. Depending on it the
    % returnDataStruct will have different fields
    % 1: About the surface
    %   inputDataStruct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.Name
    %       returnDataStruct.ImageFullFileName
    %       returnDataStruct.Description
    % 2: Surface specific 'UniqueSurfaceParameters' table field names and initial values in Surface Editor GUI
    %   inputDataStruct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.UniqueParametersStructFieldNames
    %       returnDataStruct.UniqueParametersStructFieldTypes
    %       returnDataStruct.DefaultUniqueParametersStruct
    % 3: Surface specific 'Extra Data' table field names and initial values in Surface Editor GUI
    %   inputDataStruct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.UniqueExtraDataFieldNames
    %       returnDataStruct.DefaultUniqueExtraData
    % 4: Return the surface sag at given xyGridPoints computed from rayPosition % Used for plotting the surface
    %   inputDataStruct:
    %       inputDataStruct.xyMeshGrid
    %   Output Struct:
    %       returnDataStruct.MainSag
    %       returnDataStruct.AlternativeSag
    % 5: Paraxial ray trace results (Ray height and angle)
    %   inputDataStruct:
    %       inputDataStruct.InputParaxialRayParameters
    %       inputDataStruct.IndexBefore
    %       inputDataStruct.IndexAfter
    %       inputDataStruct.Wavelength
    %       inputDataStruct.ReflectionFlag
    %       inputDataStruct.ReverseTracingFlag
    %   Output Struct:
    %       returnDataStruct.OutputParaxialRayParameters
    % 6: Real Ray trace results (Surface intersection points, Surface normal, Path length to the surface intersection points, Exit ray direction, Exit ray position for given
    %   inputDataStruct:
    %       inputDataStruct.InitialRayPosition
    %       inputDataStruct.InitialRayDirection
    %       inputDataStruct.IndexBefore
    %       inputDataStruct.IndexAfter
    %       inputDataStruct.Wavelength
    %       inputDataStruct.ReferenceWavelength
    %       inputDataStruct.ReflectionFlag
    %       inputDataStruct.ReverseTracingFlag
    %   Output Struct:
    %       returnDataStruct.GeometricalPathLength
    %       returnDataStruct.AdditionalPathLength
    %       returnDataStruct.LocalRayIntersectionPoint
    %       returnDataStruct.LocalSurfaceNormal
    %       returnDataStruct.LocalExitRayPosition
    %       returnDataStruct.LocalExitRayDirection
    %       returnDataStruct.TotalInternalReflectionFlag
    %       returnDataStruct.NoIntersectionPointFlag
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    % Jul 10,2015   Worku, Norman G.     input and output are made struct
    %% Default input vaalues
    if nargin == 0
        disp('Error: The function ImageSurface() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 2 || returnFlag == 3 || returnFlag == 4
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for ImageSurface().');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % About the surface
            surfName = {'ImageSurface','IMG'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            imageFullFileName = {[pathstr,'\Surface.jpg']};  % Image file name
            description = {['ImageSurface: An image surface.']};  % Text description
            
            returnDataStruct = struct();
            returnDataStruct.Name = surfName;
            returnDataStruct.ImageFullFileName = imageFullFileName;
            returnDataStruct.Description =  description;
        case 2 % Surface specific 'UniqueSurfaceParameters'
            uniqueParametersStructFieldNames = {'Unused'};
            uniqueParametersStructFieldTypes = {{'numeric'}};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.Unused = 0;
            
            returnDataStruct = struct();
            returnDataStruct.UniqueParametersStructFieldNames = uniqueParametersStructFieldNames;
            returnDataStruct.UniqueParametersStructFieldTypes = uniqueParametersStructFieldTypes;
            returnDataStruct.DefaultUniqueParametersStruct = defaultUniqueParametersStruct;
        case 3 % Surface specific 'Extra Data' table
            uniqueExtraDataFieldNames = {'Unused'};
            defaultUniqueExtraData = {[0]};
            
            returnDataStruct = struct();
            returnDataStruct.UniqueExtraDataFieldNames = uniqueExtraDataFieldNames;
            returnDataStruct.DefaultUniqueExtraData = defaultUniqueExtraData;
        case 4 % Surface sag at given xyGridPoints
            % Just assume plane surface
            xyCoordinateMeshGrid = inputDataStruct.xyMeshGrid;
            mainSag = zeros(size(xyCoordinateMeshGrid,1),size(xyCoordinateMeshGrid,2));
            
            returnDataStruct = struct();
            returnDataStruct.MainSag = mainSag;
            returnDataStruct.AlternativeSag = mainSag;
        case 5 % Paraxial ray trace results
            y = inputDataStruct.InputParaxialRayParameters(1,:);
            u = inputDataStruct.InputParaxialRayParameters(2,:);
            % the height and angle doesnot change
            yf = y;
            uf = u;
            outputParaxialRayParameters = [yf,uf]';
            returnDataStruct = struct();
            returnDataStruct.OutputParaxialRayParameters = outputParaxialRayParameters;
        case 6 % Real Ray trace results
            rayPosition = inputDataStruct.InitialRayPosition;
            rayDirection = inputDataStruct.InitialRayDirection;
            reverseTracing = inputDataStruct.ReverseTracingFlag;
            reflection = inputDataStruct.ReflectionFlag;
            indexBefore = inputDataStruct.IndexBefore;
            indexAfter = inputDataStruct.IndexAfter;
            wavlenInM = inputDataStruct.Wavelength;
            
            %% Path length calculation
            % Just assume plane surface
            nRay = size(rayPosition,2);
            initialPoint = rayPosition; % define the start point
            k = rayDirection(1,:);
            l = rayDirection(2,:);
            m = rayDirection(3,:);
            distanceToXY = -initialPoint(3,:)./m;
            geometricalPathLength = distanceToXY;
            additionalPathLength = zeros(1,size(rayPosition,2));
            
            NoIntersectioPoint = zeros([1,nRay]);
            NoIntersectioPoint(~(isreal(distanceToXY))) = 1;
            noIntersectionPointFlag = NoIntersectioPoint;
            
            %% Intersection point calculation
            % Just assume plane surface
            intersectionPointXY  = ...
                [initialPoint(1,:) +  distanceToXY.*k;...
                initialPoint(2,:) +  distanceToXY.*l;...
                zeros([1,nRay])];
            surfaceNormal = repmat([0;0;1],[1,nRay]);
            localRayIntersectionPoint = intersectionPointXY;
            localSurfaceNormal = surfaceNormal;
            
            %% Exit ray position and direction
            % Just assume plane surface
            localExitRayPosition = localRayIntersectionPoint;
            TIR = ones(1,size(localExitRayPosition,2));
            
            localExitRayDirection = rayDirection;
            totalInternalReflectionFlag = TIR;
            
            returnDataStruct = struct();
            returnDataStruct.GeometricalPathLength = geometricalPathLength;
            returnDataStruct.AdditionalPathLength = additionalPathLength;
            returnDataStruct.LocalRayIntersectionPoint = localRayIntersectionPoint;
            returnDataStruct.LocalSurfaceNormal = localSurfaceNormal;
            returnDataStruct.LocalExitRayPosition = localExitRayPosition;
            returnDataStruct.LocalExitRayDirection = localExitRayDirection;
            returnDataStruct.TotalInternalReflectionFlag = totalInternalReflectionFlag;
            returnDataStruct.NoIntersectionPointFlag = noIntersectionPointFlag;
        otherwise
    end
end
