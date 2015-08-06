c = 3e+8; % speed of light 3*10^8 m/s
lambda = 5e-3; % carrier wavelength (5mm)
omega = 2*pi*c/lambda; % central angular frequency

tau = 50e-12; % pulse duration (FWHM of the pulse envelope) 20fs
phi0 = 0; % Absolute phase
phi1 = 0; % Frequency shift
%phi2 = 0.003*1e+24; % linear chirp parameter (phi2 > 0 := +ve chirp)
phi2 = 0;
%phi3 = 0.0002*1e+36; % quadratic chirp parameter
phi3 = -0.0002*1e+36;

% Define the gaussian field in temporal domain
t = -200e-12:1e-12:200e-12; % order of femtosecond (fs)
phi = 0; % for example: 1i*pi/2
envelope = exp(-(t/tau).^2).*exp(-1i*(phi0 + phi1*t + (1/2)*phi2*t.^2 + (1/6)*phi3*t.^3));
E = envelope.*exp(1i*omega*t+phi);

time = t/1e-12;
plot(time,real(E))
xlabel('time (as)')
ylabel('Electric field amplitude (E)')
title('Ultrashort pulse-Chirping (Positive) ')
hold on
plot(time,abs(envelope),'r') % envelope function
plot(time,-abs(envelope),'r')
grid on
figure()
plot(time,abs(E).^2/max(abs(E))) % intensity plot
xlabel('time (as)')
ylabel('Intensity')