function [ C ] = computeSurfaceColor( X,Y,Z,peakColor,valleyColor,nLevels,refAxisIndex )
    %COMPUTESURFACECOLOR Computes the 3D color matrix for coloring the
    %surface described by (X,Y,Z). The function first generates a color map
    %based on the two maxima colors given and maps the values of either
    %(Z) or (X) or (Y) to the colormap. The reference axis index specifies
    %which values to use for this mapping.
    if refAxisIndex == 1
        P = X;
    elseif refAxisIndex == 2
        P = Y;
    else
        P = Z;
    end
    
    colorGrad = colorGradient(peakColor,valleyColor,nLevels);
    stepSize = (max(max(P) - min(min(P))))/nLevels;
    if stepSize == 0
        stepSize = 1;
    end
    colorLevelIndex = floor((P - min(min(P)))/stepSize);
    colorLevelIndex(colorLevelIndex == 0) = 1;
    
    R = reshape(colorGrad(colorLevelIndex(:),1),size(colorLevelIndex));
    G = reshape(colorGrad(colorLevelIndex(:),2),size(colorLevelIndex));
    B = reshape(colorGrad(colorLevelIndex(:),3),size(colorLevelIndex));
    C = cat(3,R,G,B);
end

