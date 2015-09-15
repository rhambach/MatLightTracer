function [ semiMajorAxisIn3D,semiMinorAxisIn3D,directionIn3D,orientationAngleIn3D,...
        xMesh,yMesh ] = polarizationEllipseParametersIn3D( harmonicFieldSet,plane )
    %COMPLEXAMPLITUDEIN3D % return Ex and Ey in 3D matrix with the 3rd dimension being the spectral dim
    
    [ allExIn3D, x_lin,y_lin,freq_vec ] = computeTemporalFieldSpectrumIn3D( harmonicFieldSet,'Ex' );
    [ allEyIn3D ] = computeTemporalFieldSpectrumIn3D( harmonicFieldSet,'Ey' );
    [xMesh,yMesh] = meshgrid(x_lin,y_lin);
    
    % Initialize all returns to zero
    semiMajorAxisIn3D = allExIn3D*0;
    semiMinorAxisIn3D = allExIn3D*0;
    directionIn3D = allExIn3D*0;
    orientationAngleIn3D = allExIn3D*0;
    
    nFields = size(allExIn3D,3);
    Nx = size(allExIn3D,1);
    Ny = size(allExIn3D,2);
    if plane == 1 %strcmpi(plane,'XY')
        for kk = 1:nFields
            Ex = allExIn3D(:,:,kk);
            Ey = allEyIn3D(:,:,kk);
            % Convert to 1 D to make compatble with the function computing
            % polarization ellipse parameter( accepts 1XN vector) and
            % returns 4XN matrix of a,b,dir and angle
            Ex1D = (Ex(:))';
            Ey1D = (Ey(:))';
            ellipseParameter = convertJonesVectorToPolarizationEllipse( Ex1D,Ey1D );
            
            semiMajorAxisIn3D(:,:,kk) = reshape(ellipseParameter(1,:),Nx,Ny);
            semiMinorAxisIn3D(:,:,kk) = reshape(ellipseParameter(2,:),Nx,Ny);
            directionIn3D(:,:,kk) = reshape(ellipseParameter(3,:),Nx,Ny);
            orientationAngleIn3D(:,:,kk) = reshape(ellipseParameter(4,:),Nx,Ny);
        end
    else
        msgbox('Ez computaion is not supported at the momnet.');
        return;
    end
end

