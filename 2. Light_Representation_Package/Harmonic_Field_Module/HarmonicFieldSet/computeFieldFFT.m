function [ modifiedHarmonicFieldSet ] = computeFieldFFT( harmonicFieldSet,scale )
    %computeFieldFFT Computes forier transform using FFT algorithm

    % Default Input
    if nargin < 1
        % Get all catalogues from current folder
        harmonicFieldSet = HarmonicFieldSet;
    end
    if nargin < 2
        scale = [1,1];
    end
    if length(scale) == 1
        scale = repmat(scale,1,2);
    end
    
    % If single harmonic field is passed then convert it to a harmonic
    % field set
    if isHarmonicField(harmonicFieldSet)
        harmonicFieldSet = HarmonicFieldSet(harmonicFieldSet);
    end
    
    modifiedHarmonicFieldSet = harmonicFieldSet;
    nHarmonicFields = length(harmonicFieldSet);
    for kk = 1:nHarmonicFields
        curentHarmonicField = harmonicFieldSet.HarmonicFieldArray(kk);
        oldComplexAmplitude = curentHarmonicField.ComplexAmplitude;
        deltaInSpatial = curentHarmonicField.SamplingDistance;
        [ complexFFTofEx,deltaInFrequency ] = computeCZFFT( oldComplexAmplitude(:,:,1),deltaInSpatial,[1:2],scale );
        [ complexFFTofEy ] = computeCZFFT( oldComplexAmplitude(:,:,2),deltaInSpatial,[1:2],scale );
        
        newComplexAmplitude = cat(3,complexFFTofEx,complexFFTofEy);
        curentHarmonicField.ComplexAmplitude = newComplexAmplitude;
        curentHarmonicField.Domain = 2; % Spatial frequency domain
        curentHarmonicField.SamplingDistance = deltaInFrequency; % in Spatial frequency domain
        modifiedHarmonicFieldSet.HarmonicFieldArray(kk) = curentHarmonicField;
    end
end

