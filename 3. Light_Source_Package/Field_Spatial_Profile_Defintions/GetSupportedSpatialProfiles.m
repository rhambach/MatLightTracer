function [ fullNames,dispNames ] = getSupportedSpatialProfiles(index)
    %GETSUPPORTEDSPATIALPROFILES Summary of this function goes here
    %   Detailed explanation goes here
    fullNames = {'PlaneWaveProfile','GaussianWaveProfile'};
    dispNames = {'Plane Wave Profile','Gaussian Wave Profile'};
    
    if nargin == 0
        
    elseif index ~= 0
        fullNames = fullNames{index};
        dispNames = dispNames{index};
    end
end