clc;clear;close all;
%% 1. Get your optical system
fullFileName = 'C:\Users\li\Desktop\MatLightTracer_Toolbox\MatLightTracer_GitHub\Sample_Optical_Systems\Double Gauss 28 degree field.mat';
optSystem = OpticalSystem(fullFileName);

%% Plot the system layout
plotSystemLayout(optSystem,NaN,1);
%% To compute ray path matrix
 wavLen = 0.55;%getPrimaryWavelength(optSystem);%
 fieldPointXY = [0;0];
 PupSamplingType = 'Tangential';
 nRay1 = 50;
 nRay2 = 50;
 rayPathMatrix = computeRayPathMatrix...
        (optSystem,wavLen,fieldPointXY,PupSamplingType,nRay1,nRay2);
rayPathMatrix = rayPathMatrix(:,1:2:end,:);
