% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);

%% Coating Analysis
surfIndex = 3;
testCoating = OS.SurfaceArray(surfIndex).Coating;
wavLen = OS.WavelengthMatrix(OS.PrimaryWavelengthIndex);
minAngle = 0;
maxAngle = 90;
indexBefore = OS.SurfaceArray(surfIndex-1).Glass.getRefractiveIndex(wavLen);
indexAfter = OS.SurfaceArray(surfIndex).Glass.getRefractiveIndex(wavLen);

figure;
axesHandle = axes;
testCoating.plotCoatingRefractiveIndexProfile(axesHandle);

figure;
axesHandle = axes;
testCoating.plotCoatingReflectionVsAngle(axesHandle,wavLen,...
            minAngle,maxAngle,indexBefore,indexAfter);
figure;
axesHandle = axes;
testCoating.plotCoatingTransmissionVsAngle(axesHandle,wavLen,...
            minAngle,maxAngle,indexBefore,indexAfter);
figure;
axesHandle = axes;
testCoating.plotCoatingDiattenuationVsAngle(axesHandle,wavLen,...
            minAngle,maxAngle,indexBefore,indexAfter);
figure;
axesHandle = axes;
testCoating.plotCoatingRetardanceVsAngle(axesHandle,wavLen,...
            minAngle,maxAngle,indexBefore,indexAfter);


