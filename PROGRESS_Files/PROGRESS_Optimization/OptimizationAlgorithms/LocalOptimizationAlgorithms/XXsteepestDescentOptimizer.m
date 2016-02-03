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
%     operandArray = currentMeritFunction.OptimizationOperand;
    currentVariableValueVector = getOptimizableVector(optimizableObject);
     
%     currentMeritFunction = meritFunction;
%     currentVariableValueVector = getOptimizableVector(currentMeritFunction);   
    
    nIter = 0; %initialize iteration counter
    error = 1;          %initialize error
    delMag = 2;         %set iteration parameter
    
    while nIter <= maxIter %& error > tolfun
        [currentMFValue] = getMeritFunctionValue( currentMeritFunction );
        error = currentMeritFunction.Target - currentMFValue;
        gradientvector = getGradientVector(currentMeritFunction);%0*currentVariableValues;
        newOptVector = currentVariableValueVector - delMag*gradientvector;
        currentMeritFunction = setOptimizableVector(currentMeritFunction,newOptVector); 
        currentVariableValueVector = newOptVector;
        nIter = nIter+1;
    end
    
    optimalVector = currentVariableValueVector;
    optimalMeritFunctionValue = currentMFValue
    outputStruct.Algorithm = 'steepestDescentOptimizer';
    outputStruct.NumberOfIterations = nIter;
    outputStruct.ExitMessage = 'Done!!';
end

