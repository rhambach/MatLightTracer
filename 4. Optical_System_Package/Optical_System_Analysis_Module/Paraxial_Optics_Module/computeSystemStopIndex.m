function [ stopIndex,stopClearAperture] = computeSystemStopIndex(optSystem,givenStopIndex)
% computeSystemStopIndex: calculate the stop index
% the stop index may be given directly by the user
% Inputs
% 	givenStopIndex: Stop index if specified by user otherwise = 0
% Output
% 	stopIndex: surface index of stop surface.
% <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%

% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%

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

% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

% send pseudo mariginal ray from oxial point at object

% if the stop surface is fixed by the user
if givenStopIndex
    stopIndex = givenStopIndex;
    stopClearAperture = optSystem.NonDummySurfaceArray(stopIndex).getClearAperture;
else
    if abs(optSystem.SurfaceArray(1).Thickness)>10^10 || optSystem.ObjectAfocal
        obj = 'I';
    else
        obj = 'F';
    end
    if optSystem.ImageAfocal
        img = 'I';
    else
        img = 'F';
    end
    obj_img = [obj, img];
    
    if strcmpi(obj_img,'IF') || strcmpi(obj_img,'II')
        % for object side afocal systems (object from infinity)
        ytm = 0.01;
        utm = 0;
    else
        % assume object surface at origin of the coordinate system
        ytm = 0;
        utm = 0.01;
    end

    nsurf = optSystem.NumberOfNonDummySurfaces; % number of surfaces including object and image
    
    clearAperture = zeros(1,nsurf);
    CAy  = zeros(1,nsurf);
    clearAperture(1) =  optSystem.NonDummySurfaceArray(1).getClearAperture;
    % compute clear aperture to height ratio for each surface
    CAy(1) = abs((clearAperture(1))/(ytm));
    for kk=1:1:nsurf-1
        clearAperture(kk+1) = optSystem.NonDummySurfaceArray(kk+1).getClearAperture;
        initialSurf = kk;
        finalSurf = kk+1;
        wavlenInM = optSystem.getPrimaryWavelength;
        [ ytm,utm ] = paraxialRayTracer( optSystem,ytm,utm,initialSurf,finalSurf,wavlenInM);
        % 		  [ytm,utm]=yniTrace(ytm,utm,kk,kk+1, refIndex,thick,curv);
        CAy(kk+1) = abs((clearAperture(kk+1))/(ytm));
    end
    % the surface with minimum value of clear aperture to height ratio is the stop
    [C,I] = min(CAy);
    stopIndex = I;
    stopClearAperture = optSystem.NonDummySurfaceArray(stopIndex).getClearAperture;
end
end
