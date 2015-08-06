function [ options ] = RayTraceOptionStruct( )
    % Structure containng options for ray tracing function which are
    % logical values indicating what to compute and consider
    options.ConsiderPolarization = 0;
    options.ConsiderSurfAperture = 1;
    options.RecordIntermediateResults = 0;
    
    options.ComputeGeometricalPathLength = 1;
    options.ComputeOpticalPathLength = 0;
    options.ComputeGroupPathLength = 0;
    
    options.ComputeRefractiveIndex = 1;
    options.ComputeRefractiveIndexFirstDerivative = 0;
    options.ComputeRefractiveIndexSecondDerivative = 0;
    options.ComputeGroupIndex = 0;
end

