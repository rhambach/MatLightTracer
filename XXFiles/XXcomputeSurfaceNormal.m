function surfaceNormal = computeSurfaceNormal(intersectionPoint,surfaceType,...
												surfaceRadius,surfaceConic)
	% COMPUTESURFACENORMAL to calculate the normal vector at a point of the surface
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

   % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Part of the RAYTRACE toolbox
	%   Written by: Yi Zhong 30.08.2012
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
	% 30.08.2012    Yi Zhong             Original Version         Version 2.1
	% Oct 14,2013   Worku, Norman G.     OOP Version              Version 3.0
    % Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs
    
	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	try
        nRay = size(intersectionPoint,2);
        
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
				surfaceNormal = repmat([0;0;1],[1,nRay]);
			case 'Spherical'
				curv = 1/(surfaceRadius);
				normal = [-curv*intersectionPoint(1,:);-curv*intersectionPoint(2,:);...
				1-curv*intersectionPoint(3,:)];
				surfaceNormal = normal./repmat(sum(normal.^2,1),[3,1]);        
			case 'Conic Aspherical'
				curv = 1/(surfaceRadius);  
                denom = (sqrt(1-2*curv*surfaceConic*intersectionPoint(3,:) + ...
                    curv^2*(1+surfaceConic)*surfaceConic*intersectionPoint(3,:).^2));
                normal = [-curv*intersectionPoint(1,:); -curv*intersectionPoint(2,:);...
                    1-curv*(1+surfaceConic)*intersectionPoint(3,:)]./...
                    repmat(denom,[3,1]);
				% to determine if the normal vector cosines are real
                S3 = 1-(1+surfaceConic)*curv^2*((intersectionPoint(1,:)).^2 + ...
				(intersectionPoint(2,:)).^2); 
                normal(:,S3<0) = NaN;  
                surfaceNormal = normal./repmat(sum(normal.^2,1),[3,1]);    
			case 'Even Aspherical'

			case 'Odd Aspherical'
		end
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
	   
		 msgbox(strcat(err.message,' So the function "computeSurfaceNormal" will return NaN'), ...
		 'Program Error','error');
		 surfaceNormal = [NaN,NaN,NaN];      
    end
end

