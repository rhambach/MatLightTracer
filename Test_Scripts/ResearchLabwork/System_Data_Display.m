% Clear command window
clc;

%% Open saved optical system
% Get path of the single lens system used for testing
singleLensFullFileName = which('SingleLensTest.mat');
% Construct the optical system object from the saved file
OS = OpticalSystem(singleLensFullFileName);

%% View test system data

% View Surface Data
dispStandard = 1;
dispSurfaceAperture = 0;
dispCoating = 1;
dispAspheric = 0;
dispTiltDecenter = 0;
OS.displaySurfaceData(dispStandard,dispSurfaceAperture,dispCoating,...
    dispAspheric,dispTiltDecenter);

% View system configuration data
dispSystemAperture = 1;
dispGeneral = 0;
dispWavelength = 1;
dispField = 1;
OS.displaySystemConfiguration(dispSystemAperture,dispGeneral,...
    dispWavelength,dispField);
