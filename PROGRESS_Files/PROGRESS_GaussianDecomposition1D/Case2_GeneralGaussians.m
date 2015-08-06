function [optimalValue,optimalMeritFunction,optimizedObject,outputStruct] = ...
        Case2_GeneralGaussians(signalAmplitudeVector,signalCenter,signalWidth,signalEdgeFactor,nGauss )
    if nargin == 0
        % Make a rectangular signal
        myMaxAmplitude = [1];
        myCenter = [0];
        myWidth = [10];
        myEdgeFactor = 0.2;
        
        % Fixed parameters
        nGauss = 10; % shall be odd
        
        nSampling = 500;
        nx = nSampling;
        lowerXTotal = myCenter - (myEdgeFactor + 0.5)*myWidth;
        upperXTotal = myCenter + (myEdgeFactor + 0.5)*myWidth;
        xlinTotal = linspace(lowerXTotal,upperXTotal,nx);
        
       
        
        signalCenter = myCenter;
        signalWidth = myWidth;
        signalEdgeFactor = myEdgeFactor;
        
%         % Rectangle
         myRect1D =  Rect1D(myMaxAmplitude,myCenter,myWidth,myEdgeFactor);
         signalAmplitudeVector = computeRectAmplitude1D( myRect1D,xlinTotal );
%        % Parabola
%         signalAmplitudeVector = -myMaxAmplitude*(xlinTotal-signalCenter).^2;
        % Plot input
        figure; plot(xlinTotal,signalAmplitudeVector);
    end
    
    optimizationAlgorithmName = 'steepestDescentOptimizer';
    meritFunctionName = 'GaussianDecomposition1DRMSE';
    targetValue = 0;
    weight = 1;
    
    gaussAmplitude = [1,0,-Inf,Inf];
    gaussCenter = [0,0,-Inf,Inf];
    gaussWaistRadius = [1,0,-Inf,Inf];
    
    gauss1DArray = Gauss1D( gaussAmplitude,gaussCenter,gaussWaistRadius,nGauss );
    
    % Make the center, width and amplitude optimizable variables
    gauss1DArray.Amplitude(:,2) = ones(nGauss,1);
    gauss1DArray.Center(:,2) = ones(nGauss,1);
    gauss1DArray.WaistRadius(:,2) = ones(nGauss,1);
    optimizableObject = gauss1DArray;
    
    tolx = 10^-3;
    tolfun = 10^-3;
    outputFuncHandle = @(x)x; % just nothing
    maxIter = 300;
    optimizationOption = struct();
    optimizationOption.TolX = tolx;
    optimizationOption.TolFun = tolfun;
    optimizationOption.OutputFcn = outputFuncHandle;
    optimizationOption.MaximumIteration = maxIter;
    
    meritFunctionParameters = struct();
    meritFunctionParameters.nGauss = nGauss;

    meritFunctionParameters.SignalCenter = signalCenter;
    meritFunctionParameters.SignalAmplitudeVector = signalAmplitudeVector;
    meritFunctionParameters.SignalWidth = signalWidth;
    meritFunctionParameters.SignalEdgeFactor = signalEdgeFactor;
    
    % Get the initial center and width using a constant width to spacing ratio
    waistRadiusToSpacing = 1.0;
    % Assume the rectangle edge is on the waist of the last gausslets
    initialGaussWaistRadius = (waistRadiusToSpacing*signalWidth)/(nGauss-1 + 2*waistRadiusToSpacing);
    initialGaussCenter = linspace(-signalWidth/2 + initialGaussWaistRadius,signalWidth/2 - initialGaussWaistRadius,nGauss);
    optimizableObject.WaistRadius(:,1) = initialGaussWaistRadius';
    optimizableObject.Center(:,1) = initialGaussCenter';
    [initialVector,minimumVector,maximumVector] = getOptimizableVector( optimizableObject );
    
    % Call the nonlinear optimizer
    [ optimalValue,optimalMeritFunction,optimizedObject,outputStruct ] = ...
        NonLinearOptimizer( optimizationAlgorithmName,meritFunctionName,...
        targetValue,weight,optimizableObject,meritFunctionParameters,...
        optimizationOption,initialVector,minimumVector,maximumVector );
    
    % Plot results    
    nPoints = 500;
    lowerXTotal = signalCenter - (signalEdgeFactor + 0.5)*signalWidth;
    upperXTotal = signalCenter + (signalEdgeFactor + 0.5)*signalWidth;
    % before optimization
    [ ampValuesDecomposed,xValuesDecomposed ] = plotGauss1D( optimizableObject,lowerXTotal,upperXTotal,nPoints );
    % after optimization
    [ ampValuesDecomposed,xValuesDecomposed ] = plotGauss1D( optimizedObject,lowerXTotal,upperXTotal,nPoints );
end