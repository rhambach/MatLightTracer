function [ returnDataStruct] = Kostenbauder(returnFlag,surfaceParameters,inputDataStruct)
    %KOSTENBAUDER Represent an ideal kostenbuder matrix surface defined by 4x4
    % matrix in general. If the refrernce ray is axial ray, then Kostenbuder
    % matrix surface can represent the normal ABCD matrix surfaces
    % surfaceParameters = values of {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I'}
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
        disp('Error: The function Kostenbauder() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 2 || returnFlag == 3 || returnFlag == 4
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for Kostenbauder().');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % About the surface
            surfName = {'Kostenbauder','KOST'};; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            imageFullFileName = {[pathstr,'\Surface.jpg']};  % Image file name
            description = {['Kostenbauder: Used to define an ideal Kostenbauder matrix element.']};  % Text description
            
            returnDataStruct = struct();
            returnDataStruct.Name = surfName;
            returnDataStruct.ImageFullFileName = imageFullFileName;
            returnDataStruct.Description =  description;
        case 2 % Surface specific 'UniqueSurfaceParameters'
            uniqueParametersStructFieldNames = {'A','B','C','D','E','F','G','H','I'};
            uniqueParametersStructFieldTypes = {{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'}};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.A = 0;
            defaultUniqueParametersStruct.B = 0;
            defaultUniqueParametersStruct.C = 0;
            defaultUniqueParametersStruct.D = 0;
            defaultUniqueParametersStruct.E = 0;
            defaultUniqueParametersStruct.F = 0;
            defaultUniqueParametersStruct.G = 0;
            defaultUniqueParametersStruct.H = 0;
            defaultUniqueParametersStruct.I = 0;
            
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
            reverseTracing = inputDataStruct.ReverseTracingFlag;
            indexBefore = inputDataStruct.IndexBefore;
            indexAfter = inputDataStruct.IndexAfter;
            A = surfaceParameters.A;
            B = surfaceParameters.B;
            C = surfaceParameters.C;
            D = surfaceParameters.D;
            
            % Use the ABCD matrix for paraxial ray tracing
            ABCD = [A,B;C,D];
            invABCD = (1/(A*D-B*C))*[D,-B;-C,A];
            if ~reverseTracing
                %forward trace
                yf = ABCD(1,1)*y + ABCD(1,2)*u ;
                uf = ABCD(2,1)*y + ABCD(2,2)*u ;
            else
                %reverse trace
                yf = invABCD(1,1)*y + invABCD(1,2)*u ;
                uf = invABCD(2,1)*y + invABCD(2,2)*u ;
            end
            
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
            refWavlenInM = inputDataStruct.ReferenceWavelength;
            
            A = surfaceParameters.A;
            B = surfaceParameters.B;
            C = surfaceParameters.C;
            D = surfaceParameters.D;
            E = surfaceParameters.E;
            F = surfaceParameters.F;
            
            speedOfLightInVacuum = 299792458;
            %% Path length calculation
            % Just assume plane surface
            nRay = size(rayPosition,2);
            initialPoint = rayPosition; % define the start point
            k = rayDirection(1,:);
            l = rayDirection(2,:);
            m = rayDirection(3,:);
            distanceToXY = -initialPoint(3,:)./m;
            intersectionPointXY  = ...
                [initialPoint(1,:) +  distanceToXY.*k;...
                initialPoint(2,:) +  distanceToXY.*l;...
                zeros([1,nRay])];
            
            geometricalPathLength = distanceToXY;
            NoIntersectioPoint = zeros([1,nRay]);
            NoIntersectioPoint(imag(distanceToXY) ~= 0) = 1;
            geometricalPathLength(imag(distanceToXY) ~= 0) = NaN;
            noIntersectionPointFlag = NoIntersectioPoint;
            
            % Ref: http://www2.ph.ed.ac.uk/~wjh/teaching/mo/slides/lens/lens.pdf
            % additionalPathLength = -(2*pi./wavlenInM).*(intersectionPointXY(1,:).^2+intersectionPointXY(2,:).^2)./(2*focalLength);
            % additionalPathLength = -(intersectionPointXY(1,:).^2+intersectionPointXY(2,:).^2)/(2*focalLength);
            additionalPathLength = -(sqrt(intersectionPointXY(1,:).^2+intersectionPointXY(2,:).^2 + focalLength^2)-focalLength);
            % additionalPathLength = -(2*pi/(wavlenInM)).*(intersectionPointXY(1,:).^2+intersectionPointXY(2,:).^2)/(2*focalLength);
            
            %% Intersection point calculation
            localSurfaceNormal = repmat([0;0;1],[1,nRay]);
            localRayIntersectionPoint = intersectionPointXY;
            
            %% Exit ray position and direction
            % Just use the positions and  direction cosines with the ABCD matrix
            delWaveLength = wavlenInM-refWavlenInM;
            refFrequency = speedOfLightInVacuum./refWavlenInM;
            frequency = speedOfLightInVacuum./wavlenInM;
            delFrequency = -((refFrequency^2)/(speedOfLightInVacuum))*delWaveLength;
            
            
            % The Z and X position remins unchanged
            exitRayPosition(1,:) = rayPosition(1,:);
            exitRayPosition(3,:) = rayPosition(3,:);
            % Kostenbauder matrix apply for y positions
            exitRayPosition(2,:) = ((1./indexAfter)).*((indexBefore).*rayDirection(2,:)*B+rayPosition(2,:)*A+ (delFrequency*E));
            
            localExitRayPosition = exitRayPosition;
            
            delWaveLength = wavlenInM-refWavlenInM;
            refFrequency = speedOfLightInVacuum./refWavlenInM;
            frequency = speedOfLightInVacuum./wavlenInM;
            delFrequency = -((refFrequency^2)/(speedOfLightInVacuum))*delWaveLength;
            
            % X direction not changed
            exitRayDirection(1,:) = rayDirection(1,:);
            % Y direction changed by the Kostenbauder matrix
            exitRayAnglesInY = (((1./indexAfter)).*((indexBefore).*acos(rayDirection(2,:))*D - rayPosition(2,:)*C + (delFrequency*F)));
            exitRayDirection(2,:) = cos(exitRayAnglesInY).*sign(exitRayAnglesInY);
            % The Z direction cosine shall be computed in such a way that the
            % mag of direction vector is unity
            exitRayDirection(3,:) = sqrt(1-exitRayDirection(1,:).^2-exitRayDirection(2,:).^2);
            TIR = ones(1,size(exitRayDirection,2));
            
            localExitRayDirection = exitRayDirection;
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

