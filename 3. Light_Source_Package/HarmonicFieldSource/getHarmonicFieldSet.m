function [ outHarmonicFieldSet ] = getHarmonicFieldSet( harmonicFieldSource )
    %GETHARMONICFIELDSET Summary of this function goes here
    %   Detailed explanation goes here
    
    samplingPoints = harmonicFieldSource.SamplingPoints;
    samplingDistance = harmonicFieldSource.SamplingDistance;
    
    [ intensityVect, wavelengthVect, referenceWavelengthIndex ] = ...
        getPowerSpectrumProfile( harmonicFieldSource );
    [ U_xyTot,xlinTot,ylinTot] = getSpatialProfile( harmonicFieldSource );
    [ matrixOfJonesVector ] = getPolarizationProfile( harmonicFieldSource );
    sampDistX = samplingDistance(1);
    sampDistY = samplingDistance(2);
    
    center = harmonicFieldSource.LateralPosition;
    direction = harmonicFieldSource.Direction;
    % Construct array of harmonic fields
    nWav = length(wavelengthVect);
    arrayOfHarmonicFields(nWav) = HarmonicField;
    for k = 1:nWav
        wavelen = wavelengthVect(k);
        Ex = sqrt(intensityVect(k))*matrixOfJonesVector(:,:,1).*U_xyTot;
        Ey = sqrt(intensityVect(k))*matrixOfJonesVector(:,:,2).*U_xyTot;
        arrayOfHarmonicFields(k) = HarmonicField(Ex,Ey,sampDistX,sampDistY,wavelen,center,direction);
    end
    
    refIndex = referenceWavelengthIndex;
    outHarmonicFieldSet = HarmonicFieldSet(arrayOfHarmonicFields,refIndex);
end

