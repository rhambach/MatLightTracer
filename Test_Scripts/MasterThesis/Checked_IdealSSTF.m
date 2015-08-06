% For genral gaussian bema and general k matrix. The result is sooo complex
% that nothing can be seen out
% syms A B C D E F G H I L Qxx Qxt Qtt
% Qin = inv([Qxx Qxt;-Qxt Qtt])
% 
% Qout = ([A 0;G 1]*Qin+[B E/L;H I/L])*inv([C 0;0 1]*Qin+[D F/L;0 1])
%   
% QoutInv = inv(Qout);
% QoutXT = QoutInv(1,2);
% QoutXX = QoutInv(1,1);
% QoutTX = QoutInv(2,1);
% QoutTT = QoutInv(2,2)

% For genral gaussian bema and ideal lens k matrix. The result is sooo complex
% that nothing can be seen out

%%
syms C f L Qxx Qxt Qtt
A = 1;
B = 0;
C = -1/f;
D = 1;
E = 0;
F = 0;
G = 0;
H = 0;
I  = 0;
K_Lens = [A,B,0,E;C,D,0,F;G,H,1,I;0,0,0,1];
% Add corrector K matrix
syms Z
Kcorrector = [1,Z,0,0;
             0,1,0,0;
             0,0,1,0;
             0,0,0,1];
KTotal = Kcorrector*K_Lens;
Qin = inv([Qxx Qxt;-Qxt Qtt])

Qout = ([KTotal(1,1) 0;KTotal(3,1) 1]*Qin+[KTotal(1,2) KTotal(1,4)/L;KTotal(3,2) I/L])*inv([KTotal(2,1) 0;0 1]*Qin+[KTotal(2,2) KTotal(2,4)/L;0 1]);
  
QoutInv = inv(Qout);
QoutXT = QoutInv(1,2)
QoutXX = QoutInv(1,1)
QoutTX = QoutInv(2,1)
QoutTT = QoutInv(2,2)

%% 
syms C f L Qxx Qxt Qtt wav
A = 1;
B = 0;
C = -1/f;
D = 1;
E = 0;
F = 0;
G = 0;
H = 0;
I  = 0;
K_Lens = [A,B,0,E;
    C,D,0,F;
    G,H,1,I;
    0,0,0,1];
% Add corrector K matrix
syms SC D Z
H = 0;
Kdiffractive = [1,0,0,SC;
             0,1,0,0;
             0,H,1,0;
             0,0,0,1]; % The H = -SC/L but Site ignored it assuming small value
KBeforeLens = [1,L-f,0,0;
             0,1,0,0;
             0,0,1,0;
             0,0,0,1];
KAfterLens = [1,f,0,0;
 0,1,0,0;
 0,0,1,D;
 0,0,0,1];
KTotal = KAfterLens*K_Lens*KBeforeLens*Kdiffractive;
%KTotal = Kdiffractive;

Qin = inv([Qxx 0;0 Qtt])

Qout = ([KTotal(1,1) 0;KTotal(3,1) 1]*Qin+[KTotal(1,2) KTotal(1,4)/wav;KTotal(3,2) I/wav])*inv([KTotal(2,1) 0;0 1]*Qin+[KTotal(2,2) KTotal(2,4)/wav;0 1]);
  
QoutInv = inv(Qout);
QoutXT = QoutInv(1,2)
QoutXX = QoutInv(1,1)
QoutTX = QoutInv(2,1)
QoutTT = QoutInv(2,2)

%% SSTF Analytical
syms M D wav f L df alph zeth c pi a0 b0 m0 Q0xx Q0tt Q0xt
K_G1 = [M,0,0,0;
            0,1/M,0,D;
            D*M/wav,0,1,0;
            0,0,0,1];
K_G2 = [1/M,0,0,0;
    0,M,0,-D*M;
    -D/wav,0,1,0;
    0,0,0,1];
K_Lens = [1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,0,1];
K_L = [1,L,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1];
K_f = [1,f,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1];

K_G1;
K_L*K_G1;
K_Diffractive = K_G2*K_L*K_G1
K_Diffractive_Approximated = K_Diffractive;
K_Diffractive_Approximated(3,2)=0;
K_Diffractive_Approximated(3,4)=0;
K_Diffractive_Approximated;
K_Focussing = K_f*K_Lens;
KSSTF = K_Focussing*K_Diffractive;
KSSTF_Approximated = K_Focussing*K_Diffractive_Approximated;


KTotal = KSSTF_Approximated;
% Qin = -1i*(wav/pi)*inv([a0 m0;-m0 b0]);
Qin = 1i*(wav/pi)*inv([Q0xx 0;-0 Q0tt]);

% Qin = inv([Qxx 0;0 Qtt])
Qout = ([KTotal(1,1) 0;KTotal(3,1) 1]*Qin+[KTotal(1,2) KTotal(1,4)/wav;KTotal(3,2) KTotal(3,4)/wav])*inv([KTotal(2,1) 0;0 1]*Qin+[KTotal(2,2) KTotal(2,4)/wav;0 1]); 
QoutInv = inv(Qout)

QoutXT = QoutInv(1,2);
QoutXX = QoutInv(1,1);
QoutTX = QoutInv(2,1);
QoutTT = QoutInv(2,2);

K_Focusing_After_G1 = K_f*K_Lens*K_G1;
K_Diff_Paper = [1 L*alph^2 0 -L*wav*alph*zeth/c;
    0 1 0 0;
    0 L*alph*zeth/c 1 -L*wav*zeth^2/c^2;
    0 0 0 1];
KSSTF_Paper = K_Focussing*K_Diff_Paper;