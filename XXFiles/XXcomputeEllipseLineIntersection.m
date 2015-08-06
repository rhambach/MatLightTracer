function [nearestIntersectionPoint, point1,point2] = computeEllipseLineIntersection(a,b,h,k,x1 ,y1 ,x2 ,y2 )
%computeEllipseLineIntersection: Computes the intersection of ellipse and line
% Ellipse: ((x-h)^2)/a^2 + ((y-k)^2)/b^2) = 1
% Line: y = y1 + (y2-y1) * (x-x1) / (x2-x1)

% make sure that size of x1,x2,y1 and y2 are all equal
if length(x1) ~= length(y1) || ...
        length(x2) ~= length(y2) ||...
        length(x1) ~= length(y1)
    disp('Error: The sizes of x1,x2,y1 and y2 should be equal.');
    point1 = NaN;
    point2 = NaN;
    return;
else
    xin1 = NaN * x1;
    xin2 = NaN * x1;
    yin1 = NaN * x1;
    yin2 = NaN * x1;
end

vertLineIndices = find(x1 == x2);
nonVertLineIndices = find(x1 ~= x2);

% First compute vertical lines and then replace the non vertical lines with
% new calculations.

% vertical line case
xin1(vertLineIndices) = x1(vertLineIndices);
xin2(vertLineIndices) = x2(vertLineIndices);
E = 1-(xin1(vertLineIndices) - h).^2/a^2;
% Negative values of E => No intersection point so replace with NaN
E(E<0) = NaN;
yin1(vertLineIndices) = b*sqrt(E) + k;
yin2(vertLineIndices) = -b*sqrt(E) + k;

% Non vertical line case
x1_non_vert = x1(nonVertLineIndices);
y1_non_vert = y1(nonVertLineIndices);
x2_non_vert = x2(nonVertLineIndices);
y2_non_vert = y2(nonVertLineIndices);

m = (y2_non_vert - y1_non_vert)./...
    (x2_non_vert - x1_non_vert);
A = 1/a^2 + m.^2/b^2;
B = -2*h/a^2 + (2*y1_non_vert.*m - 2*m.^2.*x1_non_vert)/b^2;
C = h^2/a^2 + (y1_non_vert.^2 - 2.*y1_non_vert.*m.*x1_non_vert + m.^2.*x1_non_vert.^2)/b^2 - 1;

D = B.^2-4.*A.*C;
% Negative values of D => No intersection point so replace with NaN
D(D<0) = NaN;

xin1(nonVertLineIndices) = (-B + sqrt(D))./(2*A);
xin2(nonVertLineIndices) = (-B - sqrt(D))./(2*A);
yin1(nonVertLineIndices) = y1_non_vert + m.*(xin1(nonVertLineIndices) - x1_non_vert);
yin2(nonVertLineIndices) = y1_non_vert + m.*(xin2(nonVertLineIndices) - x1_non_vert);
        
        

% if E >= 0
%     yin1 = b*sqrt(E) + k;
%     yin2 = -b*sqrt(E) + k;
% else
%     point1 = NaN;
%     point2 = NaN;
%     return;        
% end
%     
% 
% if ( x1 ~= x2)
%     m = (y2-y1)./(x2-x1);
%     A = 1/a^2 + m.^2/b^2;
%     B = -2*h/a^2 + (2*y1.*m - 2*m.^2.*x1)/b^2;
%     C = h^2/a^2 + (y1.^2 - 2.*y1.*m.*x1 + m.^2.*x1^2)/b^2 - 1;
%     
%     D = B.^2-4.*A.*C;
%     if D >= 0
%         xin1 = (-B + sqrt(D))/(2*A);
%         xin2 = (-B - sqrt(D))/(2*A);
%         yin1 = y1 + m*(xin1 - x1);
%         yin2 = y1 + m*(xin2 - x1);
%     else
%         point1 = NaN;
%         point2 = NaN;
%         return;
%     end
% else
%     % vertical line case
%     xin1 = x1;
%     xin2 = x1;
%     E = 1-(xin1 - h)^2/a^2;
%     if E >= 0
%         yin1 = b*sqrt(E) + k;
%         yin2 = -b*sqrt(E) + k;
%     else
%         point1 = NaN;
%         point2 = NaN;
%         return;        
%     end
% end


point1 = [xin1 yin1];
point2 = [xin2 yin2];
nearestIntersectionPoint = point1;
% But if the y2 is below yc (k) then the nearest intersection point will be the
% second point
nearestIntersectionPoint (find(y2 < k)) = point2(find(y2 < k));

% check
% pt1 = ((xin1-h)^2)/a^2 + ((yin1-k)^2)/b^2
% pt2 = ((xin2-h)^2)/a^2 + ((yin2-k)^2)/b^2


end

