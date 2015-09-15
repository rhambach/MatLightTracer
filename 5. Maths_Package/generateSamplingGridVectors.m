function [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance,centerXY)
    %GENERATESAMPLINGGRIDVECTORS return vectors for sampling points of x
    %and y diretion which will later be used to compute mesh grid points
     
    if nargin < 1
        samplingPoints = [65;65];
    end
    if nargin < 2
        samplingDistance = [1;1];
    end
    if nargin < 3
        centerXY = [0;0];
    end
    xlin = uniformSampling1D(centerXY(1),samplingPoints(1),samplingDistance(1));
    ylin = uniformSampling1D(centerXY(2),samplingPoints(2),samplingDistance(2));
end

