function [Ex,x_lin,y_lin] = computeEx(harmonicField)
  Ex = harmonicField.ComplexAmplitude(:,:,1);
  nx = size(Ex,1); 
  ny = size(Ex,2);
  cx = harmonicField.Center(1);
  cy = harmonicField.Center(2);
  dx = harmonicField.SamplingDistance(1);
  dy = harmonicField.SamplingDistance(2);
  
  x_lin = uniformSampling1D(cx,nx,dx);
  y_lin = uniformSampling1D(cy,ny,dy);
  end 

