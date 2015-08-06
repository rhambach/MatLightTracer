classdef GaussianPulse
    % GaussianPulse class:
    %   To represent all scalar (with no polarization) gaussian pulsed beam objects
    %   The class supports constructors to construct an array of gaussian pulsed beam
    %   objects from array of its properties.
    % Properties (All are scaled to Unit of distance = mm and unit of time = fs)
    %     QInverseMatrix         % 2 X 2 X N 3D Matrix
    %     CentralWavelength % 1X N In meter
    
    
    % Methods:
    % No methods yet defined for this class
    
    % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
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
    properties
        QInverseMatrix          % 2 X 2 X N 3D Matrix
        CentralWavelength % 1X N In meter
        Direction % 3 X N diretion cosines
    end
    
    methods
        function NewGaussianPulse = GaussianPulse(pulseParameterInSI,centralWavelengthInSI,direction)
            if nargin == 0
                % Empty constructor
                % Default values remember all width are 1/e widths and not
                % FWHM
                spatialWidthInSI = 2*10^-3;    % 2 mm
                radiusOfCurvatureInSI = Inf;   % Beam at its waist
                temporalWidthInSI = 70*10^-15; % 70 fs
                initialChirpInSI = 0;          % No chirp
                centralWavelengthInSI = 800 * 10^-9;  % 800 nm
                
                [ complexQInverseMatrix ] = computeComplexQInverseMatrix( spatialWidthInSI,...
                    radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI,centralWavelengthInSI );
                NewGaussianPulse.QInverseMatrix = complexQInverseMatrix;
                NewGaussianPulse.CentralWavelength = centralWavelengthInSI;
                NewGaussianPulse.Direction = [0,0,1]';
                return;
            elseif nargin == 1
                centralWavelengthInSI = 800 * 10^-9;  % 800 nm
                direction = [0,0,1]';
            elseif nargin == 2
                direction = [0,0,1]';                
            else
            end
            
            
            
            % The complexQInverseMatrix could be given direclty or it could be
            % given as vector [spatialWidthInSI;radiusOfCurvatureInSI;...
            %                  temporalWidthInSI;initialChirpInSI]
            % Indetify the sizes
            if size(pulseParameterInSI,1) == 2 && size(pulseParameterInSI,2) == 2
                % 2x2 matrix given
                complexQInverseMatrix = pulseParameterInSI;
            elseif size(pulseParameterInSI,1) == 4 && size(pulseParameterInSI,2) == 1
                % Vector of the gaussian pulse beam parameters given
                [ complexQInverseMatrix ] = computeComplexQInverseMatrix( pulseParameterInSI(1,:),...
                    pulseParameterInSI(2,:),pulseParameterInSI(3,:),...
                    pulseParameterInSI(4,:),centralWavelengthInSI );
            end
            nDir = size(direction,2);
            nWav = size(centralWavelengthInSI,2);
            nQInverseMatrix = size(complexQInverseMatrix,3);
            nMax = max([nWav, nQInverseMatrix]);
            if nDir < nMax
                direction = cat(2,direction,repmat(direction(:,end),[1,nMax-nDir]));            
            end
            if nWav < nMax
                centralWavelengthInSI = cat(2,centralWavelengthInSI,repmat(centralWavelengthInSI(:,end),[1,nMax-nWav]));
            end
            if nQInverseMatrix < nMax
                complexQInverseMatrix= cat(3,complexQInverseMatrix,repmat(complexQInverseMatrix(:,:,end),[1,1,nMax-nQInverseMatrix]));
            end
            % Preallocate object array
            NewGaussianPulse(nMax) = GaussianPulse;
            for kk = 1:nMax
                NewGaussianPulse(kk).QInverseMatrix = complexQInverseMatrix(:,:,kk);
                NewGaussianPulse(kk).CentralWavelength = centralWavelengthInSI(1,kk);
                NewGaussianPulse(kk).Direction = direction(:,kk);
            end
        end
    end
    
end
function [ QInverseMatrix ] = computeComplexQInverseMatrix( spatialWidthInSI,radiusOfCurvatureInSI,temporalWidthInSI,initialChirpInSI,wavelengthInSI )
%computeComplexQInverseMatrix Computes the complex Q inverse Matrix from given gaussian pulse
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

Qinv11 = (1/(radiusOfCurvatureInSI) - 1i*wavelengthInSI/(pi*(spatialWidthInSI)^2)); % 1/m
Qinv22 = ((wavelengthInSI/pi)*(initialChirpInSI + 1i* 1/(temporalWidthInSI)^2)); %1/s
Qinv12 = 0;
Qinv21 = 0;
QInverseMatrix = ([Qinv11,Qinv12;Qinv21,Qinv22]);
end


