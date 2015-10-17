%%  Ideal Grating Pair 4f. Analytic expression is soo lenghty.

syms M D wav f l2
K_G1 = [M,0,0,0;
        0,1/M,0,D;
        D*M/wav,0,1,0;
        0,0,0,1];
K_G2 = [1/M,0,0,0;
    0,M,0,-D;
    -D*M/wav,0,1,0;
    0,0,0,1];
K_Lens1 = [1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,0,1];
K_Lens2 = [1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,0,1];

K_L2 = [1,l2,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1];
K_f = [1,f,0,0;
    0,1,0,0;
    0,0,1,0;
    0,0,0,1];

K_GratingPair = K_G2*K_L2*K_f*K_Lens2*K_f*K_f*K_Lens1*K_f*K_G1

%% GDD vs l2 of Grating Pair 4f
format short e
% Import prism pair system used at Brewster angle and minimum deviation
fGratingPair4F = which ('GratingPair4F.mat');
GratingPair4F = OpticalSystem(fGratingPair4F);
l2Vector = (linspace(-10*10^-3,10*10^-3,4))/(GratingPair4F.getLensUnitFactor);
lens2 = GratingPair4F.SurfaceArray(9);
f2 = lens2.OtherStandardData.FocalLength;

    
for kk = 1:size(l2Vector,2)
    % Set the length after lens 2
    GratingPair4F.SurfaceArray(9).Thickness = f2+l2Vector(kk);
    % update the surface array
    [ GratingPair4F ] = updateSurfaceArray( GratingPair4F );
    
    % Computed value compute the GDD
    KGratingPair4F = GratingPair4F.computeKostenbauderMatrix;
    GDDComputed(kk) = KGratingPair4F(3,4)/(2*pi); 
end
slopeUsingKostenbauder = ((GDDComputed(1))-(GDDComputed(end)))/((l2Vector(1)-l2Vector(end))*(GratingPair4F.getLensUnitFactor))

% Expected value Use the formula from Weiner 4.77
wavLen = GratingPair4F.getPrimaryWavelength;
c =  299792458;
cheirRayTrace = GratingPair4F.traceChiefRay;
chiefRayExitAngle = [cheirRayTrace.ExitAngle];
% grating period in meter
d = (1/GratingPair4F.SurfaceArray(6).OtherStandardData.GratingLineDensity)*10^-6;
% diffracted angle
thetaD = chiefRayExitAngle(4);

slopeFromAnalyticalFormula = -((wavLen^3)/(2*pi*c^2))*(1/(d*cos(thetaD))^2)
GDDExpected = slopeFromAnalyticalFormula*l2Vector*(GratingPair4F.getLensUnitFactor);


% Plot GDD vs l2
figure;
axes
% l2 in mm and the GDD in fs^2
plot(l2Vector*(GratingPair4F.getLensUnitFactor)/10^-3,GDDComputed/10^-30,l2Vector*(GratingPair4F.getLensUnitFactor)/10^-3,GDDExpected/10^-30);
legend('GDD From Kostenbauder','GDD Analytical');


   
%% Angular dispersion and spatial chirp vs l2 of Grating Pair 4f
format short e
% Import prism pair system used at Brewster angle and minimum deviation
fGratingPair4F = which ('GratingPair4F.mat');
GratingPair4F = OpticalSystem(fGratingPair4F);
l2Vector = (linspace(-10*10^-3,10*10^-3,50))/(GratingPair4F.getLensUnitFactor);
lens2 = GratingPair4F.SurfaceArray(9);
f2 = lens2.OtherStandardData.FocalLength;

    
for kk = 1:size(l2Vector,2)
    % Set the length after lens 2
    GratingPair4F.SurfaceArray(9).Thickness = f2+l2Vector(kk);
    % update the surface array
    [ GratingPair4F ] = updateSurfaceArray( GratingPair4F );
    
    % Computed value compute the GDD
    KGratingPair4F = GratingPair4F.computeKostenbauderMatrix;
    spatialChirp(kk) = KGratingPair4F(1,4)/(2*pi); 
    angularDispersion(kk) = KGratingPair4F(2,4)/(2*pi); 
end
% Plot spatialChirp vs l2
figure;
axes
% l2 in mm and the spatialChirp in m/Hz
plot(l2Vector*(GratingPair4F.getLensUnitFactor)/10^-3,spatialChirp);
legend('Spatial Chirp Using Kostenbauder');
% Plot angularDispersion vs l2
figure;
axes
% l2 in mm and , angularDispersion rad/Hz
plot(l2Vector*(GratingPair4F.getLensUnitFactor)/10^-3,angularDispersion);
legend('Angular Dispersion Using Kostenbauder');
