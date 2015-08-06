function draw = system_layout( Systemdata )
%SYSTEM_LAYOUT to draw the system layout
%     Systemdata: structure
%             Systemdata.Num: (number of surfaces in the system)
%             Systemdata.P:   (the 'position' of the vertexes of the surfaces, j-by-3 matrix)
%             Systemdata.s:   (the 'angles' of the  succesive rotations, j-by-3 matrix)
%             Systemdata.Q:   (the 'type' of surfaces, 1-by-j vector, plane, eg. 0(plane),1(sphere),2(conic),3(cone)........)
%             Systemdata.Ref: (the 'type' of refractive or reflective of the surfaces, 1-by-(j-2) vector)
%             Systemdata.R:   (the 'curvature' of surfaces, 1-by-j vector)
%             Systemdata.k:   (the parameter of 'shape' of the surfaces, 1-by-j vector)
%             Systemdata.D:   (the 'size' of the surfaces, j-by-3 matrix)
%             Systemdata.t:   (the 'thickness' between surfaces, 1-by-(j-1) vector)
%             Systemdata.n:   (the 'index' of the medium, 1-by-(j-1) vector)


%   Part of the RAYTRACE toolbox
%   Written by: Yi Zhong 30.08.2012
%   Institute of Applied Physics
%   Friedrich-Schiller-University 

%--------------------- TOTAL NUMBER OF THE SURFACES j ---------------------
j=Systemdata.Num+2;  


figure(1);
axes1 = axes('Parent',gcf);
view(axes1,[-190 -30 45]); 
box(axes1,'on');
hold(axes1,'all');

%--------------------- Surfaces at the optical axis----------------------------
% Systemdata.P:   (the 'position' of the vertexes of the surfaces, j-by-3 matrix)
% Systemdata.R:   (the 'curvature' of surfaces, 1-by-j vector)
% Systemdata.k:   (the parameter of 'shape' of the surfaces, 1-by-j vector)
% Systemdata.D:   (the 'size' of the surfaces, j-by-3 matrix)
% Systemdata.Q:   (the 'type' of surfaces, 1-by-j vector, plane, eg. 0(plane),1(sphere),2(conic),3(cone)........)
for i=1:j
    if Systemdata.Q(i)==0  % plane           
        draw_sph( Systemdata.P(i,:),Systemdata.D(i,:),Systemdata.R(i),Systemdata.k(i) );
    end
    
    if Systemdata.Q(i)==1  % sphere
        draw_sph( Systemdata.P(i,:),Systemdata.D(i,:),Systemdata.R(i),Systemdata.k(i) );
    end
    
    if Systemdata.Q(i)==2  % conic
        draw_conic( Systemdata.P(i,:),Systemdata.D(i,:),Systemdata.R(i),Systemdata.k(i) );
    end
end
    


hold on;


set(gca, 'YDir','reverse');
xlabel('X-axis','fontweight','bold');
ylabel('Z-axis','fontweight','bold');
zlabel('Y-axis','fontweight','bold');
title('SYSTEM LAYOUT','fontsize',13,'fontweight','bold','fontname','TIMES NEW ROMAN');


draw=1;
end

