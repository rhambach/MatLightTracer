function [jacobianMatrix] = getJacobianMatrix( operandArray,optimizableObject )
    %getJacobianMatrix Returns the gradient vector of the current merit
    %function
    % Inputs:
    % operandArray:
    %       1. Struct/object --> Array of operands
    % Outputs:
    %   [jacobianMatrix]
    
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
        disp('Error: The function getJacobianMatrix requires atleast one input argument.');
        jacobianMatrix = NaN;
        return;
    end

    currentVariableValueVector = getOptimizableVector(optimizableObject);
    operandValueVector = computeOperandValue( operandArray,optimizableObject );
    nVariables = length(currentVariableValueVector);
    nOperands = length(operandValueVector);

    h = 0.01; % for numerical derivative computation
    jacobianMatrix = zeros(nOperands,nVariables);
    for kk = 1:nVariables
        hVector1 = zeros(nVariables,1);
        hVector2 = zeros(nVariables,1);
        hVector1(kk) = -h;
        hVector2(kk) = h;
        % Use double sided numerical derivative
        optimizableObject1 = setOptimizableVector(optimizableObject,currentVariableValueVector + hVector1);
        optimizableObject2 = setOptimizableVector(optimizableObject,currentVariableValueVector + hVector2);
        
        operandValueVector1 = computeOperandValue( operandArray,optimizableObject1 );
        operandValueVector2 = computeOperandValue( operandArray,optimizableObject2 );
        
        jacobianMatrix(:,kk) = (operandValueVector2 - operandValueVector1)/(2*h);
    end
end

