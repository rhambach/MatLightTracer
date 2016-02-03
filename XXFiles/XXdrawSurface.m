function [xyzPoints] = drawSurface(surface,plotIn2D,nPoints1,nPoints2,...
    axesHandle,surfColor,drawnAperture,sectionDrawn)
% drawSurface: Drwas a single surface in 3D/2D layout diagram
% Inputs
%   surface: the surface object
%   axesHandle: axes to plot the surface. A negative number can be
%   passed as axes handle to supress the graphical output.
%   nRadialPoints: number of sampling points in radius
%   plotIn2D: Plot the YZ cross section in 2D layout
%   sectionDrawn: 1,0.75,0.5 or 0.25 indicating the portion of the system
%   to draw
%   nPoints1,nPoints2: nRadialPoints,nAngularPoints or nPointsX,nPointsY
%   varagrin: Not used yet. Can be used to indicate edge type and
%   thickness in future
% Output
%   surfH:  height of the surface drawn
%   xyzPoints: The matrix of points defining the surface poitns

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
if nargin > 0 
    if strcmpi(surface.getGridType,'Polar')
        nPoints1Default = 17;
        nPoints2Default = 33;
    else
        nPoints1Default = 75;
        nPoints2Default = 75;    
    end
end

if nargin == 0
    disp('Error: The function drawSurface requires the surface object.');
    xyzPoints = NaN;
    return;
elseif nargin == 1
    plotIn2D = 0;
    nPoints1 = nPoints1Default;
    nPoints2 = nPoints2Default;
    figure;
    axesHandle = axes;
    surfColor = 'interp';
	drawnAperture = surface.getDrawnAperture(1);
    sectionDrawn = 1;
elseif nargin == 2
    nPoints1 = nPoints1Default;
    nPoints2 = nPoints2Default;
    figure;
    axesHandle = axes;
    surfColor = 'interp';
	drawnAperture = surface.getDrawnAperture(1);
    sectionDrawn = 1;
elseif nargin == 3
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    nPoints2 = nPoints2Default;
    figure;
    axesHandle = axes;
    surfColor = 'interp';
	drawnAperture = surface.getDrawnAperture(1);
    sectionDrawn = 1;
elseif nargin == 4
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end    
    figure;
    axesHandle = axes;
    surfColor = 'interp';
	drawnAperture = surface.getDrawnAperture(1);
    sectionDrawn = 1;
elseif nargin == 5
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end     
    surfColor = 'interp';
	drawnAperture = surface.getDrawnAperture(1);
    sectionDrawn = 1;
elseif nargin == 6
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end     
	drawnAperture = surface.getDrawnAperture(1);
    sectionDrawn = 1;
elseif nargin == 7
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end     
    sectionDrawn = 1;
else
    if strcmpi(nPoints1,'default')
       nPoints1 = nPoints1Default;
    end
    if strcmpi(nPoints2,'default')
       nPoints2 = nPoints2Default;
    end 
end

if ~surface.ApertureParameter(1)||~surface.ApertureParameter(2)
    if plotIn2D
        xyzPoints(1:nPoints1,2,1) = 0;
        xyzPoints(1:nPoints1,2,2) = 0;
        xyzPoints(1:nPoints1,2,3) = 0;        
    else
        xyzPoints(1:nPoints1,1:nPoints2,1) = 0;
        xyzPoints(1:nPoints1,1:nPoints2,2) = 0;
        xyzPoints(1:nPoints1,1:nPoints2,3) = 0;
    end
    return;
end
surfCoordinateTM = surface.SurfaceCoordinateTM;
apertType = surface.ApertureType;
apertParam = surface.ApertureParameter;
apartSizeX = apertParam(1);
apartSizeY = apertParam(2);
apartDecX = apertParam(3);
apartDecY = apertParam(4);
surfPosition = surfCoordinateTM(1:3,4);
surfRotation = (surfCoordinateTM(1:3,1:3)); % from local to global

apartSizeXDrawn = drawnAperture(1);
apartSizeYDrawn = drawnAperture(2);

if strcmpi(surface.getGridType,'Polar')
    % Radius of the largest circle circumscribing the aperture
    maxR = sqrt((apartSizeXDrawn)^2+(apartSizeYDrawn)^2);
    % Draw a circle with radiaus maxR and then cut out the part required
    % using the given X and Y ranges
%     r = (linspace(-maxR,maxR,nPoints1))';
    r = (linspace(-maxR,maxR,nPoints1))';
    if plotIn2D
        phi = [-pi/2,pi/2];
    else
        % Any section size can be plotted.
        
%         phi = (linspace(-pi,sectionDrawn*pi,nPoints2));
sectionDrawn = 3/4;
        phi = (linspace(-pi,(-1+2*sectionDrawn)*pi,nPoints2));
    end
    x = r*cos(phi);
    y = r*sin(phi);
    
    maxX = maxR;
    maxY = maxR;
else
    xgv = linspace(-apartSizeXDrawn,apartSizeXDrawn,nPoints1);
    ygv = linspace(-apartSizeYDrawn,apartSizeYDrawn,nPoints2);    
    [x,y] = meshgrid(xgv,ygv);
    
    maxX = apartSizeXDrawn;
    maxY = apartSizeYDrawn;
end

if strcmpi(apertType,'Elliptical')||strcmpi(apertType,'Circular')||strcmpi(apertType,'Floating')
    x = x + apartDecX;
    y = y + apartDecY;
    
    a = apartSizeXDrawn;
    b = apartSizeYDrawn;
    dx = apertParam(3);
    dy = apertParam(4);
    xc = dx;
    yc = dy;
    
    % Move all (x,y) points outside the aperture to the edge of aperture
    aboveEllipseIndices = ((((x-xc).^2)/a^2 + ((y-yc).^2)/b^2) >= 1 & y >= yc);
    belowEllipseIndices = ((((x-xc).^2)/a^2 + ((y-yc).^2)/b^2) >= 1 & y < yc);
    
    y(aboveEllipseIndices) = sqrt(1 - ((x(aboveEllipseIndices)-xc).^2)/a^2) * b + yc;
    y(belowEllipseIndices) = -sqrt(1 - ((x(belowEllipseIndices)-xc).^2)/a^2) * b + yc;
    
    x((x>=a+xc)) = a+xc;
    x((x<=-a+xc)) = -a+xc;
    y = real(y);
    x = real(x);
    
    actualSurfSizeX = min([abs(maxX),abs(apartSizeX)]);
    actualSurfSizeY = min([abs(maxY),abs(apartSizeY)]);
    pointRad = sqrt((x-xc).^2/actualSurfSizeX^2+(y-yc).^2/actualSurfSizeY^2);
    actualSurfacePointIndices = (pointRad<=1);
elseif strcmpi(apertType,'Rectangular')
    % Rectangular aperture
    x = x + apartDecX;
    y = y + apartDecY;
    
    a = apartSizeXDrawn;
    b = apartSizeYDrawn;
    dx = apertParam(3);
    dy = apertParam(4);
    xc = dx;
    yc = dy;
    
    % Move all (x,y) points outside the aperture to the edge of aperture
    x((x)>a+xc) = a+xc;
    x((x)<-a+xc) = -a+xc;
    y((y)>b+yc) = b+yc;
    y((y)<-b+yc) = -b+yc;
    
    actualSurfSizeX = min([abs(maxX),abs(apartSizeX)]);
    actualSurfSizeY = min([abs(maxY),abs(apartSizeY)]);
    actualSurfacePointIndices = (abs(x-xc)<=actualSurfSizeX & abs(y-yc)<=actualSurfSizeY);
end
% Comput the z coordinates using the sag function surface definition file
xyCoordinateMeshGrid = cat(3,x,y);
[ surfaceSag1,surfaceSag2 ] = surface.getSurfaceSag(xyCoordinateMeshGrid,actualSurfacePointIndices);
% At then moment the second sag is not considered
z = surfaceSag1;

xyzPointsLocal(1,:,:) = x;
xyzPointsLocal(2,:,:) = y;
xyzPointsLocal(3,:,:) = z;

% Multiply each points with rotation matrix. This can be done by
% using the functions NUM2CELL to break the matrix xyzPointsLocal
% into a cell matrix with each cell containg x,y,z values and
% CELLFUN to operate across the cells. Then finally convert to
% number matrix.
cellArray = num2cell(xyzPointsLocal,[1]);
Z = cellfun(@(p) p'*surfRotation,cellArray,'UniformOutput',false);
Zn = cell2mat(squeeze(Z));
xRot = (Zn(:,1:3:end));
yRot = (Zn(:,2:3:end));
zRot = (Zn(:,3:3:end));

xyzPointsRotated = cat(3,xRot,yRot,zRot);
xyzPointsTranslated(:,:,1) = xyzPointsRotated(:,:,1) + surfPosition(1);
xyzPointsTranslated(:,:,2) = xyzPointsRotated(:,:,2) + surfPosition(2);
xyzPointsTranslated(:,:,3) = xyzPointsRotated(:,:,3) + surfPosition(3);
xyzPoints = xyzPointsTranslated;
% Plot the surface on the axes handle
if axesHandle > 0 && ~isempty(xyzPoints)% negative value can be used to supress the output
    % now take only Z-Y coordinates for 2D plot
    x = xyzPoints(:,:,1);
    y = xyzPoints(:,:,2);
    z = xyzPoints(:,:,3);
    if plotIn2D
        % No surface drawn
    else %surfColor
        surf(axesHandle,x,z,y,z,'facecolor','interp' ,...
            'edgecolor','none','facelighting','gouraud',...
            'FaceAlpha', 0.5,'AmbientStrength', 0.5, 'SpecularStrength', 0.5);
    end
axis equal;
end
end

