function [interPoint,outOfAperture] = computeIntersectionPoint(localRayPosition,localRayDirection,...
                              geometricalPathLength,clearApertureParameter,apertureParam,considerSurfAperture)
	% COMPUTEINTERSECTIONPOINT to calculate the intersection point of a ray on one surface
	%   Ref: G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
	%   We are calculating the intersection point for the j surface
    % The function is vectorized so it can work on multiple sets of 
    % inputs once at the same time.
    
    % Inputs (For N ray)
	%   localRayPosition: the position of the start ray point, 3-by-N
	%   matrix
	%          (for homogeneous media raytracing, P is the position of the intersection ...
	%           point of the (j-1) surface)
	%          (for inhomogeneous media, P is the start point before the j surface)
	%   localRayDirection: the unit vector of direction of the start ray,
	%   3-by-N matrix
	%   geometricalPathLength: the pathlength of the ray from the start point (j-1) to ...
	%                          the intersection point of the j surface
	%   surfaceSize: the size of the surface, 3-by-N matrix
	%   The output will be 3-by-N matrix, which is the position of the intersection point
    %   outOfAperture: if the ray intersection point is out of Aperture.

   % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Part of the RAYTRACE toolbox
	%   Written by: Yi Zhong 29.08.2012
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
	% 29.08.2012    Yi Zhong             Original Version         Version 2.1
	% Oct 14,2013   Worku, Norman G.     OOP Version              Version 3.0
	% Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	if nargin < 5
        disp(['Error: Missing Input. The function computeIntersectionPoint '...
            'needs atleast :(localRayPosition,localRayDirection,'...
            'geometricalPathLength,apertureType, and apertureParam) as input arguments.']);
        interPoint = NaN;
        outOfAperture = NaN;
        return;
    elseif nargin == 5
        considerSurfAperture = 1;
    else
    end
    try
        nRay = size(localRayPosition,2);
		%compute the intersection point
		intersectionPoint = ...
		[localRayPosition(1,:) + localRayDirection(1,:).*geometricalPathLength;...
		localRayPosition(2,:) + localRayDirection(2,:).*geometricalPathLength;...
		localRayPosition(3,:) + localRayDirection(3,:).*geometricalPathLength];
    
		interPoint = intersectionPoint;
        outOfAperture = zeros([1,nRay]);  
    if considerSurfAperture
		% check whether the intersection point is inside the aperture
		% The region (disk) bounded by the ellipse is given by the equation:
		% (x?h)^2/rx^2+(y?k)^2/ry^2?1. In our case local coordinate => h = 0

		pointX = intersectionPoint(1,:);
		pointY = intersectionPoint(2,:);

        % apertureParam = [apertSizeX,apertSizeY,apertDecX,apertDecY]
        apertSizeX = apertureParam(1);
        apertSizeY = apertureParam(2);
        apertDecX = apertureParam(3);
        apertDecY = apertureParam(4);
        switch lower(clearApertureParameter)
            case lower('None')
                out = zeros([1,nRay]);
            case {lower('Floating'), lower('Circular')}
                out = ((pointX-apertDecX).^2+(pointY-apertDecY).^2) > (apertSizeX)^2;
            case lower('Elliptical')
                out = ((pointX-apertDecX).^2./(apertSizeX^2))+((pointY-apertDecY).^2./...
                    (apertSizeY^2)) > 1 ;
            case lower('Rectangular')
                out = abs(pointX-apertDecX) > apertSizeX|...
                    abs(pointY-apertDecY) > apertSizeY;
        end
        if ~isempty(find(out))
            interPoint(:,find(out)) = NaN;         
            outOfAperture(:,find(out)) = 1; 
        end
    end
	catch err
	     % open file
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
		 
		msgbox(strcat(err.message,' So the function "computeIntersectionPoint" will return NaN'), ...
				'Program Error','error');
		interPoint = NaN;
	end
end

