function [ optimalVector,optimalMeritFunctionValue,outputStruct ] = ...
        steepestDescentOptimizer( meritFunctionStruct,optimizationOption )
    %STEEPESTDESCENTOPTIMIZER Summary of this function goes here
    %   Detailed explanation goes here
    
    tolx = optimizationOption.TolX;
    tolfun = optimizationOption.TolFun;
    outputFuncHandle = optimizationOption.OutputFcn;
    maxIter = optimizationOption.MaximumIteration;
    
    
    currentMeritFunction = meritFunctionStruct;
    currentOptVector = getOptimizableVector(currentMeritFunction);    
    nIter = 0; %initialize iteration counter
    error = 1;          %initialize error
    delMag = 2;         %set iteration parameter
    
    while nIter <= maxIter %& error > tolfun
        [currentMFValue] = getMeritFunctionValue( currentMeritFunction );
        error = currentMeritFunction.Target - currentMFValue;
        gradientvector = getGradientVector(currentMeritFunction);%0*currentVariableValues;
        newOptVector = currentOptVector - delMag*gradientvector;
        currentMeritFunction = setOptimizableVector(currentMeritFunction,newOptVector); 
        currentOptVector = newOptVector;
        nIter = nIter+1;
    end
    
    optimalVector = currentOptVector;
    optimalMeritFunctionValue = currentMFValue
    outputStruct.Algorithm = 'steepestDescentOptimizer';
    outputStruct.NumberOfIterations = nIter;
    outputStruct.ExitMessage = 'Done!!';
end

