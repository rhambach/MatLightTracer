function [ ampValues,X,Y ] = plotGauss2D( gauss2D,xlin,ylin )
    %PLOTRECT1D Summary of this function goes here
    %   Detailed explanation goes here
    
    
    [ totalAmp,individualAmp,X,Y ] = computeGaussAmplitude2D( gauss2D,xlin,ylin );
    figure;
%     subplot(2,1,1);
%     surf(X,Y,individualAmp);
%     subplot(2,1,2);
    surf(X,Y,totalAmp);
    ampValues = totalAmp;
end

