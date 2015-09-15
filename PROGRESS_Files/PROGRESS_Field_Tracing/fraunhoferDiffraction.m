function [ scalarFieldXYOut, x2, y2 ] = fraunhoferDiffraction( scalarFieldXYIn,...
        wavLen, gridSpacingXYSource, propDist, gridSpacingXYObservation )
    %FRAUNHOFERDIFFRACTION
    % Ref: Schmidt Numerical simulation of optical wave propagation
    % r1 = (x1; y1) source-plane coordinates
    % r2 = (x2; y2) observation-plane coordinates
    % wvl wavelength
    % d1 grid spacing in source plane
    % d2 grid spacing in observation plane
    %  propDist: distance between source plane and observation plane
    
    % Note that in all inputs x is assumed to be the 1st dimension and y the 2nd
    [Nx,Ny] = size(scalarFieldXYIn);
    k = 2*pi / wavLen; % optical wavevector
    
    dimension = [1,2];
%     % Using normal FFT
%     % observation plane grid
%     [x2, y2] = meshgrid((-Nx/2 : Nx/2-1)*(wavLen * propDist/(Nx*gridSpacingXYSource(1))),...
%         (-Ny/2 : Ny/2-1)*(wavLen * propDist/(Ny*gridSpacingXYSource(2))));
%     
%     scalarFieldXYOut = exp(1i*k/(2*propDist)*(x2.^2+y2.^2)) ...
%         / (1i*wavLen*propDist) .* computeFFT(scalarFieldXYIn, gridSpacingXYSource,dimension);
    
    % Using normal CZ FFT results agree except for the amplitude
    % coefficients
    % observation plane grid
     [x2, y2] = meshgrid((-Nx/2 : Nx/2-1)*gridSpacingXYObservation(1),...
         (-Ny/2 : Ny/2-1)*gridSpacingXYObservation(2));
     zoomFactorXY =  (wavLen*propDist)./(gridSpacingXYSource.*gridSpacingXYObservation.*[Nx,Ny]);
     zoomFactorXY = [1,1];
     scalarFieldXYOut = exp(1i*k/(2*propDist)*(x2.^2+y2.^2)) ...
     / (1i*wavLen*propDist) .* computeCZFFT(scalarFieldXYIn, gridSpacingXYSource,dimension,zoomFactorXY);
end

