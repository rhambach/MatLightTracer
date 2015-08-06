function [ PFT ] = getPulseFrontTilt( gaussianPulse )
%getPulseFrontTilt Returns the pulse front tilt parameter for a given
%gaussian pulsed beam.

Qinv = gaussianPulse.QInverseMatrix;
% Pulse front tilt vs z
PFT = imag(Qinv(1,2))/imag(Qinv(2,2));
end

