classdef RayTraceResult
	% RayTraceResult Class:
	%   Store ray trace results in the form of arrays
    % Properties:
    %     % All properties are arrays of the corresponding properties of the
    %     % ray traced for each surfces in the system
    %     RayIntersectionPoint
    %     SurfaceNormal     
    %     IncidentRayDirection
    %     IncidenceAngle     
    %     ExitRayDirection
    %     ExitAngle     
    %     PathLength     
    %     JonesVector
    %     PolarizationVectorInitial
    %     PolarizationVectorBeforeCoating
    %     PolarizationVectorAfterCoating
    %     PolarizationEllipseBeforeCoating
    %     PolarizationEllipseAfterCoating     
    %     IntensityBeforeCoating
    %     IntensityAfterCoating     
    %     Diattenuation
    %     Retardance     
    %     TotalPMatrix
    %     TotalQMatrix
    % Methods:
    %     [PolEllipseBeforeCoating,PolEllipseAfterCoating] = ...
    %                      getPolarizationEllipseParameters(RayTraceResult,surfIndex)
    %                  % getPolarizationEllipseParameters: Returns polarization ellipse
    %                  % parameters of the ray before and after the coating of a surf
    %     [IntensityBeforeCoating,IntensityAfterCoating] =  ...
    %                      getIntensity(RayTraceResult,surfIndex)
    %                  % getIntensity: Returns intensity parameters of the ray before
    %                  % and after the coating of a surf
    
	% <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    properties
        % All properties are arrays of the corresponding properties of the
        % ray traced for each surfces in the system
        RayIntersectionPoint
        SurfaceNormal        
        IncidentRayDirection
        IncidenceAngle        
        ExitRayDirection
        ExitAngle        
        PathLength       
        JonesVector
        PolarizationVectorInitial
        PolarizationVectorBeforeCoating
        PolarizationVectorAfterCoating       
        PolarizationEllipseBeforeCoating
        PolarizationEllipseAfterCoating
        IntensityBeforeCoating
        IntensityAfterCoating        
        Diattenuation
        Retardance        
        CoatingJonesMatrix        
        CoatingPMatrix
        CoatingQMatrix        
        TotalPMatrix
        TotalQMatrix        
        % Failure cases
        NoIntersectionPoint
        OutOfAperture
        TotalInternalReflection
    end
    
    methods
        % Constructor
        
        % Signatures of methods defined on separate file
        [PolEllipseBeforeCoating,PolEllipseAfterCoating] = ...
                 getPolarizationEllipseParameters(RayTraceResult,surfIndex)
        [IntensityBeforeCoating,IntensityAfterCoating] =  ...
                 getIntensity(RayTraceResult,surfIndex)    
    end
end

