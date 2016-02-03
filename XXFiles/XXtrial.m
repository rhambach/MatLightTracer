drawnSurfHeight = 20;
radSpacing = .1;
conic = 0;
rad = 10;
actualSurfHeight = min(abs([rad,drawnSurfHeight]));


nPointsAll  = drawnSurfHeight/radSpacing;
r = (linspace(-drawnSurfHeight,drawnSurfHeight,nPointsAll))';
phi = (linspace(0,2*pi,nPointsAll));
k = conic;
c = 1/rad;

x = r*cos(phi);
y = r*sin(phi);
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

figure;
surf(x,z,y,...
    'edgecolor','none',...
    'facelighting','phong')
hold on;
borderColor = [0,0,0];
plot3(x(1,:),z(1,:),y(1,:),'Color',borderColor)


% Rectangular aperture
xc = 2; yc = 0; a = 12; b = 12;

figure;
x1=x;
y1=y;

% Move all (x,y) points outside the aperture to the edge of aperture
x1((x1-xc)>a) = a+xc;
x1((x1-xc)<-a) = -a+xc;
y1((y1-yc)>b) = b+yc;
y1((y1-yc)<-b) = -b+yc;
z1 = (c*((x1).^2+(y1).^2))./(1+sqrt(1-(1+k)*c^2*((x1).^2+(y1).^2)));
% Z values will be complex for points outside the actual surface.
% So replace the complex Z values wi the neighboring values
z1 = real(z1);
% Chnage the Z coordinate values to the extreme z for all points
% outside the actual surface area.
pointRad1 = sqrt(x1.^2+y1.^2);
actualSurfacePointIndices1 = find(pointRad1<actualSurfHeight);
if ~isempty(actualSurfacePointIndices1)
    if rad < 0
        extremeZ1 = min(z1(actualSurfacePointIndices1));
    else
        extremeZ1 = max(z1(actualSurfacePointIndices1));
    end
    z1(abs(z1)>abs(extremeZ1)) = extremeZ1;
end

surf(x1,z1,y1,...
    'edgecolor','none',...
    'facelighting','phong')
hold on;
borderColor = [0,0,0];
plot3(x1(1,:),z1(1,:),y1(1,:),'Color',borderColor)



% Elliptical aperture
xc = 0; yc = 0; a = 13; b = 10;

figure;
x2=x;
y2=y;

% Move all (x,y) points outside the aperture to the edge of aperture
aboveEllipseIndices = find((((x2-xc).^2)/a^2 + ((y2-yc).^2)/b^2) >= 1 & y2 >= yc);
belowEllipseIndices = find((((x2-xc).^2)/a^2 + ((y2-yc).^2)/b^2) >= 1 & y2 < yc);


y2(aboveEllipseIndices) = sqrt(1 - ((x2(aboveEllipseIndices)-xc).^2)/a^2) * b + yc;
y2(belowEllipseIndices) = -sqrt(1 - ((x2(belowEllipseIndices)-xc).^2)/a^2) * b + yc;

x2(find(x2>=a)) = a;
x2(find(x2<=-a)) = -a;
y2 = real(y2);
x2 = real(x2);

z2 = ((c*((x2).^2+(y2).^2))./(1+sqrt(1-(1+k)*c^2*((x2).^2+(y2).^2))));
% Z values will be complex for points outside the actual surface.
% So replace the complex Z values wi the neighboring values
z2 = real(z2);

% Chnage the Z coordinate values to the extreme z for all points
% outside the actual surface area.
pointRad2 = sqrt(x2.^2+y2.^2);
actualSurfacePointIndices2 = find(pointRad2<actualSurfHeight);
if ~isempty(actualSurfacePointIndices2)
    if rad < 0
        extremeZ2 = min(z2(actualSurfacePointIndices2));
    else
        extremeZ2 = max(z2(actualSurfacePointIndices2));
    end
    z2(abs(z2)>=abs(extremeZ2)) = extremeZ2;
end

surf(x2,z2,y2,...
    'edgecolor','none',...
    'facelighting','phong')
hold on;
borderColor = [0,0,0];
plot3(x2(1,:),z2(1,:),y2(1,:),'Color',borderColor)
