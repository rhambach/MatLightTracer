function [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance)
    %GENERATESAMPLINGGRIDVECTORS return vectors for sampling points of x
    %and y diretion which will later be used to compute mesh grid points
     
    Nx = samplingPoints(1);
    Ny = samplingPoints(2);
    dx = samplingDistance(1);
    dy = samplingDistance(2);
    xlin = [-floor(Nx/2):floor(Nx/2)]*dx;
    ylin = [-floor(Ny/2):floor(Ny/2)]*dy;
end

