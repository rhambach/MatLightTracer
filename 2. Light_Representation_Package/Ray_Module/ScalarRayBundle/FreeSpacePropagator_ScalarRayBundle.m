function [ propagatedRayBundle ] = FreeSpacePropagator_ScalarRayBundle(...
        inputScalarRayBundle,propagationDistance )
    %FreeSpacePropagator_ScalarRayBundle Used to compute free space
    %propagation of scalar ray bundles using real ray tracing method.
    % The code is also vectorized for multiple propagation distance input 
    
    if nargin < 1
        inputScalarRayBundle = NaN;
    end
    if nargin < 2
        propagationDistance = 0;
    end
    
    if isScalarRayBundle(inputScalarRayBundle)
        % Do nothing
    else
        disp(['Error: Invalid input to FreeSpacePropagator_ScalarRayBundle.',...
            'The first argument should be scalar ray bundle.']);
    end
    
    tempRayBundle = inputScalarRayBundle;
    nPropagationDistance = length(propagationDistance);
    for kk = 1:nPropagationDistance
        tempRayBundle.Position = tempRayBundle.Position + ...
            propagationDistance*tempRayBundle.Direction;
        propagatedRayBundle (kk) =  tempRayBundle;
    end
end

