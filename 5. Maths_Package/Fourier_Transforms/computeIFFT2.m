function [ complexIFFTofE,deltaInSpatial ] = computeIFFT2( complexEin,deltaInFrequency )
    %COMPUTEIFFT2 returns the IFFT of complexE 
    % Input:
    %   complexEin : Can be a column vector or a matrix (2D).
    %   deltaInSpatial : The sample spacing in spatial domain (2 x 1  vector)
    % Output:
    %   complexFFTofE : Th resulting field in the spatial domain
    %   deltaInFrequency : The sample spacing in freq domain(2 x 1  vector)
    
    % Source: Schmidt Numerical Simulation of Wave Optical Propagation
     % Input validation and default input assignment
    if nargin < 1
        disp('Error: The function computeFFT needs atleast the input field.');
        complexIFFTofE = NaN;
        deltaInSpatial = NaN;
        return;
    else
        inputDimSize = (size(complexEin))';
    end
    
    if nargin < 2
        % Default input field size = 1 so the spacing will be
        deltaInFrequency = 1./inputDimSize;
    end
    sizeInFrequency = deltaInFrequency.*inputDimSize;
    complexIFFTofE = ifftshift(ifft2(ifftshift(complexEin)))*(numel(complexEin)* prod(deltaInFrequency))*(1/(2*pi));
    deltaInSpatial =  2*pi./(sizeInFrequency);
end

