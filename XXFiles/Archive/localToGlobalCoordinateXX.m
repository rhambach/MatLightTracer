function [globalRayData,globalSurfaceNormal,globalIncidentRayDirection,globalExitRayDirection] =...
             		localToGlobalCoordinate(localRayData,polarized,localSurfaceNormal,...
					localIncidentRayDirection,localExitRayDirection,globalVertex,rotAngle); 
	% LOCALTOGLOBALCOORDINATE the transfer from the local coordinate system back to 
	% the reference coordinate system 
	%   REF:G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
	% Inputs:
	%   localRayData: [localRayPosition;localRayDirection;localRayPolarizationVector]
	%   polarized: Indicator for polarized ray.
	%   localSurfaceNormal: (normal vector to the surface in local coordinate system)
	%   globalVertex: (the position of the surface vertex in the references system, 
	%       which will be the o-point for the local coordinate system, 1-by-3 vector)
	%   rotAngle: (the angle which describes the tilt of the surface correspondent 
	%              to the reference system, 1-by-3 vector)
	%   localIncidentRayDirection,localExitRayDirection: Incident and exit ray direction 
	%                                                      cosines in local coordinate
	% Output:
	%   globalRayData: [globalRayPosition;globalRayDirection;globalRayPolarizationVector] 
	%   globalSurfaceNormal: (normal vector to the surface in global coordinate system)
	%   globalIncidentRayDirection,globalExitRayDirection: Incident and exit ray direction 
	%                                                      cosines in global coordinate
	
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
	% Oct 14,2013   Worku, Norman G.     OOP Version              Version 3.0

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	try
		P_L = localRayData(1,:);
		Dir_L = localRayData(2,:);

		R1=[cos(rotAngle(3)),-sin(rotAngle(3)),0;sin(rotAngle(3)),cos(rotAngle(3)),0;0,0,1];
		R2=[1,0,0;0,cos(rotAngle(2)),-sin(rotAngle(2));0,sin(rotAngle(2)),cos(rotAngle(2))];
		R3=[cos(rotAngle(1)),0,-sin(rotAngle(1));0,1,0;sin(rotAngle(1)),0,cos(rotAngle(1))];

		R=(R1*R2*R3);  % the R matrix

		P=(P_L)';
		D=Dir_L';


		e=localSurfaceNormal';
		% coordinates of Pj in the reference system( R\P means inv(R)*P )
		globalRayPosition = (R\P)'+globalVertex; 
		% direction cosines of the ray in the reference system( R\D means inv(R)*D )
		globalRayDirection = (R\D)'; 
	%     if polarized
			polVect = localRayData(3,:);
			polVect = polVect';
			globalRayPolarizationVector = (R\polVect)';
			globalRayData = [globalRayPosition;globalRayDirection;globalRayPolarizationVector];
	%     else
			%globalRayData = [globalRayPosition;globalRayDirection];
	%     end
	% direction cosines of the normal vecotr (R\e means inv(R)*e)
		globalSurfaceNormal = (R\(localSurfaceNormal'))'; 
		globalIncidentRayDirection = (R\(localIncidentRayDirection'))';
		globalExitRayDirection = (R\(localExitRayDirection'))';
	catch err
		 %open file
		 fid = fopen('logFile','a+');
		 % write the error to file
		 % first line: message
		 fprintf(fid,'%s\n',err.message);
		 % following lines: stack
		 for e=1:length(err.stack)
			fprintf(fid,'%sin %s at %i\n',txt,err.stack(e).name,err.stack(e).line);
		 end
		 % close file
		 fclose(fid)
	   
		 msgbox(strcat(err.message,' So the function "globalToLocalCoordinate" will return NaN'), ...
		 'Program Error','error');
		 globalRayData = [NaN,NaN,NaN;NaN,NaN,NaN;NaN,NaN,NaN];
		 globalSurfaceNormal = [NaN,NaN,NaN];
		 globalIncidentRayDirection = [NaN,NaN,NaN];
		 globalExitRayDirection = [NaN,NaN,NaN];     
	end
end

