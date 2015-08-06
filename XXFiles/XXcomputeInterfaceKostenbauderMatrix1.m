function [ K ] = computeInterfaceKostenbauderMatrix( ang1,ang2,n1,n2,dn1dl,dn2dl,f0,reflection,radius )
%computeInterfaceKostenbauderMatrix: Computes the Kostenbauder matrix for plane interface
%(Including plane grating) for transmission or reflection case

% All angles must be between [-90,90]
if ang1 > pi/2 && ang1 < pi
    ang1 = (pi - ang1);
elseif ang1 < -pi/2 && ang1 > -pi
    ang1 = (- pi - ang1);
end
if ang2 > pi/2 && ang2 < pi
    ang2 = (pi - ang2);
elseif ang2 < -pi/2 && ang2 > -pi
    ang2 = (- pi - ang2);
end


% disp('Propagation through interface')
% ang1*180/pi
% ang2*180/pi
% n1
% n2
% dn1dl
% dn2dl
% f0
% reflection

% ang2 = -ang2;
% ang1 = -ang1;

 c =  299792458;
% c =  3*10^8;

lambda0 = c/f0;
dn1df = -lambda0^2*dn1dl/c;
dn2df = -lambda0^2*dn2dl/c;


if reflection
    A = -cos(ang2)/cos(ang1);
    B = 0;
    C = -2/(radius);
    D = -(cos(ang1))/(cos(ang2));
    E = 0;
    F = ((sin(ang1)+sin(ang2))/(f0*n1*cos(ang2)));
    G = -((sin(ang2)+sin(ang1))/(c*cos(ang1)));
    H = 0;
    I = 0;
    
    K = [A,B,0,E;
        C,D,0,F;
        G,H,1,I;
        0,0,0,1];
else
    A = cos(ang2)/cos(ang1);
    B = 0;
    C = -(n1-n2)/(radius*n2);
    D = (n1*cos(ang1))/(n2*cos(ang2));
    E = 0;
%     F = -((sin(ang1)*dn1df-sin(ang2)*dn2df)/(n2*cos(ang2)))+((n2*sin(ang2)-n1*sin(ang1))/(f0*n2*cos(ang2)));
     G = -(f0*(sin(ang1)*dn1df-sin(ang2)*dn2df)/(c*cos(ang1)))+((n2*sin(ang2)-n1*sin(ang1))/(c*cos(ang1)));
    H = 0;
    I = 0;
    
     F = ((sin(ang1)*dn1df-sin(ang2)*dn2df)/(n2*cos(ang2)))-((n2*sin(ang2)-n1*sin(ang1))/(f0*n2*cos(ang2)));
%     G = (f0*(sin(ang1)*dn1df-sin(ang2)*dn2df)/(c*cos(ang1)))-((n2*sin(ang2)-n1*sin(ang1))/(c*cos(ang1)));  
    
    K = [A,B,0,E;
        C,D,0,F;
        G,H,1,I;
        0,0,0,1];
end


% if reflection
%     A = -cos(ang2)/cos(ang1);
%     B = 0;
%     C = -2/(radius);
%     D = -(cos(ang1))/(cos(ang2));
%     E = 0;
%     F = -((sin(ang1)+sin(ang2))/(f0*n1*cos(ang2)));
%     G = ((sin(ang2)+sin(ang1))/(c*cos(ang1)));
%     H = 0;
%     I = 0;
%     
%     K = [A,B,0,E;
%         C,D,0,F;
%         G,H,1,I;
%         0,0,0,1];
% else
%     A = cos(ang2)/cos(ang1);
%     B = 0;
%     C = -(n1-n2)/(radius*n2);
%     D = (n1*cos(ang1))/(n2*cos(ang2));
%     E = 0;
%     F = ((sin(ang1)*dn1df-sin(ang2)*dn2df)/(n2*cos(ang2)))-((n2*sin(ang2)-n1*sin(ang1))/(f0*n2*cos(ang2)));
%     G = (f0*(sin(ang1)*dn1df-sin(ang2)*dn2df)/(c*cos(ang1)))-((n2*sin(ang2)-n1*sin(ang1))/(c*cos(ang1)));
%     H = 0;
%     I = 0;
%     
%     K = [A,B,0,E;
%         C,D,0,F;
%         G,H,1,I;
%         0,0,0,1];
% end
end

