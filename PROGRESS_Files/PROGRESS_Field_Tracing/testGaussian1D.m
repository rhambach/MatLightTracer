%% example_ft_gaussian.m

% function values to be used in DFT
L = 6; % spatial extent of the grid
N = 32*8; % number of samples
delta = L / N; % sample spacing
xPoints = (-N/2 : N/2-1) * delta;
% fPoints = (-N/2 : N/2-1) / (N*delta);
a = 1/6;
% sampled function & its DFT
xPoints = xPoints - 0.5;
g_samp = exp(-pi*a*xPoints.^2); % function samples

% [g_dft,deltaFreq] = computeFFT( g_samp,delta,2);%ft(g_samp, delta); % DFT
[g_dft,deltaFreq] = computeCZFFT( g_samp,delta,2,2);

fPoints = (-N/2 : N/2-1) * deltaFreq(1);
% analytic function & its continuous FT
M = 1024;
x_cont = linspace(xPoints(1), xPoints(end), M);
f_cont = linspace(fPoints(1), fPoints(end), M);
g_cont = exp(-pi*a*x_cont.^2);
g_ft_cont = exp(-pi*f_cont.^2/a)/a;


figure;
ax1 = subplot(1,3,1);
plot(xPoints,g_samp);

ax2 = subplot(1,3,2);
plot(fPoints,abs(g_dft));

ax3 = subplot(1,3,3);
plot(fPoints,angle(g_dft));

axis([ax1],[-3.5 3.5 -4 4 ])
axis([ax2,ax3],[-0.5 0.5 -4 4 ])

