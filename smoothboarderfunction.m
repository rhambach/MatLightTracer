xlin = linspace(-2,2,100);
ylin = linspace(-3,3,100);
[x,y] = meshgrid(xlin,ylin);
area = zeros(size(x));

% For elliptical
a = 1;
b = 2;
ellipse = area;
ellipse(((x.^2)/a^2 + (y.^2)/b^2) > 1) = 1;

figure
surf(ellipse)
figure
distanceFromEllipse = (1-(a*b)./sqrt(x.^2*b^2+y.^2*a^2)).*sqrt(x.^2+y.^2);
surf(distanceFromEllipse)

figure
ellipse(((x.^2)/a^2 + (y.^2)/b^2) > 1) = distanceFromEllipse(((x.^2)/a^2 + (y.^2)/b^2) > 1);
surf(ellipse)

% For rectangular
a = 1;
b = 2;
rectangle = area;
rectangle(abs(x)<a & abs(y)<b) = 1;

figure
surf(rectangle)

figure
distanceFromRectangle = sqrt(((abs(x)-a).*(abs(x)>a))+((abs(y)-b).*(abs(y)>b)));
surf(distanceFromRectangle)

figure
rectangle(abs(x)<a & abs(y)<b)  = distanceFromRectangle(abs(x)<a & abs(y)<b);
surf(rectangle)