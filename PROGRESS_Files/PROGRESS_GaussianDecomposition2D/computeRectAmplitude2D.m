function [ totalAmp,individualAmp,X,Y ] = computeRectAmplitude2D( rect2D,xlin,ylin )
    %COMPUTERECTAMPLITUDE1D Summary of this function goes here
    %   Detailed explanation goes here
    
    % repeat the center, width and amplitude in the 3rd dim
    
    nx = length(xlin);
    ny = length(ylin);
    [X,Y] = meshgrid(xlin,ylin);
    N = nx*ny;
    nRect = rect2D.nRect;
    
    rectCentersX = repmat(rect2D.CenterX,[1,1,N]);
    rectCentersY = repmat(rect2D.CenterY,[1,1,N]);
    rectWidthsX = repmat(rect2D.WidthX,[1,1,N]);
    rectWidthsY = repmat(rect2D.WidthY,[1,1,N]);
    
    rectAmps = repmat(rect2D.Amplitude,[1,1,N]);

    yPoints = repmat(permute(Y(:),[3,2,1]),[nRect,1]);
    xPoints = repmat(permute(X(:),[3,2,1]),[nRect,1]);
    
    % Rotate and decenter the x and y points to transform to local
    % coordinates of each rectian
    angleInRad = 0;
    xLocal = (xPoints - rectCentersX).*cos(angleInRad) + (yPoints - rectCentersY).*sin(angleInRad);
    yLocal = -(xPoints - rectCentersX).*sin(angleInRad) + (yPoints - rectCentersY).*cos(angleInRad);
    
    xIsInsideTheRect = (abs(xLocal) < 0.5*rectWidthsX);
    yIsInsideTheRect = (abs(yLocal) < 0.5*rectWidthsY);

    individualAmp = zeros(size(rectAmps));
    
    individualAmp(xIsInsideTheRect & yIsInsideTheRect) = rectAmps(xIsInsideTheRect & yIsInsideTheRect);

    totalAmp = reshape(squeeze(sum(individualAmp,1)),[nx,ny]);
    individualAmp = reshape(squeeze(individualAmp),[nRect,nx,ny]);
end

