function [ optimalValue,optimalMeritFunctionValue,optimizedObject,outputStruct ] = ...
        NonLinearOptimizer( optimizationAlgorithmName,meritFunction,...
        optimizationOperand,optimizableObject,...
        optimizationOption,initialValue,minimumValue,maximumValue )
    %NonLinearOptimizer Summary of this function goes here
    %   Detailed explanation goes here
    
% 
%     optimizableObject = 
%     
%     meritFunction = meritFunction;
%     meritFunction.Target = targetValue;
%     meritFunction.Weight = weight;
%     meritFunction.UniqueParameters = meritFunctionParameters;
    
    % Set the initial, maximum and minimum values of the optimizable
    % objects
    initialObject = setOptimizableVector(optimizableObject,initialValue,minimumValue,maximumValue);
    meritFunction.OptimizableObject = initialObject;
    optimizationAlgorithmDefinition = str2func(optimizationAlgorithmName);
    [ optimalValue,optimalMeritFunctionValue,outputStruct ] = ...
        optimizationAlgorithmDefinition( meritFunction,optimizationOption);
    
    optimizedObject = setOptimizableVector(meritFunction.OptimizableObject,optimalValue);
end

