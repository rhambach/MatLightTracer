function [ complexIFFT2DofE ] = computeIFFT2D( complexE, deltaFreq )
%COMPUTEFFT2D returns the FFT2 of complex E
complexIFFT2ofE = ifftshift(ifft2(ifftshift(complexE)))*deltaFreq^2;
end

