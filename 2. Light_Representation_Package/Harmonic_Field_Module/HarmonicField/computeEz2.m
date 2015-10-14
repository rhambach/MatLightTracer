function [Ez,xlin,ylin] = computeEz(harmonicField)
    Ex = harmonicField.ComplexAmplitude(:,:,1);
    nx = size(Ex,1);
    ny = size(Ex,2);
    cx = harmonicField.Center(1);
    cy = harmonicField.Center(2);
    dx = harmonicField.SamplingDistance(1);
    dy = harmonicField.SamplingDistance(2);
    [xlin,ylin] = generateSamplingGridVectors([nx,ny],[dx,dy],[cx,cy]);
end

