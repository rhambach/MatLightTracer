function [ totalAmp,individualAmp,X,Y ] = computeGaussAmplitude2D( gauss2D,xlin,ylin )
    %COMPUTERECTAMPLITUDE1D Summary of this function goes here
    %   Detailed explanation goes here
    
    % repeat the center, width and amplitude in the 3rd dim number of
    % sampling point times (N = nx*ny) so that the values of all gaussians can be
    % computed in each sampling points and then be superposed.
    
    nx = length(xlin);
    ny = length(ylin);
    [X,Y] = meshgrid(xlin,ylin);
    N = nx*ny;
    nGauss = gauss2D.nGaussian;
    
    gaussAmps = repmat(gauss2D.Amplitude(:,1),[1,1,N]);
    
    gaussCentersX = repmat(gauss2D.CenterX(:,1),[1,1,N]);
    gaussCentersY = repmat(gauss2D.CenterY(:,1),[1,1,N]);
    
    gauss1eWaistRadiusX = repmat(gauss2D.WaistRadiusX(:,1),[1,1,N]);
    gauss1eWaistRadiusY = repmat(gauss2D.WaistRadiusY(:,1),[1,1,N]);

    angleInRad = repmat(gauss2D.OrientationAngle(:,1),[1,1,N]);
    
    yPoints = repmat(permute(Y(:),[3,2,1]),[nGauss,1]);
    xPoints = repmat(permute(X(:),[3,2,1]),[nGauss,1]);
    
    % Rotate and decenter the x and y points to transform to local
    % coordinates of each gaussian
    xLocal = (xPoints - gaussCentersX).*cos(angleInRad) + (yPoints - gaussCentersY).*sin(angleInRad);
    yLocal = -(xPoints - gaussCentersX).*sin(angleInRad) + (yPoints - gaussCentersY).*cos(angleInRad);
       
    individualAmp = gaussAmps.*(exp(-((xLocal.^2)./(gauss1eWaistRadiusX.^2)+(yLocal.^2)./(gauss1eWaistRadiusY.^2))));
    
    totalAmp = reshape(squeeze(sum(individualAmp,1)),[nx,ny]);
    individualAmp = reshape(squeeze(individualAmp),[nGauss,nx,ny]);
    
end

