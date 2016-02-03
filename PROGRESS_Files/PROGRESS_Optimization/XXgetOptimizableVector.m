function [ optimimumVector, minimumVector,maximumVector ] =...
        getOptimizableVector( optimizableObject )
    %GETOPTIMIZABLEVARIABLES Summary of this function goes here
    %   Detailed explanation goes here
    
    if isGauss1D (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        myGauss1D = optimizableObject;
        
        allValues1 = myGauss1D.Amplitude;
        optimizableIndices1 = logical(allValues1(:,2));
        nOpt1 = sum(optimizableIndices1);
        if nOpt1
            currentValues1 = allValues1(optimizableIndices1,1);
            minimumValue1 = allValues1(optimizableIndices1,3);
            maximumValue1 = allValues1(optimizableIndices1,4);
        else
            currentValues1 = [];
            minimumValue1 = [];
            maximumValue1 = [];
        end
        
        allValues2 = myGauss1D.Center;
        optimizableIndices2 = logical(allValues2(:,2));
        nOpt2 = sum(optimizableIndices2);
        if nOpt2
            currentValues2 = allValues2(optimizableIndices2,1);
            minimumValue2 = allValues2(optimizableIndices2,3);
            maximumValue2 = allValues2(optimizableIndices2,4);
        else
            currentValues2 = [];
            minimumValue2 = [];
            maximumValue2 = [];
        end
        
        
        allValues3 = myGauss1D.WaistRadius;
        optimizableIndices3 = logical(allValues3(:,2));
        nOpt3 = sum(optimizableIndices3);
        if nOpt3
            currentValues3 = allValues3(optimizableIndices3,1);
            minimumValue3 = allValues3(optimizableIndices3,3);
            maximumValue3 = allValues3(optimizableIndices3,4);
        else
            currentValues3 = [];
            minimumValue3 = [];
            maximumValue3 = [];
        end
        
        optimimumVector = [currentValues1;currentValues2;currentValues3];
        minimumVector = [minimumValue1;minimumValue2;minimumValue3];
        maximumVector = [maximumValue1;maximumValue2;maximumValue3];
        
    elseif isMeritFunction (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        [optimimumVector, minimumVector,maximumVector] = getOptimizableVector( ...
            optimizableObject.OptimizableObject);
    else
        
        
    end
    
end

