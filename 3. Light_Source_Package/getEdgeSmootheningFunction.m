function [edgeSmootheningFunction,xlin,ylin] = getEdgeSmootheningFunction(...
        samplingPoints,samplingDistance, boarderShape,absouteEdgeValue)
    %getEdgeSmootheningFunction As sharp edge doesn't exist in physical fields,
    % this function returns a matrix with smooth edge following gaussian curve.
    
    Nx = samplingPoints(1);
    Ny = samplingPoints(2);
    dx = samplingDistance(1);
    dy = samplingDistance(2);
    xlin = [-floor(Nx/2):floor(Nx/2)]*dx;
    ylin = [-floor(Ny/2):floor(Ny/2)]*dy;
    [x,y] = meshgrid(xlin,ylin);
    
    outerRadiusX = floor(Nx/2)*dx;
    outerRadiusY = floor(Ny/2)*dy;
    
    innerRadiusX = outerRadiusX - absouteEdgeValue;
    innerRadiusY = outerRadiusY - absouteEdgeValue;
    
    
    % compute the waist radius of gaussian function so that the
    % edge smoothening function falls to zero in the last
    % pixels
    HWHMx = ((outerRadiusX - innerRadiusX))/2;
    edgeWaistX = HWHMx/sqrt(2*log(2));
    HWHMy = ((outerRadiusY - innerRadiusY))/2;
    edgeWaistY = HWHMy/sqrt(2*log(2));
    
    % Take average of both edgeWaist and make single edgeWaist for the
    % edge gaussian
    edgeWaist = (edgeWaistX + edgeWaistY)/2;
    a = innerRadiusX;
    b = innerRadiusY;
    switch lower(boarderShape)
        case lower('Elliptical')
            % Distance from a point to ellipse along the line
            % connectinf the center with the point
            % = (1-(a*b)/sqrt(xp^2*b^2+yp^2*a^2))*sqrt(xp^2+yp^2)
            distanceFromEllipse = (1-(a*b)./sqrt(x.^2*b^2+y.^2*a^2)).*sqrt(x.^2+y.^2);
            distanceFromEllipse(((x.^2)/a^2 + (y.^2)/b^2) <= 1) = 0;
            edgeSmootheningFunction = exp(-(distanceFromEllipse.^2)/edgeWaist^2);
        case lower('Rectangular')
            
            distanceFromRectangle = sqrt(((abs(x)-a).*(abs(x)>a))+((abs(y)-b).*(abs(y)>b)));
            distanceFromRectangle(abs(x)<a & abs(y)<b) = 0;
            edgeSmootheningFunction = exp(-(distanceFromRectangle.^2)/edgeWaist^2);
    end
end

