function [ optimalVector,optimalMeritFunctionValue,outputStruct ] = ...
        steepestDescentOptimizer( meritFunction,optimizationOption )
    %STEEPESTDESCENTOPTIMIZER Summary of this function goes here
    %   Detailed explanation goes here
    
    tolx = optimizationOption.TolX;
    tolfun = optimizationOption.TolFun;
    outputFuncHandle = optimizationOption.OutputFcn;
    maxIter = optimizationOption.MaximumIteration;
    
    currentMeritFunction = meritFunction;
    optimizableObject = currentMeritFunction.OptimizableObject;
    operandArray = currentMeritFunction.OptimizationOperand;
    currentVariableValueVector = getOptimizableVector(optimizableObject);
    
    %     currentMeritFunction = meritFunction;
    %     currentVariableValueVector = getOptimizableVector(currentMeritFunction);
    
    nIter = 0; %initialize iteration counter
    error = 1;          %initialize error
    delMag = 1;         %set iteration parameter
    
    while nIter <= maxIter %& error > tolfun
        nIter = nIter+1;
        [currentMFValue(nIter)] = getMeritFunctionValue( currentMeritFunction );
        error = 0 - currentMFValue(nIter);
        gradientvector = getGradientVector(currentMeritFunction);%0*currentVariableValues;
        newOptVector = currentVariableValueVector - delMag*gradientvector;
        currentMeritFunction.OptimizableObject = setOptimizableVector(currentMeritFunction.OptimizableObject,newOptVector);
        currentVariableValueVector = newOptVector;
    end
    
    optimalVector = currentVariableValueVector;
    optimalMeritFunctionValue = currentMFValue(nIter);
    outputStruct.Algorithm = 'steepestDescentOptimizer';
    outputStruct.NumberOfIterations = nIter;
    outputStruct.ExitMessage = 'Done!!';
    
    figure; axes; plot([1:nIter],currentMFValue);
end

