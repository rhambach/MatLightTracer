function [ totalAmp,individualAmp ] = computeGaussAmplitude1D( gauss1D,x )
    %COMPUTERECTAMPLITUDE1D Summary of this function goes here
    %   Detailed explanation goes here
    
    % repeat the center, width and amplitude in the 3rd dim
    
    nx = length(x);
    nGauss = size(gauss1D.Center,1);

    gaussCenters = repmat(gauss1D.Center(:,1),[1,1,nx]);
    gauss1eWaistRadius = repmat(gauss1D.WaistRadius(:,1),[1,1,nx]);
    gaussAmps = repmat(gauss1D.Amplitude(:,1),[1,1,nx]);
    xPoints = permute(repmat(x,[1,1,nGauss]),[3,1,2]);
    
    xFromGaussCenter = (xPoints - gaussCenters);
    individualAmp = zeros(size(gaussAmps));
    
    individualAmp = gaussAmps.*(exp(-(xFromGaussCenter.^2)./(gauss1eWaistRadius.^2)));
    totalAmp = squeeze(sum(individualAmp,1));
    
    individualAmp = squeeze(individualAmp);
end

