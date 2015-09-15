function [Ey,xlin,ylin] = computeEy(harmonicField)
  Ey = harmonicField.ComplexAmplitude(:,:,2);
  nx = size(Ey,1); 
  ny = size(Ey,2);
  cx = harmonicField.Center(1);
  cy = harmonicField.Center(2);
  dx = harmonicField.SamplingDistance(1);
  dy = harmonicField.SamplingDistance(2); 
  [xlin,ylin] = generateSamplingGridVectors([nx,ny],[dx,dy],[cx,cy]);
end 

