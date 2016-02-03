% Test script to test propagation of generally astigmatic gaussian beam in
% non orthogonal general optical systems.
% Here I have tried to reproduce the results reported in the Greynolds 1985
% paper by focussing  an orthogonal gaussian beam with the cylinderical mirror
% whose axis is 45 degree with respect to the input gaussian axis.
% Results: The gaussian beam becomes generally astigmatic after the mirror
% Amplitude and phase profile are not oriented in the same angle
% The amplitude and phase profile ellipse rotate as the beam propagates in free
% space.
% By changing the wavelength from 1 um to 10 um, it can be seen that the
% larger the wavelength, the broader is the amplitude ellipse at the focal
% point.

% Output calculation window
Nx = 3*250; Ny = 3*250;
windowSizeX = 15*10^-3; windowSizeY = 15*10^-3;
% The non orthogonal optical system
optSystem = OpticalSystem('D:\MatLightTracer_GitHub\Sample_Optical_Systems\RotatedCylindericalMirror.mat');

% Initial orthogonal gaussian beam
centralRayPosition = [0,0,0]';
centralRayDirection =  [0,0,1]';
centralRayWavelength =  0.7*10^-6;
waistRadiusInX = (1/sqrt(2))*2*10^-3; % 
waistRadiusInY = (1/sqrt(2))*1*10^-3; %
distanceFromWaistInX = 0*10^-3;
distanceFromWaistInY = 0*10^-3;


initialGaussianBeamSet = OrthogonalGaussianBeamSet(centralRayPosition,...
    centralRayDirection,centralRayWavelength,waistRadiusInX,...
    waistRadiusInY,distanceFromWaistInX,distanceFromWaistInY);

propagationDistanceAfterMirror = [0,50,100,150,200,250];

for kk = 1:length(propagationDistanceAfterMirror)
    % Adjust the distance after the mirror and update the system;
    optSystem.OpticalElementArray{6}.Thickness = -propagationDistanceAfterMirror(kk);
    optSystem.IsUpdatedSurfaceArray = 0; % Enable re updation of the system.
    [ updatedOpticalSystem ] = updateOpticalSystem( optSystem );
    
    % Trace the gaussian beam using complex ray tracing
    outputGeneralAstignmaticBeam = gaussianBeamTracer(updatedOpticalSystem,initialGaussianBeamSet);
    % Convert the GeneralAstignmaticBeam to harmonic field
    arrayOfHarmonicFields(kk) = ConvertGenerallyAstigmaticGaussianBeamToHarmonicField(outputGeneralAstignmaticBeam,Nx,Ny,windowSizeX,windowSizeY);
% % View the harmonic field
% harmonicFieldSetViewer(arrayOfHarmonicFields(kk));
end

outputHarmonicField = ConvertHFArrayToHFSet(arrayOfHarmonicFields);
% View the harmonic field
harmonicFieldSetViewer(outputHarmonicField);

%%
% harmonicFieldSetViewer(ConvertGenerallyAstigmaticGaussianBeamToHarmonicField(gaussianBeamTracer(OpticalSystem('D:\MatLightTracer_GitHub\Sample_Optical_Systems\RotatedCylindericalMirror.mat')),Nx,Ny,windowSizeX,windowSizeY))