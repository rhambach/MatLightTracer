function [ gaussianBeamSet ] = fromQParametersToGaussianBeamSet( qxArray,qyArray,centralRayArray,localXDirectionMatrix,localYDirectionMatrix )
%FROMQPARAMETERSTOGAUSSIANBEAM Compute the gaussian beam from its complex q
% parameters        
% The code is also vectorized. The gaussian beam array could be computed
% from multiple inputs.
% qxArray,qyArray,centralRayArray: Size 1xN for N gaussian beams
% localXDirectionMatrix,localYDirectionMatrix: Size 3xN for N gaussian beams

% all  inputs are supposed to be of the same size
wavLen = [centralRayArray.Wavelength];
distanceFromWaistInX = -real(qxArray);
distanceFromWaistInY = -real(qyArray);
if distanceFromWaistInX ~= distanceFromWaistInY
    disp(['Error: Waist shall be at the same position for both x and y ',...
        'directions. That is -real(qx) == -real(qy) ']);
    gaussianBeamSet = NaN;
    return;
else
    distanceFromWaist = distanceFromWaistInY;
end

invalidWaistPositionIndices = (distanceFromWaistInX ~= distanceFromWaistInY);
distanceFromWaist = distanceFromWaistInY;
waistRadiusInX = sqrt(-wavLen./(pi*imag(1./qxArray)));
waistRadiusInY = sqrt(-wavLen./(pi*imag(1./qyArray)));
peakAmplitude = 1;
gaussianBeamSet = ScalarGaussianBeamSet(centralRayArray,waistRadiusInX,waistRadiusInY,...
    distanceFromWaist,peakAmplitude,localXDirectionMatrix,localYDirectionMatrix);
gaussianBeamSet(invalidWaistPositionIndices) = NaN;

% gaussianBeamArray.CentralRay = centralRayArray;
% gaussianBeamArray.LocalXDirection = localXDirectionMatrix;
% gaussianBeamArray.LocalYDirection = localYDirectionMatrix;
% gaussianBeamArray.WaistRadiusInX = waistRadiusInX;
% gaussianBeamArray.WaistRadiusInY = waistRadiusInY;
% gaussianBeamArray.DistanceFromWaist = distanceFromWaist;
% gaussianBeam.DistanceFromWaistInY = distanceFromWaistInY;

end

