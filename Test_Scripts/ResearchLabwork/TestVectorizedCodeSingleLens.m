% Clear command window
clc;
% clear;
%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('TestVectorizedCodeSingleLens.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);
% OS.SurfaceArray(1).Thickness = Inf;

%% Bundle oriented  ray trace
figure;
axesHandle = axes;
surfIndex = OS.NumberOfSurfaces;
wavLen = OS.WavelengthMatrix(OS.PrimaryWavelengthIndex);
fieldPoint1 = [0;0]; % start from an axis point
fieldPoint2 = [0;2];
fieldPoint3 = [0;-2];
fieldPoint4 = [2;0];
fieldPoint5 = [-2;0];

fieldPoint = [fieldPoint1,fieldPoint2,fieldPoint3];%,fieldPoint4,fieldPoint5];
sampleGridSize = 15;
% spotSymbal = '*';

numberOfRays = sampleGridSize^2;
PupSamplingType = 1; % rectangular
% 
% wavInd=size(wavLen,2);fldInd=size(fieldPoint,2);
% rayPathMatrix = computeRayPathMatrix...
%         (OS,wavInd,fldInd,PupSamplingType,numberOfRays)

tic
OS.plotSpotDiagram(axesHandle,surfIndex,wavLen,...
        fieldPoint,numberOfRays,PupSamplingType)
toc    