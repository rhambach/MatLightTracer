function [ optimalValue,optimalMeritFunction,optimizedObject,outputStruct ] = ...
        NonLinearOptimizer( optimizationAlgorithmName,meritFunctionName,...
        targetValue,weight,optimizableObject,meritFunctionParameters,...
        optimizationOption,initialValue,minimumValue,maximumValue )
    %NonLinearOptimizer Summary of this function goes here
    %   Detailed explanation goes here
    meritFunctionStruct = MeritFunction(meritFunctionName);
    meritFunctionStruct.Target = targetValue;
    meritFunctionStruct.Weight = weight;
    meritFunctionStruct.UniqueParameters = meritFunctionParameters;
    
    % Set the initial, maximum and minimum values of the optimizable
    % objects
    initialObject = setOptimizableVector(optimizableObject,initialValue,minimumValue,maximumValue);
    meritFunctionStruct.OptimizableObject = initialObject;
    optimizationAlgorithmDefinition = str2func(optimizationAlgorithmName);
    [ optimalValue,optimalMeritFunction,outputStruct ] = ...
        optimizationAlgorithmDefinition( meritFunctionStruct,optimizationOption);
    
    optimizedObject = setOptimizableVector(meritFunctionStruct.OptimizableObject,optimalValue);
end

