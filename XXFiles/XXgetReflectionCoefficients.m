function  [ampRs,ampRp,powRs,powRp,JonesRefMatrix] = getReflectionCoefficients...
    (coating,wavLenInUm,incAngle,ns,nc,primaryWavelengthInUm)
% Computes the amplitude and power coefficients of reflection using
% general Fresnel's equations
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

% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>    nRayAngle = size(incAngle,2);
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
        ampRs = repmat(1,[1,nRay]);
        ampRp = repmat(1,[1,nRay]);
        powRs = repmat(1,[1,nRay]);
        powRp = repmat(1,[1,nRay]);
        
        JonesRefMatrix(1,1,:) = ampRs; JonesRefMatrix(1,2,:) = 0;
        JonesRefMatrix(2,1,:) = 0; JonesRefMatrix(2,2,:) = ampRp;
        
    case 'BareGlass'
        % No layer means empty permitivity profile
        refIndex = [];
        thickness = [];
        % Compute general Fresnels Coefficients using Matrix
        % Method for multilayer layer
        [Ts,Rs,tau_s,rho_s] = computeMultilayerFresnelsCoefficients...
            (refIndex,thickness,'TE',wavLenInUm,incAngle,ns,nc);
        [Tp,Rp,tau_p,rho_p] = computeMultilayerFresnelsCoefficients...
            (refIndex,thickness,'TM',wavLenInUm,incAngle,ns,nc);
        
        % return fresnel coeff.
        ampRs = Rs;
        ampRp = Rp;
        powRs = rho_s;
        powRp = rho_p;
        
        JonesRefMatrix(1,1,:) = ampRs; JonesRefMatrix(1,2,:) = 0;
        JonesRefMatrix(2,1,:) = 0; JonesRefMatrix(2,2,:) = ampRp;        
    case 'JonesMatrix'        
        % Amp reflection for each polarization given directly
        refMatrix = coating.CoatingParameters.TransmissionMatrix;        
        Rs = refMatrix(1,1);
        Rp = refMatrix(2,2);
        
        % new code
        % return fresnel coeff.
        ampRs = repmat(Rs,[1,nRay]);
        ampRp = repmat(Rp,[1,nRay]);
        
        % Compute power coefficnets        
        powRs = (abs(ampRs)).^2;
        powRp = (abs(ampRp)).^2;        
        JonesRefMatrix = repmat(refMatrix,[1,1,nRay]);
    case 'Multilayer'
        
        [refIndexAll,thicknessAll] = getRefractiveIndexThicknessTable...
            (coating,wavLenInUm);
        
        if isempty(refIndexAll) || isempty(thicknessAll)
            refIndexAll = [];
            thicknessAll = [];
        end
        
        % Compute general Fresnels Coefficients using Matrix
        % Method for multilayer layer
        [Ts,Rs,tau_s,rho_s]=computeMultilayerFresnelsCoefficients...
            (refIndexAll,thicknessAll,'TE',wavLenInUm,incAngle,ns,nc);
        [Tp,Rp,tau_p,rho_p]=computeMultilayerFresnelsCoefficients...
            (refIndexAll,thicknessAll,'TM',wavLenInUm,incAngle,ns,nc);
        
        % return fresnel coeff.
        ampRs = Rs;
        ampRp = Rp;
        powRs = rho_s;
        powRp = rho_p;
        JonesRefMatrix(1,1,:) = ampRs; JonesRefMatrix(1,2,:) = 0;
        JonesRefMatrix(2,1,:) = 0; JonesRefMatrix(2,2,:) = ampRp;        
    otherwise
        disp('Error: Invalid coating type. So it is ignored');
        ampRs = repmat(1,[1,nRay]);
        ampRp = repmat(1,[1,nRay]);
        powRs = repmat(1,[1,nRay]);
        powRp = repmat(1,[1,nRay]);
        JonesRefMatrix(1,1,:) = ampRs; JonesRefMatrix(1,2,:) = 0;
        JonesRefMatrix(2,1,:) = 0; JonesRefMatrix(2,2,:) = ampRp;
        return;
end
end
