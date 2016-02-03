function [ totlaValueVector,totalTargetVector,totalWeightVector ] = computeOperandValue( operandArray,optimizableObject )
    %COMPUTEOPERANDVALUE Evaluates and returns the currentvalue of the
    %opeand for the given optimizable object
    
    if nargin < 2
        disp('Error: The function computeOperandValue requires 2 input argument.');
        totlaValueVector = NaN;
        totalTargetVector = NaN;
        totalWeightVector = NaN;
        return;
    end
    
    % For now use for loop , shall be modified in the future somehouw by
    % faster alternative
    nOperands = length(operandArray);
    % Since some operands may return more than one value/vector it will be
    % advantage to return the cell array of all the vectors or numbers
    
    totlaValueVector = [];
    totalTargetVector = [];
    totalWeightVector = [];
    
    for kk = 1: nOperands
        currentOperand = operandArray(kk);
        % Connect the operand definition function
        operandName = currentOperand.Name;
        operandHandle = str2func(operandName);
        returnFlag = 2; % compute operand value
        
        operandParameters = currentOperand.UniqueParameters;
        inputDataStruct = struct();
        inputDataStruct.OptimizableObject = optimizableObject;
        [returnDataStruct] = operandHandle(returnFlag,operandParameters,inputDataStruct);
        
        currentValueVector = returnDataStruct.Value;
        targetVector = currentOperand.Target;
        weightVector = currentOperand.Weight;
        
        totlaValueVector = [totlaValueVector,currentValueVector];
        totalTargetVector = [totalTargetVector,targetVector];
        totalWeightVector = [totalWeightVector,weightVector];
    end
    
    % Make sure that the all return vectors are coulumn vector
    totlaValueVector = (totlaValueVector(:));
    totalTargetVector = (totalTargetVector(:));
    totalWeightVector = (totalWeightVector(:));
end

