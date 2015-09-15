function [edgeSmootheningFunction] = getEdgeSmootheningFunction(...
        xlin,ylin,boarderShape,absouteEdgeValue)    
    %getEdgeSmootheningFunction As sharp edge doesn't exist in physical fields,
    % this function returns a matrix with smooth edge following gaussian curve.

    [x,y] = meshgrid(xlin,ylin);
    outerRadiusX = 0.5*(max(xlin)-min(xlin));
    outerRadiusY = 0.5*(max(ylin)-min(ylin));
    
    innerRadiusX = outerRadiusX - absouteEdgeValue(1);
    innerRadiusY = outerRadiusY - absouteEdgeValue(2);
    
    
    % compute the waist radius of gaussian function so that the
    % edge smoothening function falls to zero in the last
    % pixels
    HWHMx = ((outerRadiusX - innerRadiusX))/2;
    edgeWaistX = HWHMx/sqrt(log(2));
    HWHMy = ((outerRadiusY - innerRadiusY))/2;
    edgeWaistY = HWHMy/sqrt(log(2));
    
    % Take average of both edgeWaist and make single edgeWaist for the
    % edge gaussian
    edgeWaistAverage = (edgeWaistX + edgeWaistY)/2;
    if edgeWaistAverage == 0
        % Avoid division by zero
        edgeWaistAverage = 10^-16;
    end
    a = innerRadiusX;
    b = innerRadiusY;
    switch (boarderShape)
        case 1 % lower('Elliptical')
            % Distance from a point to ellipse along the line
            % connectinf the center with the point
            % = (1-(a*b)/sqrt(xp^2*b^2+yp^2*a^2))*sqrt(xp^2+yp^2)
            distanceFromEllipse = (1-(a*b)./sqrt(x.^2*b^2+y.^2*a^2)).*sqrt(x.^2+y.^2);
            distanceFromEllipse(((x.^2)/a^2 + (y.^2)/b^2) < 1) = 0;
            edgeSmootheningFunction = exp(-(distanceFromEllipse.^2)/edgeWaistAverage^2);
        case 2 % lower('Rectangular')
            
            distanceFromRectangle = sqrt((((abs(x)-a).^2).*(abs(x)>a))+(((abs(y)-b).^2).*(abs(y)>b)));
            distanceFromRectangle(abs(x)<a & abs(y)<b) = 0;
            edgeSmootheningFunction = exp(-(distanceFromRectangle.^2)/edgeWaistAverage^2);
    end
end

