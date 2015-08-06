function [ K ] = computeMediumKostenbauderMatrix( L,f0,d2ndl2 )
%COMPUTEMEDIUMKostenbauderMatrix Computes the kostenbauder matrix for a
%dispersive medium.
% 
% disp('Propagation in to Glass/Air')
% L
% f0
% d2ndl2


 c =  299792458;
% c =  3*10^8;

lambda0 = c/f0;

% % Use all prism @ Apex otherwise the +ve GDD comming from glass will
% % decrease the total negative GDD of the compressor
if d2ndl2
%     d2ndl2
%     L
% The ratio of thickness inside glass to air thickness << 1 to say prism
% used at apex
% L = 0;
%      L = 10^-3;
else
    
end
% d2ndl2 = d2ndl2*0;

A = 1;
% B = L;

B = -L;

C = 0;
D = 1;
E = 0;
F = 0;
G = 0;
H = 0;
I = L*(lambda0^3)*d2ndl2/(c^2);

K = [A,B,0,E;
    C,D,0,F;
    G,H,1,I;
    0,0,0,1];

end

