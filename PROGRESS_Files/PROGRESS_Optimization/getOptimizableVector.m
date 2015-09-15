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
        
    elseif isGauss2D (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        myGauss2D = optimizableObject;
        
        allValues1 = myGauss2D.Amplitude;
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
        
        allValues2 = myGauss2D.CenterX;
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
        
        allValues3 = myGauss2D.CenterY ;
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
        
        allValues4 = myGauss2D.WaistRadiusX ;
        optimizableIndices4 = logical(allValues4(:,2));
        nOpt4 = sum(optimizableIndices4);
        if nOpt4
            currentValues4 = allValues4(optimizableIndices4,1);
            minimumValue4 = allValues4(optimizableIndices4,3);
            maximumValue4 = allValues4(optimizableIndices4,4);
        else
            currentValues4 = [];
            minimumValue4 = [];
            maximumValue4 = [];
        end
        
        
        allValues5 = myGauss2D.WaistRadiusY ;
        optimizableIndices5 = logical(allValues5(:,2));
        nOpt5 = sum(optimizableIndices5);
        if nOpt5
            currentValues5 = allValues5(optimizableIndices5,1);
            minimumValue5 = allValues5(optimizableIndices5,3);
            maximumValue5 = allValues5(optimizableIndices5,4);
        else
            currentValues5 = [];
            minimumValue5 = [];
            maximumValue5 = [];
        end
        
        allValues6 = myGauss2D.OrientationAngle ;
        optimizableIndices6 = logical(allValues5(:,2));
        nOpt6 = sum(optimizableIndices6);
        if nOpt6
            currentValues6 = allValues6(optimizableIndices6,1);
            minimumValue6 = allValues6(optimizableIndices6,3);
            maximumValue6 = allValues6(optimizableIndices6,4);
        else
            currentValues6 = [];
            minimumValue6 = [];
            maximumValue6 = [];
        end
        
        optimimumVector = [currentValues1;currentValues2;currentValues3;currentValues4;currentValues5;currentValues6];
        minimumVector = [minimumValue1;minimumValue2;minimumValue3;minimumValue4;minimumValue5;minimumValue6];
        maximumVector = [maximumValue1;maximumValue2;maximumValue3;maximumValue4;maximumValue5;maximumValue6];
    elseif isScalarGaussianBeamSet (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        myGauss2D = optimizableObject;
        
        allValues1 = myGauss2D.PeakAmplitude;
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
        optimimumVector = [currentValues1];
        minimumVector = [minimumValue1];
        maximumVector = [maximumValue1];
        % At the moment other properties are not optimizable
    else
        
        
    end
    
end

