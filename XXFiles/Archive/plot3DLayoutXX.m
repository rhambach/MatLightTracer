function draw = plot3DLayout( opticalSystem,rayPathMatrix,axesHandle )

%rayPathMatrix : 3 dimensional matrix of size (p X 3 X n), where p number
%of intersection points for single ray, and n is total number of rays

axes1 = axesHandle;
%axes1 = axes('Parent',gcf);
view(axes1,[-190 -30 45]); 
%box(axes1,'on');
hold(axes1,'all');

for surfaceIndex=1:1:opticalSystem.NumberOfSurface
    curentSurface = opticalSystem.SurfaceArray(surfaceIndex);
    switch curentSurface.Type
        case 'Plane' %plane
            draw_sph( curentSurface.Position,curentSurface.ApertureParameter,1/curentSurface.Radius,curentSurface.ConicConstant,axesHandle);
        case 'Spherical' %spherical
            draw_sph( curentSurface.Position,curentSurface.ApertureParameter,1/curentSurface.Radius,curentSurface.ConicConstant,axesHandle );
        case 'Conic Aspherical' %conic
            draw_conic( curentSurface.Position,curentSurface.ApertureParameter,1/curentSurface.Radius,curentSurface.ConicConstant,axesHandle );
    end
end
hold on;
if nargin>1
    % plot the rays on the layout
    sizeOfRayPathMatrix = size(rayPathMatrix);
    if length(sizeOfRayPathMatrix)==2
        nRay=1;
    else
        nRay = sizeOfRayPathMatrix(3);
    end
    for kk=1:1:nRay
        plot3(rayPathMatrix(:,1,kk),rayPathMatrix(:,3,kk),rayPathMatrix(:,2,kk)); hold on;
        % plot3(rayPathMatrix(:,1,kk),rayPathMatrix(:,3,kk),rayPathMatrix(:,2,kk),'.'); hold on;    
        plot3(rayPathMatrix(:,1,kk),rayPathMatrix(:,3,kk),rayPathMatrix(:,2,kk)); hold on;     
    end
end

set(gca, 'YDir','reverse');
xlabel('X-axis','fontweight','bold');
ylabel('Z-axis','fontweight','bold');
zlabel('Y-axis','fontweight','bold');
title('SYSTEM LAYOUT','fontsize',13,'fontweight','bold','fontname','TIMES NEW ROMAN');


draw=1;
hold off;  
end

