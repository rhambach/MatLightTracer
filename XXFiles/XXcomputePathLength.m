function [geometricalPathLength, opticalPathLength,NoIntersectioPoint] = computePathLength ...
(rayInitialPosition,rayDirection,surfaceType,surfaceRadius,surfaceConic,refractiveIndexBefore)
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

try
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
    if strcmpi(surfaceType,'Standard')
        if abs(surfaceRadius) > 10^10
            surfaceType = 'Plane';
        elseif surfaceConic ~= 0
            surfaceType = 'Conic Aspherical'; 
        else
            surfaceType = 'Spherical'; 
        end
    end
    
    switch surfaceType
        case {'Plane','Dummy','Ideal Lens'} 
            % when the surface is plane, the intersection point is on the z=0 plane
            additionalPath = zeros([1,nRay]);
            NoIntersectioPoint = zeros([1,nRay]);
        case 'Spherical' % spherical 
            curv = 1/(surfaceRadius);       
            F = curv * ((X).^2+(Y).^2);
            G = m - curv .*(k.*X + l.*Y);
            additionalPath = F./(G+(sign(m)).*sqrt(G.^2-curv*F));
            NoIntersectioPoint = zeros([1,nRay]);
            
             NoIntersectioPoint(~(isreal(additionalPath))) = 1;
             geometricalPathLength(~(isreal(additionalPath))) = NaN;
             opticalPathLength(~(isreal(additionalPath))) = NaN; 
 
        case 'Conic Aspherical' % conic aspherical
            curv = 1/(surfaceRadius);       
            F = curv .* ((X).^2+(Y).^2);
            G = m - curv .*(k.*X + l.*Y);
            additionalPath = F./(G+(sign(m)).*sqrt(G.^2-curv.*F.*(1+surfaceConic.*(m.^2))));
            NoIntersectioPoint = zeros([1,nRay]);

             NoIntersectioPoint(~(isreal(additionalPath))) = 1;
             geometricalPathLength(~(isreal(additionalPath))) = NaN;
             opticalPathLength(~(isreal(additionalPath))) = NaN;
                 
        case 'Even Aspherical' %aspherical

        case 'Odd Aspherical' %aspherical


    end
    geometricalPathLength = distanceToXY + additionalPath;
    opticalPathLength = refractiveIndexBefore .* geometricalPathLength;
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
   
     msgbox(strcat(err.message,' So the function "computePathLength" will return NaN'), 'Program Error','error');
     
     NoIntersectioPoint = 1;
     geometricalPathLength = NaN;
     opticalPathLength = NaN;    
end