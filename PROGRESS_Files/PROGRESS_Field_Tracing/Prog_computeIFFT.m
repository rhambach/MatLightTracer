function [ complexIFFT1DofE,spatialVector ] = computeIFFT1D( complexE,deltaFreq )
%COMPUTEFFT returns the FFT of complex E
complexIFFT1DofE = ifftshift(ifft(ifftshift(complexE))) * deltaFreq;
N = length(complexE);
spatialVector = (-N/2 : N/2-1) / (N*deltaFreq);
end

