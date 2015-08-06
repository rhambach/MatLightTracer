%% Analytical SSTF
syms eta pi wav f L df alph zeth c pi Q011 Q022
K_Diffractive  = [1,0,0,2*pi*eta;
                0,1,0,0;
                0,-2*pi*eta/wav,1,0;
                0,0,0,1];
            
K_Focussing  = [0,f,0,0;
                -1/f,1,0,0;
                0,0,1,0;
                0,0,0,1];
KSSTF = K_Focussing*K_Diffractive;
KTotal = KSSTF

% initial pulsed beam Q0 = inv(Qin)
Qin = inv([Q011 0;-0 Q022]);
Qout = ([KTotal(1,1) 0;KTotal(3,1) 1]*Qin+[KTotal(1,2) KTotal(1,4)/wav;KTotal(3,2) KTotal(3,4)/wav])*inv([KTotal(2,1) 0;0 1]*Qin+[KTotal(2,2) KTotal(2,4)/wav;0 1]); 
QoutInv = inv(Qout);
QoutXT = QoutInv(1,2)
QoutXX = QoutInv(1,1);
QoutTX = QoutInv(2,1);
QoutTT = QoutInv(2,2)
% PFT can be computed PFT = imag(QoutXT)/imag(QoutTT)
% PFT = -2*pi*eta/(wav*f) : Agrees with Sites result

%% Input pulsed beam
spatialWidthInSI = 2*10^-3;    % 2 mm
radiusOfCurvatureInSI = Inf;   % Beam at its waist
temporalWidthInSI = 29.33*10^-15; % 29.33 fs
initialChirpInSI = 0;          % No chirp
centralWavelength = 800 * 10^-9;  % 800 nm
gaussianPulsedBeamParameter = [spatialWidthInSI,...
    radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
NewGaussianPulsedBeam = GaussianPulsedBeam(gaussianPulsedBeamParameter,centralWavelength);

% Plot the input beam
t_min = -1*10^-12;
t_max = 1*10^-12;
x_min = -20*10^-3;
x_max = 20*10^-3;
tlin = linspace(t_min,t_max,200);
xlin = linspace(x_min,x_max,200);

% Plot the input pulsed beam (amplitude)
%     wt = getGlobalTemporalWidth(NewGaussianPulsedBeam);
%     tMax = 3*wt/sqrt(2);
%     tlin = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(NewGaussianPulsedBeam);
%     xMax = 3*wx/sqrt(2);
%     xlin = linspace(-xMax,xMax,200);
NewGaussianPulsedBeam.plotGaussianPulsedBeam(tlin,xlin);
% NewGaussianPulsedBeam.plotGaussianPulsedBeam();

%% Analyse IdealSSTF
fIdealSSTF = which('IdealSSTF.mat');
fIdealSSTFZeroSpatialChirp = which('IdealSSTFZeroSpatialChirp.mat');
fIdealSSTFSmallSpatialChirp = which('IdealSSTFSmallSpatialChirp.mat');

IdealSSTF = OpticalSystem(fIdealSSTF);
[ K_DiffractivePart_IdealSSTF] = IdealSSTF.computeKostenbauderMatrix(3,0,3,1)
[ K_Lens_IdealSSTF] = IdealSSTF.computeKostenbauderMatrix(4,0,4,1)
[ K_AfterLens_IdealSSTF] = IdealSSTF.computeKostenbauderMatrix(4,0,5,1)

K_IdealSSTF = K_AfterLens_IdealSSTF*K_Lens_IdealSSTF*K_DiffractivePart_IdealSSTF

% Input beam parameters
spatialWidthInSI = 3*10^-3;    % 3 mm
radiusOfCurvatureInSI = Inf;   % Beam at its waist
temporalWidthInSI = 24.91*10^-15; % Gaussian beam centered at 800 nm and has bandwidth of 32 nm 
% http://www.rp-photonics.com/gaussian_pulses.html
initialChirpInSI = 0;          % No chirp
centralWavelength = 800 * 10^-9;  % 800 nm
gaussianPulsedBeamParameter = [spatialWidthInSI,...
    radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
NewGaussianPulsedBeam = GaussianPulsedBeam(gaussianPulsedBeamParameter,centralWavelength);

% Plot the input beam
t_min = -0.15*10^-12;
t_max = 0.15*10^-12;
x_min = -15*10^-3;
x_max = 15*10^-3;

tlin = linspace(t_min,t_max,200);
xlin = linspace(x_min,x_max,200);

tlinFocal = linspace(-0.15*10^-12,0.15*10^-12,200);
xlinFocal = linspace(-8*10^-6,8*10^-6,200);

initialPulsedBeam = NewGaussianPulsedBeam;
%     wt = getGlobalTemporalWidth(initialPulsedBeam);
%     tMax = 3*wt/sqrt(2);
%     tlin = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(initialPulsedBeam);
%     xMax = 3*wx/sqrt(2);
%     xlin = linspace(-xMax,xMax,200);
initialPulsedBeam.plotGaussianPulsedBeam(tlin,xlin);
% initialPulsedBeam.plotGaussianPulsedBeam();

pulsedBeamAfterDiffractivePart = initialPulsedBeam.propagateUsingKostenbauder((K_DiffractivePart_IdealSSTF));
%     wt = getGlobalTemporalWidth(pulsedBeamAfterDiffractivePart);
%     tMax = 3*wt/sqrt(2);
%     tlin = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(pulsedBeamAfterDiffractivePart);
%     xMax = 3*wx/sqrt(2);
%     xlin = linspace(-xMax,xMax,200);
pulsedBeamAfterDiffractivePart.plotGaussianPulsedBeam(tlin,xlin);
% pulsedBeamAfterDiffractivePart.plotGaussianPulsedBeam();

pulsedBeamAtFocalPoint = initialPulsedBeam.propagateUsingKostenbauder((K_IdealSSTF));
%     wt = getGlobalTemporalWidth(pulsedBeamAtFocalPoint);
%     tMax = 3*wt/sqrt(2);
%     tlinFocal = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(pulsedBeamAtFocalPoint);
%     xMax = 3*wx/sqrt(2);
%     xlinFocal = linspace(-xMax,xMax,200);
pulsedBeamAtFocalPoint.plotGaussianPulsedBeam(tlinFocal,xlinFocal);
% pulsedBeamAtFocalPoint.plotGaussianPulsedBeam();

nPoints = 400;
dl = linspace(-0.25*10^-3,0.25*10^-3,nPoints);
K_L = K_AfterLens_IdealSSTF;

PFTwithoutInitialPFT = zeros(1,nPoints);
localPulseDuration = zeros(1,nPoints);
globalPulseDuration = zeros(1,nPoints);
localPulseWidth = zeros(1,nPoints);
globalPulseWidth = zeros(1,nPoints);

for kk = 1:1:nPoints
    K_L(1,2) = K_AfterLens_IdealSSTF(1,2) + dl(kk);
    K_Total = K_L*K_Lens_IdealSSTF*K_DiffractivePart_IdealSSTF;
        
    finalPulsedBeamWithOutInitialPFT = initialPulsedBeam.propagateUsingKostenbauder((K_Total));
    
    % Pulse front tilt vs z
    PFTwithoutInitialPFT(kk) = finalPulsedBeamWithOutInitialPFT.getPulseFrontTilt;
    
    localPulseDuration(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalTemporalWidth;
    globalPulseDuration(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalTemporalWidth;
    
        
    localPulseWidth(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalSpatialWidth;
    globalPulseWidth(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalSpatialWidth;
end
figure;
axes
plot(dl,PFTwithoutInitialPFT)

figure;
axes
plot(dl,localPulseDuration,dl,globalPulseDuration)
legend('Local Pulse Duration', 'Global Pulse Duration')

figure;
axes
plot(dl,localPulseWidth,dl,globalPulseWidth)
legend('Local Pulse Width', 'Global Pulse Width')


% %% Diffractive part + Ideal Lens
% fSSTF = which('SSTFUsingIdealLens.mat');
% SSTF = OpticalSystem(fSSTF);
% [ K_DiffractivePart] = SSTF.computeKostenbauderMatrix(1,0,7,0)
% [ K_Lens] = SSTF.computeKostenbauderMatrix(7,0,8,1);
% [ K_AfterLens] = SSTF.computeKostenbauderMatrix(8,0,9,0);
% 
% % K_AdditionalPath = [1,10*5000*10^-3,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
% 
% initialPulsedBeam = NewGaussianPulsedBeam;
% initialPFT = -(1/(2*pi))*2.67*10^-11;
% % initialPFT = (1/(1))*14*10^-11;
% 
% initialPulsedBeamWithInitialPFT = initialPulsedBeam.addPulseFrontTilt(initialPFT);
% 
% pulsedBeamAfterDiffractive = initialPulsedBeam.propagateUsingKostenbauder(K_DiffractivePart);
% pulsedBeamAfterDiffractive.plotGaussianPulsedBeam;%(tlin,xlin);
% 
% K_DiffractivePart_SiteApprox = eye(4);
% lateralSeparationFactor = 2*pi*7.5*10^-17;
% K_DiffractivePart_SiteApprox(1,4) = lateralSeparationFactor;
% K_DiffractivePart_SiteApprox(3,2) = -lateralSeparationFactor/centralWavelength;
% 
% pulsedBeamAfterDiffractiveSiteApprox1 = initialPulsedBeam.propagateUsingKostenbauder((K_DiffractivePart_SiteApprox));
% pulsedBeamAfterDiffractiveSiteApprox1.plotGaussianPulsedBeam(tlin,xlin);
% 
% pulsedBeamAfterDiffractiveSiteApprox2 = initialPulsedBeamWithInitialPFT.propagateUsingKostenbauder((K_DiffractivePart_SiteApprox));
% pulsedBeamAfterDiffractiveSiteApprox2.plotGaussianPulsedBeam(tlin,xlin);
% 
% 
% K_Total = K_AfterLens*K_Lens*K_DiffractivePart_SiteApprox;
% finalPulsedBeam1 = initialPulsedBeam.propagateUsingKostenbauder((K_Total));
% finalPulsedBeam1.plotGaussianPulsedBeam(linspace(-0.9*10^-12,0.9*10^-12,200),linspace(-26*10^-6,26*10^-6,200));
% 
% finalPulsedBeam2 = initialPulsedBeamWithInitialPFT.propagateUsingKostenbauder((K_Total));
% finalPulsedBeam2.plotGaussianPulsedBeam(linspace(-0.9*10^-12,0.9*10^-12,200),linspace(-26*10^-6,26*10^-6,200));
% 
% nPoints = 400;
% dl = linspace(-0.4*10^-3,0.4*10^-3,nPoints);
% K_L = K_AfterLens;
% 
% 
% PFTwithoutInitialPFT = zeros(1,nPoints);
% PFTwithInitialPFT = zeros(1,nPoints);
% localPulseDuration = zeros(1,nPoints);
% globalPulseDuration = zeros(1,nPoints);
% localPulseWidth = zeros(1,nPoints);
% globalPulseWidth = zeros(1,nPoints);
% 
% 
% for kk = 1:1:nPoints
%     K_L(1,2) = K_AfterLens(1,2) + dl(kk);
%     K_Total = K_L*K_Lens*K_DiffractivePart_SiteApprox;
%     
%     finalPulsedBeamWithOutInitialPFT = initialPulsedBeam.propagateUsingKostenbauder((K_Total));
%     finalPulsedBeamWithInitialPFT = initialPulsedBeamWithInitialPFT.propagateUsingKostenbauder((K_Total));
%     
%     % Pulse front tilt vs z
%     PFTwithoutInitialPFT(kk) = finalPulsedBeamWithOutInitialPFT.getPulseFrontTilt;
%     PFTwithInitialPFT(kk) = finalPulsedBeamWithInitialPFT.getPulseFrontTilt;
%     
%     localPulseDuration(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalTemporalWidth;
%     globalPulseDuration(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalTemporalWidth;
%     
%     localPulseWidth(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalSpatialWidth;
%     globalPulseWidth(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalSpatialWidth;
%     
% end
% figure;
% axes
% plot(dl,PFTwithoutInitialPFT,dl,PFTwithInitialPFT)
% hold on 
% 
% figure;
% axes
% plot(dl,localPulseDuration,dl,globalPulseDuration)
% hold on 
% 
% figure;
% axes
% plot(dl,localPulseWidth,dl,globalPulseWidth)
% hold on 
%% Analyse Real SSTF using Grating pair + ideal lens 
fSSTFUsingIdealLensSSTF = which('SSTFUsingIdealLens.mat');

SSTF = OpticalSystem(fSSTFUsingIdealLensSSTF);
[ K_DiffractivePart_SSTF] = SSTF.computeKostenbauderMatrix(1,0,7,1)
[ K_Lens_SSTF] = SSTF.computeKostenbauderMatrix(7,0,8,1)
[ K_AfterLens_SSTF] = SSTF.computeKostenbauderMatrix(8,0,9,1)


% compensate the GDD part
additionalGVD = 4000*10^-30; % 4000 fs^2
K_DiffractivePart_SSTF_Compensator = eye(4);
K_DiffractivePart_SSTF_Compensator(3,4) = -K_DiffractivePart_SSTF(3,4) + additionalGVD*2*pi;
K_DiffractivePart_SSTF = K_DiffractivePart_SSTF*K_DiffractivePart_SSTF_Compensator;

K_SSTF = K_AfterLens_SSTF*K_Lens_SSTF*K_DiffractivePart_SSTF;

% Input beam parameters
spatialWidthInSI = 3*10^-3;    % 3 mm
radiusOfCurvatureInSI = Inf;   % Beam at its waist
temporalWidthInSI = 24.91*10^-15; % Gaussian beam centered at 800 nm and has bandwidth of 32 nm 
% http://www.rp-photonics.com/gaussian_pulses.html
initialChirpInSI = 0;          % No chirp
centralWavelength = 800 * 10^-9;  % 800 nm
gaussianPulsedBeamParameter = [spatialWidthInSI,...
    radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI]';
NewGaussianPulsedBeam = GaussianPulsedBeam(gaussianPulsedBeamParameter,centralWavelength);

% Plot the input beam
t_min = -0.15*10^-12;
t_max = 0.15*10^-12;
x_min = -25*10^-3;
x_max = 25*10^-3;

tlin = linspace(t_min,t_max,200);
xlin = linspace(x_min,x_max,200);

% tlinFocal = linspace(-0.15*10^-9,0.15*10^-9,200);
% xlinFocal = linspace(-8*10^-5,8*10^-5,200);
tlinFocal = linspace(-0.15*10^-12,0.15*10^-12,200);
xlinFocal = linspace(-8*10^-6,8*10^-6,200);

initialPulsedBeam = NewGaussianPulsedBeam;
%     wt = getGlobalTemporalWidth(initialPulsedBeam);
%     tMax = 3*wt/sqrt(2);
%     tlin = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(initialPulsedBeam);
%     xMax = 3*wx/sqrt(2);
%     xlin = linspace(-xMax,xMax,200);
initialPulsedBeam.plotGaussianPulsedBeam(tlin,xlin);
% initialPulsedBeam.plotGaussianPulsedBeam();

pulsedBeamAfterDiffractivePart = initialPulsedBeam.propagateUsingKostenbauder((K_DiffractivePart_SSTF));
%     wt = getGlobalTemporalWidth(pulsedBeamAfterDiffractivePart);
%     tMax = 3*wt/sqrt(2);
%     tlin = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(pulsedBeamAfterDiffractivePart);
%     xMax = 3*wx/sqrt(2);
%     xlin = linspace(-xMax,xMax,200);
pulsedBeamAfterDiffractivePart.plotGaussianPulsedBeam(tlin,xlin);
% pulsedBeamAfterDiffractivePart.plotGaussianPulsedBeam();

pulsedBeamAtFocalPoint = initialPulsedBeam.propagateUsingKostenbauder((K_SSTF));
%     wt = getGlobalTemporalWidth(pulsedBeamAtFocalPoint);
%     tMax = 3*wt/sqrt(2);
%     tlinFocal = linspace(-tMax,tMax,200);
%     wx = getGlobalSpatialWidth(pulsedBeamAtFocalPoint);
%     xMax = 3*wx/sqrt(2);
%     xlinFocal = linspace(-xMax,xMax,200);
pulsedBeamAtFocalPoint.plotGaussianPulsedBeam(tlinFocal,xlinFocal);
% pulsedBeamAtFocalPoint.plotGaussianPulsedBeam();

nPoints = 400;
dl = linspace(-0.25*10^-3,0.25*10^-3,nPoints);
K_L = K_AfterLens_SSTF;

PFTwithoutInitialPFT = zeros(1,nPoints);
localPulseDuration = zeros(1,nPoints);
globalPulseDuration = zeros(1,nPoints);
localPulseWidth = zeros(1,nPoints);
globalPulseWidth = zeros(1,nPoints);

for kk = 1:1:nPoints
    K_L(1,2) = K_AfterLens_SSTF(1,2) + dl(kk);
    K_Total = K_L*K_Lens_SSTF*K_DiffractivePart_SSTF;
        
    finalPulsedBeamWithOutInitialPFT = initialPulsedBeam.propagateUsingKostenbauder((K_Total));
    
    % Pulse front tilt vs z
    PFTwithoutInitialPFT(kk) = finalPulsedBeamWithOutInitialPFT.getPulseFrontTilt;
    
    localPulseDuration(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalTemporalWidth;
    globalPulseDuration(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalTemporalWidth;
    
        
    localPulseWidth(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalSpatialWidth;
    globalPulseWidth(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalSpatialWidth;
end
figure;
axes
plot(dl,PFTwithoutInitialPFT)

figure;
axes
plot(dl,localPulseDuration,dl,globalPulseDuration)
legend('Local Pulse Duration', 'Global Pulse Duration')

figure;
axes
plot(dl,localPulseWidth,dl,globalPulseWidth)
legend('Local Pulse Width', 'Global Pulse Width')

% %% Diffractive part + Ideal Lens
% fSSTF = which('SSTFUsingIdealLens.mat');
% SSTF = OpticalSystem(fSSTF);
% [ K_DiffractivePart] = SSTF.computeKostenbauderMatrix(1,0,7,0)
% [ K_Lens] = SSTF.computeKostenbauderMatrix(7,0,8,1);
% [ K_AfterLens] = SSTF.computeKostenbauderMatrix(8,0,9,0);
% 
% % K_AdditionalPath = [1,10*5000*10^-3,0,0;0,1,0,0;0,0,1,0;0,0,0,1];
% 
% initialPulsedBeam = NewGaussianPulsedBeam;
% initialPFT = -(1/(2*pi))*2.67*10^-11;
% % initialPFT = (1/(1))*14*10^-11;
% 
% initialPulsedBeamWithInitialPFT = initialPulsedBeam.addPulseFrontTilt(initialPFT);
% 
% pulsedBeamAfterDiffractive = initialPulsedBeam.propagateUsingKostenbauder(K_DiffractivePart);
% pulsedBeamAfterDiffractive.plotGaussianPulsedBeam;%(tlin,xlin);
% 
% K_DiffractivePart_SiteApprox = eye(4);
% lateralSeparationFactor = 2*pi*7.5*10^-17;
% K_DiffractivePart_SiteApprox(1,4) = lateralSeparationFactor;
% K_DiffractivePart_SiteApprox(3,2) = -lateralSeparationFactor/centralWavelength;
% 
% pulsedBeamAfterDiffractiveSiteApprox1 = initialPulsedBeam.propagateUsingKostenbauder((K_DiffractivePart_SiteApprox));
% pulsedBeamAfterDiffractiveSiteApprox1.plotGaussianPulsedBeam(tlin,xlin);
% 
% pulsedBeamAfterDiffractiveSiteApprox2 = initialPulsedBeamWithInitialPFT.propagateUsingKostenbauder((K_DiffractivePart_SiteApprox));
% pulsedBeamAfterDiffractiveSiteApprox2.plotGaussianPulsedBeam(tlin,xlin);
% 
% 
% K_Total = K_AfterLens*K_Lens*K_DiffractivePart_SiteApprox;
% finalPulsedBeam1 = initialPulsedBeam.propagateUsingKostenbauder((K_Total));
% finalPulsedBeam1.plotGaussianPulsedBeam(linspace(-0.9*10^-12,0.9*10^-12,200),linspace(-26*10^-6,26*10^-6,200));
% 
% finalPulsedBeam2 = initialPulsedBeamWithInitialPFT.propagateUsingKostenbauder((K_Total));
% finalPulsedBeam2.plotGaussianPulsedBeam(linspace(-0.9*10^-12,0.9*10^-12,200),linspace(-26*10^-6,26*10^-6,200));
% 
% nPoints = 400;
% dl = linspace(-0.4*10^-3,0.4*10^-3,nPoints);
% K_L = K_AfterLens;
% 
% 
% PFTwithoutInitialPFT = zeros(1,nPoints);
% PFTwithInitialPFT = zeros(1,nPoints);
% localPulseDuration = zeros(1,nPoints);
% globalPulseDuration = zeros(1,nPoints);
% localPulseWidth = zeros(1,nPoints);
% globalPulseWidth = zeros(1,nPoints);
% 
% 
% for kk = 1:1:nPoints
%     K_L(1,2) = K_AfterLens(1,2) + dl(kk);
%     K_Total = K_L*K_Lens*K_DiffractivePart_SiteApprox;
%     
%     finalPulsedBeamWithOutInitialPFT = initialPulsedBeam.propagateUsingKostenbauder((K_Total));
%     finalPulsedBeamWithInitialPFT = initialPulsedBeamWithInitialPFT.propagateUsingKostenbauder((K_Total));
%     
%     % Pulse front tilt vs z
%     PFTwithoutInitialPFT(kk) = finalPulsedBeamWithOutInitialPFT.getPulseFrontTilt;
%     PFTwithInitialPFT(kk) = finalPulsedBeamWithInitialPFT.getPulseFrontTilt;
%     
%     localPulseDuration(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalTemporalWidth;
%     globalPulseDuration(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalTemporalWidth;
%     
%     localPulseWidth(kk) =  finalPulsedBeamWithOutInitialPFT.getLocalSpatialWidth;
%     globalPulseWidth(kk) = finalPulsedBeamWithOutInitialPFT.getGlobalSpatialWidth;
%     
% end
% figure;
% axes
% plot(dl,PFTwithoutInitialPFT,dl,PFTwithInitialPFT)
% hold on 
% 
% figure;
% axes
% plot(dl,localPulseDuration,dl,globalPulseDuration)
% hold on 
% 
% figure;
% axes
% plot(dl,localPulseWidth,dl,globalPulseWidth)
% hold on 