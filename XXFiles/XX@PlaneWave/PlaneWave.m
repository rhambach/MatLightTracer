classdef PlaneWave
    %PLANEWAVE is field defined in spatial domain with a given wavelength
    %and propagating in a given direction
    
    properties
%         Domain % 1: E(x,y,omega) 2: E(kx,ky,omega), 3: E(x,y,t), 4: E(kx,ky,t)
        ComplexAmplitude % NxMx2 for Ex and Ey component
        SamplingDistance % 1x2 for sampling distance in x and y in meter 
%         for Domain  or kx and ky in 1/m 
        Direction % 1x3 direction cosine of the plane wave
        Wavelength % wavelength in meter
    end
    
    methods
        function newPlaneWave = PlaneWave(Ex,Ey,sampDistX,sampDistY,dir,wavelen)
            if nargin == 0
                N = 65;
                Ex = zeros(N,N);
                Ex(24:40,24:40) = 1;
                Ey = zeros(N,N);
                d = (2*10^-3)/N;
                sampDistX = d;
                sampDistY = d;
                dir = [0;0;1];
                wavelen = 0.55*10^-6;
            elseif nargin < 6
                disp('Error: You need to enter all input parameters or nothing.');
                newPlaneWave = PlaneWave;
                return;
            else
                if (size(Ex,1)~= size(Ey,1))||(size(Ex,2)~= size(Ey,2))
                    disp('Error: Sizes of Ex and Ey must be the same');
                    return;
                end
            end
            
            % Make the field size ODD in both side (zero padding to the
            % right and bottom of the matrices)
            nPoints1Ex = size(Ex,1);
            nPoints2Ex = size(Ex,2);
            nPoints1Ey = size(Ey,1);
            nPoints2Ey = size(Ey,2);
            
            if (nPoints1Ex == nPoints1Ey)&&(nPoints2Ex == nPoints2Ey)
                nPoints1 = nPoints1Ex;
                nPoints2 = nPoints2Ex;
            else
                disp('Error: Ex and Ey must be of the same size');
                return;
            end
            
            if ~mod(nPoints1,2)
                nPoints1 = nPoints1 + 1;
                Ex = [Ex,zeros(nPoints2,1)];
                Ey = [Ey,zeros(nPoints2,1)];
            end
            if ~mod(nPoints2,2)
                nPoints2 = nPoints2 + 1;
                Ex = [Ex;zeros(1,nPoints1)];
                Ey = [Ey;zeros(1,nPoints1)];
            end            
            newPlaneWave.ComplexAmplitude = cat(3,Ex,Ey);
            newPlaneWave.SamplingDistance = [sampDistX;sampDistY];
            newPlaneWave.Direction = dir;
            newPlaneWave.Wavelength = wavelen;
        end
        
        function [Ex,x_lin,y_lin] = computeEx(planeWave)
          Ex = planeWave.ComplexAmplitude(:,:,1);
          nx = size(Ex,1); 
          ny = size(Ex,2);
          dx = planeWave.SamplingDistance(1);
          dy = planeWave.SamplingDistance(2); 
          x_lin = [-(nx/2):1:((nx/2)-1)]*dx;
          y_lin = [-(ny/2):1:((ny/2)-1)]*dy;
        end 
        function [Ey,x_lin,y_lin] = computeEy(planeWave)
          Ey = planeWave.ComplexAmplitude(:,:,2);
          nx = size(Ex,1); 
          ny = size(Ex,2);
          dx = planeWave.SamplingDistance(1);
          dy = planeWave.SamplingDistance(2); 
          x_lin = [-(nx/2)*dx:dx:((nx/2)-1)*dx];
          y_lin = [-(ny/2)*dy:dy:((ny/2)-1)*dy];
        end       
        function [Ez,x_lin,y_lin] = computeEz(planeWave)
          disp('Erorr: computeEz not implemented yet.');
          Ez = NaN;
          x_lin = NaN;
          y_lin = NaN;
        end  
        
        function [Hx,X,Y] = computeHx(planeWave)
          disp('Erorr: computeHx not implemented yet.');
          Hx = NaN;
        end 
        function [Hy,X,Y] = computeHy(planeWave)
          disp('Erorr: computeHy not implemented yet.');
          Hy = NaN;
        end 
        function [Hz,X,Y] = computeHz(planeWave)
          disp('Erorr: computeHz not implemented yet.');
          Hz = NaN;
        end         
    end
    
end

