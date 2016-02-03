function [ totalAmp,individualAmp ] = computeRectAmplitude1D( rect1D,x )
    %COMPUTERECTAMPLITUDE1D Summary of this function goes here
    %   Detailed explanation goes here
    
    % repeat the center, width and amplitude in the 3rd dim
    
    nx = length(x);
    nRects = size(rect1D.Center,2);
    rectCenters = repmat(rect1D.Center,[1,1,nx]);
    rectWidths = repmat(rect1D.Width,[1,1,nx]);
    rectAmps = repmat(rect1D.Amplitude,[1,1,nx]);
    xPoints = permute(repmat(x,[1,1,nRects]),[1,3,2]);
    
    xIsInsideTheRect = (abs(xPoints - rectCenters) < 0.5*rectWidths);
    xIsOnTheEdgeOfTheRect = (abs(xPoints - rectCenters) == 0.5*rectWidths);
    individualAmp = zeros(size(rectAmps));
    
    individualAmp(xIsInsideTheRect) = rectAmps(xIsInsideTheRect);
    individualAmp(xIsOnTheEdgeOfTheRect) = 0.5*rectAmps(xIsOnTheEdgeOfTheRect);
    totalAmp = squeeze(sum(individualAmp,2));
    
    individualAmp = squeeze(individualAmp);
end

