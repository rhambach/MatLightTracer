function localRayData = globalToLocalCoordinate(globalRayData,polarized,...
                                                  globalVertex,rotAngle)
	%GLOBALTOLOCALCOORDINATE the transfer from the reference coordinate system 
	%   to the local coordinate system
	%   REF:G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
	% Inputs:
	%   globalRayData: [globalRayPosition;globalRayDirection;globalRayPolarizationVector] 
	%   globalVertex: (the position of the surface vertex in the references system,
	%            which will be the o-point for the local coordinate system, 1-by-3 vector)
	%   rotAngle: (the angle which describes the tilt of the surface correspondent to 
	%              the reference system, 1-by-3 vector)
	% Output 
	%   localRayData: [localRayPosition;localRayDirection;localRayPolarizationVector]

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
	% 03.09.2012    Yi Zhong             Original Version         Version 2.1
	% Oct 14,2013   Worku, Norman G.     OOP Version              Version 3.0

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	try
		globalRayPosition = globalRayData(1,:);
		globalRayDirection = globalRayData(2,:);

		R1=[cos(rotAngle(3)),-sin(rotAngle(3)),0;sin(rotAngle(3)),cos(rotAngle(3)),0;0,0,1];
		R2=[1,0,0;0,cos(rotAngle(2)),-sin(rotAngle(2));0,sin(rotAngle(2)),cos(rotAngle(2))];
		R3=[cos(rotAngle(1)),0,-sin(rotAngle(1));0,1,0;sin(rotAngle(1)),0,cos(rotAngle(1))];

		R=R1*R2*R3;

		newTranslatedPosition = (globalRayPosition - globalVertex)';
		newTranslatedDirection = (globalRayDirection)';
		localRayPosition = (R*newTranslatedPosition)';
		localRayDirection = (R*newTranslatedDirection)';

	%     if polarized
			globalRayPolarizationVector = globalRayData(3,:);
			newTranslatedPolarizationVector = (globalRayPolarizationVector)';
			localRayPolarizationVector = (R*newTranslatedPolarizationVector)';
			localRayData = [localRayPosition;localRayDirection;localRayPolarizationVector];
	%     else
			%localRayData = [localRayPosition;localRayDirection];
	%     end
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
	   
		 msgbox(strcat(err.message,' So the function "globalToLocalCoordinate" will return NaN'),...
		 'Program Error','error');
		 localRayData = [NaN,NaN,NaN;NaN,NaN,NaN;NaN,NaN,NaN];       
	end
end

