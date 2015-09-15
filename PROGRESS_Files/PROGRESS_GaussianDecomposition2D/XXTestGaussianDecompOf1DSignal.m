function [optimalValue,optimalMeritFunction,optimizedObject,outputStruct] = ...
        TestGaussianDecompOf1DSignal(signalAmplitudeVector,signalCenter,...
        signalWidth,signalEdgeFactor,nGauss )
    if nargin == 0
        % Make a rectangular signal
        myMaxAmplitude = [1];
        myCenter = [0];
        myWidth = [20];
        myEdgeFactor = 0.2;
        
        % Fixed parameters
        nGauss = 10; % shall be odd
        nSampling = 200;
        lowerXTotal = myCenter - (myEdgeFactor + 0.5)*myWidth;
        upperXTotal = myCenter + (myEdgeFactor + 0.5)*myWidth;
        xlinTotal = linspace(lowerXTotal,upperXTotal,nSampling);

        signalCenter = myCenter;
        signalWidth = myWidth;
        signalEdgeFactor = myEdgeFactor;
        
%          % Rectangle
%          myRect1D =  Rect1D(myMaxAmplitude,myCenter,myWidth,myEdgeFactor);
%          signalAmplitudeVector = computeRectAmplitude1D( myRect1D,xlinTotal );

        % Upside Down Parabola
        signalAmplitudeVector = zeros(1,nSampling);
        lowerXSignal = -0.5*myWidth;
        upperXSignal = 0.5*myWidth;
        isInsideParabola = xlinTotal>=lowerXSignal & xlinTotal<=upperXSignal;
        upsideDownParabola = -(xlinTotal(isInsideParabola)-signalCenter).^2;
        upsideDownParabola_ShiftedUp = upsideDownParabola - min(upsideDownParabola);
        upsideDownParabola_ShiftedUp_Scaled = (myMaxAmplitude/max(upsideDownParabola_ShiftedUp))*upsideDownParabola_ShiftedUp;
        signalAmplitudeVector(isInsideParabola) = upsideDownParabola_ShiftedUp_Scaled;
    end
    
    optimizationAlgorithmName = 'steepestDescentOptimizer';
    meritFunctionName = 'GaussianDecomposition1DRMSE';
%     meritFunctionName = 'GaussianDecompositionFFT1DRMSE';
%     meritFunctionName = 'RootMeanSquareError';
    targetValue = 0;
    weight = 1;
    
    % [value,status,minVal,maxVal]
    gaussAmplitude = [1,0,-Inf,Inf];
    gaussCenter = [0,0,-Inf,Inf];
    gaussWaistRadius = [1,0,-Inf,Inf];
    
    gauss1DArray = Gauss1D( gaussAmplitude,gaussCenter,gaussWaistRadius,nGauss );
    
    % Make the center, width and amplitude optimizable variables
    varAmp = 1;
    varCent = 1;
    varWaist = 1;
    
    if varAmp
        gauss1DArray.Amplitude(:,2) = ones(nGauss,1);
    else
        gauss1DArray.Amplitude(:,2) = zeros(nGauss,1);
    end
    if varCent
        gauss1DArray.Center(:,2) = ones(nGauss,1);
    else
        gauss1DArray.Center(:,2) = zeros(nGauss,1);
    end
    if varWaist
        gauss1DArray.WaistRadius(:,2) = ones(nGauss,1);
    else
        gauss1DArray.WaistRadius(:,2) = zeros(nGauss,1);
    end

    optimizableObject = gauss1DArray;
    
    tolx = 10^-3;
    tolfun = 10^-3;
    outputFuncHandle = @(x)x; % just nothing
    maxIter = 50;
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
    waistRadiusToSpacing = 1.5;
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
    lowerXTotal = signalCenter - (signalEdgeFactor + 0.5)*signalWidth;
    upperXTotal = signalCenter + (signalEdgeFactor + 0.5)*signalWidth;
    % before optimization
    xValues = linspace(lowerXTotal,upperXTotal,nSampling);
    [ totalAmp,individualAmp ] = computeGaussAmplitude1D( optimizableObject,xValues );
    figure;
    subplot(2,1,1);
    plot(xValues,individualAmp);
    subplot(2,1,2);
    plot(xValues,totalAmp);
    hold on;
    % Plot input
    plot(xValues,signalAmplitudeVector);
           
    % after optimization
    [ totalAmp2,individualAmp2 ] = computeGaussAmplitude1D( optimizedObject,xValues );
    figure;
    subplot(2,1,1);
    plot(xValues,individualAmp2);
    subplot(2,1,2);
    plot(xValues,totalAmp2);
    hold on;
    % Plot input
    plot(xValues,signalAmplitudeVector);
end