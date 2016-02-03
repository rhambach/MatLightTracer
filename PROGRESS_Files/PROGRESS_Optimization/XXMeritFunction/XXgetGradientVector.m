function [gradientVector] = getGradientVector( currentMeritFunction )
    %getGradientVector Returns the gradient vector of the current merit
    %function
    % Inputs:
    % currentMeritFunction:
    %       1. Struct/object --> currentMeritFunction
    % Outputs:
    %   [gradientVector]
    
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
        disp('Error: The function getGradientVector requires atleast one input argument.');
        gradientVector = NaN;
        return;
    end
    currentValueVector = getOptimizableVector(currentMeritFunction);
    
    nVariables = length(currentValueVector);
    h = 0.01; % for numerical derivative computation
    gradientVector = zeros(nVariables,1);
    for kk = 1:nVariables
        hVector1 = zeros(nVariables,1);
        hVector2 = zeros(nVariables,1);
        hVector1(kk) = -h;
        hVector2(kk) = h;
        % Use double sided numerical derivative
        meritFunction1 = setOptimizableVector(currentMeritFunction,currentValueVector + hVector1);
        meritFunction2 = setOptimizableVector(currentMeritFunction,currentValueVector + hVector2);
        
        meritFunctionValue1 = getMeritFunctionValue(meritFunction1);
        meritFunctionValue2 = getMeritFunctionValue(meritFunction2);
        
        gradientVector(kk) = ((meritFunctionValue2-meritFunctionValue1)/(2*h));
    end
end

