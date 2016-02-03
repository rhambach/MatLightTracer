function [ newGauss2D ] = Gauss2D( amplitude,center_x,center_y,waistRadius_x,waistRadius_y,orientationInRad,nGaussian )
    %GAUSS1D Summary of this function goes here
    %   Detailed explanation goes here
    if nargin < 1
        amplitude = [1,0,-Inf,Inf];
    end
    if nargin < 2
        center_x = [0,0,-Inf,Inf];
    end
    if nargin < 3
        center_y = [0,0,-Inf,Inf];
    end   
    if nargin < 4
        waistRadius_x = [1,0,-Inf,Inf];
    end      
    if nargin < 5
        waistRadius_y = [1,0,-Inf,Inf];
    end   
    if nargin < 6
        orientationInRad = [0,0,-Inf,Inf];
    end      
    if nargin < 7
        nGaussian = 20;
    end     
    
        
    % Determine the size of each inputs
    nAmp = size(amplitude,1);
    nCent_x = size(center_x,1);
    nCent_y = size(center_y,1);
    nWaist_x = size(waistRadius_x,1);
    nWaist_y = size(waistRadius_y,1);
    nAngle = size(orientationInRad,1);
    % The number of array to be initialized is maximum of all inputs
    nMax = max([nAmp,nCent_x,nCent_y,nWaist_x,nWaist_y,nAngle]);
    if nargin > 6
        % limit nMax to the nGaussian
        nMax = nGaussian;
    else
        nGaussian = nMax;
    end
    
    % Fill the smaller inputs to have nMax size by repeating their
    % last element
    if nAmp < nMax
        amplitude = cat(1,amplitude,repmat(amplitude(end,:),[nMax-nAmp,1]));
    else
        amplitude = amplitude(1:nMax,:);
    end
    if nCent_x < nMax
        center_x = cat(1,center_x,repmat(center_x(end,:),[nMax-nCent_x,1]));
    else
        center_x = center_x(1:nMax,:);
    end
    if nCent_y < nMax
        center_y = cat(1,center_y,repmat(center_y(end,:),[nMax-nCent_y,1]));
    else
        center_y = center_y(1:nMax,:);
    end    
    if nWaist_x < nMax
        waistRadius_x = cat(1,waistRadius_x,repmat(waistRadius_x(end,:),[nMax-nWaist_x,1]));
    else
        waistRadius_x = waistRadius_x(1:nMax,:);
    end
    if nWaist_y < nMax
        waistRadius_y = cat(1,waistRadius_y,repmat(waistRadius_y(end,:),[nMax-nWaist_y,1]));
    else
        waistRadius_y = waistRadius_y(1:nMax,:);
    end
    if nAngle < nMax
        orientationInRad = cat(1,orientationInRad,repmat(orientationInRad(end,:),[nMax-nAngle,1]));
    else
        orientationInRad = orientationInRad(1:nMax,:);
    end    
    
    
    % Add the variable status and the min and max values for optimization
    % So all variables will be [value,status,minVal,maxVal]
    variableFlag = zeros(nMax,1);
    minVector = ones(nMax,1)*-Inf;
    maxVector = ones(nMax,1)*Inf;
    if size(amplitude,2) == 1
        amplitude = [amplitude,variableFlag,minVector,maxVector];
    end
    if size(center_x,2) == 1
        center_x = [center_x,variableFlag,minVector,maxVector];
    end
    if size(center_y,2) == 1
        center_y = [center_y,variableFlag,minVector,maxVector];
    end    
    if size(waistRadius_x,2) == 1
        waistRadius_x = [waistRadius_x,variableFlag,minVector,maxVector];
    end
    if size(waistRadius_y,2) == 1
        waistRadius_y = [waistRadius_y,variableFlag,minVector,maxVector];
    end
    if size(orientationInRad,2) == 1
        orientationInRad = [orientationInRad,variableFlag,minVector,maxVector];
    end
    
    newGauss2D.Amplitude = amplitude;
    newGauss2D.CenterX = center_x;
    newGauss2D.CenterY = center_y;
    newGauss2D.WaistRadiusX = waistRadius_x;
    newGauss2D.WaistRadiusY = waistRadius_y;
    newGauss2D.OrientationAngle = orientationInRad;
    newGauss2D.nGaussian = nGaussian;
    
    newGauss2D.ClassName = 'Gauss2D';
end

