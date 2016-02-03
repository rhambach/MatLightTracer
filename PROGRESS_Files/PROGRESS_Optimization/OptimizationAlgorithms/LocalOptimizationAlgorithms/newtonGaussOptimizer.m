function [ optimalVector,optimalMeritFunctionValue,outputStruct ] = ...
        newtonGaussOptimizer( meritFunction,optimizationOption )
    %newtonGaussOptimizer Summary of this function goes here
    %   Detailed explanation goes here
    % Can be aplied for only root mean square minimization problems
    
    if ~strcmpi(meritFunction.Name,'RootMeanSquareError')
        disp('Error: newtonGaussOptimizer can only be used with RootMeanSquareError merit function.');
        optimalVector = NaN;
        optimalMeritFunctionValue = NaN;
        outputStruct = NaN;
        return;
    end
    
    tolx = optimizationOption.TolX;
    tolfun = optimizationOption.TolFun;
    outputFuncHandle = optimizationOption.OutputFcn;
    maxIter = optimizationOption.MaximumIteration;
    
    
    currentMeritFunction = meritFunction;
    optimizableObject = currentMeritFunction.OptimizableObject;
    operandArray = currentMeritFunction.OptimizationOperand;
    
    currentVariableValueVector = getOptimizableVector(optimizableObject);
    nIter = 0; %initialize iteration counter
    error = 1;          %initialize error
    delMag = 2;         %set iteration parameter
    

    while nIter <= maxIter %& error > tolfun
        nIter = nIter+1;
        [currentMFValue(nIter)] = getMeritFunctionValue( currentMeritFunction );
        [operandValueVector,operandTargetVector,operandWeightVector] = computeOperandValue(operandArray,optimizableObject);
        JM = getJacobianMatrix( operandArray,optimizableObject );
        %         newVariableValueVector = currentVariableValueVector + (((JM)'*(JM)))\((JM)'*operandValueVector);
        newVariableValueVector = currentVariableValueVector + (pinv((JM)'*(JM)))*(JM)'*(operandWeightVector.*(operandTargetVector-operandValueVector));
        %         newVariableValueVector = currentVariableValueVector + (inv((JM)'*(JM)))*(JM)'*operandValueVector;
        optimizableObject = setOptimizableVector(optimizableObject,newVariableValueVector);
        currentVariableValueVector = newVariableValueVector;

        currentMeritFunction.OptimizableObject = optimizableObject;
%         [currentMFValue(nIter)] = getMeritFunctionValue( currentMeritFunction );
    end
    
    optimalVector = currentVariableValueVector;
    optimalMeritFunctionValue = currentMFValue(nIter);
    outputStruct.Algorithm = 'newtonGaussOptimizer';
    outputStruct.NumberOfIterations = nIter;
    outputStruct.ExitMessage = 'Done!!';
    
    figure; axes; plot([1:nIter],currentMFValue);
end

