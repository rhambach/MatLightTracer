function [operandValue] = getOperandValue( currentOperand )
    %getOperandValue Returns the Operand Value
    % Inputs:
    % currentOperand:
    %       1. Struct/object --> currentOperand
    % Outputs:
    %   [operandValue]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    if nargin == 0
        disp('Error: The function getOperandValue requires atleast 1 input argument.');
        operandValue = NaN;
        return;
    end
    
    % Connect the operand definition function
    operandName = currentOperand.Name;
    operandHandle = str2func(operandName);
    returnFlag = 2; % compute operand value
    
    operandParameters = currentOperand.UniqueParameters;
    inputDataStruct = struct();
    inputDataStruct.OptimizableObject = currentOperand.OptimizableObject;
    [returnDataStruct] = operandHandle(returnFlag,operandParameters,inputDataStruct);
    operandValue = returnDataStruct.Value;
end

