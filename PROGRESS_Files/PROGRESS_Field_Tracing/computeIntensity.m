function [ intE ] = computeIntensity( complexE )
%COMPUTEINTENSITY returns the intensity of the complex amplitude function
     intE = (abs(complexE)).^2;
end

