%% Result 2: Test computation of Kostenbauder Matrix using ray tracing (numerically)
% clc
clear
% Get the optical system and initial ray pulse vectors
% NB. The kostenbauder matrix method is valid only if all the differential
% values of the ray pulse vector remain very small through out the system,
% otherwise the paraxial approximation will be violated.
% NB. For freqency (2um :=> 10^12 hz) b/c (3*10^8)/(600*10^-9)-(3*10^8)/(602*10^-9) = 1.6611e+12

% fOpticalSystemName = which ('TestPrismPair.mat'); 
% fOpticalSystemName = which ('DoubleGauss28.mat');  
% fOpticalSystemName = which ('TestGratingPair.mat');  
% fOpticalSystemName = which ('SingleSurface.mat'); 

fOpticalSystemName = which ('GratingStrecherImportedFromZMX.mat');  
% fOpticalSystemName = which ('GratingCompressorImportedFromZMX.mat'); 


opticalSystem = OpticalSystem(fOpticalSystemName);
% Compute the kostenbauder matrix
KostenbauderMatrix = opticalSystem.computeKostenbauderMatrix
KostenbauderMatrixNumerical = opticalSystem.computeKostenbauderMatrixNumerically

% % Compute the final ray pulse vector using the Kostenbauder matrix.
% delta_x0 = 0; delta_y0 = 100.0*10^-6; delta_dx0 = 0; delta_dy0 = 0*10^-9*pi/180; delta_t0 = 0*10^-16; delta_f0 = 0*10^12;  
% y0 = delta_y0;
% u0 = delta_dy0;
% t0 = delta_t0;
% f0 = delta_f0;
% finalRayPulseVectorUsingKostenbauderMatrix =  (KostenbauderMatrix*[y0,u0,t0,f0]')';

% % Compute the final ray vector using real ray trace of the differntial ray
% [delta_x,delta_y, delta_dx,delta_dy,delta_t,delta_f] = opticalSystem.compute3DRayPulseVector(delta_x0,delta_y0, delta_dx0,delta_dy0,delta_t0,delta_f0);
% finalPulseVectorUsingRayTrace = [delta_y, delta_dy,delta_t,delta_f];
% 
% format longE
% format compact
% disp('Ray pulse vector [y2,u2,t2,f2] using ray trace');
% finalPulseVectorUsingRayTrace
% disp('Ray pulse vector [y2,u2,t2,f2] using Kostenbauder Matrix');
% finalRayPulseVectorUsingKostenbauderMatrix