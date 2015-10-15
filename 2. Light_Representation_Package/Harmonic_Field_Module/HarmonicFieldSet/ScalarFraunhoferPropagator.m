function [ finalHarmonicField ] = ScalarFraunhoferPropagator( initialHarmonicField,...
        propagationDistance,outputWindowSize,addSphericalCorrection )
    %SCALARFRAUNHOFERPROPAGATOR computes the scalar (Ex far field diffraction pattern
    % using fft based fraunhofer integral
    
    finalHarmonicField = initialHarmonicField;
    
    [efd,xp,yp] = computeEx(initialHarmonicField);
    
    % efd = initialHarmonicField.computeEx;
    npx = size(efd,1);
    npy = size(efd,2);
    
    % dx = initialHarmonicField.SamplingDistance(1);
    % dy = initialHarmonicField.SamplingDistance(2);
    % if npx == 1
    %     xp = 0;
    % else
    %     xp = [-floor(npx/2)*dx:dx:floor(npx/2)*dx];
    % end
    % if npy == 1
    %     yp = 0;
    % else
    %     yp = [-floor(npy/2)*dy:dy:floor(npy/2)*dy];
    % end
    
    dus = outputWindowSize/2; % size to see the result (radius)
    xs = linspace(-dus,dus,npx);
    ys = xs;
    z = propagationDistance ;
    wl = (initialHarmonicField.Wavelength);
    
    if addSphericalCorrection
        % If input field is computed on an exit pupil sphere and not on plane
        % Add spherical phase correction as the existing diffraction code
        % assumes the wavefront has curvature = Z of propagation
        [xpm,ypm] = meshgrid(xp,yp);
        rpm = sqrt(xpm.^2+ypm.^2);
        rcurv = z;
        efd = efd .* exp(-1i*pi/(wl*z)*(rpm.^2));
    end
    efds = prop_fraun_fft(xp,yp,efd,xs,ys,z,wl);
    dx_final = outputWindowSize/npx;
    dy_final = outputWindowSize/npy;
    
    finalHarmonicField.ComplexAmplitude(:,:,1) = efds;
    finalHarmonicField.SamplingDistance(1) = dx_final;
    finalHarmonicField.SamplingDistance(2) = dy_final;
end

