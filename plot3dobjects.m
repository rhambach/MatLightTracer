close all;
clc;
clear;

[x, y,z]=meshgrid(-3:0.1:3, -3:0.1:3,-3:0.1:3);
v1=x.^2+y.^2+z.^2; % create the 1st object
r1=2;% set radius

% (x+2-y^2)^2+y^2+z^2=6
% v1 = (x+2-y.^2).^2+y.^2+z.^2;
% r1 = 4;

p1=patch(isosurface(x,y,z,v1,r1),'EdgeColor','none');
set(p1, 'FaceColor','r')
camlight 
lighting gouraud
hold on

% v2=(x-1).^2+(y-1).^2+(z-1).^2;% create the 2nd object
% r2=3;
% p2=patch(isosurface(x,y,z,v2,r2));
% set(p2,'FaceColor','b')
view(3)% set to 3D view 


%%
[x, y, z] = meshgrid(-3:0.25:3);
v = x.*exp(-x.^2 - y.^2 - z.^2);
clf;
vals = logspace(-1, -5, 25);  % 20 points from 1e-1 down to 1e-5
h = patch(isosurface(x, y, z, v, vals(1)), ...
   'facecolor', 'g', 'edgecolor', 'none');
axis([-3 3 -3 3 -3 3]);
camlight; lighting phong
for id = vals
   [faces, vertices] = isosurface(x, y, z, v, id);
   set(h, 'Faces', faces, 'Vertices', vertices);
   pause(0.1);
end

close;