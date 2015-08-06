function [ pupilSamplingPoints,pupilGridIndices ] = computePupilSamplingPoints...
                        (nRay,pupilZLocation,pupilRadius,pupilSamplingTypeIndex,objThick)
    % computePupilSamplingPoints:  Returns coordinates of pupil sampling points
    % Inputs:
    %   nRay: Total number of pupil sampling points required
    %   pupilZLocation: Location of entrance pupil from the first lens surface
    %   pupilRadius: The radius of the entrance pupil
    %   pupilSamplingTypeIndex: Type of pupil sampling used
    %   objThick: thickness related to the object surface
    % Outputs:
    %   pupilSamplingPoints: 3 x nRay matrix containg values of pupil sampling
    %   coordinates.
    %   pupilGridIndices: the grid indices corresponding to each sampling
    %   points for cartesian sampling. Not used for other sampling.

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
 
    % objPupilDistZ = objThick + pupilZLocation;
    
    
    % currently only 1,5, 6 and 7 are supported all others will be trated as 1
    if pupilSamplingTypeIndex == 2 || pupilSamplingTypeIndex == 3 || pupilSamplingTypeIndex == 4 
        pupilSamplingTypeIndex = 1;
    end 
    
    
    switch pupilSamplingTypeIndex
        case 1 % 1: Cartesian
            % For caretesian sampling the number of rays specifed correspond 
            % to the rectangular pupil. So the effective number of rays traced 
            % through circular pupil may be less than that specified.
            Nt = nRay;            
            % Determine the grid size which can give the number of sampling
            % points inside the pupil.             
            Ntx = sqrt(Nt); % Assumed to be odd
            % And take the nearest odd intiger above Ntx to make sure that
            % the circular entrance pupil is sampled symetrically.
            Ntx = 2*floor(ceil(Ntx)/2)+1;
            if Ntx == 1 % single ray in cartesian coordinate = cheif ray
                % the global coordinates of the pupil sample point
                pupilPoint(1,:)=[0,0,pupilZLocation];
                % indexing starts from lower left corner from 1 1
                gridIndices(1,:) = [1,1];
            else
                dx = 2*pupilRadius/(Ntx-1); % spacing
                dy = dx;
                Nr = floor((Ntx-1)/2); %total number of points along the radius of pupil
                kk = 0;
                for rr = -Nr:1:Nr
                    for cc = -Nr:1:Nr
                        xCoord = dx*cc;  % the coordinate of the point along x-axis
                        yCoord = dy*rr;  % the coordinate of the point along y-axis
                        if (xCoord^2+yCoord^2)<= pupilRadius^2
                            kk = kk+1;     % count the number of sampling points
                            % the global coordinates of the pupil sample point
                            pupilPoint(kk,:)=[xCoord,yCoord,pupilZLocation];
                            % indexing starts from lower left corner from 1 1
                            gridIndices(kk,:) = [cc+Nr+1,rr+Nr+1];
                        end
                        
                    end
                end
            end

        case 2 %2: Polar Grid 
                dy = 2*pupilRadius/(nRay-1); % spacing
                Nr = round((nRay-1)/2); %total number of points along the radius of pupil
                kk = 0;
                for rr = -Nr:1:Nr
                    xCoord = 0;  % the coordinate of the point along x-axis
                    yCoord = dy*rr;  % the coordinate of the point along y-axis
                    if (xCoord^2+yCoord^2)<= pupilRadius^2
                        kk = kk+1;     % count the number of sampling points
                        % the global coordinates of the pupil sample point
                        pupilPoint(kk,:)=[xCoord,yCoord,pupilZLocation];
                        gridIndices = NaN; % not defined
                    end
                end
        case 3 %3: Hexagonal

        case 4 %4: Isoenergetic Circular

        case 5 %5: Tangential Plane
            % single ray in tangential plane = cheif ray
            if nRay == 1
                pupilPoint(1,:)=[0,0,pupilZLocation];
                gridIndices = NaN; % not defined
            elseif nRay == 2 % Take only the two mariggianl rays
                pupilPoint(1,:)=[0,pupilRadius,pupilZLocation];
                pupilPoint(2,:)=[0,-pupilRadius,pupilZLocation];
                gridIndices = NaN; % not defined
            else
                dy = 2*pupilRadius/(nRay-1); % spacing
                Nr = round((nRay-1)/2); %total number of points along the radius of pupil
                kk = 0;
                for rr = -Nr:1:Nr
                    xCoord = 0;  % the coordinate of the point along x-axis
                    yCoord = dy*rr;  % the coordinate of the point along y-axis
                    if (xCoord^2+yCoord^2)<= pupilRadius^2
                        kk = kk+1;     % count the number of sampling points
                        % the global coordinates of the pupil sample point
                        pupilPoint(kk,:)=[xCoord,yCoord,pupilZLocation];
                        gridIndices = NaN; % not defined
                    end
                end
            end
        case 6 %6: Sagital Plane
            % single ray in sagital plane = cheif ray
            if nRay == 1
                pupilPoint(1,:)=[0,0,pupilZLocation];
                gridIndices = NaN; % not defined
            elseif nRay == 2 % Take only the two mariggianl rays
                pupilPoint(1,:)=[pupilRadius,0,pupilZLocation];
                pupilPoint(2,:)=[-pupilRadius,0,pupilZLocation];
                gridIndices = NaN; % not defined
            else
                dx = 2*pupilRadius/(nRay-1); % spacing
                Nr = round((nRay-1)/2); %total number of points along the radius of pupil
                kk = 0;
                for rr = -Nr:1:Nr
                    xCoord = dx*rr;  % the coordinate of the point along x-axis
                    yCoord = 0;  % the coordinate of the point along y-axis
                    if (xCoord^2+yCoord^2)<= pupilRadius^2
                        kk = kk+1;     % count the number of sampling points
                        % the global coordinates of the pupil sample point
                        pupilPoint(kk,:)=[xCoord,yCoord,pupilZLocation];
                        gridIndices = NaN; % not defined
                    end
                end
                
            end
         case 7 %7: Random
                theta = rand(nRay,1)*(2*pi);
                r = sqrt(rand(nRay,1))*pupilRadius;
                randX = r.*cos(theta);
                randY = r.*sin(theta);
                pupilPoint = [randX randY repmat(pupilZLocation,nRay,1)];
                gridIndices = [NaN,NaN]; % not defined
                % Replace the first ray with a cheif ray 
                pupilPoint(1,:) = [0,0,pupilZLocation];
        otherwise 

    end
    % Make the output in 3xnRay size
    pupilSamplingPoints = pupilPoint';
    pupilGridIndices = gridIndices';
end

