%% Compute K matrices for real compressor and strecher systems
% Import GratingCompressorImportedFromZMX
clc
format short e
fGratingCompressorImportedFromZMX = 'F:\MATLAB_Based_Optical_System_Analyser_Toolbox_3.0_Oct_05_2014_Working_Version\Evaluation_Systems\GratingCompressorImportedFromZMX.mat';
GratingCompressorImportedFromZMX = OpticalSystem(fGratingCompressorImportedFromZMX);
KGratingCompressorImportedFromZMX = GratingCompressorImportedFromZMX.computeSystemRayPulseMatrix;
GDDGratingCompressorImportedFromZMX = KGratingCompressorImportedFromZMX(3,4)/(2*pi); % Factor of 1/2pi to convert from herzian freq to radian
format short e
KGratingCompressorImportedFromZMX
GDDGratingCompressorImportedFromZMX

% Import grating pair system 
fGratingStrecherImportedFromZMX = 'F:\MATLAB_Based_Optical_System_Analyser_Toolbox_3.0_Oct_05_2014_Working_Version\Evaluation_Systems\GratingStrecherImportedFromZMX.mat';
GratingStrecherImportedFromZMX = OpticalSystem(fGratingStrecherImportedFromZMX);
KGratingStrecherImportedFromZMX = GratingStrecherImportedFromZMX.computeSystemRayPulseMatrix;
GDDGratingStrecherImportedFromZMX = KGratingStrecherImportedFromZMX(3,4)/(2*pi); % Factor of 1/2pi to convert from herzian freq to radian
format short e
KGratingStrecherImportedFromZMX
GDDGratingStrecherImportedFromZMX


% Compute Kostenbauder Matrix
format short e

lambda0 =  0.55; %um


% Glass data BK7
glassParameters = [1.03961212,0.00600069867,0.231792344,0.0200179144,1.01046945,103.560653];
wavLen = lambda0;
K1 = glassParameters(1);
L1 = glassParameters(2);
K2 = glassParameters(3);
L2 = glassParameters(4);
K3 = glassParameters(5);
L3 = glassParameters(6);
n = sqrt(1 + ...
            ((K1*wavLen.^2)./(wavLen.^2 - L1)) + ...
            ((K2*wavLen.^2)./(wavLen.^2 - L2)) + ...
            ((K3*wavLen.^2)./(wavLen.^2 - L3)));
        
dndl = (0.5*(-((2*K1*wavLen^3)/(-L1+wavLen^2)^2)+...
    (2*K1*wavLen)/(-L1+wavLen^2)-...
    (2*K2*wavLen^3)/(-L2+wavLen^2)^2+...
    (2*K2*wavLen)/(-L2+wavLen^2)-...
    (2*K3*wavLen^3)/(-L3+wavLen^2)^2+...
    (2*K3*wavLen)/(-L3+wavLen^2)))/...
    (1+(K1*wavLen^2)/(-L1+wavLen^2)+...
    (K2*wavLen^2)/(-L2+wavLen^2)+...
    (K3*wavLen^2)/(-L3+wavLen^2))^0.5;

d2ndl2 = -(0.25*(-((2*K1*wavLen^3)/(-L1+wavLen^2)^2)+...
    (2*K1*wavLen)/(-L1+wavLen^2)-...
    (2*K2*wavLen^3)/(-L2+wavLen^2)^2+...
    (2*K2*wavLen)/(-L2+wavLen^2)-...
    (2*K3*wavLen^3)/(-L3+wavLen^2)^2+...
    (2*K3*wavLen)/(-L3+wavLen^2))^2)/...
    (1+(K1*wavLen^2)/(-L1+wavLen^2)+...
    (K2*wavLen^2)/(-L2+wavLen^2)+...
    (K3*wavLen^2)/(-L3+wavLen^2))^1.5+...
    (0.5*((8*K1*wavLen^4)/(-L1+wavLen^2)^3-...
    (10*K1*wavLen^2)/(-L1+wavLen^2)^2+...
    (2*K1)/(-L1+wavLen^2)+...
    (8*K2*wavLen^4)/(-L2+wavLen^2)^3-...
    (10*K2*wavLen^2)/(-L2+wavLen^2)^2+...
    (2+K2)/(-L2+wavLen^2)+...
    (8*K3*wavLen^4)/(-L3+wavLen^2)^3-...
    (10*K3*wavLen^2)/(-L3+wavLen^2)^2+...
    (2*K3)/(-L3+wavLen^2)))/...
    (1+(K1*wavLen^2)/(-L1+wavLen^2)+...
    (K2*wavLen^2)/(-L2+wavLen^2)+...
    (K3*wavLen^2)/(-L3+wavLen^2))^0.5;

% Once the refractive indices are computed change the wavelength to meter
lambda0 = lambda0*10^-6;
dndl = dndl*10^6;
d2ndl2 = d2ndl2*10^12;
c = 299792458;
dndf = -lambda0^2*dndl/c;
d2ndf2 = (lambda0^2/c^2)*(lambda0^2*d2ndl2 + 2*lambda0 *dndl);

% Test 1: Prism as Surface + Propgation + Surface
% General Prisim as given in Kostenbauder

psiIn = 10*pi/180;% first interrior angle
psiOut = -30*pi/180; % second interrior angle
L = .5 ; % the lenght of 10 cm

% Compute the matrix elements for the prism
mOut = sqrt(1-(n*sin(psiOut))^2)/cos(psiOut);
mIn = cos(psiIn)/sqrt(1-(n*sin(psiIn))^2);

prismA = mIn*mOut;
prismB = L*mOut/(n*mIn);
prismC = 0;
prismD = 1/(mIn*mOut);
prismE = -dndf*L*mOut*tan(psiIn)/n;
prismF = -dndf*(tan(psiIn)-tan(psiOut))/mOut;
prismG = -dndf*mIn*(tan(psiIn)-tan(psiOut))/lambda0;
prismH = dndf*L*tan(psiOut)/(mIn*n*lambda0);
% prismI = -(dndf^2)*L*tan(psiIn)*tan(psiOut)/(n*lambda0)+ L*lambda0^3*d2ndl2/c^2;
prismI = -(dndf^2)*L*tan(psiIn)*tan(psiOut)/(n*lambda0)+ L*(d2ndf2/lambda0+2*dndf/c);

prismKAsOneElelement = [prismA,prismB,0,prismE;
    prismC,prismD,0,prismF;
    prismG,prismH,1,prismI;
    0,0,0,1]

% Check with surface K matrices
n1 = 1;
n2 = n;
ang2 = psiIn;
ang1 = asin(n2*sin(ang2)/n1);
dl1n1 = 0;
dl1n2 =  dndl;
f0 = c/lambda0;
reflection = 0;
K1 = computeInterfaceRayPulseMatrix( ang1,ang2,n1,n2,dl1n1,dl1n2,f0,reflection )

n1 = n;
n2 = 1;
ang1 = psiOut;
ang2 = asin(n1*sin(ang1)/n2);
dl1n1 = dndl;
dl1n2 =  0;
f0 = c/lambda0;
reflection = 0;
K2 =  computeInterfaceRayPulseMatrix( ang1,ang2,n1,n2,dl1n1,dl1n2,f0,reflection )

L = L;
f0 = c/lambda0;
d2ndl2 = d2ndl2;
KL = computeMediumRayPulseMatrix(L,f0,d2ndl2 );

KPrismAsSurfaceComposition = K2*KL*K1

% Test 2: Propagation after Grating
% Grating 
ang1 = 10;
ang2 = -50;
n1 = n;
n2 = n;
dl1n1 = dndl;
dl1n2 = dndl;
f0 = c/lambda0;;
reflection = 1;
KGrating =  computeInterfaceRayPulseMatrix( ang1,ang2,n1,n2,dl1n1,dl1n2,f0,reflection );
% Grating Plus Propagation
KGratingPlusPropagation = KL*KGrating;

