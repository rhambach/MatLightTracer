function [ updatedObject ] =...
        setOptimizableVector( optimizableObject,optimumVector,minimumVector,maximumVector )
    %GETOPTIMIZABLEVARIABLES Summary of this function goes here
    %   Detailed explanation goes here
    if nargin == 2
        nVariable = length(optimumVector);
        minimumVector = ones(1,nVariable)*-Inf;
        maximumVector = ones(1,nVariable)*Inf;
    end
    if isGauss1D (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        updatedObject = optimizableObject;
        
        optIndices1 = logical(updatedObject.Amplitude(:,2));
        nOpt1 = sum(optIndices1);
        range1 = [1:nOpt1];
        if ~isempty(range1)
            updatedObject.Amplitude(optIndices1,1) = optimumVector(range1);
            updatedObject.Amplitude(optIndices1,3) = minimumVector(range1);
            updatedObject.Amplitude(optIndices1,4) = maximumVector(range1);
        end
        optIndices2 = logical(updatedObject.Center(:,2));
        nOpt2 = sum(optIndices2);
        range2 = [1 + nOpt1:nOpt2 + nOpt1];
        if ~isempty(range2)
            updatedObject.Center(optIndices2,1) = optimumVector(range2);
            updatedObject.Center(optIndices1,3) = minimumVector(range2);
            updatedObject.Center(optIndices1,4) = maximumVector(range2);
        end
        optIndices3 = logical(updatedObject.WaistRadius(:,2));
        nOpt3 = sum(optIndices3);
        range3 = [1 + nOpt1 + nOpt2:nOpt3 + nOpt2 + nOpt1];
        if ~isempty(range3)
            updatedObject.WaistRadius(optIndices3,1) = optimumVector(range3);
            updatedObject.WaistRadius(optIndices1,3) = minimumVector(range3);
            updatedObject.WaistRadius(optIndices1,4) = maximumVector(range3);
        end
    elseif isMeritFunction (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        updatedObject = optimizableObject;
        updatedObject.OptimizableObject = setOptimizableVector( ...
            optimizableObject.OptimizableObject,optimumVector,minimumVector,maximumVector );
    else
        
    end
    
end

