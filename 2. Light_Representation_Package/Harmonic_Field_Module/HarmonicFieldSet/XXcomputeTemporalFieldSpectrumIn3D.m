function [ temporalFieldSpectrum3D, x_lin,y_lin,v_lin  ] = ...
        computeTemporalFieldSpectrumIn3D( harmonicFieldSet,fieldPol )
    %COMPUTEXSPECTRUM Summary of this function goes here
    %   Detailed explanation goes here
    if nargin < 2
        fieldPol = 'Ex';
    end
    harmonicFieldArray = harmonicFieldSet.HarmonicFieldArray;
    nSpectralSample = size(harmonicFieldArray,2);
    
    nx = size(computeEx(harmonicFieldArray(1)),2);
    ny = size(computeEy(harmonicFieldArray(1)),1);
    
    dx = harmonicFieldArray(1).SamplingDistance(1);
    dy = harmonicFieldArray(1).SamplingDistance(2);
    
    cx = harmonicFieldSet.LateralPosition(1);
    cy = harmonicFieldSet.LateralPosition(2);
    
    x_lin = uniformSampling1D(cx,nx,dx);
    y_lin = uniformSampling1D(cy,ny,dy);
    
    v_lin = getFrequencyVector( harmonicFieldSet );
    if strcmpi(fieldPol, 'Ex')
        N1 = size(computeEx(harmonicFieldArray(1)),1);
        N2 = size(computeEy(harmonicFieldArray(1)),2);
        temporalFieldSpectrum3D = zeros(N1,N2,nSpectralSample);
        for ss = 1:nSpectralSample
            temporalFieldSpectrum3D(:,:,ss) = computeEx(harmonicFieldArray(ss));
        end
    elseif strcmpi(fieldPol, 'Ey')
        N1 = size(computeEx(harmonicFieldArray(1)),1);
        N2 = size(computeEy(harmonicFieldArray(1)),2);
        temporalFieldSpectrum3D = zeros(N1,N2,nSpectralSample);
        for ss = 1:nSpectralSample
            temporalFieldSpectrum3D(:,:,ss) = computeEy(harmonicFieldArray(ss));
        end
    else
        disp('Error: Invalid Field Polarization. It must be Ex or Ey.');
        temporalFieldSpectrum3D = [];
        return;
    end
end

