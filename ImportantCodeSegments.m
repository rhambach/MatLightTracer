  if mod(nx,2) && mod(ny,2)
      % odd
        x_lin = [-floor(nx/2):1:(floor(nx/2))]*dx + cx;
        y_lin = [-floor(ny/2):1:(floor(ny/2))]*dy + cy;        
  elseif ~mod(nx,2) && ~mod(ny,2)
      % even
        x_lin = [-(nx/2):1:((nx/2)-1)]*dx + cx;
        y_lin = [-(ny/2):1:((ny/2)-1)]*dy + cy;      
  else
      % don't agree 
      disp('Error: Both dimensions of harmonic field must be either even or odd');
      Ex = NaN;
      x_lin = NaN;
      y_lin = NaN;
      return;
  end
  
  
  %%
