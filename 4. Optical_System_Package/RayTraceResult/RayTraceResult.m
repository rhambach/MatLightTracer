function traceResult = RayTraceResult(nRayPupil,nField,nWav,...
        RayIntersectionPoint,ExitRayPosition,SurfaceNormal,...
        IncidentRayDirection,ExitRayDirection,...
        NoIntersectionPoint,OutOfAperture,TotalInternalReflection,GeometricalPathLength,AdditionalPathLength,OpticalPathLength,...
        GroupPathLength,TotalGeometricalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
        RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,...
        GroupRefractiveIndex,CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix)
    % Assume all inputs are valid and of equal size
    if nargin == 0
        traceResult.TotalNumberOfPupilPoints = NaN;
        traceResult.TotalNumberOfFieldPoints = NaN;
        traceResult.TotalNumberOfWavelengths = NaN;
        
        traceResult.RayIntersectionPoint = [0;0;0]*NaN;
        traceResult.ExitRayPosition = [0;0;0]*NaN;
        traceResult.SurfaceNormal  = [0;0;0]*NaN;
        traceResult.IncidentRayDirection = [0;0;0]*NaN;
        traceResult.ExitRayDirection = [0;0;0]*NaN;
        traceResult.GeometricalPathLength = 0*NaN;
        traceResult.OpticalPathLength = 0*NaN;
        traceResult.AdditionalPathLength = 0*NaN;
        
        traceResult.GroupPathLength = 0*NaN;
        traceResult.TotalGeometricalPathLength = 0*NaN;
        traceResult.TotalOpticalPathLength = 0*NaN;
        traceResult.TotalGroupPathLength = 0*NaN;
        
        traceResult.RefractiveIndex = 0*NaN;
        traceResult.RefractiveIndexFirstDerivative  = 0*NaN;
        traceResult.RefractiveIndexSecondDerivative  = 0*NaN;
        
        traceResult.GroupRefractiveIndex  = 0*NaN;
        
        traceResult.CoatingJonesMatrix  = eye(2)*NaN;
        traceResult.CoatingPMatrix  = eye(3)*NaN;
        traceResult.CoatingQMatrix  = eye(3)*NaN;
        traceResult.TotalPMatrix  = eye(3)*NaN;
        traceResult.TotalQMatrix  = eye(3)*NaN;
        
        % Failure cases
        traceResult.NoIntersectionPoint = 0*NaN;
        traceResult.OutOfAperture = 0*NaN;
        traceResult.TotalInternalReflection = 0*NaN;
        traceResult.ClassName = 'RayTraceResult';
    else
        traceResult.TotalNumberOfPupilPoints = nRayPupil;
        traceResult.TotalNumberOfFieldPoints = nField;
        traceResult.TotalNumberOfWavelengths = nWav;
        % reshape each result to [nRayPupil,nField,nWav]
        traceResult.RayIntersectionPoint = (RayIntersectionPoint);
        traceResult.ExitRayPosition = (ExitRayPosition) ;
        traceResult.SurfaceNormal  = (SurfaceNormal) ;
        traceResult.IncidentRayDirection = (IncidentRayDirection) ;
        traceResult.ExitRayDirection = (ExitRayDirection) ;
        traceResult.GeometricalPathLength = (GeometricalPathLength) ;
        traceResult.AdditionalPathLength = AdditionalPathLength;
        
        traceResult.OpticalPathLength = (OpticalPathLength) ;
        
        traceResult.GroupPathLength = (GroupPathLength) ;
        traceResult.TotalGeometricalPathLength = (TotalGeometricalPathLength) ;
        traceResult.TotalOpticalPathLength = (TotalOpticalPathLength) ;
        traceResult.TotalGroupPathLength = (TotalGroupPathLength) ;
        
        % Failure cases
        traceResult.NoIntersectionPoint = (NoIntersectionPoint) ;
        traceResult.OutOfAperture = (OutOfAperture) ;
        traceResult.TotalInternalReflection = (TotalInternalReflection) ;
        
        traceResult.RefractiveIndex = (RefractiveIndex) ;
        traceResult.RefractiveIndexFirstDerivative  = (RefractiveIndexFirstDerivative) ;
        traceResult.RefractiveIndexSecondDerivative  = (RefractiveIndexSecondDerivative) ;
        
        traceResult.GroupRefractiveIndex  = (GroupRefractiveIndex) ;
        
        if nargin > 22
            traceResult.CoatingJonesMatrix  = (CoatingJonesMatrix) ;
            traceResult.CoatingPMatrix  = (CoatingPMatrix) ;
            traceResult.CoatingQMatrix  = (CoatingQMatrix) ;
            traceResult.TotalPMatrix  = (TotalPMatrix) ;
            traceResult.TotalQMatrix  = (TotalQMatrix) ;
        end
        traceResult.ClassName = 'RayTraceResult';
    end
    
    % Used in the object surface to store the pupil coordinate of each ray
    % It doesnt change with surfaces so there is no need to store it
    % for all surfaces
    traceResult.RayPupilCoordinates = [0;0];
end



