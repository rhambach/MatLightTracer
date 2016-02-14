% Test script to test evolution of phase of a gaussian beam using the complex ray tracing method.
% Here I have tried to show the complex ray tracing method handles not only
% amplitude but also the phase evolution of gaussian beam

% Output calculation window
Nx = 3*250; Ny = 3*250;
windowSizeX = 15*10^-3; windowSizeY = 15*10^-3;

% Initial simply circularly symetric gaussian beam
centralRayPosition = [0,0,0]';
centralRayDirection =  [0,0,1]';
centralRayWavelength =  1*10^-6;
waistRadiusInX = (1/2)*1*10^-3; % 
waistRadiusInY = waistRadiusInX; %
distanceFromWaistInX = 0*10^-3;
distanceFromWaistInY = 0*10^-3;


initialGaussianBeamSet = OrthogonalGaussianBeamSet(centralRayPosition,...
    centralRayDirection,centralRayWavelength,waistRadiusInX,...
    waistRadiusInY,distanceFromWaistInX,distanceFromWaistInY);

[ rayleighRangeInX,rayleighRangeInY ] = getOrthogonalGaussianBeamRayleighRange(...
    initialGaussianBeamSet );
raleighLength = rayleighRangeInX;

propagationDistances = [0,0.5*raleighLength,raleighLength,2*raleighLength];


for kk = 1:length(propagationDistances)
    % Adjust the distance after the mirror and update the system;
    optSystem.OpticalElementArray{6}.Thickness = -propagationDistances(kk);
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