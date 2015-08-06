function [ ampValues,xValues ] = plotRect1D( rect1D,lowerX,upperX,nPoints )
    %PLOTRECT1D Summary of this function goes here
    %   Detailed explanation goes here
    
    xValues = linspace(lowerX,upperX,nPoints);
    
    [ totalAmp,individualAmp ] = computeRectAmplitude1D( rect1D,xValues );
    figure;
    subplot(2,1,1);
    plot(xValues,individualAmp);
    subplot(2,1,2);
    plot(xValues,totalAmp);
    ampValues = totalAmp;
end

