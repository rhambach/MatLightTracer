function sampled1DPoints = uniformSampling1D(centerPoint,numberOfSamplePoints,samplingInterval)
  if mod(numberOfSamplePoints,2)
      % odd
        sampled1DPoints = [-floor(numberOfSamplePoints/2):1:(floor(numberOfSamplePoints/2))]*samplingInterval + centerPoint;
  elseif ~mod(numberOfSamplePoints,2) 
      % even
        sampled1DPoints = [-(numberOfSamplePoints/2):1:((numberOfSamplePoints/2)-1)]*samplingInterval + centerPoint;
  else
  end
end