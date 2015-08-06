function [finalOptimumValues, finalRMS, exitflag, output] = ...
        TestEvenlySpacedGaussianDecomposition(rectAmplitude,rectCenter,rectWidth,nGauss )
    if nargin == 0
        rectAmplitude = 1;
        rectCenter = 0;
        rectWidth = 20;
        
        % Fixed parameters
        nGauss = 10; % shall be odd
    end
    
    % Rectangular signla to be decomposed
    myRect1D = Rect1D( rectAmplitude,rectCenter,rectWidth );
    nPoints = 100;
    
    % Variable parameters
    commonAmplitude = 0.6;
    waistRadiusToSpacing = 1;
  
%     % Plot the dependance surf plot
%     commonAmplitude = [0:0.01:2];
%     waistRadiusToSpacing = [0:0.01:2];
%     
%     for kk1 = 1:length(commonAmplitude)
%         for kk2 = 1:length(waistRadiusToSpacing)
%             optimizableVariable = [commonAmplitude(kk1),waistRadiusToSpacing(kk2)];
%             errorRMS(kk2,kk1) = rmsOfTheFitError(optimizableVariable,myRect1D,nGauss,nPoints);
%         end
%     end
%     figure;
%     [xx,yy] = meshgrid(commonAmplitude,waistRadiusToSpacing);
%     surf(xx,yy,errorRMS);
    
    optimizableVariable = [commonAmplitude,waistRadiusToSpacing];
    
%      [finalOptimumValues, finalRMS,exitflag,output] = ...
%          fminsearch(@(x) rmsOfTheFitError(optimizableVariable,myRect1D,nGauss,nPoints),[1,1]);
     [finalOptimumValues, finalRMS,exitflag,output] = ...
         fminunc(@(x) rmsOfTheFitError(optimizableVariable,myRect1D,nGauss,nPoints),[0.6,0.5]);    
end

function myRMS = rmsOfTheFitError(optimizableVariable,myRect1D,nGauss,nPoints)
    commonAmplitude = optimizableVariable(1);
    waistRadiusToSpacing = optimizableVariable(2);
    rectWidth = myRect1D.Width;
    % Rectangle values
    xValues = linspace(-0.5,0.5,nPoints)*rectWidth;
    [ totalAmpRect,individualAmpRect ] = computeRectAmplitude1D( myRect1D,xValues );
    
    % Gaussina decomposition fit
    amplitude = ones(1,nGauss)*commonAmplitude;
    
    % Assume the rectangle edge is on the waist of the last gausslets
    waistRadius = (waistRadiusToSpacing*rectWidth)/(nGauss-1 + 2*waistRadiusToSpacing);
    center = linspace(-rectWidth/2 + waistRadius,rectWidth/2 - waistRadius,nGauss); %(-totalWidth/2 )+[0,cumsum(centerSpacing)];
    
    
    [ newGauss1D ] = Gauss1D( amplitude,center,waistRadius );
    [ totalAmpGauss,individualAmpGauss ] = computeGaussAmplitude1D( newGauss1D,xValues );
    
    % compute rms error
    ampError = totalAmpRect-totalAmpGauss;
%     myRMS = sqrt(sum(ampError.^2));
     myRMS = sqrt(sum(ampError.^2)/nPoints);
%     disp(['The RMS = ', num2str(myRMS)]);
end

function myRms = rmsOfTheFarFieldIntensityError(optimizableVariable,myRect1D,nGauss)
    
end