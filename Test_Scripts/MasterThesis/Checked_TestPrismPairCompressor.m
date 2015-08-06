%% Ideal Prism pair compressor
syms D f0 c L
KPrism1 = [1,0,0,0;
           0,1,0,D;
           D*f0/c,0,1,0;
           0,0,0,1];
KPrism2 = [1,0,0,0;
           0,1,0,-D;
          -D*f0/c,0,1,0;
           0,0,0,1];
KL = [1,L,0,0;
      0,1,0,0;
      0,0,1,0;
      0,0,0,1];
KprismPair = KPrism2*KL*KPrism1

%% GDD of Test Prism pair
% clc
format short e
% Import prism pair system used at Brewster angle and minimum deviation
fTestPrismPair = which ('TestPrismPair.mat');
TestPrismPair = OpticalSystem(fTestPrismPair);
% TestPrismPair.plotSystemLayout(1);
% Computed value 
KPrism1 = TestPrismPair.computeKostenbauderMatrix(1,0,4,0);
KPrismPairAnalytical = TestPrismPair.computeKostenbauderMatrix;
KostenbauderMatrixNumerical = TestPrismPair.computeKostenbauderMatrixNumerically;

GDDComputedAnalyticK = KPrismPairAnalytical(3,4)/(2*pi); % Factor of 1/2pi to convert from herzian freq to radian
GDDComputedNumericalK = KostenbauderMatrixNumerical(3,4)/(2*pi); % Factor of 1/2pi to convert from herzian freq to radian

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

% Apex to apex
p1=[36.8,-25.9]; p2=[21.4,0.0];
CB = sqrt(sum((p1-p2).^2))*TestPrismPair.getLensUnitFactor;
apexToApex = CB
pathGlass = path1+path2;

n;
dndl;
d2ndl2;
% GDDExpected = ((wavLen^3)/(2*pi*c^2))*(4*L*cos(theta)(dndl)^2-2*L*sin(theta)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2)))
GDDExpected = -((wavLen^3)/(2*pi*c^2))*(4*pathair*(dndl)^2-(pathGlass)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2));
format short e
KPrism1
KPrismPairAnalytical
GDDComputedAnalyticK 
GDDComputedNumericalK
GDDExpected
pathair
pathGlass

%% GDD vs wavelength of TestPrismPair
format short e
% Import prism pair system used at Brewster angle and minimum deviation
fTestPrismPair = which ('TestPrismPair.mat');
TestPrismPair = OpticalSystem(fTestPrismPair);
wavLenVector = (linspace(750*10^-9,850*10^-9,60))/(TestPrismPair.getWavelengthUnitFactor);
%     TestPrismPair.plotSystemLayout(1)

for kk = 1:size(wavLenVector,2)
    % set the primary wavelegnth of  TestPrismPair to current wavelength
    TestPrismPair.WavelengthMatrix(TestPrismPair.PrimaryWavelengthIndex,1) = ...
        wavLenVector(kk);
    % Computed value compute the GDD
    KPrismPairAnalytical = TestPrismPair.computeKostenbauderMatrix;
    GDDComputedAnalyticK(kk) = KPrismPairAnalytical(3,4)/(2*pi); 
    
    % Expected value Use the formula from Weiner 4.91
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
    % Apex to apex
    p1=[36.8,-25.9]; p2=[21.4,0.0];
    CB = sqrt(sum((p1-p2).^2))*TestPrismPair.getLensUnitFactor;
    apexToApex = CB;
    pathAir = CDE;
    pathGlass = path1+path2;
    % GDDExpected = ((wavLen^3)/(2*pi*c^2))*(4*L*cos(theta)(dndl)^2-2*L*sin(theta)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2)))
    GDDExpected(kk) = -((wavLen^3)/(2*pi*c^2))*(4*pathair*(dndl)^2-(pathGlass)*(d2ndl2 + (2*n-1/n^3)*(dndl)^2));

end
% Plot GDD vs wavLen
figure;
axes
% Wavelength in nm and the GDD in fs^2
plot(wavLenVector*(TestPrismPair.getWavelengthUnitFactor)/10^-9,GDDComputedAnalyticK/10^-30,wavLenVector*(TestPrismPair.getWavelengthUnitFactor)/10^-9,GDDExpected/10^-30);
legend('GDD From Kostenbauder','GDD using analytical formula');