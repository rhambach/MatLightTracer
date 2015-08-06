function [ surfH,zyPoints,errCode] = draw2DSurface(surfCoordinateTM,rad,conic,...
    apertType,apertParam,lensXRange,lensYRange,...
    axesHandle,radSpacing,surfColor,varagrin)
    % draw2DSurface: Drwas a single surface in 2D layout diagram
    % Inputs
    %   surfCoordinateTM,rad,conic,semiDiam: coordinate transfer matrix, radius, conic constant and
    %   semidiameter of the surface
    %   apertType,apertParam: Aperture types and parameters of the surface.
    %   lensXRange,lensYRange: Range of X and Y coordinates to be drawn for the surface
    %   axesHandle: axes to plot the surface. A negative number can be
    %   passed as axes handle to supress the graphical output.
    %   radSpacing: radius sampling Spacing
    %   varagrin: Not used yet. Can be used to indicate edge type and
    %   thickness in future
    % Output
    %   surfH:  height of the surface drawn
    %   zyPoints: The matrix of points defining the surface poitns in y z plane

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
	% Aug 20,2014   Worku, Norman G.     Few revisions
    
	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    surfPosition = surfCoordinateTM(1:3,4);
    surfRotation = (surfCoordinateTM(1:3,1:3)); % from local to global
     if radSpacing == 0
        radSpacing = 10^-10;
    end   
    % check for vertxes on the meridional plane
    if surfPosition(1)~=0 
        msgbox ('Surface vertex is not in the Meridional Plane');
        surfH = NaN;
        zyPoints = NaN;
        errCode = 1; % Surface vertex is not in the Meridional Plane
        return;
    else


        % the actual height of the surf is minimum of the given actualSurfHeight 
        %  and radius
        actualSurfHeight = min(abs([rad,actualSurfHeight]));

        if actualSurfHeight==0 
            actualSurfHeight = 2*radSpacing;
        end

        nPointsSurf = actualSurfHeight/radSpacing;
        % nPointsAll includes all points which are drawn (may have some 
        % additional points from the actual surface) 
        nPointsAll  = drawnSurfHeight/radSpacing;
        r = (linspace(-drawnSurfHeight,drawnSurfHeight,nPointsAll))';
        k = conic;
        c = 1/rad;

        x = (r*0);
        y = r*1;
        z = (c*((x).^2+(y).^2))./(1+sqrt(1-(1+k)*c^2*((x).^2+(y).^2)));
        
        % Z values will be complex for points outside the actual surface. 
        % So replace the complex Z values wi the neighboring values
        z = real(z);
        % Chnage the Z coordinate values to the extreme z for all points
        % outside the actual surface area.
        pointRad = sqrt(x.^2+y.^2);
        actualSurfacePointIndices = find(pointRad<actualSurfHeight);    
        if ~isempty(actualSurfacePointIndices)
            if rad < 0
                extremeZ = min(z(actualSurfacePointIndices));
            else
                extremeZ = max(z(actualSurfacePointIndices));
            end
            z(abs(z)>abs(extremeZ)) = extremeZ;
        end
        
        xyzPointsLocal(:,1) = x;
        xyzPointsLocal(:,2) = y;
        xyzPointsLocal(:,3) = z;

        % Multiply each points with rotation matrix. 
        xyzPointsRotated = xyzPointsLocal*surfRotation;
        
        xyzPointsTranslated(:,1) = xyzPointsRotated(:,1) + surfPosition(1);
        xyzPointsTranslated(:,2) = xyzPointsRotated(:,2) + surfPosition(2);
        xyzPointsTranslated(:,3) = xyzPointsRotated(:,3) + surfPosition(3);        
         
         zyPoints(:,1) = xyzPointsTranslated(:,3);
         zyPoints(:,2) = xyzPointsTranslated(:,2);  
         surfH = actualSurfHeight;
         errCode = 0; % No error
         
         
         % Plot the surface on the axes handle
         if axesHandle > 0  && ~isempty(zyPoints)% negative value can be used to supress the output
            % now take only Z-Y coordinates for 2D plot
            z = zyPoints(:,1);
            y = zyPoints(:,2); 
            hold on;
            plot(axesHandle,z,y,'Color',surfColor);
            hold on;
         end            
end

