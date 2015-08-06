function [ newGauss1D ] = Gauss1D( amplitude,center,waistRadius,nGaussian )
    %GAUSS1D Summary of this function goes here
    %   Detailed explanation goes here
    if nargin == 0
        amplitude = [1,0,-Inf,Inf];
        center = [0,0,-Inf,Inf];
        waistRadius = [1,0,-Inf,Inf];
    elseif nargin == 1
        center = [0,0,-Inf,Inf];
        waistRadius = [1,0,-Inf,Inf];
    elseif nargin == 2
        waistRadius = [1,0,-Inf,Inf];
    else
    end
        
    % Determine the size of each inputs
    nAmp = size(amplitude,1);
    nCent = size(center,1);
    nWaist = size(waistRadius,1);
    % The number of array to be initialized is maximum of all inputs
    nMax = max([nAmp,nCent,nWaist]);
    if nargin > 3
        % limit nMax to the nGaussian
        nMax = nGaussian;
    end
    
    % Fill the smaller inputs to have nMax size by repeating their
    % last element
    if nAmp < nMax
        amplitude = cat(1,amplitude,repmat(amplitude(end,:),[nMax-nAmp,1]));
    else
        amplitude = amplitude(1:nMax,:);
    end
    if nCent < nMax
        center = cat(1,center,repmat(center(end,:),[nMax-nCent,1]));
    else
        center = center(1:nMax,:);
    end
    if nWaist < nMax
        waistRadius = cat(1,waistRadius,repmat(waistRadius(end,:),[nMax-nWaist,1]));
    else
        waistRadius = waistRadius(1:nMax,:);
    end

    % Add the variable status and the min and max values for optimization
    % So all variables will be [value,status,minVal,maxVal]
    variableFlag = zeros(nMax,1);
    minVector = ones(nMax,1)*-Inf;
    maxVector = ones(nMax,1)*Inf;
    if size(amplitude,2) == 1
    amplitude = [amplitude,variableFlag,minVector,maxVector];
    end
    if size(center,2) == 1
    center = [center,variableFlag,minVector,maxVector];
    end
    if size(waistRadius,2) == 1
    waistRadius = [waistRadius,variableFlag,minVector,maxVector];
    end
    
    newGauss1D.Amplitude = amplitude;
    newGauss1D.Center = center;
    newGauss1D.WaistRadius = waistRadius;
    
    newGauss1D.ClassName = 'Gauss1D';
end

