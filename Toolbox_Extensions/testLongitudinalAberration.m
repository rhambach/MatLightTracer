% Test script for plotLongitudinalAberration.m function

% Read the double gauss system
% Open saved optical system
% Get path of the single lens system used for testing
% doubleGauss28 = which('DoubleGauss28.mat');
doubleGauss28 = 'G:\MatLightTracer_May_26_2015_Working_Version\Sample_Optical_Systems\DoubleGauss28.mat';
% Construct the optical system object from the saved file
OS = OpticalSystem(doubleGauss28);

plotLongitudinalAberration(OS);