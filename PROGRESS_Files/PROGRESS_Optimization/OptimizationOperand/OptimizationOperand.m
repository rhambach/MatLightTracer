function [ newOptimizationOperand ] = OptimizationOperand( optimizationOperandName,...
        optimizableObject,operandTarget,operandWeight,uniqueParamStruct )
    % OptimizationOperand Struct:
    %
    %   Defines Optimization Operands used in the toolbox. All Optimization
    %   Operands definitions are defined using external functions and this class makes
    %   calls to the external functions to work with the OptimizationOperands struct.
    %
    % Properties: -- and Methods: --
    %
    % Example Calls:
    %
    % newOptimizationOperand = OptimizationOperand('GBAG')
    %   Returns the Gaussian beam agregate.
    %
    if nargin < 1
        optimizationOperandName = 'GBAG'; % Gaussian beam agregate
    end
    if nargin < 2
        [defaultOptimizableObject] = getOptimizableObject( optimizationOperandName );
        optimizableObject = defaultOptimizableObject;
    end
    
    if nargin < 3
        operandTarget = 0;
    end
    if nargin < 4
        operandWeight = 1;
    end
    
    if nargin < 5
        [fieldNames,fieldFormat,defaultUniqueParamStruct] = ...
            getOptimizationOperandUniqueParameters(optimizationOperandName);
        uniqueParamStruct = defaultUniqueParamStruct;
    end
    
    newOptimizationOperand.Name = optimizationOperandName;
    newOptimizationOperand.Target = operandTarget;
    newOptimizationOperand.Weight = operandWeight;
    
    newOptimizationOperand.OptimizableObject = optimizableObject; % object whose parameter is being optimized
    newOptimizationOperand.UniqueParameters = uniqueParamStruct;
    newOptimizationOperand.ClassName = 'OptimizationOperand';
end