% Rectangular signla to be decomposed
rectAmplitude = 1;
rectCenter = 0;
rectWidth = 20;
myRect1D = Rect1D( rectAmplitude,rectCenter,rectWidth );
nPoints = 500;
lowerX = -0.5*rectWidth - 5;
upperX = -lowerX;
[ ampValuesRect,xValuesRect ] = plotRect1D( myRect1D,lowerX,upperX,nPoints );

% gaussian decomposition
%% Method 1: Evenly spaced identical gaussians
% Fixed parameters
nGauss = 10; % shall be odd

% Variable parameters
commonAmplitude = 0.6;
waistRadiusToSpacing = 1;

amplitude = ones(1,nGauss)*commonAmplitude;

% Assume the rectangle edge is on the waist of the last gausslets
waistRadius = (waistRadiusToSpacing*rectWidth)/(nGauss-1 + 2*waistRadiusToSpacing);
center = linspace(-rectWidth/2 + waistRadius,rectWidth/2 - waistRadius,nGauss); %(-totalWidth/2 )+[0,cumsum(centerSpacing)];

% %%
% waistRadiusToSpacing = 1.0;
% amplitude = [1];
% xMin = -10; xMax = 10; % of the rectangle
%
% minWaistRad = 1; maxWaistRad = 1;
% % minWaistRad = 0.1; maxWaistRad = 3.0;
%
% % Constant width
% % waistRadius = [1.5];
% %center = linspace(-9,9,nGauss);
%
% % non uniform width
% waistRadiusFirstHalf = [linspace(minWaistRad,maxWaistRad,floor(nGauss/2))];
% waistRadius = [waistRadiusFirstHalf,fliplr(waistRadiusFirstHalf(1:end-1))];
% averageWaistRadius = (waistRadius(1:end-1)+waistRadius(2:end))/2; % nGauss-1
% centerSpacing = averageWaistRadius/waistRadiusToSpacing;% nGauss-1
%
% totalWidth = sum(centerSpacing);
% %  center = (-totalWidth/2 )+[0,cumsum(centerSpacing(1:end-1))];
% % center = (-totalWidth/2 )+[cumsum(centerSpacing(1:end))];
% center = (-totalWidth/2 )+[0,cumsum(centerSpacing)];

%%
[ newGauss1D ] = Gauss1D( amplitude,center,waistRadius );
[ ampValuesDecomposed,xValuesDecomposed ] = plotGauss1D( newGauss1D,lowerX,upperX,nPoints );


%% Perform fourier transform and compare the far field result
deltaInSpatial = 1; dimension = 1; zoomFactor = 10;
[ftRect,deltaInFrequency1] = computeCZFFT(ampValuesRect,deltaInSpatial,dimension,zoomFactor);
[ftDecomposed,deltaInFrequency2] = computeCZFFT(ampValuesDecomposed,deltaInSpatial,dimension,zoomFactor);
figure;
plot([-nPoints/2:nPoints/2-1]*deltaInFrequency1(1),abs(ftRect));
hold on
plot([-nPoints/2:nPoints/2-1]*deltaInFrequency1(1),abs(ftDecomposed));
hold on
ampError = abs(ftRect) - abs(ftDecomposed);
plot([-nPoints/2:nPoints/2-1]*deltaInFrequency1(1),ampError);

% compute rms error
myRMS = sqrt(sum(ampError.^2)/nPoints);
disp(['The RMS = ', num2str(myRMS)]);

%     figure;
%     subplot(2,1,1);
%     plot(abs(ftRect));
%     subplot(2,1,2);
%     plot(abs(ftDecomposed));