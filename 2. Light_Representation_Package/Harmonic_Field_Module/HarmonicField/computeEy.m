function [Ey,x_lin,y_lin] = computeEy(harmonicField)
  Ey = harmonicField.ComplexAmplitude(:,:,2);
  nx = size(Ey,1); 
  ny = size(Ey,2);
  cx = harmonicField.Center(1);
  cy = harmonicField.Center(2);
  dx = harmonicField.SamplingDistance(1);
  dy = harmonicField.SamplingDistance(2); 
  
  x_lin = uniformSampling1D(cx,nx,dx);
  y_lin = uniformSampling1D(cy,ny,dy);
end 

