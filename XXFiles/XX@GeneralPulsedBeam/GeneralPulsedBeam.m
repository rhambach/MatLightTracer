classdef GeneralPulsedBeam
    %GENERALPULSEDBEAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PlaneWaveArray % Array of monochromatic plane waves with spectral weight included
        Direction % Direction of the pulsed beam
        
        %         SpatialDistribution % X Y spatialAmplitude spatialPhase        
%         SpectralDistribution % wav spectralAmplitude spectralPhase
    end
    
    methods
        % constructor
         function NewGeneralPulsedBeam = GeneralPulsedBeam(arrayOfPlaneWaves,direction)
              if nargin == 0
                  arrayOfPlaneWaves =  PlaneWave;
                  direction = [0,0,1]';
              elseif nargin == 1
                  direction = [0,0,1]';
              else
                  
              end
              NewGeneralPulsedBeam.PlaneWaveArray = arrayOfPlaneWaves;
              NewGeneralPulsedBeam.Direction = direction;
         end
%         % constructor
%         function NewGeneralPulsedBeam = GeneralPulsedBeam(spatialDistribution,spectralDistribution)
%             if nargin == 0
%                 % just one point and one wavelength
%                 spatialDistribution = [0,0,1,0]';
%                 spectralDistribution = [0.55*10^-6,1,0]';
%             elseif nargin == 1
%                 %  one wavelength
%                 spectralDistribution = [0.55*10^-6,1,0]';
%             else
%                 
%             end
%             NewGeneralPulsedBeam.SpatialDistribution = spatialDistribution;
%             NewGeneralPulsedBeam.SpectralDistribution = spectralDistribution;
%         end
    end
    
end

