function [ ampValues,xValues ] = plotRect2D( rect2D,xlin,ylin )
    %PLOTRECT1D Summary of this function goes here
    %   Detailed explanation goes here
        
    [ totalAmp,individualAmp,X,Y ] = computeRectAmplitude2D( rect2D,xlin,ylin );
    figure;
%     subplot(2,1,1);
%     plot(xValues,individualAmp);
%     subplot(2,1,2);
    surf(X,Y,totalAmp);
    ampValues = totalAmp;
end

