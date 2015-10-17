%% Step 1. Define your optical system. This can be done using the GUI of the toolbox. 
% Then you can also just open an already saved optical systems by giving 
% its full file name. The path shall be changed to the actual folder path
% in your PC.
doubleGaussFullFileName = 'D:\MatLightTracer_GitHub\Sample_Optical_Systems\Double Gauss 28 degree field.mat';
prismFullFileName = 'C:\Users\li\Desktop\MatLightTracer_Toolbox\MatLightTracer_GitHub\Sample_Optical_Systems\Prisms using coordinate breaks.mat';

optSystem = OpticalSystem(doubleGaussFullFileName);

%% Step 2. Compute ray path matrix
%   There is a function to compute the ray path matrix which contains all
%   the intersection points of the rays with surfaces.
 wavLenIndex = 1;
 fieldPointIndex = [1,3];
 PupSamplingType = 'Cartesian';
 nRay1 = 25;
 nRay2 = 25;
 rayPathMatrix = computeRayPathMatrix...
        (optSystem,wavLenIndex,fieldPointIndex,PupSamplingType,nRay1,nRay2);
%% Step 3 Plot the system layout with the ray path drawn on it.
plotIn2D = 0;
plotSystemLayout(optSystem,rayPathMatrix,plotIn2D);

