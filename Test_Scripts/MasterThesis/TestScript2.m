
%% Result 1: Graph of Optical Path length and "Group Path Length" vs Wavelength 
clc
format short e
%  fOpticalSystemName = which ('DoubleGauss28.mat');  
fOpticalSystemName = which ('TestGratingPair.mat');  

opticalSystem = OpticalSystem(fOpticalSystemName);
fieldIndex = 1;
minWavelengthInM = opticalSystem.getPrimaryWavelength-50*10^-9;
maxWavelengthInM = opticalSystem.getPrimaryWavelength+50*10^-9;
nPoints = 100;
[ wavelengthGeometricalOpticalGroupPathLength ] = ...
    opticalSystem.plotPathLengthVersusWavelength(fieldIndex, minWavelengthInM, maxWavelengthInM, nPoints)

%% Result 2: Test the Kostenbauder Matrix for a given system using the ray-pulse-vector computation 
% The Kostenbauder matrix transformas the RayPulseVector from the object to
% image space. The ray-pulse vectors can be independantly computed
% independantly by tracing the differential ray. If the ray pulse matrix
% computed using the kostenbauder matrix is the same as that determined
% independantly, then our matrix is Correct.

clc
% Get the optical system and initial ray pulse vectors
% NB. The kostenbauder matrix method is valid only if all the differential
% values of the ray pulse vector remain very small through out the system,
% otherwise the paraxial approximation will be violated.
% NB. For freqency (2um :=> 10^12 hz) b/c (3*10^8)/(600*10^-9)-(3*10^8)/(602*10^-9) = 1.6611e+12
% fOpticalSystemName = which ('TestPrismPair.mat'); y0 = 100.0*10^-6; u0 = -0.4*pi/180; t0 = 0; f0 = 50*10^12;
% fOpticalSystemName = which ('DoubleGauss28.mat');  y0 = 100.0*10^-6; u0 = -0.5*pi/180; t0 = 0; f0 = 2*10^12; 
% fOpticalSystemName = which ('TestGratingPair.mat');  y0 = -10.0*10^-6; u0 = -0.02*pi/180; t0 = 0; f0 = 0.1*10^12;
% fOpticalSystemName = which ('TestGratingPair.mat');  y0 = 0.0*10^-6; u0 = -0.1*pi/180; t0 = 0; f0 = -5*10^12;
% fOpticalSystemName = which ('SingleSurface.mat');  y0 = 100.0*10^-6; u0 = -2*pi/180; t0 = 0; f0 = 100*10^12; 
% fOpticalSystemName = which ('DoubleGauss28.mat'); y0 = 0.0*10^-6; u0 = -0*pi/180; t0 = 0; f0 = -10*10^12; 

opticalSystem = OpticalSystem(fOpticalSystemName);

% Compute the kostenbauder matrix
KostenbauderMatrix = opticalSystem.computeKostenbauderMatrix;

% Compute the final ray pulse vector using the Kostenbauder matrix.
finalKostenbauderMatrixUsingKostenbauderMatrix =  (KostenbauderMatrix*[y0,u0,t0,f0]')';

% Compute the final ray vector using real ray trace of the differntial ray
[y2,u2,t2,f2] = opticalSystem.computeRayPulseVector(y0,u0,t0,f0);
finalKostenbauderMatrixUsingRayTrace = [y2,u2,t2,f2];

format longE
format compact
disp('Ray pulse vector [y2,u2,t2,f2] using ray trace');
finalKostenbauderMatrixUsingRayTrace
disp('Ray pulse vector [y2,u2,t2,f2] using Kostenbauder Matrix');
finalKostenbauderMatrixUsingKostenbauderMatrix

%% Result 3: Pulse front delay of single prism
clc
% Get the optical system and initial ray pulse vectors
fOpticalSystemName = which ('SinglePrism.mat'); 

% Define the height of the apex ray and base ray (ray pulse vector
% parameters)
y0ApexRay = 2.744*10^-2; u0ApexRay = -0.0*pi/180; t0ApexRay = 0; f0ApexRay = 0*10^12;
y0BaseRay = -2.744*10^-2; u0BaseRay = -0.0*pi/180; t0BaseRay = 0; f0BaseRay = 0*10^12;

opticalSystem = OpticalSystem(fOpticalSystemName);

% Compute the final ray vector  for both rays using ray trace of the differntial ray
[y2ApexRay,u2ApexRay,t2ApexRay,f2ApexRay] = opticalSystem.computeRayPulseVector(y0ApexRay,u0ApexRay,t0ApexRay,f0ApexRay);
[y2BaseRay,u2BaseRay,t2BaseRay,f2BaseRay] = opticalSystem.computeRayPulseVector(y0BaseRay,u0BaseRay,t0BaseRay,f0BaseRay);

% Determine the delay between the apex and base ray
totalDelayComputed = t2BaseRay - t2ApexRay;

% Use the formula equation 5 on Zor paper to determine the expected time delay
% totalDelayExpected = -(baseLength/c)*wavLen*dndl;
% To get base length trace a pilot ray parallel to the cheif ray but
% starting from y0 = y0BaseRay
pilotRay = opticalSystem.getChiefRay;
position = pilotRay.Position;
pilotRay.Position = [position(1);y0BaseRay;position(3)];
pilotRayTraceResult = opticalSystem.rayTracer(pilotRay);
baseLength = pilotRayTraceResult(3).PathLength*opticalSystem.getLensUnitFactor;
c =  299792458;
wavLen = pilotRay.Wavelength;
% Get the glass of prism
BK7 = Glass('BK7');
derivativeOrder1 = 1;
dndl = BK7.getRefractiveIndex(wavLen,derivativeOrder1);
totalDelayExpected = -(baseLength/c)*wavLen*dndl;

% Display outputs
disp('Computed delay between base ray and apex ray in single prism:');
ComputedDelay = totalDelayComputed
disp('Expected delay between base ray and apex ray in single prism:');
ExpectedDelay = totalDelayExpected

%% Result 4.1: Ploting Phase fronts and Pulse fronts in Lens system
% Example1: Singlet Lens of Fused Silica
fOpticalSystemName = which ('SingletFusedSilicaF150mm.mat'); 
fusedSilicaLens = OpticalSystem(fOpticalSystemName);
wavLenInSI = fusedSilicaLens.getPrimaryWavelength;
fieldPointXYInSI = [0;0];
nSamplingPoints2 = 50;
% gridType =  'Polar';
gridType =  'Rectangular'; 
plotIn2D = 0; 
nSamplingPoints1 = 50;

% gridType =  'Rectangular'; 
% plotIn2D = 1; 
% nSamplingPoints1 = 1;

%  distanceAlongChiefRay = 140; % At -20 mm from focus. Both pulse and phase fronts convex
% distanceAlongChiefRay = 180; % At 20 mm from focus.convex pulse but concave phase front
% distanceAlongChiefRay = 200; % At 40 mm from focus % Flat pulse front and concave phase front
distanceAlongChiefRay = 160; plotIn2D = 1; nSamplingPoints1 = 1;% At -20 mm from focus. Pulse front at focal plane
[ drawn ] = fusedSilicaLens.plotPhaseFrontAndPulseFront(wavLenInSI,fieldPointXYInSI,...
    distanceAlongChiefRay, nSamplingPoints1,nSamplingPoints2,gridType,plotIn2D );
%% Result 4.2: Ploting Phase fronts and Pulse fronts in Lens system
% Example1: Achromat (Use AchromaticAt800nmF25mm.mat)
fOpticalSystemName = which ('AchromaticAt800nmF25mm.mat'); 
achromaticLens = OpticalSystem(fOpticalSystemName);
wavLenInSI = achromaticLens.getPrimaryWavelength;
fieldPointXYInSI = [0;0];
nSamplingPoints1 = 50;
nSamplingPoints2 = 150;
% gridType =  'Polar';
% gridType =  'Rectangular'; 
% plotIn2D = 0; 
% nSamplingPoints1 = 50;

gridType =  'Rectangular'; 
plotIn2D = 1; 
nSamplingPoints1 = 1;

distanceAlongChiefRay = 15; 
[ drawn ] = achromaticLens.plotPhaseFrontAndPulseFront(wavLenInSI,fieldPointXYInSI,...
    distanceAlongChiefRay, nSamplingPoints1,nSamplingPoints2,gridType,plotIn2D );

% Expected delay between phase fronts and pulse fronts equal for the whole
% apertutre size (In paraxial approximation)
% From eqn 22 of Z.Bor Distortion of femtosecond laser pulse

%% Result 5: Skew gaussian beam propagation through optical systems using 5 rays
fOpticalSystemName = which ('DoubleGauss28.mat'); 
opticalSystem = OpticalSystem(fOpticalSystemName);
% Initial gaussian beam parameters just before the 1st surface after object
lensUnitFactor = opticalSystem.getLensUnitFactor;
waistX = 0.02*lensUnitFactor;
waistY = 0.05*lensUnitFactor;
distanceFromWaist = 0*lensUnitFactor;
% fieldIndex = 1;
% fieldIndex = 2;
fieldIndex = 3;
wavelengthIndex = 2;

initialGaussianBeamParameters = [waistX,waistY,distanceFromWaist,fieldIndex,wavelengthIndex];
recordRayTraceResults = 1;
    
opticalSystem.gaussianBeamTracerTester( initialGaussianBeamParameters,...
    recordRayTraceResults)
%% Result 6: Gaussian beam decomposition
fOpticalSystemName = which ('DoubleGauss28.mat'); 
opticalSystem = OpticalSystem(fOpticalSystemName);
initialGBArray = os.computeInitialGaussianBeamArray(1,1,2*10^-3,0.1*10^-3,0.1*10^-3,1.5);
os.gaussianBeamTracer(initialGBArray)

% SSTF
%% Result 7.1:  Ideal SSTF Pulse front tilt parameter near focus
% Take initial gaussian pulse 
% 70 fs temporal width
% 800 nm central wavelength
% 2mm beam diameter
wavLen = 800 * 10^-9;
t0 = 70 * 10^-15;
w0 = 2*10^-3;
Qin(1,1) = -1i*wavLen/(pi*w0^2);
Qin(2,2) = 1i*wavLen/(pi*t0^2);
Qin(1,2) = 0;
Qin(2,1) = 0;

QinInvers = inv(Qin);
% % Use ideal K matrices to model ideal SSTF system
% spacialChirp = 2*pi*7.5*10^-17;
% idealDiffractive_K = [1,0,0,spacialChirp;...
%                         0,1,0,0;...
%                         0,0,1,0;...
%                         0,0,0,1];
                    
%Use real sstf for diffractive
% fSSTF = which('SSTF.mat');
fSSTF = which('SSTFUsingIdealLens.mat');

SSTF = OpticalSystem(fSSTF);
[ KostenbauderMatrixDiffractivePart] = SSTF.computeKostenbauderMatrix(1,0,7,0);
SSTF.computeKostenbauderMatrix;
idealDiffractive_K = KostenbauderMatrixDiffractivePart;

focalLength = 25*10^-3;
idelLens_K = [1,0,0,0;...
            -1/focalLength,1,0,0;...
            0,0,1,0;...
            0,0,0,1];
                                   
% distance = linspace(24.5*10^-3,25.5*10^-3,50);
distance = linspace(24.5*10^-3,26.5*10^-3,50);
figure;
axes
for kk = 1:1:50
    propagation_K =  [1,distance(kk),0,0;...
                0,1,0,0;...
                0,0,1,0;...
                0,0,0,1];
            idealSSTF_K = propagation_K*SSTF.computeKostenbauderMatrix;
%     idealSSTF_K = propagation_K*idelLens_K*idealDiffractive_K; 

    QoutInverse = inv(([idealSSTF_K(1,1),0;...
                        idealSSTF_K(3,1),1]*Qin + ....
                        [idealSSTF_K(1,2),idealSSTF_K(1,4)/wavLen;...
                        idealSSTF_K(3,2),idealSSTF_K(3,4)/wavLen])...
                        /(([idealSSTF_K(2,1),0;...
                               0,0]*Qin + ....
                              [idealSSTF_K(2,2),idealSSTF_K(2,4)/wavLen;...
                               0,1])));
    % Pulse front tilt vs z
    PFT = imag(QoutInverse(1,2))/imag(QoutInverse(2,2));
    scatter(distance(kk),PFT,'.')
    hold on                     
end
%% Result 7.2 Test Pulse front tilt parameter in real SSTF system
% Import grating pair system 
clc
format short e
fSSTF = which('SSTF.mat');
SSTF = OpticalSystem(fSSTF);
[ KostenbauderMatrixDiffractivePart] = SSTF.computeKostenbauderMatrix(1,0,8,0);
[ KostenbauderMatrixFocusingPart] = SSTF.computeKostenbauderMatrix(8,1,11,0);
KostenbauderMatrixTotal = SSTF.computeKostenbauderMatrix;


% Take initial gaussian pulse 
% 70 fs temporal width
% 800 nm central wavelength
% 2mm beam diameter
wavLen = 800 * 10^-9;
t0 = 70 * 10^-15;
w0 = 2*10^-3;
Qin(1,1) = -1i*wavLen/(pi*w0^2);
Qin(2,2) = 1i*wavLen/(pi*t0^2);
Qin(1,2) = 0;
Qin(2,1) = 0;

QinInvers = inv(Qin);
K1 = KostenbauderMatrixDiffractivePart;
K = KostenbauderMatrixTotal;

Q_After_Diffractive = inv(([K1(1,1),0;...
                        K1(3,1),1]*QinInvers + ....
                        [K1(1,2),K1(1,4)/wavLen;...
                        K1(3,2),K1(3,4)/wavLen])...
                        /(([K1(2,1),0;...
                               0,0]*QinInvers + ....
                              [K1(2,2),K1(2,4)/wavLen;...
                               0,1])));
                           
QoutInverse = inv(([K(1,1),0;...
                        K(3,1),1]*QinInvers + ....
                        [K(1,2),K(1,4)/wavLen;...
                        K(3,2),K(3,4)/wavLen])...
                        /(([K(2,1),0;...
                               0,0]*QinInvers + ....
                              [K(2,2),K(2,4)/wavLen;...
                               0,1])));
                                          
PFTParamater = imag(QoutInverse(1,2))/imag(QoutInverse(2,2));

format short e
KostenbauderMatrixDiffractivePart
KostenbauderMatrixFocusingPart
KostenbauderMatrixTotal

Qin
% Q_After_Diffractive
QoutInverse
PFTParamater
