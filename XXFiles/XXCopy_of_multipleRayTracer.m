function [multipleRayTracerResult,pupilMeshGrid,outsidePupilIndices ] = ...
        multipleRayTracer(optSystem,wavLenInWavUnit,fieldPointXYInLensUnit,nRay1,nRay2,...
        pupSamplingType,jonesVector,considerSurfAperture,...
        recordIntermediateResults) %
    % Trace bundle of rays through an optical system based on the pupil 
    % sampling specified. Multiple rays can be defined with wavLenInWavUnit (1XnWav),
    % fieldPointXYInLensUnit (2XnField) and the total number of ray will be nRay*nWav*nField
    % That is all rays from each field point with each of wavelegths will be
    % traced. And the result will be 4 dimensional matrix (nNonDummySurface X nRay X nField X nWav). 

    
	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    % Jan 18,2014   Worku, Norman G.     Vectorized version
    
	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    % Deafault inputs
    if nargin < 1
        disp('Error: The function multipleRayTracer needs atleast optical system');
        return;
    elseif nargin == 1
        % Take all field points and primary wavelength   
        nField = optSystem.NumberOfFieldPoints;
        fieldPointMatrix = optSystem.FieldPointMatrix;
        fieldPointXYInLensUnit = (fieldPointMatrix(:,1:2))';
        wavLenInWavUnit = repmat(getPrimaryWavelength(optSystem)/getWavelengthUnitFactor(optSystem),[1,nField]);

        nRay1 = 3;
        nRay2 = 3;
        pupSamplingType = 'Cartesian';
        jonesVector = [NaN;NaN];
        considerSurfAperture = 1;        
        recordIntermediateResults = 1;
    elseif nargin == 2 
        % Take all field points and given wavelength   
        nField = optSystem.NumberOfFieldPoints;
        fieldPointMatrix = optSystem.FieldPointMatrix;
        fieldPointXYInLensUnit = (fieldPointMatrix(:,1:2))';
        wavLenInWavUnit = repmat(wavLenInWavUnit(1),[1,nField]);
        
        nRay1 = 3;
        nRay2 = 3;
        pupSamplingType ='Cartesian';
        jonesVector = [NaN;NaN];
        considerSurfAperture = 1;  
        recordIntermediateResults = 1;
    elseif nargin == 3
        nRay1 = 3;
        nRay2 = 3;
        pupSamplingType ='Cartesian';
        jonesVector = [NaN;NaN];
        considerSurfAperture = 1;  
        recordIntermediateResults = 1;
     elseif nargin == 4
        nRay2 = 3;
        pupSamplingType ='Cartesian';
        jonesVector = [NaN;NaN];
        considerSurfAperture = 1;
        recordIntermediateResults = 1;
    elseif nargin == 5
        pupSamplingType ='Cartesian';
        jonesVector = [NaN;NaN];
        considerSurfAperture = 1;  
        recordIntermediateResults = 1;
    elseif nargin == 6
        jonesVector = [NaN;NaN];
        considerSurfAperture = 1; 
        recordIntermediateResults = 1;
    elseif nargin == 7
        considerSurfAperture = 1; 
        recordIntermediateResults = 1;
    elseif nargin == 8
        recordIntermediateResults = 1;
    end
    
    tic
    
    if isnan(jonesVector(1))
        polarized = 0;
    else
        polarized = 1;
    end

    nSurface = optSystem.NumberOfSurfaces;
    NonDummySurfaceArray =  optSystem.NonDummySurfaceArray ;
    nNonDummySurface = optSystem.NumberOfNonDummySurfaces;
    
    %% Compute initial ray bundle parameters
    pupilShape = 'Circular';
    nField = size(fieldPointXYInLensUnit,2);
    nWav  = size(wavLenInWavUnit,2);
    
    [ initialRayBundle, pupilSamplingPoints,pupilMeshGrid,...
     outsidePupilIndices   ] = ...
    computeInitialRayArray( optSystem, wavLenInWavUnit,...
    fieldPointXYInLensUnit, nRay1,nRay2,pupSamplingType,polarized,jonesVector);
    nRayTotal = size(pupilSamplingPoints,2);
  
    %===============RAYTRACE For Bundle of Ray========================
    rayTraceResult = rayTracer(optSystem,initialRayBundle,considerSurfAperture,recordIntermediateResults); 
    if recordIntermediateResults
        multipleRayTracerResult = reshape(rayTraceResult,[nNonDummySurface,nRayTotal,nField,nWav]); %(nNonDummySurface X nRay X nField X nWav)
    else
        multipleRayTracerResult = reshape(rayTraceResult,[1,nRayTotal,nField,nWav]); %(1 X nRay X nField X nWav)
    end
    pupilCoordinates = pupilSamplingPoints;
    timeElapsed =  toc;
    disp(['Ray Bundle Trace Completed. Polarized  = ',num2str(polarized), ...
        ', Total Number  = ', num2str(nRayTotal*nField*nWav), ', Time Elapsed = ', ...
        num2str(timeElapsed)]); 
end  