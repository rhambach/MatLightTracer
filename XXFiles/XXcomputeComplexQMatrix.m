function [ QMatrix ] = computeComplexQMatrix(gaussianPulsedBeam, spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI,wavelengthInSI )
%COMPUTECOMPLEXQMATRIX Computes the complex Q Matrix from given gaussian pulse
%parameters. Assume no initial spatio temporal coupling
% Ref used: Akturk General theory of first order spatiotemporal distortion

    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %   Part of the RAYTRACE_TOOLBOX
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Nov 17,2014   Worku, Norman G.     Original Version       
    
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Qxx = -1i*pi/(wavelengthInSI*radiusOfCurvatureInSI) - 1/(spatialWidthInSI)^2;
Qtt = -1i*(initialChirpInSI) + 1/(temporalWidthInSI)^2;
Qxt = 0;
Qtx = 0;
QMatrix = 1i*(wavelengthInSI/pi)*inv([Qxx,Qxt;Qtx,Qtt]);
end

