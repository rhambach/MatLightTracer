function [ allExIn3D,allEyIn3D,freq_vec ] = complexAmplitudeIn3D( harmonicFieldSet )
%COMPLEXAMPLITUDEIN3D % return Ex and Ey in 3D matrix with the 3rd dimension being the spectral dim

[ allExIn3D, freq_vec ] = computeFieldSpectrumIn3D( harmonicFieldSet,'Ex' );
[ allEyIn3D ] = computeFieldSpectrumIn3D( harmonicFieldSet,'Ey' );
end

