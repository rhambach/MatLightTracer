function [ refIndexAll,absoluteThicknessAll ] = getRefractiveIndexThicknessTable( coating,wavLenInUm )
%getRefractiveIndexThicknessTable: Returns a 2D matrix corresponding to the
% refractive index vs thickness (absolute in um) table of the coating.
% It also performs repeating the coating layers and reversing the
% order of the coating layers.

refIndexProfile = coating.CoatingParameters.RefractiveIndexProfile;
refIndex = (refIndexProfile(:,1));
relativeThicknessValue = (refIndexProfile(:,2));
relativeThicknessFlag = (refIndexProfile(:,3));

nRay = size(wavLenInUm,2);

% Compute the actual thickness for relative definition
% Change the thickness from relative value to absloute
% The actual thickness of the coating is determined by:
% d = (wavLen0/n0)*T
% where wavLen0 is the primary wavelength in micrometers ,
% n0 is the real part of the index of refraction of the coating at the
% primary wavelength, and T is the "optical thickness" of the coating
% specified in the coating definition.            
% Compute Refractive index for all rays (may have d/t wavelegnth).
% Currently this is ignored
refIndexAll = repmat(refIndex,[1,nRay]);
absoluteThicknessAll = repmat(relativeThicknessValue,[1,nRay]);
defaultWavLenInUm = coating.CoatingParameters.WavelengthInUm;
relativeThicknessIndices = find(relativeThicknessFlag);
if ~isempty(relativeThicknessIndices)
    T = absoluteThicknessAll(relativeThicknessIndices,:);
    wavLen0 = defaultWavLenInUm;
    % refractive index at primary wavelength. just take that for the 1st
    % wavelength.
    n0 = real(refIndexAll(relativeThicknessIndices,1));
    absoluteThicknessAll(relativeThicknessIndices,:) = (wavLen0/n0).*T;
end

% NB: At the moment all coating layers are assumed to have the same
% refractive index at all wavelengths (i.e. disperssion of caoting layers
% is ignored).

% Replicate the profile by given repetition number
refIndexAll = repmat(refIndexAll,...
    [coating.CoatingParameters.RepetetionNumber,1]);
absoluteThicknessAll = repmat(absoluteThicknessAll,...
    [coating.CoatingParameters.RepetetionNumber,1]);
% Flip the refIndex - thickness for inverted coating
if coating.CoatingParameters.UseInReverse
    refIndexAll = flipud(refIndexAll);
    absoluteThicknessAll = flipud(absoluteThicknessAll);
end

end

