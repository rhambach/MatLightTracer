function [ y_lin,t_lin,xyt_complexField ] = plotYversusTime( generalPulsedBeam, timeWindow, nTimeSampling )
%PLOTYVERSUSTIME Plots graph of y vs time

% spatialDistribution = generalPulsedBeam.SpatialDistribution; % (X Y spatialAmplitude spatialPhase)'
% spectralDistribution = generalPulsedBeam.SpectralDistribution; % (wav spectralAmplitude spectralPhase)'
% 
% c = 299792458;
% wavLenVector = spectralDistribution(1,:);
% freqVector = c./wavLenVector;
% spectralAmplitude = spectralDistribution(2,:);
% spectralPhase = spectralDistribution(3,:);
% 
% spatialPositionX = spatialDistribution(:,:,);
% spatialAmplitude = spatialDistribution(3,:);
% spatialPhase = spatialDistribution(4,:);
% 
% nTimeSampling = 100;
% nSpectralSample = size(spectralDistribution,2);

c = 299792458;
% wavLenVector = [generalPulsedBeam.PlaneWaveArray.Wavelength];
% freqVector = c./wavLenVector;

% spectralAmplitude = spectralDistribution(2,:);
% spectralPhase = spectralDistribution(3,:);
% 
% spatialPositionX = spatialDistribution(:,:,);
% spatialAmplitude = spatialDistribution(3,:);
% spatialPhase = spatialDistribution(4,:);
% 
% % nTimeSampling = 100;
nSpectralSample = size(generalPulsedBeam.PlaneWaveArray,2);

% % take spatial coordinates where x is 0 (along y axis)
% pointsAlongYaxis = (spatialPosition(1,:)==0);
% 
% spatialPositionAlongY = spatialPosition(:,pointsAlongYaxis);
% spatialAmplitudeAlongY = spatialAmplitude(:,pointsAlongYaxis);
% spatialPhaseAlongY = spatialPhase(:,pointsAlongYaxis);
% 
% y_lin = spatialPositionAlongY(2,:);
nXSamples = size(generalPulsedBeam.PlaneWaveArray(1).computeEx,1);
nYSamples = size(generalPulsedBeam.PlaneWaveArray(1).computeEx,2);

t_lin = linspace(-timeWindow/2,timeWindow/2,nTimeSampling);
dy = generalPulsedBeam.PlaneWaveArray(1).SamplingDistance(2);
y_lin = [-floor(nYSamples/2):floor(nYSamples/2)]*dy;

% compute the complex field at each y-t point
% nYSampling = length(y_lin);
 

xyt_complexField = zeros(nXSamples,nYSamples,nTimeSampling);
for tt = 1:nTimeSampling 
    xy_complexField = 0;
        for ww = 1: nSpectralSample
            freq = c./generalPulsedBeam.PlaneWaveArray(ww).Wavelength;
            xy_complexField = xy_complexField + ...
                generalPulsedBeam.PlaneWaveArray(ww).computeEx * ...
                exp(1i*(2*pi*freq*t_lin(tt)));
        end
        xyt_complexField(:,:,tt) = xy_complexField;
end

% plot the intensity in y-t graph

yt_intensity = squeeze(abs(xyt_complexField(floor(nXSamples/2),:,:)).^2);
figure;
axesHandle = axes;
surf(axesHandle,t_lin,y_lin,yt_intensity,'facecolor','interp',...
             'edgecolor','none',...
             'facelighting','phong');


end

