function [ allExIn3D,allEyIn3D,xMesh,yMesh,freq_vec ] = complexAmplitudeIn3D( harmonicFieldSet )
    %COMPLEXAMPLITUDEIN3D % return Ex and Ey in 3D matrix with the 3rd dimension being the spectral dim
    
    [ allExIn3D, x_lin,y_lin,freq_vec ] = computeTemporalFieldSpectrumIn3D( harmonicFieldSet,'Ex' );
    [ allEyIn3D ] = computeTemporalFieldSpectrumIn3D( harmonicFieldSet,'Ey' );
    [xMesh,yMesh] = meshgrid(x_lin,y_lin);
end

