function [ outHarmonicFieldSet ] = getHarmonicFieldSet( harmonicFieldSource )
    %GETHARMONICFIELDSET Summary of this function goes here
    %   Detailed explanation goes here
    
    [ sampDistX,sampDistY ] = getSamplingDistance( harmonicFieldSource);
    [ intensityVect, wavelengthVect, referenceWavelengthIndex ] = ...
        getPowerSpectrumProfile( harmonicFieldSource );
    [ U_xyTot,xlinTot,ylinTot] = getSpatialProfile( harmonicFieldSource );
    [ matrixOfJonesVector ] = getPolarizationProfile( harmonicFieldSource );

    center = harmonicFieldSource.LateralPosition;
    direction = getPrincipalDirection(harmonicFieldSource);
    % Construct array of harmonic fields
    nWav = length(wavelengthVect);
    wavelen = (wavelengthVect(:))';
    Ex = zeros([size(U_xyTot),nWav]);
    Ey = Ex;
    for kk = 1:nWav
        
        Ex(:,:,kk) = sqrt(intensityVect(kk))*matrixOfJonesVector(:,:,1).*U_xyTot;
        Ey(:,:,kk) = sqrt(intensityVect(kk))*matrixOfJonesVector(:,:,2).*U_xyTot;
    end
    
    refIndex = referenceWavelengthIndex;
    outHarmonicFieldSet = HarmonicFieldSet(Ex,Ey,sampDistX,sampDistY,wavelen,center,direction,refIndex);
end

