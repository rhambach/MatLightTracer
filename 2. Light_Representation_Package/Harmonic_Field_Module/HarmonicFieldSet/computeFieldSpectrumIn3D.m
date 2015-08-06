function [ fieldSpectrum3D, x_lin,y_lin,v_lin  ] = computeFieldSpectrumIn3D( harmonicFieldSet,fieldPol )
%COMPUTEXSPECTRUM Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    fieldPol = 'Ex';
end
harmonicFieldArray = harmonicFieldSet.HarmonicFieldArray;
nSpectralSample = size(harmonicFieldArray,2);

nx = size(harmonicFieldArray(1).computeEx,2);
ny = size(harmonicFieldArray(1).computeEx,1);

dx = harmonicFieldArray(1).SamplingDistance(1);
dy = harmonicFieldArray(1).SamplingDistance(2);

cx = harmonicFieldSet.Center(1);
cy = harmonicFieldSet.Center(2);

x_lin = uniformSampling1D(cx,nx,dx);
y_lin = uniformSampling1D(cy,ny,dy);

v_lin = getFrequencyVector( harmonicFieldSet );
if strcmpi(fieldPol, 'Ex')
    N1 = size(harmonicFieldArray(1).computeEx,1);
    N2 = size(harmonicFieldArray(1).computeEx,2);
    fieldSpectrum3D = zeros(N1,N2,nSpectralSample);
    for ss = 1:nSpectralSample
        fieldSpectrum3D(:,:,ss) = harmonicFieldArray(ss).computeEx;
    end
elseif strcmpi(fieldPol, 'Ey')
    N1 = size(harmonicFieldArray(1).computeEy,1);
    N2 = size(harmonicFieldArray(1).computeEy,2);
    fieldSpectrum3D = zeros(N1,N2,nSpectralSample);
    for ss = 1:nSpectralSample
        fieldSpectrum3D(:,:,ss) = harmonicFieldArray(ss).computeEy;
    end    
else
    disp('Error: Invalid Field Polarization. It must be Ex or Ey.');
    fieldSpectrum3D = [];
    return;
end
end

