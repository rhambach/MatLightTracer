function [ complexFFTofE,deltaInFrequency ] = computeFFT( complexEin,deltaInSpatial,dimension )
    %COMPUTEFFT returns the FFT of complexE in 2d
    % Input:
    %   complexEin : A complex matrix (2D).
    %   deltaInSpatial : The sample spacing in spatial (temporal) domain 
    %   dimension : The dimension (and order of) along which the FT is done.
    %   Note: Both deltaInSpatial and dimension can be vectors of the same
    %   size indicating the subsequent FT operations on the given field. So
    %   this function can handle multidimensional FT operations as well.
    % Output:
    %   complexFFTofE : Th resulting field in the fourier space
    %   deltaInFrequency : The sample spacing in freq domain(can be vector
    %   in general case)
    
    % Source: Schmidt Numerical Simulation of Wave Optical Propagation
    
    % Input validation and default input assignment
    if nargin < 1
        disp('Error: The function computeFFT needs atleast the input field.');
        complexFFTofE = NaN;
        deltaInFrequency = NaN;
        return;
    else
        inputDimSize = size(complexEin);
    end
    
    if nargin < 2
        % Default input field size = 1 so the spacing will be
        deltaInSpatial = 1./inputDimSize;
    end
    
    if nargin < 3
        % By defualt compute the FT in all available dims
        dimension = [1:length(inputDimSize)];
    end
    
    % Do the FFT in all required dims one after another
    nDim = length(dimension);
    tempE = complexEin;
    deltaInFrequency = zeros(1,length(inputDimSize));
    for k = 1:nDim
        currentDim = dimension(k);
        % Perform the fft
%         tempE = fftshift(fft(fftshift(tempE,currentDim),[],currentDim),currentDim)*(deltaInSpatial(k));
        
        tempE=FFT(tempE,inputDimSize(1),inputDimSize(2));
        
        N = size(tempE,currentDim);
        deltaInFrequency(k) = 2*pi/ (N*deltaInSpatial(k));
    end
    complexFFTofE = tempE;
end

