% function [optimalValue,optimalMeritFunction,optimizedObject,outputStruct] = ...
function  TestGaussianDecompOf1DSignal(signalAmplitudeVector,signalCenter,...
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
        
        % Rectangle
        myRect1D =  Rect1D(myMaxAmplitude,myCenter,myWidth,myEdgeFactor);
        signalAmplitudeVector = computeRectAmplitude1D( myRect1D,xlinTotal );
        
        %         % Upside Down Parabola
        %         signalAmplitudeVector = zeros(1,nSampling);
        %         lowerXSignal = -0.5*myWidth;
        %         upperXSignal = 0.5*myWidth;
        %         isInsideParabola = xlinTotal>=lowerXSignal & xlinTotal<=upperXSignal;
        %         upsideDownParabola = -(xlinTotal(isInsideParabola)-signalCenter).^2;
        %         upsideDownParabola_ShiftedUp = upsideDownParabola - min(upsideDownParabola);
        %         upsideDownParabola_ShiftedUp_Scaled = (myMaxAmplitude/max(upsideDownParabola_ShiftedUp))*upsideDownParabola_ShiftedUp;
        %         signalAmplitudeVector(isInsideParabola) = upsideDownParabola_ShiftedUp_Scaled;
    end
    
    optimizationAlgorithmName = 'steepestDescentOptimizer';
%     optimizationAlgorithmName = 'newtonGaussOptimizer';
    % Note: newtonGaussOptimizer This method now works correctly for amplitude
    %  only. But it gives almost the best result in the first iteration
    
    meritFunctionName = 'RootMeanSquareError';
    
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
    maxIter = 150;
    optimizationOption = struct();
    optimizationOption.TolX = tolx;
    optimizationOption.TolFun = tolfun;
    optimizationOption.OutputFcn = outputFuncHandle;
    optimizationOption.MaximumIteration = maxIter;
    
    % Define the Gausssian Beam Agregate Operand
    optimizationOperandName = 'GBAG1';
    operandTarget = signalAmplitudeVector;
    % The weight can be changed
    %     % Case 1: Unity weight
    %      operandWeight = ones(size(signalAmplitudeVector));
    
    % Case 2: Give higher weight for boundary gaussians (Parabolic)
    maxWeight = 1;
    minWeight = 0.5;
    nOp = length(signalAmplitudeVector);
    x = linspace(-nOp/2,nOp/2-1,nOp);
    a = (4*(maxWeight-minWeight))/(nOp^2);
    operandWeight = a*x.^2 + minWeight;
    
    
    
    %  Case 3: Give weight of 0 for all. atleast one element has to be different
    % from zero since the rmse involves division by weight.
    %     operandWeight = zeros(size(signalAmplitudeVector));
    %     operandWeight(1) = 1;
    
    figure; plot(operandWeight)
    
    uniqueParamStruct = struct();
    uniqueParamStruct.nPoints = nSampling;
    uniqueParamStruct.lowerX = lowerXTotal;
    uniqueParamStruct.upperX = upperXTotal;
    
    optimizationOperand = OptimizationOperand( optimizationOperandName,...
        optimizableObject,operandTarget,operandWeight,uniqueParamStruct );
    
    % Define the merit function given by its name
    
    newMeritFunction.Name = meritFunctionName;
    newMeritFunction.OptimizationOperand = optimizationOperand;
    newMeritFunction.OptimizableObject = optimizableObject;
    
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = ...
        getMeritFunctionUniqueParameters(meritFunctionName);
    newMeritFunction.UniqueParameters = defaultUniqueParamStruct;
    
    
    
    %     meritFunctionParameters = struct();
    %     meritFunctionParameters.nGauss = nGauss;
    %
    %     meritFunctionParameters.SignalCenter = signalCenter;
    %     meritFunctionParameters.SignalAmplitudeVector = signalAmplitudeVector;
    %     meritFunctionParameters.SignalWidth = signalWidth;
    %     meritFunctionParameters.SignalEdgeFactor = signalEdgeFactor;
    
    % Get the initial center and width using a constant width to spacing ratio
    waistRadiusToSpacing = 1.5;
    % Assume the rectangle edge is on the waist of the last gausslets
    initialGaussWaistRadius = (waistRadiusToSpacing*signalWidth)/(nGauss-1 + 2*waistRadiusToSpacing);
    initialGaussCenter = linspace(-signalWidth/2 + initialGaussWaistRadius,signalWidth/2 - initialGaussWaistRadius,nGauss);
    optimizableObject.WaistRadius(:,1) = initialGaussWaistRadius';
    optimizableObject.Center(:,1) = initialGaussCenter';
    [initialVariableVector,minimumVariableVector,maximumVariableVector] = getOptimizableVector( optimizableObject );
    
    % Call the nonlinear optimizer
    
    [ optimalValue,optimalMeritFunction,optimizedObject,outputStruct ] = ...
        NonLinearOptimizer( optimizationAlgorithmName,newMeritFunction,...
        optimizationOperand,optimizableObject,...
        optimizationOption,initialVariableVector,minimumVariableVector,maximumVariableVector );
    
    
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