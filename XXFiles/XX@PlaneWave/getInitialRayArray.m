function [ initialRayArray,chiefRayIndex ] = getInitialRayArray( planeWave,initialZ )
%GETINITIALRAYARRAY Computes the initial ray positions and directions and
%returns the array of intial Ray objects
commonRayDirectionCosine = planeWave.Direction;
wavelength = planeWave.Wavelength;
nPoints1 = size(planeWave.ComplexAmplitude,1);
nPoints2 = size(planeWave.ComplexAmplitude,2);
dx = planeWave.SamplingDistance(1);
dy = planeWave.SamplingDistance(2);

% Make sure that the samplign points are odd so
% that one of the sampling point will go through origin
if ~mod(nPoints1,2)
    nPoints1 = nPoints1 + 1;
end
if ~mod(nPoints2,2)
    nPoints2 = nPoints2 + 1;
end
nPointsTotal = nPoints1*nPoints2;

nPointsX = nPoints1;
nPointsY = nPoints2;
if nPointsX == 1
    xgv = 0;
else
    xgv = [-floor(nPointsX/2)*dx:dx:floor(nPointsX/2)*dx];
end
if nPointsY == 1
    ygv = 0;
else
    ygv = [-floor(nPointsY/2)*dy:dy:floor(nPointsY/2)*dy];
end
[x,y] = meshgrid(xgv,ygv);

% Convert the mesh grid to 1D vector
xCoord = x(:);
yCoord = y(:);

initialPoints = [xCoord,yCoord,repmat(initialZ,nPointsTotal,1)]';

initialRayBundleDirections = repmat(commonRayDirectionCosine,[1,nPointsTotal]);
initialRayBundlePositions = initialPoints;

% Initialize initial ray bundle using constructor.
pos = initialRayBundlePositions;
dir = initialRayBundleDirections;
wav = repmat(wavelength,[1,nPointsTotal]);
% construct array of Ray objects
initialRayArray = ScalarRay(pos,dir,wav);

% Find cheif ray index
chiefRayIndices = find((xCoord).^2+(yCoord).^2==0);
% take first value in case of multiple ocuurances
chiefRayIndex = chiefRayIndices(1);
end

