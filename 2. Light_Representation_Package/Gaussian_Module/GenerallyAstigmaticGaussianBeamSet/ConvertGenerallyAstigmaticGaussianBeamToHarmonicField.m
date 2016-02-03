function [ newHarmonicField ] = ConvertGenerallyAstigmaticGaussianBeamToHarmonicField( ...
        generallyAstigmaticGaussianBeamSet,Nx,Ny,windowSizeX,windowSizeY )
    %CONVERTGENERALLYASTIGMATICGAUSSIANTOHARMONICFIELD Assume the gaussian
    %beam parameters are all given on the plane perpendicular to the
    %central ray.
    
    wavelen = generallyAstigmaticGaussianBeamSet.Wavelength;
    centralRayPosition = generallyAstigmaticGaussianBeamSet.CentralRayPosition;
    centralRayDirection = generallyAstigmaticGaussianBeamSet.CentralRayDirection;
    domain = 1;% 1 for Spatial domain, and 2 for spatial frequency
    sampDistX = windowSizeX/(Nx-1);
    sampDistY = windowSizeY/(Ny-1);
    xlin = linspace(-0.5*windowSizeX,0.5*windowSizeX,Nx);
    ylin = linspace(-0.5*windowSizeY,0.5*windowSizeY,Ny);
    [X,Y] = meshgrid(xlin,ylin);
    
    % Use the vectorial formula given in the
    % Vector Formulation Of The Ray-Equivalent Method For General Gaussian Beam Propagation
    % Author(s): Alan W Greynolds
    % Date Published: 19 December 1986
    complexRay1Position = generallyAstigmaticGaussianBeamSet.ComplexRay1Position;
    complexRay2Position = generallyAstigmaticGaussianBeamSet.ComplexRay2Position;
    complexRay1Direction = generallyAstigmaticGaussianBeamSet.ComplexRay1Direction;
    complexRay2Direction = generallyAstigmaticGaussianBeamSet.ComplexRay2Direction;
    
    %     p1x = complexRay1Position(1,:);
    %     p1y = complexRay1Position(2,:);
    %     p2x = complexRay2Position(1,:);
    %     p2y = complexRay2Position(2,:);
    %
    %     d1x = complexRay1Direction(1,:);
    %     d1y = complexRay1Direction(2,:);
    %     d2x = complexRay2Direction(1,:);
    %     d2y = complexRay2Direction(2,:);
    
    p1x = complexRay1Position(1,:) - centralRayPosition(1,:);
    p1y = complexRay1Position(2,:) - centralRayPosition(2,:);
    p2x = complexRay2Position(1,:) - centralRayPosition(1,:);
    p2y = complexRay2Position(2,:) - centralRayPosition(2,:);
    
    complexRay1Direction_projected = complexRay1Direction-...
        (dot(complexRay1Direction,centralRayDirection))*centralRayDirection;
    complexRay2Direction_projected = complexRay2Direction-...
        (dot(complexRay2Direction,centralRayDirection))*centralRayDirection;
    d1x = complexRay1Direction_projected(1,:)/(sqrt(sum((abs(complexRay1Direction_projected)).^2)));
    d1y = complexRay1Direction_projected(2,:)/(sqrt(sum((abs(complexRay1Direction_projected)).^2)));
    d2x = complexRay2Direction_projected(1,:)/(sqrt(sum((abs(complexRay2Direction_projected)).^2)));
    d2y = complexRay2Direction_projected(2,:)/(sqrt(sum((abs(complexRay2Direction_projected)).^2)));
    
    %         d1x = complexRay1Direction(1,:);
    %     d1y = complexRay1Direction(2,:);
    %     d2x = complexRay2Direction(1,:);
    %     d2y = complexRay2Direction(2,:);
    
    %  d1x = 1;d1y = 0;d2x = 0;d2y = 1;
    
    E00 = 1;
    p1_cross_p2 = p1x*p2y-p1y*p2x;
    p1_cross_r = p1x*Y-p1y*X;
    p2_cross_r = p2x*Y-p2y*X;
    d1_dot_r = d1x*X + d1y*Y;
    d2_dot_r = d2x*X + d2y*Y;
    k = 2*pi/wavelen;
    ampCoeff =(E00/sqrt(p1_cross_p2));
    ampCoeff = 1;
    
    Ex = ampCoeff*exp(-1i*k*((p1_cross_r.*d2_dot_r - p2_cross_r.*d1_dot_r)/(2*p1_cross_p2)));
    
    Ey = Ex*0;
    
    newHarmonicField = HarmonicFieldSet(Ex,Ey,sampDistX,sampDistY,wavelen,centralRayPosition(1:2,:),centralRayDirection,domain);
end

