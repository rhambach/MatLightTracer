function draw = draw_sph( Vertex,D,c,k,axesHandle )
%DRAW_SPH to draw one spherical surface in 3D
%   Vertex: (the position of the surface vertex, 1-by-3 vector)
%   D: (size of the surface, 1-by-3 vector)
%   c: (curvature of the surface, scalar)
%   k: (shape parameter of the surface)

%   Part of the RAYTRACE toolbox
%   Written by: Yi Zhong 30.08.2012
%   Institute of Applied Physics
%   Friedrich-Schiller-University 


Dr=D(1);
Dx=D(2);
Dy=D(3);


if Dx==0 && Dy==0  % the size of surface is described by Diameter
    M=5;
    n=2^(M-1);
    
    phi = (linspace(0,2*pi,n));
    r=(linspace(0,Dr,n))';
    
    x = r*cos(phi)+Vertex(1);
    y = r*sin(phi)+Vertex(2);
    z = (c*((r*cos(phi)).^2+(r*sin(phi)).^2))./(1+sqrt(1-(1+k)*c^2*((r*cos(phi)).^2+(r*sin(phi)).^2)))+Vertex(3);

end

if Dr==0   % the size of surface is described by X and Y
    
end
    
    
    
    
surf(axesHandle,x,z,y,'facecolor','interp',...
    'edgecolor','none',...
    'facelighting','phong'); 


axis equal
axis tight
%camlight left
alpha(.33)



draw=1;

end

