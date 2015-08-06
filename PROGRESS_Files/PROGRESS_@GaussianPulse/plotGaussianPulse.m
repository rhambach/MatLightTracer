function [ plotted ] = plotGaussianPulse( gaussianPulse,tlinInSI,xlinInSI,axesHandle )
%plotGaussianPulse plots the the normalized amplitude of a given
%gaussian pulsed beam in 1D i.e x-t plot

if nargin == 0
    disp('Error: The function plotGaussianPulse requires gaussian beam object.');
    plotted = NaN;
    return;
elseif nargin == 1 
    wt = getGlobalTemporalWidth(gaussianPulse);
    tMax = 3*wt/sqrt(2);
    tlinInSI = linspace(-tMax,tMax,200);
    wx = getGlobalSpatialWidth(gaussianPulse);
    xMax = 3*wx/sqrt(2);
    xlinInSI = linspace(-xMax,xMax,200);
    figure;
    axesHandle = axes;    
elseif nargin == 2 
    wx = getGlobalSpatialWidth(gaussianPulse);
    xMax = 3*wx/sqrt(2);
    xlinInSI = linspace(-xMax,xMax,200);
    figure;
    axesHandle = axes;   
elseif nargin == 3 
    figure;
    axesHandle = axes;     
else
    
end

[t,x] = meshgrid(tlinInSI,xlinInSI);

E0 = 1;
Qinv = gaussianPulse.QInverseMatrix;
centralWavelength = gaussianPulse.CentralWavelength;

% Amplitude
amplitude = E0*exp(real(-1i*(pi/(centralWavelength))*(Qinv(1,1)*x.^2 + (Qinv(1,2)-Qinv(2,1))*x.*t - Qinv(2,2)*t.^2)));
output = amplitude;
        
surf(axesHandle,t,x,output,'facecolor','interp',...
             'edgecolor','none',...
             'facelighting','phong');
view(2);
t_min = min(tlinInSI);
t_max = max(tlinInSI);
x_min = min(xlinInSI);
x_max = max(xlinInSI);
axis([t_min t_max x_min x_max])
% axis equal;
% Display the beam parameters
disp(['   ']);
disp(['Local Spatial Width   : ',num2str(getGlobalSpatialWidth(gaussianPulse),'%.4e'),' m']);
disp(['Global Spatial Width  : ',num2str(getGlobalSpatialWidth(gaussianPulse),'%.4e'),' m']);
disp(['Local Temporal Width  : ',num2str(getLocalTemporalWidth(gaussianPulse),'%.4e'),' s']);
disp(['Global Temporal Width : ',num2str(getGlobalTemporalWidth(gaussianPulse),'%.4e'),' s']);
disp(['Pulse Front Tilt      : ',num2str(getPulseFrontTilt(gaussianPulse),'%.4e'),' s/m']);

plotted = 1;
end

