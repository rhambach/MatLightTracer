function [ returnDataStruct] = Standard(returnFlag,surfaceParameters,inputDataStruct)
    %STANDARD Standard surface definition
    % surfaceParameters = values of {'Radius','Conic','GratingLineDensity','DiffractionOrder'}
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
        disp('Error: The function Standard() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 2 || returnFlag == 3 || returnFlag == 4
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for Standard().');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % About the surface
            surfName = {'Standard','STND'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            imageFullFileName = {[pathstr,'\Surface.jpg']};  % Image file name
            description = {['Standard: Used to define standard conical surfaces.']};  % Text description
            
            returnDataStruct = struct();
            returnDataStruct.Name = surfName;
            returnDataStruct.ImageFullFileName = imageFullFileName;
            returnDataStruct.Description =  description;
        case 2 % Surface specific 'UniqueSurfaceParameters'
            uniqueParametersStructFieldNames = {'Radius','Conic','GratingLineDensity','DiffractionOrder'};
            uniqueParametersStructFieldTypes = {{'numeric'},{'numeric'},{'numeric'},{'numeric'}};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.Radius = Inf;
            defaultUniqueParametersStruct.Conic = 0;
            defaultUniqueParametersStruct.GratingLineDensity = 0;
            defaultUniqueParametersStruct.DiffractionOrder = 0;
            
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
            surfaceRadius = surfaceParameters.Radius;
            surfaceConic = surfaceParameters.Conic;
            surfaceGratingLineDensity = surfaceParameters.GratingLineDensity;
            if surfaceGratingLineDensity
                gratingHeight = 0.1*surfaceRadius;
            else
                gratingHeight = 0;
            end
            xyCoordinateMeshGrid = inputDataStruct.xyMeshGrid;
            mainSag = computeStandardSurfaceSag(surfaceRadius,surfaceConic,xyCoordinateMeshGrid,gratingHeight);
            
            returnDataStruct = struct();
            returnDataStruct.MainSag = mainSag;
            returnDataStruct.AlternativeSag = mainSag;
        case 5 % Paraxial ray trace results
            y = inputDataStruct.InputParaxialRayParameters(1,:);
            u = inputDataStruct.InputParaxialRayParameters(2,:);
            reverseTracing = inputDataStruct.ReverseTracingFlag;
            indexBefore = inputDataStruct.IndexBefore;
            indexAfter = inputDataStruct.IndexAfter;
            surfaceRadius = surfaceParameters.Radius;
            % the height doesnot change
            yf = y;
            % for angle compute based on the direction of propagation
            if ~reverseTracing
                %forward trace
                c = 1/surfaceRadius;
                n = indexBefore;
                nPrime = indexAfter;
            else
                %reverse trace
                c = -1/surfaceRadius;
                n = indexAfter;
                nPrime = indexBefore;
            end
            paI = u+yf*c; %The yui method generates the paraxial angles of incidence
            % during the trace and is probably the most common method used in computer programs.
            uf = u+((n/nPrime)-1)*paI;
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
            
            surfaceRadius = surfaceParameters.Radius;
            surfaceConic = surfaceParameters.Conic;
            surfaceDiffractionOrder = surfaceParameters.DiffractionOrder;
            surfaceGratingLineDensity = surfaceParameters.GratingLineDensity;
            
            %% Path length calculation
            % To compute path length general iterative method can be used in
            % gereal case but for standard surface analytic solution is
            % possible.
            [geometricalPathLength,noIntersectionPointFlag] = computeStandardSurfacePath ...
                (rayPosition,rayDirection,surfaceRadius,surfaceConic);
            % Additional phase shift due to grating
            % similar formula used in Zemax  usgdcyl.c user defined surface
            % file
            gratingAdditionalPath = (rayPosition(2,:).*wavlenInM*(surfaceDiffractionOrder)*surfaceGratingLineDensity*10^6)./indexBefore;
            % currently the additional path due to grating is ignored
            gratingAdditionalPath = zeros(1,size(rayPosition,2));
            additionalPathLength = gratingAdditionalPath; % Since rayPosition is in lens units
            %% Intersection point calculation
            % For standard surfaces the intersection points can be easily
            % computed from the path length and initial ray parameters
            % since geometric path length computation doesn't require the
            % refractive index data
            localRayIntersectionPoint = computeIntersectionPoint(rayPosition,rayDirection,geometricalPathLength);
            localSurfaceNormal = computeStandardSurfaceNormal(surfaceRadius,surfaceConic,localRayIntersectionPoint);
            %% Exit ray position and direction
            localExitRayPosition = localRayIntersectionPoint;
            
            wavLenInUm = wavlenInM*10^6;
            gratingVector1 = [0,2*pi*surfaceGratingLineDensity,0]';
            diffractionOrder1 = surfaceDiffractionOrder;
            if  reflection
                if diffractionOrder1 ~= 0 && gratingVector1(2) ~= 0
                    localReflectedRayDirection = computeNewRayDirection ...
                        (rayDirection,localSurfaceNormal,...
                        indexBefore,indexAfter,reflection,wavLenInUm,gratingVector1,diffractionOrder1);
                else
                    localReflectedRayDirection = computeReflectedRayDirection ...
                        (rayDirection,localSurfaceNormal); % 6th function
                end
                exitRayDirection = localReflectedRayDirection;
                TIR = ones(1,size(localReflectedRayDirection,2));
            else
                if diffractionOrder1 ~= 0 && gratingVector1(2) ~= 0
                    [localTransmittedRayDirection,TIR] = computeNewRayDirection ...
                        (rayDirection,localSurfaceNormal,...
                        indexBefore,indexAfter,reflection,wavLenInUm,gratingVector1,diffractionOrder1);
                else
                    [localTransmittedRayDirection,TIR] = computeRefractedRayDirection ...
                        (rayDirection,localSurfaceNormal,indexBefore,indexAfter);
                end % 7th function
                exitRayDirection = localTransmittedRayDirection;
            end
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

function surfaceNormal = computeStandardSurfaceNormal...
        (surfaceRadius,surfaceConic,intersectionPoint)
    % COMPUTESTANDARDSURFACENORMAL to calculate the normal vector at a point of the surface
    % The function is vectorized so it can work on multiple sets of
    % inputs once at the same time.
    % Inputs:
    % 	intersectionPoint: 1-by-3 vector, the position of the point at the surface
    % 	surfaceType: scalar, the parameter to describe the type of the surface,
    %                eg. 0(plane), 1(sphere), 2(conic)
    % 	surfaceRadius: scalar, radius of the surface
    % 	surfaceConic: scalar, the parameter to describe the shape of aspherical
    %                 surface, for plane and sphere(k=0)
    % Output:
    %   surfaceNormal: 1-by-3 vector, which is the unit normal vector of the
    %                  surface at this point
    
    
    nRay = size(intersectionPoint,2);
    
    % Determine the exact surface type for standard surfaces
    if abs(surfaceRadius) > 10^10
        surfaceType = 'Plane';
    elseif surfaceConic ~= 0
        surfaceType = 'Conic Aspherical';
    else
        surfaceType = 'Spherical';
    end
    switch surfaceType
        case {'Plane'}
            surfaceNormal = [0;0;1]*ones(1,nRay);%repmat([0;0;1],[1,nRay]);
        case 'Spherical'
            curv = 1/(surfaceRadius);
            normal = [-curv*intersectionPoint(1,:);-curv*intersectionPoint(2,:);...
                1-curv*intersectionPoint(3,:)];
            surfaceNormal = normal./(ones(3,1)*sum(normal.^2,1));%repmat(sum(normal.^2,1),[3,1]);
        case 'Conic Aspherical'
            curv = 1/(surfaceRadius);
            denom = (sqrt(1-2*curv*surfaceConic*intersectionPoint(3,:) + ...
                curv^2*(1+surfaceConic)*surfaceConic*intersectionPoint(3,:).^2));
            normal = [-curv*intersectionPoint(1,:); -curv*intersectionPoint(2,:);...
                1-curv*(1+surfaceConic)*intersectionPoint(3,:)]./...
                (ones(3,1)*denom);%repmat(denom,[3,1]);
            % to determine if the normal vector cosines are real
            S3 = 1-(1+surfaceConic)*curv^2*((intersectionPoint(1,:)).^2 + ...
                (intersectionPoint(2,:)).^2);
            normal(:,S3<0) = NaN;
            surfaceNormal = normal./(ones(3,1)*sum(normal.^2,1));%repmat(sum(normal.^2,1),[3,1]);
    end
end

function surfaceSag = computeStandardSurfaceSag...
        (surfaceRadius,surfaceConic,xyCoordinateMeshGrid,gratingHeight)
    
    r = computeNormOfMatrix(xyCoordinateMeshGrid,3);
    c = 1/surfaceRadius;
    k = surfaceConic;
    z = (c.*r.^2)./(1+sqrt(1-(1+k).*c.^2.*r.^2));
    
    % sameXIndices = floor(size(r,1)/2);
    % % Make the sawtooth groove every 2nd points
    % z(2:2:end) = z(2:2:end) + gratingHeight;
    surfaceSag = z;
end

function [geometricalPathLength,NoIntersectioPoint] = computeStandardSurfacePath ...
        (rayInitialPosition,rayDirection,surfaceRadius,surfaceConic)
    % COMPUTEPATHLENGTH to calculate the path length of the ray from the start
    % point to the intersection point
    %    REF: G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
    % The function is vectorized so it can work on
    % multiple sets of inputs once at the same time.
    
    % Inputs:
    %   rayInitialPosition: position of the start ray point 1-by-3 vector
    %   rayDirection: unit vector for the direction of the start ray, 1-by-3 vector
    %   surfaceType: type of the surface, scalar, 0(plane), 1(spherical), 2(conic).....
    %   surfaceRadius: radius for the surface, scalar
    %   surfaceConic: the parameter of 'shape' of the surface, scalar
    %   refractiveIndexBefore: refractive index of the medium, vector as it
    %   depends on th wavelength.
    % Outputs
    % 	geometricalPathLength: scalar, which is the total length from the start point to
    %                          the intersection point
    %	opticalPathLength: scalar, which is the optical path corresponding to the
    %                      geometrical path length
    
    
    % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Part of the RAYTRACE toolbox
    %   Written by: Yi Zhong 05.03.2013
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University
    
    %   Modified By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % 04.09.2012    Yi Zhong             Original Version         Version 2.1
    % 05.03.2013	Yi Zhong			 Modification			  Version 2.1
    % Oct 14,2013   Worku, Norman G.     OOP Version              Version 3.0
    % Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    nRay = size(rayInitialPosition,2);
    initialPoint = rayInitialPosition; % define the start point
    k = rayDirection(1,:);
    l = rayDirection(2,:);
    m = rayDirection(3,:);
    
    distanceToXY = -initialPoint(3,:)./m;
    intersectionPointXY  = ...
        [initialPoint(1,:) +  distanceToXY.*k;...
        initialPoint(2,:) +  distanceToXY.*l;...
        zeros([1,nRay])];
    
    X = intersectionPointXY(1,:);
    Y = intersectionPointXY(2,:);
    Z = intersectionPointXY(3,:);
    
    % Determine the exact surface type for standard surfaces
    if abs(surfaceRadius) > 10^10
        surfaceType = 'Plane';
    elseif surfaceConic ~= 0
        surfaceType = 'Conic Aspherical';
    else
        surfaceType = 'Spherical';
    end
    
    switch surfaceType
        case {'Plane'}
            % when the surface is plane, the intersection point is on the z=0 plane
            additionalPath = zeros([1,nRay]);
            NoIntersectioPoint = zeros([1,nRay]);
        case 'Spherical' % spherical
            curv = 1/(surfaceRadius);
            F = curv * ((X).^2+(Y).^2);
            G = m - curv .*(k.*X + l.*Y);
            additionalPath = F./(G+(sign(m)).*sqrt(G.^2-curv*F));
            NoIntersectioPoint = zeros([1,nRay]);
            
            NoIntersectioPoint(imag(additionalPath) ~= 0) = 1;
            additionalPath(imag(additionalPath) ~= 0) = NaN;
            
        case 'Conic Aspherical' % conic aspherical
            curv = 1/(surfaceRadius);
            F = curv .* ((X).^2+(Y).^2);
            G = m - curv .*(k.*X + l.*Y);
            additionalPath = F./(G+(sign(m)).*sqrt(G.^2-curv.*F.*(1+surfaceConic.*(m.^2))));
            NoIntersectioPoint = zeros([1,nRay]);
            
            NoIntersectioPoint(imag(additionalPath) ~= 0) = 1;
            additionalPath(imag(additionalPath) ~= 0) = NaN;
    end
    geometricalPathLength = distanceToXY + additionalPath;
end

function intersectionPoint = computeIntersectionPoint(rayInitialPosition,rayDirection,...
        geometricalPathLength)
    % COMPUTEINTERSECTIONPOINT to calculate the intersection point of a ray on one surface
    %   Ref: G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
    %   We are calculating the intersection point for the j surface
    % The function is vectorized so it can work on multiple sets of
    % inputs once at the same time.
    
    % Inputs (For N ray)
    %   incidentRayArray: Array of ray object incident to the surface p
    %   geometricalPathLength: the pathlength of the ray from the start point (j-1) to ...
    %                          the intersection point of the j surface
    %   The output will be 3-by-N matrix, which is the position of the intersection point
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    nRay = size(rayInitialPosition,2);
    %compute the intersection point
    intersectionPoint = ...
        [rayInitialPosition(1,:) + rayDirection(1,:).*geometricalPathLength;...
        rayInitialPosition(2,:) + rayDirection(2,:).*geometricalPathLength;...
        rayInitialPosition(3,:) + rayDirection(3,:).*geometricalPathLength];
end

