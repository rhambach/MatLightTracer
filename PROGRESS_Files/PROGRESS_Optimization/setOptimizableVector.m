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
            updatedObject.Center(optIndices2,3) = minimumVector(range2);
            updatedObject.Center(optIndices2,4) = maximumVector(range2);
        end
        optIndices3 = logical(updatedObject.WaistRadius(:,2));
        nOpt3 = sum(optIndices3);
        range3 = [1 + nOpt1 + nOpt2:nOpt3 + nOpt2 + nOpt1];
        if ~isempty(range3)
            updatedObject.WaistRadius(optIndices3,1) = optimumVector(range3);
            updatedObject.WaistRadius(optIndices3,3) = minimumVector(range3);
            updatedObject.WaistRadius(optIndices3,4) = maximumVector(range3);
        end
        
    elseif isGauss2D (optimizableObject)
        % Optimizable vector [amplitude,center,waistRadius]'
        updatedObject = optimizableObject;
        
        optIndices1 = logical(updatedObject.Amplitude(:,2));
        nOpt1 = sum(optIndices1);
        if nOpt1
            range1 = [1:nOpt1];
        else
            range1 = 0;
        end
        if (range1(1))
            updatedObject.Amplitude(optIndices1,1) = optimumVector(range1);
            updatedObject.Amplitude(optIndices1,3) = minimumVector(range1);
            updatedObject.Amplitude(optIndices1,4) = maximumVector(range1);
        end
        
        
        optIndices2 = logical(updatedObject.CenterX(:,2));
        nOpt2 = sum(optIndices2);
        if nOpt2
            range2 = [1:nOpt2]+range1(end);
        else
            range2 = 0;
        end
        if (range2(1))
            updatedObject.CenterX(optIndices2,1) = optimumVector(range2);
            updatedObject.CenterX(optIndices2,3) = minimumVector(range2);
            updatedObject.CenterX(optIndices2,4) = maximumVector(range2);
        end
        
        
        optIndices3 = logical(updatedObject.CenterY(:,2));
        nOpt3 = sum(optIndices3);
        if nOpt3
            range3 = [1:nOpt3]+range2(end);
        else
            range3 = 0;
        end
        if (range3(1))
            updatedObject.CenterY(optIndices3,1) = optimumVector(range3);
            updatedObject.CenterY(optIndices3,3) = minimumVector(range3);
            updatedObject.CenterY(optIndices3,4) = maximumVector(range3);
        end
        
        optIndices4 = logical(updatedObject.WaistRadiusX(:,2));
        nOpt4 = sum(optIndices4);
        if nOpt4
            range4 = [1:nOpt4]+range3(end);
        else
            range4 = 0;
        end
        if (range4(1))
            updatedObject.WaistRadiusX(optIndices4,1) = optimumVector(range4);
            updatedObject.WaistRadiusX(optIndices4,3) = minimumVector(range4);
            updatedObject.WaistRadiusX(optIndices4,4) = maximumVector(range4);
        end
        
        optIndices5 = logical(updatedObject.WaistRadiusY(:,2));
        nOpt5 = sum(optIndices5);
        if nOpt5
            range5 = [1:nOpt5]+range4(end);
        else
            range5 = 0;
        end
        if (range5(1))
            updatedObject.WaistRadiusY(optIndices5,1) = optimumVector(range5);
            updatedObject.WaistRadiusY(optIndices5,3) = minimumVector(range5);
            updatedObject.WaistRadiusY(optIndices5,4) = maximumVector(range5);
        end
        
        optIndices6 = logical(updatedObject.OrientationAngle(:,2));
        nOpt6 = sum(optIndices6);
        if nOpt6
            range6 = [1:nOpt6]+range5(end);
        else
            range6 = 0;
        end
        if (range6(1))
            updatedObject.OrientationAngle(optIndices6,1) = optimumVector(range6);
            updatedObject.OrientationAngle(optIndices6,3) = minimumVector(range6);
            updatedObject.OrientationAngle(optIndices6,4) = maximumVector(range6);
        end
        
    elseif isScalarGaussianBeamSet (optimizableObject)
        % Optimizable vector [amplitude]'
        updatedObject = optimizableObject;
        
        optIndices1 = logical(updatedObject.PeakAmplitude(:,2));
        nOpt1 = sum(optIndices1);
        if nOpt1
            range1 = [1:nOpt1];
        else
            range1 = 0;
        end
        if (range1(1))
            updatedObject.PeakAmplitude(optIndices1,1) = optimumVector(range1);
            updatedObject.PeakAmplitude(optIndices1,3) = minimumVector(range1);
            updatedObject.PeakAmplitude(optIndices1,4) = maximumVector(range1);
        end
        % At the moment other properties are not optimizable
    else
        
    end
    
end

