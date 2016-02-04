function [ returnDataStruct] = ExtendedEvenAsphere(returnFlag,surfaceParameters,inputDataStruct)
    %STANDARD ExtendedEvenAsphere surface definition
    % surfaceParameters = values of {'NumberOfTerms','NormalizationRadius'}
    % inputDataStruct : Struct of all additional inputs (not included in the surface parameters)
    % required for computing the return. (Vary depending on the returnFlag)
    % returnFlag : An integer indicating what is requested. Depending on it the
    % returnDataStruct will have different fields
    % 1: About the surface
    %   inputDataStruct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.Name
    %       returnDataStruct.IsGratingEnabled;
    %       returnDataStruct.ImageFullFileName
    %       returnDataStruct.Description
    % 2: Surface specific 'UniqueSurfaceParameters' table field names and initial values in Surface Editor GUI
    %   inputDataStruct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.UniqueParametersStructFieldNames
    %       returnDataStruct.UniqueParametersStructFieldDisplayNames
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
    %       inputDataStruct.X
    %       inputDataStruct.Y
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
    % 6: New ray direction for real ray tracing
    %   inputDataStruct:
    %         inputDataStruct.RayDirection
    %         inputDataStruct.LocalSurfaceNormal
    %         inputDataStruct.IndexBefore
    %         inputDataStruct.IndexAfter
    %         inputDataStruct.WavelengthInUm
    %         inputDataStruct.DiffractionOrder
    %         inputDataStruct.GratingVectorDirection
    %         inputDataStruct.GratingLinesPerMicrometer
    %   Output Struct:
    %         returnDataStruct.NewLocalRayDirection
    %         returnDataStruct.TIR
    % 7: Return the function values of F(X,Y,Z) at the given ray intersection
    %    points
    %   inputDataStruct:
    %         inputDataStruct.RayIntersectionPoint
    %   Output Struct:
    %         returnDataStruct.Fxyz
    % 8: Return F'(X,Y,Z),the derivatives function values of F,  at the given
    %    ray intersection points and the surface normals
    %   inputDataStruct:
    %         inputDataStruct.RayIntersectionPoint
    %         inputDataStruct.RayDirection
    %   Output Struct:
    %         returnDataStruct.FxyzDerivative
    %         returnDataStruct.SurfaceNormal
    % 9: Return the ray Exit position (This allows the ray input and exit
    %    positions to be decoupled)
    %   inputDataStruct:
    %         inputDataStruct.RayIntersectionPoint
    %   Output Struct:
    %         returnDataStruct.LocalExitRayPosition
    % 10: Return any additional path related to the surface that is not
    %     given by the surface sag.
    %   inputDataStruct:
    %         inputDataStruct.RayIntersectionPoint
    %   Output Struct:
    %         returnDataStruct.AdditionalPathLength
    
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
        disp('Error: The function ExtendedEvenAsphere() needs atleat the return type.');
        returnDataStruct = struct;
        return;
    elseif nargin == 1 || nargin == 2
        if returnFlag == 1 || returnFlag == 2 || returnFlag == 3 || returnFlag == 4
            inputDataStruct = struct();
        else
            disp('Error: Missing input argument for ExtendedEvenAsphere().');
            returnDataStruct = struct();
            return;
        end
    elseif nargin == 3
        % This is fine
    else
        
    end
    switch returnFlag
        case 1 % About the surface
            surfName = {'ExtendedEvenAsphere','STND'}; % display name
            % look for image description in the current folder and return
            % full address
            [pathstr,name,ext] = fileparts(mfilename('fullpath'));
            imageFullFileName = {[pathstr,'\Surface.jpg']};  % Image file name
            description = {['ExtendedEvenAsphere: Used to define standard conical surfaces.']};  % Text description
            
            returnDataStruct = struct();
            returnDataStruct.Name = surfName;
            returnDataStruct.IsGratingEnabled = 1;
            returnDataStruct.IsExtraDataEnabled = 1;
            returnDataStruct.ImageFullFileName = imageFullFileName;
            returnDataStruct.Description =  description;
        case 2 % Surface specific 'UniqueSurfaceParameters'
            uniqueParametersStructFieldNames = {'NormalizationRadius','PolynomialCoefficients','ZernikeCoefficients'};
            uniqueParametersStructFieldDisplayNames = {'Normalization Radius','Polynomial Coefficients','Zernike Coefficients'};
            uniqueParametersStructFieldTypes = {'numeric','numericVector','numericVector'};
            defaultUniqueParametersStruct = struct();
            defaultUniqueParametersStruct.NormalizationRadius = 1;
            defaultUniqueParametersStruct.PolynomialCoefficients = [0];
            defaultUniqueParametersStruct.ZernikeCoefficients = [0];
            
            returnDataStruct = struct();
            returnDataStruct.UniqueParametersStructFieldNames = uniqueParametersStructFieldNames;
            returnDataStruct.UniqueParametersStructFieldDisplayNames = uniqueParametersStructFieldDisplayNames;
            returnDataStruct.UniqueParametersStructFieldTypes = uniqueParametersStructFieldTypes;
            returnDataStruct.DefaultUniqueParametersStruct = defaultUniqueParametersStruct;
        case 3 % Surface specific 'Extra Data' table
            uniqueExtraDataName = {'Polynomial Coefficients'};
            defaultUniqueExtraData = [0];
            
            returnDataStruct = struct();
            returnDataStruct.UniqueExtraDataName = uniqueExtraDataName;
            returnDataStruct.DefaultUniqueExtraData = defaultUniqueExtraData;
        case 4 % Surface sag at given xyGridPoints Z = F(X,Y)
            surfaceRadius = inputDataStruct.Radius;
            surfaceConic = inputDataStruct.Conic;
            normalizationRadius = surfaceParameters.NormalizationRadius;
            
            extraData = inputDataStruct.ExtraData;
            X = inputDataStruct.X;
            Y = inputDataStruct.Y;
            mainSag = computeExtendedEvenAsphereSurfaceSag(surfaceRadius,surfaceConic,...
                extraData,normalizationRadius,X,Y);
            
            returnDataStruct = struct();
            returnDataStruct.MainSag = mainSag;
            returnDataStruct.AlternativeSag = mainSag;
        case 5 % Paraxial ray trace results
            y = inputDataStruct.InputParaxialRayParameters(1,:);
            u = inputDataStruct.InputParaxialRayParameters(2,:);
            reverseTracing = inputDataStruct.ReverseTracingFlag;
            reflection = inputDataStruct.ReflectionFlag;
            indexBefore = inputDataStruct.IndexBefore;
            indexAfter = inputDataStruct.IndexAfter;
            surfaceRadius = inputDataStruct.Radius;
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
            if reflection
                n = -n;
            end
            
            paI = u+yf*c; %The yui method generates the paraxial angles of incidence
            % during the trace and is probably the most common method used in computer programs.
            uf = u+((n/nPrime)-1)*paI;
            outputParaxialRayParameters = [yf,uf]';
            
            returnDataStruct = struct();
            returnDataStruct.OutputParaxialRayParameters = outputParaxialRayParameters;
            
        case 6 % Real Ray trace new direction
            rayDirection = inputDataStruct.RayDirection;
            localSurfaceNormal = inputDataStruct.LocalSurfaceNormal;
            indexBefore = inputDataStruct.IndexBefore;
            indexAfter = inputDataStruct.IndexAfter;
            wavelengthInUm = inputDataStruct.WavelengthInUm;
            diffractionOrder = inputDataStruct.DiffractionOrder;
            gratingVectorDirection = inputDataStruct.GratingVectorDirection;
            gratingLinesPerMicrometer = inputDataStruct.GratingLinesPerMicrometer;
            
            % Use the general snells law
            [newLocalRayDirection,TIR] = computeGeneralRefractionReflection ...
                (rayDirection,localSurfaceNormal,indexBefore,indexAfter,...
                wavelengthInUm,diffractionOrder,gratingVectorDirection,gratingLinesPerMicrometer);
            
            returnDataStruct = struct();
            returnDataStruct.NewLocalRayDirection = newLocalRayDirection;
            returnDataStruct.TIR = TIR;
        case 7 % F(X,Y,Z)
            surfaceRadius = inputDataStruct.Radius;
            surfaceConic = inputDataStruct.Conic;
            normalizationRadius = surfaceParameters.NormalizationRadius;
            extraData = surfaceParameters.PolynomialCoefficients;
            extraData2 = surfaceParameters.ZernikeCoefficients;
            
            X = inputDataStruct.RayIntersectionPoint(1,:);
            Y = inputDataStruct.RayIntersectionPoint(2,:);
            Z = inputDataStruct.RayIntersectionPoint(3,:);
            
            mainSag = computeExtendedEvenAsphereSurfaceSag(surfaceRadius,surfaceConic,...
                extraData,normalizationRadius,X,Y);
            Fxyz = Z - (mainSag(1));
            returnDataStruct.Fxyz = Fxyz;
        case 8 % F'(X,Y,Z) and surface normal
            curv = (1/inputDataStruct.Radius);
            conic = inputDataStruct.Conic;
            normalizationRadius = surfaceParameters.NormalizationRadius;
            
            extraData = inputDataStruct.ExtraData;
            X = inputDataStruct.RayIntersectionPoint(1,:);
            Y = inputDataStruct.RayIntersectionPoint(2,:);
            Z = inputDataStruct.RayIntersectionPoint(3,:);
            
            k = inputDataStruct.RayDirection(1,:);
            l = inputDataStruct.RayDirection(2,:);
            m = inputDataStruct.RayDirection(3,:);
            
            % Compute its the derivative F'(X,Y,Z)
            [Fx,Fy,Fz] = computeExtendedEvenAspherePartialDerivates(curv,conic,...
                extraData,normalizationRadius,X,Y);
            Fderivative = Fx.*k + Fy.*l + Fz.*m;
            
            surfNormal = [Fx;Fy;Fz];
            normalizedSurfaceNormal = normalize2DMatrix( surfNormal,1);
            returnDataStruct.SurfaceNormal = normalizedSurfaceNormal;
            returnDataStruct.FxyzDerivative = Fderivative;
        case 9 % Exit position
            localRayExitPoint = inputDataStruct.RayIntersectionPoint;
            returnDataStruct.LocalExitRayPosition = localRayExitPoint;
        case 10 % additionaöl pathlength
            intersectionPoint = inputDataStruct.RayIntersectionPoint;
            % For now just return 0. but shall be corrected
            additionalPathLength = 0*intersectionPoint(1,:);
            returnDataStruct.AdditionalPathLength = additionalPathLength;
        otherwise
            
    end
end

function surfaceSag = computeExtendedEvenAsphereSurfaceSag(surfaceRadius,surfaceConic,...
        extraData,normalizationRadius,X,Y)
    
    r = sqrt(X.^2+Y.^2);
    Nx = size(r,1);
    Ny = size(r,2);
    p = r/normalizationRadius; % Normalized radius for xy points given
    c = 1/surfaceRadius;
    k = surfaceConic;
    
    % Evaluate the polynomial sum first
    extraData = extraData(:); % Make sure it is a column vector
    nTerms = length(extraData);
    if nTerms
        m = 2*[1:nTerms]'; % it is a column vector
        A = repmat(p,[1,1,nTerms]);
        B = repmat(permute(m,[3,2,1]),[Nx,Ny,1]);
        C = repmat(permute(extraData,[3,2,1]),[Nx,Ny,1]);
        polySum = squeeze(sum(C.*A.^B,3));
    else
        polySum = 0;
    end
    z = (c.*r.^2)./(1+sqrt(1-(1+k).*c.^2.*r.^2)) + polySum ;
    
    % sameXIndices = floor(size(r,1)/2);
    % % Make the sawtooth groove every 2nd points
    % z(2:2:end) = z(2:2:end) + gratingHeight;
    surfaceSag = z;
end

function [Fx,Fy,Fz] = computeExtendedEvenAspherePartialDerivates(curv,conic,extraData,normalizationRadius,X,Y)
    Nx = size(X,1);
    Ny = size(X,2);
    % Normalize the coordinates
    Xn = X/normalizationRadius;
    Yn = Y/normalizationRadius;
    rn = sqrt(Xn.^2+Yn.^2);
    % Evaluate the polynomial sum first
    extraData = extraData(:); % Make sure it is a column vector
    nTerms = length(extraData);
    if nTerms
        m = 2*[1:nTerms]'; % it is a column vector
        A = repmat(rn,[1,1,nTerms]);
        AX = repmat(Xn,[1,1,nTerms]);
        AY = repmat(Yn,[1,1,nTerms]);
        B = repmat(permute(m,[3,2,1]),[Nx,Ny,1]);
        C = repmat(permute(extraData.*m,[3,2,1]),[Nx,Ny,1]);
        polyDervXSum = squeeze(sum(C.*(A.^(B-2)).*AX,3));
        polyDervYSum = squeeze(sum(C.*(A.^(B-2)).*AY,3));
    else
        polyDervXSum = 0;
        polyDervYSum = 0;
    end
    E = (curv)./(sqrt(1-(conic+1)*curv^2*(X.^2+Y.^2)));
    Fx = -X.*E - polyDervXSum ;
    Fy = -Y.*E - polyDervYSum ;
    Fz = ones(1,length(E));
end
