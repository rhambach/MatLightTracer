function linePlaneIntersection = OLDcomputeLinePlaneIntersection(linePoint1,linePoint2,planePoint1,planePoint2,planePoint3)
%COMPUTELINEPLANEINTERSECTION Returns the intersection of a line and plane
%give 2 points from the line and three non coliner points from the plane 

% Ref: http://en.wikipedia.org/wiki/Line%E2%80%93plane_intersection
% General line equation in parametric term
% lp1 + (lp2-lp1)*t,  for any real parameter t
% General plane eqation in parametric form
% pp1 + (pp2-pp1)*u + (pp3-pp1)*v, for any real parameters u and v
% Intersection: lp1 + (lp2-lp1)*t = pp1 + (pp2-pp1)*u + (pp3-pp1)*v
% Solution 
% M = [lp1-lp2, pp2-pp1, pp3-pp1];
% [t,u,v]' = Inverse [M] * [lp1-pp1]
% If det (M) = 0 then it is singular then there is no solution and 
% the plane is parallel to the line

M = [linePoint1-linePoint2, planePoint2-planePoint1, planePoint3-planePoint1];
if det(M)
    parameters = inv(M)*(linePoint1-planePoint1);
    t = parameters(1);
    u = parameters(2);
    v = parameters(3);
    linePlaneIntersection = linePoint1 + (linePoint2 - linePoint1)*t;
else
    disp('Error: The line is parallel to the plane and so no intersection point exists.');
    linePlaneIntersection = [NaN;NaN;NaN];
end


end

