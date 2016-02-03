function [ complexFFTofE,deltaInFrequency ] = computeCZFFT( complexEin,...
        deltaInSpatial,dimension,zoomFactor )
    %computeCZFFT returns the FFT of complex E using the CZT algorithm.
    %The output is the frequency components on the freq vector scaled
    %factor of scale given. This allows arbitrary freq. sampling.
    % Input:
    %   complexEin : Can be a column vector or a matrix (2D) or multidimensional.
    %   deltaInSpatial : The sample spacing in spatial (temporal) domain i
    %   dimension : The dimension (and order of) along which the FT is done.
    %   zoomFactor: A number indicating the scale by which the
    %               sample spacing in the frequency domain is reduced.
    %               Compared to the regular FFT,
    %               zoomFactor > 1 : Freq. sampling distance is reduced (Maginified Result)
    %               zoomFactor = 1 : Freq. sampling distance is unchanged
    %               zoomFactor < 1 : Freq. sampling distance is increased (Shrinked Result)
    %   Note: All deltaInSpatial, dimension and zoomFactor can be vectors of
    %   the same size indicating the subsequent FT operations on the given field. So
    %   this function can handle multidimensional FT operations as well.
    % Output:
    %   complexFFTofE : Th resulting field in the fourier space
    %   deltaInFrequency : The sample spacing in freq domain (can be vector
    %   in general case)
    
    % Source: Rabiner, Schafer, Rader, The Chirp z-Transform Algorithm, IEEE Trans AU 17(1969) p. 86
    
    % Input validation and default input assignment
    if nargin < 1
        disp('Error: The function computeCZFFT needs atleast the input field.');
        complexFFTofE = NaN;
        deltaInFrequency = NaN;
        return;
    else
        inputSize = size(complexEin);
    end
    
    if nargin < 2
        % Default input field size = 1 so the spacing will be
        deltaInSpatial = 1./inputSize;
    end
    
    if nargin < 3
        % By defualt compute the FT in all available dims
        dimension = [1:length(inputSize)];
    end
    
    if nargin < 4
        % By defualt scale = 1
        zoomFactor = ones(1,length(inputSize));
    end
    
    % Do the FFT in all required dims one after another
    nDim = length(dimension);
    tempE = complexEin;
    deltaInFrequency = zeros(1,length(inputSize));
    dimOrder = [1:length(inputSize)];
    for pp = 1:nDim
        currentDim = dimension(pp);
        currentScale = zoomFactor(pp);
        
        
        % Alternative function
         tempE=SFFT(tempE,currentScale,currentScale);
    
%         % Perform the fft using czt (convolution)
%         np = inputSize( currentDim );
%         N = np;
%         M = np; % No change in number of sampling points just scale the output window
%         L = N + M - 1;
%         n = [0:N-1];
%         k = [0:M-1];
%         n1_y = L-(N-1):L-1;
%         
%         % A = A0*exp(1i*2*pi*thetha_0);
%         % W = W0*exp(1i*2*pi*phi_0);
%         % For points on a unit circle A0 = 1; W0 = 1;
%         A0 = 1;
%         W0 = 1;
%         % Frequency spacing is determined by del_omega = 2*pi*phi_0
%         phi_0 = (1/(N*currentScale));
%         del_omega = 2*pi*phi_0;
%         
%         % So total bandwidth will be (M-1)*del_omega
%         % The initial frequency will be omega_0 = 2*pi*thetha_0
%         
%         % To get symetric result : frequency sampling centered to zero
%         omega_0 = (M*del_omega)/2;
%         
%         A = A0*exp(1i*omega_0);
%         W = W0*exp(1i*del_omega);
% 
%         % Step 2
%         dimRepeatVector = inputSize;
%         dimRepeatVector(currentDim) = 1;
%         coeff1 = [((A).^(-n)).*((W).^((n.^2)/2))];
%         reshapeVector1 = inputSize*0 + 1;
%         reshapeVector1(currentDim) = length(coeff1);
%         coeff1 = repmat(reshape(coeff1,reshapeVector1),dimRepeatVector);
%         yn = coeff1.*tempE;
%         
%         % Zero pad
%         padSizeArray = inputSize*0;
%         padSizeArray(currentDim) = L-N;
%         yn = padarray(yn,padSizeArray,0,'post');
%         
%         % Step 3
%         ft_yn = fft(yn,L,currentDim);
%         % Step 4
%         coeff2 = [((W).^-((k.^2)/2)),((W).^-(((fliplr(n)).^2)/2))];
%         reshapeVector2 = inputSize*0 + 1;
%         reshapeVector2(currentDim) = length(coeff2);
%         coeff2 = repmat(reshape(coeff2,reshapeVector2),dimRepeatVector);
%         vn = coeff2;
%         % Step 5
%         ft_vn = fft(vn,L,currentDim);
%         % Step 6
%         ft_Gn = ft_yn.*ft_vn;
%         
%         % Step 7
%         gk = ifft(ft_Gn,L,currentDim);
%         % Step 8
%         coeff3 = [((W).^-((k.^2)/2))];
%         reshapeVector3 = inputSize*0 + 1;
%         reshapeVector3(currentDim) = length(coeff3);
%         coeff3 = repmat(reshape(coeff3,reshapeVector3),dimRepeatVector);
%         
%         % Currently i could not generalize the following code to arbitrary
%         % dimensional matrices so it is limited to max of 2D matrix
%         if currentDim == 1
%             Xk = coeff3.*gk(1:M,:);
%         elseif currentDim == 2
%             Xk = coeff3.*gk(:,1:M);
%         else
%             disp('Error: Currently the function computeCZFFT supports only 2D matrices.');
%             complexFFTofE = NaN;
%             deltaInFrequency = NaN;
%             return;
%         end
%         tempE = Xk;
        
        N = size(tempE,currentDim);
        deltaInFrequency(pp) = 2*pi/ (N*deltaInSpatial(pp));
    end
    complexFFTofE = tempE;

end

