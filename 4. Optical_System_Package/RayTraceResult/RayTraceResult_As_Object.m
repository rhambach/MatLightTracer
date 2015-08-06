classdef RayTraceResult
	% RayTraceResult Class:
	%   Store ray trace results in the form of arrays
    %   Constructors can construct multiple RayTraceResult objects for 
    %   multiple ray trace.
    % Properties:
    %     % All properties are arrays of the corresponding properties of the
    %     % ray traced for each surfces in the system
    %     RayIntersectionPoint
    %     ExitRayPosition
    %     SurfaceNormal        
    %     IncidentRayDirection
    %     IncidenceAngle        
    %     ExitRayDirection
    %     ExitAngle        
    %     PathLength
    %     OpticalPathLength
    % 
    %     RefractiveIndex
    %     RefractiveIndexFirstDerivative
    %     RefractiveIndexSecondDerivative
    %
    %     CoatingPMatrix
    %     CoatingQMatrix        
    %     TotalPMatrix
    %     TotalQMatrix        
    %     % Failure cases
    %     NoIntersectionPoint
    %     OutOfAperture
    %     TotalInternalReflection 
%     %     % Only used for ray trace result at first surface
%     %     Wavelength
%     %     InitialJonesVector   
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
	% Jan 18,2014   Worku, Norman G.     Vectorized constructor

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    properties
        % All properties are arrays of the corresponding properties of the
        % ray traced for each surfces in the system
        RayIntersectionPoint
        ExitRayPosition
        SurfaceNormal        
        IncidentRayDirection
        IncidenceAngle        
        ExitRayDirection
        ExitAngle        
        PathLength
        OpticalPathLength
        
        GroupPathLength
        TotalPathLength
        TotalOpticalPathLength
        TotalGroupPathLength

        RefractiveIndex
        RefractiveIndexFirstDerivative
        RefractiveIndexSecondDerivative 
        
        GroupRefractiveIndex
        
        CoatingJonesMatrix
        CoatingPMatrix
        CoatingQMatrix        
        TotalPMatrix
        TotalQMatrix 
        
        % Failure cases
        NoIntersectionPoint
        OutOfAperture
        TotalInternalReflection        
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects.    

%         % Only used for ray trace result at first surface
%         Wavelength
    end
    
    methods
        % Constructor
        function traceResult = RayTraceResult(RayIntersectionPoint,ExitRayPosition,SurfaceNormal,...        
        IncidentRayDirection,IncidenceAngle,ExitRayDirection,ExitAngle,...
        NoIntersectionPoint,OutOfAperture,TotalInternalReflection,PathLength,OpticalPathLength,...
        GroupPathLength,TotalPathLength,TotalOpticalPathLength,TotalGroupPathLength,...
        RefractiveIndex,RefractiveIndexFirstDerivative,RefractiveIndexSecondDerivative,... 
        GroupRefractiveIndex,CoatingJonesMatrix,CoatingPMatrix,CoatingQMatrix,TotalPMatrix,TotalQMatrix)
            % Assume all inputs are valid and of equal size
            if nargin == 0
                traceResult.RayIntersectionPoint = [0;0;0]*NaN;
                traceResult.ExitRayPosition = [0;0;0]*NaN;
                traceResult.SurfaceNormal  = [0;0;0]*NaN;      
                traceResult.IncidentRayDirection = [0;0;0]*NaN;
                traceResult.IncidenceAngle = 0*NaN;       
                traceResult.ExitRayDirection = [0;0;0]*NaN;
                traceResult.ExitAngle = 0*NaN;        
                traceResult.PathLength = 0*NaN;
                traceResult.OpticalPathLength = 0*NaN;

                traceResult.GroupPathLength = 0*NaN;
                traceResult.TotalPathLength = 0*NaN;
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
%                
                traceResult.ClassName = 'RayTraceResult';  

%                 traceResult.Wavelength = 0*NaN; 
%                 traceResult.InitialJonesVector = 0*NaN;
            else
                % Preallocate the array object
                nRay = size(RayIntersectionPoint,2);
                traceResult(nRay) = RayTraceResult;
                for kk = 1:nRay
                    traceResult(kk).RayIntersectionPoint = RayIntersectionPoint(:,kk);
                    traceResult(kk).ExitRayPosition = ExitRayPosition(:,kk);
                    traceResult(kk).SurfaceNormal  = SurfaceNormal(:,kk);      
                    traceResult(kk).IncidentRayDirection = IncidentRayDirection(:,kk);
                    traceResult(kk).IncidenceAngle = IncidenceAngle(kk);       
                    traceResult(kk).ExitRayDirection = ExitRayDirection(:,kk);
                    traceResult(kk).ExitAngle = ExitAngle(kk);        
                    traceResult(kk).PathLength = PathLength(kk);
                    traceResult(kk).OpticalPathLength = OpticalPathLength(kk);
                   
                    traceResult(kk).GroupPathLength = GroupPathLength(kk);
                    traceResult(kk).TotalPathLength = TotalPathLength(kk);
                    traceResult(kk).TotalOpticalPathLength = TotalOpticalPathLength(kk);
                    traceResult(kk).TotalGroupPathLength = TotalGroupPathLength(kk);
                
                    % Failure cases
                    traceResult(kk).NoIntersectionPoint = NoIntersectionPoint(kk);
                    traceResult(kk).OutOfAperture = OutOfAperture(kk);
                    traceResult(kk).TotalInternalReflection = TotalInternalReflection(kk); 
                    
                    traceResult(kk).RefractiveIndex = RefractiveIndex(kk);
                    traceResult(kk).RefractiveIndexFirstDerivative  = RefractiveIndexFirstDerivative(kk);
                    traceResult(kk).RefractiveIndexSecondDerivative  = RefractiveIndexSecondDerivative(kk);
                
                    traceResult(kk).GroupRefractiveIndex  = GroupRefractiveIndex(kk);
                    
%                     if nargin > 21 &&  nargin <= 24      
                    if nargin > 20     
                        traceResult(kk).CoatingJonesMatrix  = CoatingJonesMatrix(:,:,kk);
                        traceResult(kk).CoatingPMatrix  = CoatingPMatrix(:,:,kk);
                        traceResult(kk).CoatingQMatrix  = CoatingQMatrix(:,:,kk);       
                        traceResult(kk).TotalPMatrix  = TotalPMatrix(:,:,kk);
                        traceResult(kk).TotalQMatrix  = TotalQMatrix(:,:,kk);                        
%                     elseif nargin > 24     
%                         traceResult(kk).Wavelength = Wavelength(kk);
%                         traceResult(kk).InitialJonesVector = InitialJonesVector(:,kk);
                    end
                    traceResult(kk).ClassName = 'RayTraceResult'; 
                end
            end
        end  
    end
    
    methods(Static)
        function newObj = InputGUI()
            newObj = ObjectInputDialog(MyHandle(RayTraceResult()));
        end
    end     
end

