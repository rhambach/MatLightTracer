function [ outputGaussianBeamArray ] = gaussianBeamTracer( optSystem,initialGaussianBeamArray)
%GAUSSIANBEAMTRACER Traces gaussian beam from 2nd surface to image surface
% and returns the output gaussian beam array at image surface.
% initialGaussianBeamArray = array of ScalarGaussianBeam objects
% Intermediate surface results are not neccessary and hence are not recorded
% The code is also vectorized. Multiple inputs and outputs are possible.

    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %   Part of the RAYTRACE_TOOLBOX
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Nov 07,2014   Worku, Norman G.     Original Version       
    
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
if nargin == 0
    disp('Error: The function gaussianBeamTracer needs atleast the optical system object.');
    outputGaussianBeamArray = NaN;
    return
elseif nargin == 1
    % defaults gaussian: waist size of 0.05 lens units and
    % surface 1 to waist distance of zero; Field index = 1; wavlength index
    % = 1;
    lensUnitFactor = optSystem.getLensUnitFactor;
    
    initialGaussianBeamArray = ScalarGaussianBeam; 
    % Take the central ray as chief ray from 1st field point and primary
    % wavelength
    fieldIndex = 1;
    switch lower(optSystem.FieldType)
        case lower('ObjectHeight')
            % Convert the values from lens unit to meter
            fieldPointXYInSI =((optSystem.FieldPointMatrix(fieldIndex,1:2))')*...
                optSystem.getLensUnitFactor;
        case lower('Angle')
            % Leave in degrees
            fieldPointXYInSI = ((optSystem.FieldPointMatrix(fieldIndex,1:2))');
    end
    wavelengthInSI = optSystem.getPrimaryWavelength;
    
    initialGaussianBeamArray.CentralRay =  optSystem.getChiefRay(fieldPointXYInSI,wavelengthInSI);
    initialGaussianBeamArray.WaistRadiusInX = 0.05*lensUnitFactor;
    initialGaussianBeamArray.WaistRadiusInY = 0.05*lensUnitFactor;
    initialGaussianBeamArray.DistanceFromWaist = 0*lensUnitFactor;
else
end

recordRayTraceResults = 0;
startSurface = 2;
endSurface = optSystem.NumberOfSurfaces;
nSurface = optSystem.NumberOfSurfaces;
nNonDummySurface = optSystem.NumberOfNonDummySurfaces;
NonDummySurfaceArray = optSystem.NonDummySurfaceArray;
NonDummySurfaceIndices = optSystem.NonDummySurfaceIndices;

surfIndicesAfterStartSurface = find(NonDummySurfaceIndices>=startSurface);
startNonDummyIndex = surfIndicesAfterStartSurface(1);
surfIndicesBeforeEndSurface = find(NonDummySurfaceIndices<=endSurface);
endNonDummyIndex = surfIndicesBeforeEndSurface(end);
lensUnitFactor = optSystem.getLensUnitFactor;

if NonDummySurfaceArray(1).Thickness > 10^10
    objectThickness = 0;
else
    objectThickness = NonDummySurfaceArray(1).Thickness*lensUnitFactor;
end


% Extract the intial beam parameters from all initial beams
waistX = [initialGaussianBeamArray.WaistRadiusInX];
waistY = [initialGaussianBeamArray.WaistRadiusInY];
distanceFromWaist = [initialGaussianBeamArray.DistanceFromWaist];
centralRay = [initialGaussianBeamArray.CentralRay];
considerSurfAperture = 1;

% All rays in [waist x ; waist y; divergence x; divergence y]
[waistAndDivergenceRaysAtObjectSurface] = ...
    getWaistAndDivergenceRaysAtObjectSurface(initialGaussianBeamArray,objectThickness);
considerSurfAperture = 1;
% Append the chief ray as the 5th ray
allFiveRays = [waistAndDivergenceRaysAtObjectSurface;centralRay];
% Change the 2D matrix of array to 1D vector as the ray tracer accepts 1D
% vector for the time being
allFiveRaysInArray = allFiveRays(:);
allRaysTraceResult = rayTracer(optSystem,...
    allFiveRaysInArray,considerSurfAperture,recordRayTraceResults);

% calculate gaussian beam parameters

wavelength = [centralRay.Wavelength];
waistRayXIntersection = [allRaysTraceResult(end,1:5:end).RayIntersectionPoint];
waistRayYIntersection = [allRaysTraceResult(end,2:5:end).RayIntersectionPoint];
divergenceRayXIntersection = [allRaysTraceResult(end,3:5:end).RayIntersectionPoint];
divergenceRayYIntersection = [allRaysTraceResult(end,4:5:end).RayIntersectionPoint];
centralRayIntersection = [allRaysTraceResult(end,5:5:end).RayIntersectionPoint]; 

waistRayXDirection = [allRaysTraceResult(end,1:5:end).ExitRayDirection];
waistRayYDirection = [allRaysTraceResult(end,2:5:end).ExitRayDirection];
divergenceRayXDirection = [allRaysTraceResult(end,3:5:end).ExitRayDirection];
divergenceRayYDirection = [allRaysTraceResult(end,4:5:end).ExitRayDirection];
centralRayDirection = [allRaysTraceResult(end,5:5:end).ExitRayDirection];

refractiveIndices = [allRaysTraceResult(end,5:5:end).RefractiveIndex];

% transform the 3d ray data to 2d
localXDirection = [1;0;0];
localYDirection = [0;1;0];
[ heightOfDivergenceRayInX,angleOfDivergenceRayInX ] = transform3DRayDataTo2DCoordinate( ...
    centralRayDirection,centralRayIntersection,divergenceRayXDirection,divergenceRayXIntersection,...
    centralRayIntersection,localXDirection,localYDirection);
[ heightOfDivergenceRayInY,angleOfDivergenceRayInY ] = transform3DRayDataTo2DCoordinate( ...
    centralRayDirection,centralRayIntersection,divergenceRayYDirection,divergenceRayYIntersection,...
    centralRayIntersection,localXDirection,localYDirection);

[ heightOfWaistRayInX,angleOfWaistRayInX ] = transform3DRayDataTo2DCoordinate( ...
    centralRayDirection,centralRayIntersection,waistRayXDirection,waistRayXIntersection,...
    centralRayIntersection,localXDirection,localYDirection);
[ heightOfWaistRayInY,angleOfWaistRayInY ] = transform3DRayDataTo2DCoordinate( ...
    centralRayDirection,centralRayIntersection,waistRayYDirection,waistRayYIntersection,...
    centralRayIntersection,localXDirection,localYDirection);

heightOfDivergenceRayInX = heightOfDivergenceRayInX(1,:);
heightOfDivergenceRayInY = heightOfDivergenceRayInY(2,:);
heightOfWaistRayInX = heightOfWaistRayInX(1,:);
heightOfWaistRayInY = heightOfWaistRayInY(2,:);
angleOfDivergenceRayInX = angleOfDivergenceRayInX(1,:);
angleOfDivergenceRayInY = angleOfDivergenceRayInY(2,:);
angleOfWaistRayInX = angleOfWaistRayInX(1,:);
angleOfWaistRayInY = angleOfWaistRayInY(2,:);

sizeX = sqrt(heightOfWaistRayInX.^2+heightOfDivergenceRayInX.^2);
sizeY = sqrt(heightOfWaistRayInY.^2+heightOfDivergenceRayInY.^2);

wiastX = (heightOfWaistRayInX.*angleOfDivergenceRayInX - ...
    angleOfWaistRayInX.*heightOfDivergenceRayInX)./...
    sqrt(angleOfWaistRayInX.^2+angleOfDivergenceRayInX.^2);
wiastY = (heightOfWaistRayInY.*angleOfDivergenceRayInY - ...
    angleOfWaistRayInY.*heightOfDivergenceRayInY)./...
    sqrt(angleOfWaistRayInY.^2+angleOfDivergenceRayInY.^2);

positionX = (heightOfDivergenceRayInX.*angleOfDivergenceRayInX + ...
    heightOfWaistRayInX.*angleOfWaistRayInX)./...
    (angleOfWaistRayInX.^2+angleOfDivergenceRayInX.^2);
positionY = (heightOfDivergenceRayInY.*angleOfDivergenceRayInY + ...
    heightOfWaistRayInY.*angleOfWaistRayInY)./...
    (angleOfWaistRayInY.^2+angleOfDivergenceRayInY.^2);
% 
% rayleighX = ((pi*(wiastX*optSystem.getLensUnitFactor).^2)./...
%     (wavelength./refractiveIndices))/optSystem.getLensUnitFactor;
% rayleighY = ((pi*(wiastY*optSystem.getLensUnitFactor).^2)./...
%     (wavelength./refractiveIndices))/optSystem.getLensUnitFactor;
% 
% radiusX = positionX.*(1+(rayleighX./positionX).^2);
% radiusY = positionY.*(1+(rayleighY./positionY).^2);
% 
% divAngleX = atan(wiastX./rayleighX);
% divAngleY = atan(wiastY./rayleighY);
end

