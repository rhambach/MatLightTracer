%     M=5;
    lensHeight = 5;
    c = 1/inf;
    k = 0;
    radSpacing = .1;
    n = lensHeight/radSpacing;
%     n=2^(M-1);
    phi = (linspace(0,2*pi,n));
    r=(linspace(-lensHeight,lensHeight,n))';
    
    % phi = 90
    x1 = r*cos(phi);
    y1 = r*sin(phi);
    
    z1 = (c*((r*cos(phi)).^2+(r*sin(phi)).^2))./(1+sqrt(1-(1+k)*c^2*((r*cos(phi)).^2+(r*sin(phi)).^2)));

    
    lensHeight = 5;
    c = -1/10;
    k = 0;
    radSpacing = .1;
    n = lensHeight/radSpacing;
%     n=2^(M-1);
    phi = (linspace(0,2*pi,n));
    r=(linspace(-lensHeight,lensHeight,n))';
    
    % phi = 90
    x2 = r*cos(phi);
    y2 = r*sin(phi);
    
    z2 = (c*((r*cos(phi)).^2+(r*sin(phi)).^2))./(1+sqrt(1-(1+k)*c^2*((r*cos(phi)).^2+(r*sin(phi)).^2)));
    axesHandle = axes
    surf(axesHandle,x1,z1,y1,'facecolor','interp',...
    'edgecolor','none',...
    'facelighting','phong'); 
hold on
% z1(1,:) = 0.5 * (z1(1,:)+z2(1,:));
% z1(end,:) = 0.5 * (z1(end,:)+z2(end,:));
% z1(1,:) = z2(1,:);
% z1(end,:) = z2(end,:);

z2(1,:) = z1(1,:);
z2(end,:) = z1(end,:);
    surf(axesHandle,x2,z2,y2,'facecolor','interp',...
    'edgecolor','none',...
    'facelighting','phong'); 
hold on
xyzPointsLocal = [];
xyzPointsLocal(1,:,:) = x1;
xyzPointsLocal(2,:,:) = y1;
xyzPointsLocal(3,:,:) = z1;

rotMat = -eye(3);
celar = num2cell(xyzPointsLocal,[1]);
Z = cellfun(@(x) x'*rotMat,celar,'UniformOutput',false);
Zn = cell2mat(squeeze(Z));
x = Zn(:,1:3:end);
y = Zn(:,2:3:end);
z = Zn(:,3:3:end);

x(23,22)
x1(23,22)

plot3(x1(1,:),z1(1,:),y1(1,:),'k')
plot3(x2(2,:),z2(2,:),y2(2,:),'k')
    axis equal
    
%     figure
%     axesHandle = axes
%     waterfall(x1,z1,y1);
% hold on
%     waterfall(x2,z2,y2); 
%     axis equal
%     
%     
%     
%     figure
%         axesHandle = axes
%     patch(x1,z1,y1,'k','Parent',axesHandle,'facelighting','phong'); 
% hold on
%     patch(x2,z2,y2,'b','Parent',axesHandle,'facelighting','phong'); 
%     axis equal
%     plot(z1,y1,z2-1,y2)
%     axis equal
%     figure
%     area(z1,y1)% 
%     axis equal
%     hold on
%     figure
%     fill([z2 z1-2.7 ],([y1 y2]),'r')
%     axis equal
    
%     vertices1 = [z1+1,y1];
%     vertices2 = [z2,y2];
%    
%     vertices2 = flipud(vertices2);
%     lensVertices = [vertices1;vertices2];
% 
%         si=size(lensVertices);
%         lensFaces = 1:1: si(1);
%         axesHandle = axes
%         patch('Faces',lensFaces,'Vertices',lensVertices,'FaceColor', [0.9 0.9 0.9],'Parent',axesHandle);
% axis equal
    
    %     theta1 = asin(lensHeight/rad1);
%     t1=(-abs(theta1):angleSpacing:abs(theta1));  
% 
%     xyzPointsLocal1 = [0*(t1)', -rad1*(sin(t1))', ((1-cos(t1))*rad1)'];
%     xyzPointsRotated1 = xyzPointsLocal1 * surf1Rotation;
%     xyzPointsTranslated1 = ...
%         [xyzPointsRotated1(:,1) + surf1Position(1),...
%         xyzPointsRotated1(:,2) + surf1Position(2),...
%         xyzPointsRotated1(:,3) + surf1Position(3)];
%     % now take only Z-Y coordinates for 2D plot
%     vertices1 = [xyzPointsTranslated1(:,3),xyzPointsTranslated1(:,2)];
