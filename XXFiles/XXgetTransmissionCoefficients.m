function [ampTs,ampTp,powTs,powTp,JonesTransMatrix] = getTransmissionCoefficients...
    (coating,wavLenInUm,incAngle,ns,nc,primaryWavelengthInUm)
% Computes the amplitude and power coefficients of
% transmission using general Fresnel's equations
% The function is vectorized so it can work on multiple sets of
% inputs once at the same time. i.e incAngle or wavLen becomes array)

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
% Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs

% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
nRayAngle = size(incAngle,2);
nRayWav = size(wavLenInUm,2);
if nRayAngle == 1
    nRay = nRayWav;
    incAngle = repmat(incAngle,[1,nRay]);
elseif nRayWav == 1
    nRay = nRayAngle;
    wavLenInUm = repmat(wavLenInUm,[1,nRay]);
elseif nRayAngle == nRayWav % Both wavLen and incAngle for all rays given
    nRay = nRayAngle;
else
    disp(['Error: The size of Incident Angle and Wavelength should '...
        'be equal or one of them should be 1.']);
    return;
end

epsilon_c = (nc).^2;
epsilon_s = (ns).^2;
switch  coating.Type
    case 'None'
        % return fresnel coeff.
        ampTs = repmat(1,[1,nRay]);
        ampTp = repmat(1,[1,nRay]);
        powTs = repmat(1,[1,nRay]);
        powTp = repmat(1,[1,nRay]);
        JonesTransMatrix(1,1,:) = ampTs; JonesTransMatrix(1,2,:) = 0;
        JonesTransMatrix(2,1,:) = 0; JonesTransMatrix(2,2,:) = ampTp;  
    case 'BareGlass'
        % No layer means empty permitivity profile
        refIndexAll = [];
        thicknessAll = [];
        % Compute general Fresnels Coefficients using Matrix
        % Method for multilayer layer
        [Ts,Rs,tau_s,rho_s] = computeMultilayerFresnelsCoefficients...
            (refIndexAll,thicknessAll,'TE',wavLenInUm,incAngle,ns,nc);
        [Tp,Rp,tau_p,rho_p] = computeMultilayerFresnelsCoefficients...
            (refIndexAll,thicknessAll,'TM',wavLenInUm,incAngle,ns,nc);
        
        % return fresnel coeff.
        ampTs = Ts;
        ampTp = Tp;
        powTs = tau_s;
        powTp = tau_p;  
        
        JonesTransMatrix(1,1,:) = ampTs; JonesTransMatrix(1,2,:) = 0;
        JonesTransMatrix(2,1,:) = 0; JonesTransMatrix(2,2,:) = ampTp;
    case 'JonesMatrix'
        % Amp trasmission for each polarization given directly
        transMatrix = coating.CoatingParameters.TransmissionMatrix;        
        Ts = transMatrix(1,1);
        Tp = transMatrix(2,2);
        
        % new code
        % return fresnel coeff.
        ampTs = repmat(Ts,[1,nRay]);
        ampTp = repmat(Tp,[1,nRay]);
        
        % Compute power coefficnets        
        % K vector in substrate
        ks = (2*pi./wavLenInUm).*ns; 
        ksx = ks.*sin((incAngle));
        % x component of K vector is the same for all layer
        kx=ksx;       
        % Z components of K vector in substrate and cladding
        ksz = sqrt((2*pi./wavLenInUm).^2.*epsilon_s - (kx).^2);
        kcz = sqrt((2*pi./wavLenInUm).^2.*epsilon_c - (kx).^2);
    

        powTs = (real(kcz).*(abs(ampTs)).^2)./(real(ksz));
        powTp = (real(kcz).*(abs(ampTp)).^2)./(real(ksz));        
        JonesTransMatrix = repmat(transMatrix,[1,1,nRay]);
    case 'Multilayer'
        % Assume coating is defined by its refractive index profile
        [refIndexAll,thicknessAll] = getRefractiveIndexThicknessTable(coating,wavLenInUm);
        
        if isempty(refIndexAll) || isempty(thicknessAll)
            refIndexAll = [];
            thicknessAll = [];
        end
        
        % Compute general Fresnels Coefficients using Matrix
        % Method for multilayer layer
        
        [Ts,Rs,tau_s,rho_s] = computeMultilayerFresnelsCoefficients...
            (refIndexAll,thicknessAll,'TE',wavLenInUm,incAngle,ns,nc);
        [Tp,Rp,tau_p,rho_p] = computeMultilayerFresnelsCoefficients...
            (refIndexAll,thicknessAll,'TM',wavLenInUm,incAngle,ns,nc);
        % return fresnel coeff.
        ampTs = Ts;
        ampTp = Tp;
        powTs = tau_s;
        powTp = tau_p;
        
        JonesTransMatrix(1,1,:) = ampTs; JonesTransMatrix(1,2,:) = 0;
        JonesTransMatrix(2,1,:) = 0; JonesTransMatrix(2,2,:) = ampTp;        
        
    otherwise
        disp('Error: Invalid coating type. So it is ignored');
        ampTs = repmat(1,[1,nRay]);
        ampTp = repmat(1,[1,nRay]);
        powTs = repmat(1,[1,nRay]);
        powTp = repmat(1,[1,nRay]);
        JonesTransMatrix(1,1,:) = ampTs; JonesTransMatrix(1,2,:) = 0;
        JonesTransMatrix(2,1,:) = 0; JonesTransMatrix(2,2,:) = ampTp;        
        return;        
        
end
end
