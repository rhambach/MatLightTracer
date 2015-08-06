%% Tesst Fraunhofer diffraction
% example_fraunhofer_circ.m

 N = 64; % number of grid points per side
 L_Source = 8e-2; % total size of the grid [m]
 L_Observation = 1e-3; % total size of the grid [m] in observation plane
 d1 = L_Source / N; % source-plane grid spacing [m]
 d1_Observation = L_Observation / N; % source-plane grid spacing [m] in observation plane
 D = 4.5e-2; % 7.5e-3 diameter of the aperture [m]
 wvl = 0.5e-6; % optical wavelength [m]
 k = 2*pi / wvl;
 Dz = 20; % propagation distance [m]

 [x1 y1] = meshgrid((-N/2 : N/2-1) * d1);
 Uin = circ(x1, y1, D);
 gridSpacingXY = [d1,d1];
 gridSpacingXYObservation = [d1_Observation,d1_Observation];
 
 [Uout x2 y2] = fraunhoferDiffraction(Uin, wvl, gridSpacingXY, Dz, gridSpacingXYObservation);
 % analytic result
 Uout_th = exp(i*k/(2*Dz)*(x2.^2+y2.^2)) ...
 / (i*wvl*Dz) * D^2*pi/4 ...
 .* jinc(D*sqrt(x2.^2+y2.^2)/(wvl*Dz));

% Plot results
figure
surf(x1,y1,Uin);
figure
surf(x2,y2,abs(Uout).^2);
figure
surf(x2,y2,abs(Uout_th).^2);

