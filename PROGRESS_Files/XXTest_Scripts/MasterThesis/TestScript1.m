clc
format short e

%% 1. Test refractive index computations (n,dn/dl,d^2n/dl^2)
clc
format short e
% Take Glass SF10 from schott catalogue.
SF10 = Glass('N-SF10');
% Compute the refractive indices
wavLen = 0.8 * 10^-6;
derivativeOrder0 = 0;
derivativeOrder1 = 1;
derivativeOrder2 = 2;

n = SF10.getRefractiveIndex(wavLen,derivativeOrder0);
dndl = SF10.getRefractiveIndex(wavLen,derivativeOrder1);
d2ndl2 = SF10.getRefractiveIndex(wavLen,derivativeOrder2);

disp('Computed results');
disp(['Refractive IndeF: ',num2str(n,'%0.3e')]);
disp(['1st derivative of refractive index about wavelength: ',num2str(dndl,'%0.3e')]);
disp(['2nd derivative of refractive index about wavelength: ',num2str(d2ndl2,'%0.3e')]);

% Display the expected results
% http://www.newport.com/the-effect-of-dispersion-on-ultrashort-pulses/602091/1033/content.aspx
ex_n = 1.711;
ex_dndl = -0.050 * 10^6;
ex_d2ndl2 = 0.173 * 10^12;
disp(' ');
disp('Expected results(From http://www.newport.com/the-effect-of-dispersion-on-ultrashort-pulses/602091/1033/content.aspx)');
disp(['Refractive IndeF: ',num2str(ex_n,'%0.3e')]);
disp(['1st derivative of refractive index about wavelength: ',num2str(ex_dndl,'%0.3e')]);
disp(['2nd derivative of refractive index about wavelength: ',num2str(ex_d2ndl2,'%0.3e')]);


%% 2. Test K matrice of Prism as single component and as sequence of surfaces
% Compute Kostenbauder Matrix 
clc
format short e
% Take Glass SF10 from schott catalogue.
SF10 = Glass('SF10');
% Compute the refractive indices
wavLen = 0.8 * 10^-6;
derivativeOrder0 = 0;
derivativeOrder1 = 1;
derivativeOrder2 = 2;

n = SF10.getRefractiveIndex(wavLen,derivativeOrder0);
dndl = SF10.getRefractiveIndex(wavLen,derivativeOrder1);
d2ndl2 = SF10.getRefractiveIndex(wavLen,derivativeOrder2);

% Once the refractive indices are computed change the wavelength to meter
lambda0 = wavLen;
dndl = dndl*10^6;
d2ndl2 = d2ndl2*10^12;
c = 299792458;
dndf = -lambda0^2*dndl/c;
d2ndf2 = (lambda0^2/c^2)*(lambda0^2*d2ndl2 + 2*lambda0 *dndl);

% Case 1: Prism as single element (General Prisim as given in Kostenbauder)
format short e
psiIn = 1*(10*pi/180);% first interrior angle
psiOut = 1*(-30*pi/180); % second interrior angle
L = .5 ; % the lenght of 10 cm

% Compute the matrix elements for the prism
mOut = sqrt(1-(n*sin(psiOut))^2)/cos(psiOut);
mIn = cos(psiIn)/sqrt(1-(n*sin(psiIn))^2);

prismA = mIn*mOut;
prismB = 1*L*mOut/(n*mIn);
prismC = 1*0;
prismD = 1/(mIn*mOut);
prismE = 1*(-dndf*L*mOut*tan(psiIn)/n);
prismF = 1*(-dndf*(tan(psiIn)-tan(psiOut))/mOut);
prismG = 1*(-dndf*mIn*(tan(psiIn)-tan(psiOut))/lambda0);
prismH = 1*dndf*L*tan(psiOut)/(mIn*n*lambda0);
prismI = -(dndf^2)*L*tan(psiIn)*tan(psiOut)/(n*lambda0)+ L*(d2ndf2/lambda0+2*dndf/c);
format short e
prismKAsOneElelement = [prismA,prismB,0,prismE;
    prismC,prismD,0,prismF;
    prismG,prismH,1,prismI;
    0,0,0,1]
% Case 2: Prism as Surface + Propgation + Surface
% Check with surface K matrices
% Surface 1 K matrix
n1 = 1;
n2 = n;
ang2 = psiIn;
ang1 = asin(n2*sin(ang2)/n1);
dl1n1 = 0;
dl1n2 =  dndl;
f0 = c/lambda0;
reflection = 0;
radius = Inf;
K1 = computeInterfaceKostenbauderMatrix( ang1,ang2,n1,n2,dl1n1,dl1n2,f0,reflection,radius );
% Surface 2 K matrix
n1 = n;
n2 = 1;
ang1 = psiOut;
ang2 = asin(n1*sin(ang1)/n2);
dl1n1 = dndl;
dl1n2 =  0;
f0 = c/lambda0;
reflection = 0;
radius = Inf;
K2 =  computeInterfaceKostenbauderMatrix( ang1,ang2,n1,n2,dl1n1,dl1n2,f0,reflection,radius );
% Glass K matrix
L = L;
f0 = c/lambda0;
d2ndl2 = d2ndl2;
KL = computeMediumKostenbauderMatrix(L,f0,d2ndl2 );
% Prism K matrix
format short e
KPrismAsSurfaceComposition = K2*KL*K1


%% 3. Test Group Delay Dispersion of a Prism pair
% clc
format short e
% Import prism pair system used at Brewster angle and minimum deviation
% fTestPrismPair = 'X:\MATLAB_Based_Optical_System_Analyser_Toolbox_3.0_Oct_08_2014_Working_Version\Evaluation_Systems\TestPrismPair.mat';
fTestPrismPair = which ('TestPrismPair.mat');
TestPrismPair = OpticalSystem(fTestPrismPair);
% TestPrismPair.plotSystemLayout(1);
% Computed value 
KPrism1 = TestPrismPair.computeKostenbauderMatrix(1,0,4,0);
KPrismPair = TestPrismPair.computeKostenbauderMatrix;
[ finalKostenbauderMatrix, interfaceKostenbauderMatrices,mediumKostenbauderMatrices ] = TestPrismPair.computeKostenbauderMatrix;
GDDComputed = KPrismPair(3,4)/(2*pi); % Factor of 1/2pi to convert from herzian freq to radian

% Expected value Use the formula from Weiner 4.91
% GDDExpected = ((wavLen^3)/(2*pi*c^2))*(4*L*cos(theta)(dndl)^2-2*L*sin(theta)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2)))
% Take Glass SF10 from schott catalogue.
SF10 = Glass('N-SF10');

% Compute the refractive indices
wavLen = TestPrismPair.getPrimaryWavelength;
derivativeOrder0 = 0;
derivativeOrder1 = 1;
derivativeOrder2 = 2;
n = SF10.getRefractiveIndex(wavLen,derivativeOrder0);
dndl = SF10.getRefractiveIndex(wavLen,derivativeOrder1);
d2ndl2 = SF10.getRefractiveIndex(wavLen,derivativeOrder2);

c =  299792458;
% c =  3*10^8;
% path1 = 0.567897849920405*10^-3;
% path2 = 0.545797105999778*10^-3;
% pathair = 10.304574037414916*10^-3;

cheirRayTrace = TestPrismPair.traceChiefRay;
chiefPathLength = [cheirRayTrace.PathLength];
path1 = chiefPathLength(4)*TestPrismPair.getLensUnitFactor;
path2 = chiefPathLength(6)*TestPrismPair.getLensUnitFactor;
pathair = chiefPathLength(5)*TestPrismPair.getLensUnitFactor;

CD = pathair;
DF = path2;
DE = 0.5*DF;
%  (L cos ?) = CDE 
CDE = CD + 0.5*(path2);
% CDE = CD+DE;
%  (2*L sin ?) = path of the ray through the glass = (path1+path2)
n;
dndl;
d2ndl2;
% GDDExpected = ((wavLen^3)/(2*pi*c^2))*(4*L*cos(theta)(dndl)^2-2*L*sin(theta)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2)))
GDDExpected = -((wavLen^3)/(2*pi*c^2))*(4*CDE*(dndl)^2-(path1+path2)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2));
format short e
KPrism1
KPrismPair
GDDComputed 
GDDExpected

%% 4. Test Group Delay Dispersion of a Grating Pair
% Import grating pair system 
% clc
format short e
% fTestGratingPair = 'X:\MATLAB_Based_Optical_System_Analyser_Toolbox_3.0_Oct_08_2014_Working_Version\Evaluation_Systems\TestGratingPair.mat';
fTestGratingPair = which('TestGratingPair.mat');
TestGratingPair = OpticalSystem(fTestGratingPair);
%TestGratingPair.plotSystemLayout(1);
% Computed value
KGrating1 = TestGratingPair.computeKostenbauderMatrix(1,0,3,0);
KGratingPair = TestGratingPair.computeKostenbauderMatrix;
[ finalKostenbauderMatrix, interfaceKostenbauderMatrices,mediumKostenbauderMatrices ] = TestGratingPair.computeKostenbauderMatrix;
GDDComputed = KGratingPair(3,4)/(2*pi); % Factor of 1/2pi to convert from herzian freq to radian

% Expected value Use the formula from Weiner 4.63
% GDDExpected = ((m^2)*(wavLen^3)*b)/((2*pi*(c^2)*(d^2)*(cos (thetad))^2)
m = TestGratingPair.SurfaceArray(3).OtherStandardData.DiffractionOrder;
wavLen = TestGratingPair.getPrimaryWavelength;
c =  299792458;
d = TestGratingPair.SurfaceArray(3).getGratingPeriodicity;
chiefRayTrace = TestGratingPair.traceChiefRay;
exitAngles = [chiefRayTrace.ExitAngle];
thetad = abs(exitAngles(3)) ; % Exit angle after 1st grating or 3rd surface
pathLength = [chiefRayTrace.PathLength]*TestGratingPair.getLensUnitFactor;
b = pathLength(4);
GDDExpected = -((m^2)*(wavLen^3)*b)/((2*pi*(c^2)*(d^2)*(cos(thetad))^2));

format short e
KGrating1
KGratingPair
GDDComputed
GDDExpected
%% 3. Test Pulse Front Tilt and Angular Dispersion of a single Prism


