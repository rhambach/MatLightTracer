%% Step 1. Define your optical system. This can be done using the GUI of the toolbox. 
% Then you can also just open an already saved optical systems by giving 
% its full file name. 
doubleGaussFullFileName = 'D:\MatLightTracer_GitHub\Sample_Optical_Systems\Double Gauss 28 degree field.mat';
prismFullFileName = 'C:\Users\li\Desktop\MatLightTracer_Toolbox\MatLightTracer_GitHub\Sample_Optical_Systems\Prisms using coordinate breaks.mat';

optSystem = OpticalSystem(doubleGaussFullFileName);

%% Step 2. Define your initial rays. This can be done by two methods
%   2.1. By defining the all parameters of your initial rays and putting
%   them in ScalarRayBundle struct. 
%       Single ray generating functions
        pos = [0,0,0;1*10^-3,0,-1*10^-3;0,0,0];
        dir = [0,0,0;0,0,0;1,1,1];
        wav = [0.55*10^-6];
        directlyCreatedRayBundle = ScalarRayBundle( pos,dir,wav);
        

%   2.2. Using the field index, wavelength index and the number of pupil
%   points. This seems more simple method to obtain bundle of initial rays.
%   You can also use predefined functions such as getChiefRay() and 
%   getMariginalRay() to get specific initial rays.
%       Single ray generating functions
        fieldIndex = 1;
        wavelengthIndex = 1;
        chiefRay = getChiefRay(optSystem,fieldIndex,wavelengthIndex);
        mariginalRay = getMariginalRay(optSystem,fieldIndex,wavelengthIndex);

%       Ray bundle generating functions
        fieldIndices = 1;
        wavelengthIndices = 1;
        nRay1=31;
        nRay2=31;
        pupilSamplingType = 'Cartesian'; % Can also be 'Tangential','Sagital','Cross','Polar','Random'
        initialRayBundle = getInitialRayBundle(optSystem,wavelengthIndices,...
        fieldIndices, nRay1,nRay2,pupilSamplingType);


