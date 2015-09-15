% function [optimalValue,optimalMeritFunction,optimizedObject,outputStruct] = ...
function  TestGaussianDecompOf2DSignal(signalAmplitudeVector,signalCenterX,signalCenterY,...
        signalWidthX,signalWidthY,nGauss )
    if nargin == 0
        % Make a rectangular signal
        myMaxAmplitude = [1];
        myCenterX = [0];
        myCenterY = [0];
        
        myWidthX = [5];
        myWidthY = [5];
        
        myEdgeFactor = 0.3;
        
        % Fixed parameters
        nGauss = 400; % shall be odd
        
        nGaussX = floor(sqrt(nGauss));
        nGaussY = floor(nGauss/nGaussX);
        nGauss = nGaussY*nGaussX;
        
        nSamplingX = 50; % in  x directions
        nSamplingY = 50; % in y directions
        
        lowerXTotal = myCenterX - (myEdgeFactor + 0.5)*myWidthX;
        upperXTotal = myCenterX + (myEdgeFactor + 0.5)*myWidthX;
        
        lowerYTotal = myCenterY - (myEdgeFactor + 0.5)*myWidthY;
        upperYTotal = myCenterY + (myEdgeFactor + 0.5)*myWidthY;
        
        xlinTotal = linspace(lowerXTotal,upperXTotal,nSamplingX);
        ylinTotal = linspace(lowerYTotal,upperYTotal,nSamplingY);
        
        signalCenterX = myCenterX;
        signalCenterY = myCenterY;
        
        signalWidthX = myWidthX;
        signalWidthY = myWidthY;
        
        %         signalEdgeFactor = myEdgeFactor;
        
%         % Rectangle
%         myRect2D =  Rect2D(myMaxAmplitude,myCenterX,myCenterY,myWidthX,myWidthY);
%         [signalAmplitudeVector,~,X,Y] = computeRectAmplitude2D( myRect2D,xlinTotal,ylinTotal );

                % Circular aperture
                radius = 0.5*max([myWidthX,myWidthY]);
                signalAmplitudeVector = zeros(nSamplingX,nSamplingY);
                [X,Y] = meshgrid(xlinTotal,ylinTotal);
                isInsideCircle = (X.^2 + Y.^2) <= radius;
                signalAmplitudeVector(isInsideCircle) = 1;

        
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
    
%        optimizationAlgorithmName = 'steepestDescentOptimizer';
        optimizationAlgorithmName = 'newtonGaussOptimizer';
    % Note: newtonGaussOptimizer This method now works correctly for amplitude
    %  only. But it gives almost the best result in the first iteration
    
    meritFunctionName = 'RootMeanSquareError';
    
    % [value,status,minVal,maxVal]
    gaussAmplitude = [1,0,-Inf,Inf];
    gaussCenterX = [0,0,-Inf,Inf];
    gaussCenterY = [0,0,-Inf,Inf];
    gaussWaistRadiusX = [0.5,0,-Inf,Inf];
    gaussWaistRadiusY = [0.5,0,-Inf,Inf];
    orientationAngle = [0,0,-Inf,Inf];
    
    gauss2DArray = Gauss2D( gaussAmplitude,gaussCenterX,gaussCenterY,gaussWaistRadiusX,gaussWaistRadiusY,orientationAngle,nGauss );
    
    % Make the center, width and amplitude optimizable variables
    varAmp = 1;
    varCent = 0;
    varWaist = 0;
    varOrient = 0;
    
    if varAmp
        gauss2DArray.Amplitude(:,2) = ones(nGauss,1);
    else
        gauss2DArray.Amplitude(:,2) = zeros(nGauss,1);
    end
    if varCent
        gauss2DArray.CenterX(:,2) = ones(nGauss,1);
        gauss2DArray.CenterY(:,2) = ones(nGauss,1);
    else
        gauss2DArray.CenterX(:,2) = zeros(nGauss,1);
        gauss2DArray.CenterY(:,2) = zeros(nGauss,1);
    end
    if varWaist
        gauss2DArray.WaistRadiusX(:,2) = ones(nGauss,1);
        gauss2DArray.WaistRadiusY(:,2) = ones(nGauss,1);
    else
        gauss2DArray.WaistRadiusX(:,2) = zeros(nGauss,1);
        gauss2DArray.WaistRadiusY(:,2) = zeros(nGauss,1);
    end
    if varOrient
        gauss2DArray.OrientationAngle(:,2) = ones(nGauss,1);
    else
        gauss2DArray.OrientationAngle(:,2) = zeros(nGauss,1);
    end
    optimizableObject = gauss2DArray;
    
    tolx = 10^-3;
    tolfun = 10^-3;
    outputFuncHandle = @(x)x; % just nothing
    maxIter = 1;
    optimizationOption = struct();
    optimizationOption.TolX = tolx;
    optimizationOption.TolFun = tolfun;
    optimizationOption.OutputFcn = outputFuncHandle;
    optimizationOption.MaximumIteration = maxIter;
    
    % Define the Gausssian Beam Agregate Operand
    optimizationOperandName = 'GBAG2';
    operandTarget = signalAmplitudeVector;
    % The weight can be changed
    % Case 1: Unity weight
    operandWeight = ones(size(signalAmplitudeVector));
    
    %     % Case 2: Give higher weight for boundary gaussians (Parabolic)
    %     maxWeight = 1;
    %     minWeight = 0.5;
    %     nOp = length(signalAmplitudeVector);
    %     x = linspace(-nOp/2,nOp/2-1,nOp);
    %     a = (4*(maxWeight-minWeight))/(nOp^2);
    %     operandWeight = a*x.^2 + minWeight;
    %
    
    
    %  Case 3: Give weight of 0 for all. atleast one element has to be different
    % from zero since the rmse involves division by weight.
    %     operandWeight = zeros(size(signalAmplitudeVector));
    %     operandWeight(1) = 1;
    
    figure; plot(operandWeight)
    
    uniqueParamStruct = struct();
    uniqueParamStruct.nPointsX = nSamplingX;
    uniqueParamStruct.lowerX = lowerXTotal;
    uniqueParamStruct.upperX = upperXTotal;
    
    uniqueParamStruct.nPointsY = nSamplingX;
    uniqueParamStruct.lowerY = lowerYTotal;
    uniqueParamStruct.upperY = upperYTotal;
    
    optimizationOperand = OptimizationOperand( optimizationOperandName,...
        optimizableObject,operandTarget,operandWeight,uniqueParamStruct );
    
    % Define the merit function given by its name
    
    newMeritFunction.Name = meritFunctionName;
    newMeritFunction.OptimizationOperand = optimizationOperand;
    newMeritFunction.OptimizableObject = optimizableObject;
    
    [fieldNames,fieldFormat,defaultUniqueParamStruct] = ...
        getMeritFunctionUniqueParameters(meritFunctionName);
    newMeritFunction.UniqueParameters = defaultUniqueParamStruct;
   
    
    % Get the initial center and width using a constant width to spacing ratio
    waistRadiusToSpacing = 1.5;
    % Assume the rectangle edge is on the waist of the last gausslets
    initialGaussWaistRadiusX = (waistRadiusToSpacing*signalWidthX)/(nGaussX-1 + 2*waistRadiusToSpacing);
    initialGaussCenterX = linspace(-signalWidthX/2 + initialGaussWaistRadiusX,signalWidthX/2 - initialGaussWaistRadiusX,nGaussX);
    
    initialGaussWaistRadiusY = (waistRadiusToSpacing*signalWidthY)/(nGaussY-1 + 2*waistRadiusToSpacing);
    initialGaussCenterY = linspace(-signalWidthY/2 + initialGaussWaistRadiusY,signalWidthX/2 - initialGaussWaistRadiusY,nGaussY);
    
    [X_Center,Y_Center] = meshgrid(initialGaussCenterX,initialGaussCenterY);
    
    optimizableObject.WaistRadiusX(:,1) = initialGaussWaistRadiusX';
    optimizableObject.CenterX(:,1) = X_Center(:);
    optimizableObject.WaistRadiusY(:,1) = initialGaussWaistRadiusY';
    optimizableObject.CenterY(:,1) = Y_Center(:);
    
    [initialVariableVector,minimumVariableVector,maximumVariableVector] = getOptimizableVector( optimizableObject );
    
    % Call the nonlinear optimizer
    
    [ optimalValue,optimalMeritFunction,optimizedObject,outputStruct ] = ...
        NonLinearOptimizer( optimizationAlgorithmName,newMeritFunction,...
        optimizationOperand,optimizableObject,...
        optimizationOption,initialVariableVector,minimumVariableVector,maximumVariableVector );
    
    
    % Plot results
    % before optimization
    plotGauss2D(optimizableObject,xlinTotal,ylinTotal);
    % after optimization
    plotGauss2D(optimizedObject,xlinTotal,ylinTotal);
    
    %     lowerXTotal = signalCenter - (signalEdgeFactor + 0.5)*signalWidth;
    %     upperXTotal = signalCenter + (signalEdgeFactor + 0.5)*signalWidth;
    %     % before optimization
    %     xValues = linspace(lowerXTotal,upperXTotal,nSampling);
    %     [ totalAmp,individualAmp ] = computeGaussAmplitude1D( optimizableObject,xValues );
    %     figure;
    %     subplot(2,1,1);
    %     plot(xValues,individualAmp);
    %     subplot(2,1,2);
    %     plot(xValues,totalAmp);
    %     hold on;
    %     % Plot input
    %     plot(xValues,signalAmplitudeVector);
    %
    %     % after optimization
    %     [ totalAmp2,individualAmp2 ] = computeGaussAmplitude1D( optimizedObject,xValues );
    %     figure;
    %     subplot(2,1,1);
    %     plot(xValues,individualAmp2);
    %     subplot(2,1,2);
    %     plot(xValues,totalAmp2);
    %     hold on;
    %     % Plot input
    %     plot(xValues,signalAmplitudeVector);
end