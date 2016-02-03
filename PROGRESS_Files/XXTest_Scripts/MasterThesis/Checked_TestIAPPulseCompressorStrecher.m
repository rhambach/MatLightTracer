%% Result 1: Graph of Optical Path length vs Wavelength 
% clc
fOpticalSystemNameStrecher = which ('GratingStrecherImportedFromZMX.mat');  
fOpticalSystemNameCompressor = which ('GratingCompressorImportedFromZMX.mat');
% fOpticalSystemName = which ('TestGratingPair.mat');

% opticalSystem = OpticalSystem(fOpticalSystemName);
% Compute the kostenbauder matrix numerically
% KostenbauderMatrix = opticalSystem.computeKostenbauderMatrix;
% KostenbauderMatrixNumerical = opticalSystem.computeKostenbauderMatrixNumerically;
% GDDComputed = KostenbauderMatrixNumerical(3,4)/(2*pi)
% GDDComputedAnalyticK = KostenbauderMatrix(3,4)/(2*pi)

opticalSystemStrecher = OpticalSystem(fOpticalSystemNameStrecher);
opticalSystemCompressor = OpticalSystem(fOpticalSystemNameCompressor);
KostenbauderMatrixStrecher = opticalSystemStrecher.computeKostenbauderMatrix;
KostenbauderMatrixNumericalStrecher = opticalSystemStrecher.computeKostenbauderMatrixNumerically;
KostenbauderMatrixCompressor = opticalSystemCompressor.computeKostenbauderMatrix;
KostenbauderMatrixNumericalCompressor = opticalSystemCompressor.computeKostenbauderMatrixNumerically;

fieldIndex = 1;
minWavelengthInM = opticalSystemStrecher.getPrimaryWavelength - 30*10^-9;
maxWavelengthInM = opticalSystemStrecher.getPrimaryWavelength + 30*10^-9;
nPoints = 100;

[ wavelengthOpticalPathLengthCompressor ] = ...
    opticalSystemCompressor.plotOpticalPathLengthVersusWavelength(fieldIndex, minWavelengthInM, maxWavelengthInM, nPoints);
[ wavelengthOpticalPathLengthStrecher ] = ...
    opticalSystemStrecher.plotOpticalPathLengthVersusWavelength(fieldIndex, minWavelengthInM, maxWavelengthInM, nPoints);

% Plot additional graphs
wl_comp = wavelengthOpticalPathLengthCompressor(:,1);
opl_comp = wavelengthOpticalPathLengthCompressor(:,2);
% GDDGraph = -((wl(51))^3/(2*pi*(3*10^8)^2))*((opl(50)-2*opl(51)+opl(52))/(wl(51)-wl(50))^2)
% GDDGraph2 = -((wl(51)^2)/(2*pi*c^2))*(opl(50)-opl(52))/(wl(50)-wl(52))
c = 299792458;
t_comp = opl_comp/c;
omega_comp = 2*pi*c./wl_comp;

GDDGraph_comp = diff(t_comp)./diff(omega_comp);

figure
plot(omega_comp,t_comp)
figure
plot(omega_comp(1:end-1),GDDGraph_comp)
GDDGraph_comp(52:54)
GDDComputed_comp = KostenbauderMatrixNumericalCompressor(3,4)/(2*pi)
 

% Strecher
wl_stre = wavelengthOpticalPathLengthStrecher(:,1);
opl_stre = wavelengthOpticalPathLengthStrecher(:,2);
c = 299792458;
t_stre = opl_stre/c;
omega_stre = 2*pi*c./wl_stre;

GDDGraph_stre = diff(t_stre)./diff(omega_stre);

figure
plot(omega_stre,t_stre)
figure
plot(omega_stre(1:end-1),GDDGraph_stre)
GDDGraph_stre(52:54)
GDDComputed_stre = KostenbauderMatrixNumericalStrecher(3,4)/(2*pi)
