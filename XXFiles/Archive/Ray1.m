classdef Ray1 
    % RAY class:
    %   To represent all polarized ray objects
    % Methods    
    %     Position % 1x3 position vector
    %     Direction % 1x3 Direction cosines
    %     Polarized % 1: for Polarized and 0: for not Polarized
    %     JonesVector % 2x2 complex valued jones vector in s-p axis 
                      % [Jsmag Jsphase;Jpmag Jpphase]
    %     Wavelength % Wavelength of the ray
    %     PolarizationVector % 1x3 electric field vector
    %     Vignated % 1 for true and 0 for false  
    %     TotalPhase % Absolute total phase of the ray in radian
    %     TotalPMatrix % Total 3x3 polarization ray tracing matrix for each ray
    %     TotalQMatrix % Total 3x3 parallel transport ray tracing matrix for each ray      
    %
    %     % If we want to preserve the initial properties of the ray         
    %     InitialPosition % 1x3 initial position vector
    %     InitialDirection % 1x3 initial Direction cosines
    %     InitialJonesVector % 2x2 complex valued jones vector in s-p axis 
                             % [Jsmag Jsphase;Jpmag Jpphase]
    %     InitialPolarizationVector % 1x3 initial electric field vector
    %     InitialAbsolutePhase % Initial absolute phase of the ray in radian  
    % Methods:
    % No methods yet defined for this class
    
	% <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

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

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      
    properties        
        Position %1x3
        Direction %1x3 Direction cosines
        Polarized % scalar: 1 for Polarized and 0 for not Polarized
        JonesVector %2x2 complex valued jones vector in s-p axis [Jsmag Jsphase;Jpmag Jpphase]
        Wavelength % Wavelength in wavelength unit        
        PolarizationVector % 1x3 complex field vector               
    end % Public properties
    
    properties (SetAccess = protected)
      
    end % Protected SetAccess
    
    methods       
        % Constructors methods
        function newRay = Ray(pos,dir,wav,jonesVect)% Constructor
            if nargin == 0 
                % Empty constructor
                newRay.Position = [0,0,0];
                newRay.Direction = [0,0,1];
                newRay.Polarized = 0;
                newRay.JonesVector = [1,0;0,0];
                newRay.Wavelength = 0.55;       
                newRay.PolarizationVector = [0,0,0];                    
            elseif nargin == 1
                newRay.Position = pos;
                newRay.Direction = [0,0,1];
                newRay.Polarized = 0;
                newRay.JonesVector = [1,0;0,0];
                newRay.Wavelength = 0.55;       
                newRay.PolarizationVector = [0,0,0];                    
            elseif nargin == 2
                newRay.Position = pos;
                newRay.Direction = dir;
                newRay.Polarized = 0;
                newRay.JonesVector = [1,0;0,0];
                newRay.Wavelength = 0.55;       
                newRay.PolarizationVector = [0,0,0];                      
            elseif nargin == 3    
                newRay.Position = pos;
                newRay.Direction = dir;
                newRay.Polarized = 0;
                newRay.JonesVector = [1,0;0,0];
                newRay.Wavelength = wav;       
                newRay.PolarizationVector = [0,0,0];                                 
            elseif nargin == 4
                newRay.Position = pos;
                newRay.Direction = dir;
                newRay.Polarized = 1;
                newRay.JonesVector = jonesVect;
                newRay.Wavelength = wav;       
                newRay.PolarizationVector = [0,0,0];                                                 
            else
            end           
        end
        
        function obj = computePropagationVector()% K vector of the ray computed from the wavelength and Direction cosines
        end
        
        function obj = computeIntensity() % Computed from the Field componenets
        end
        
        function obj = computeFieldInXyz() % Field converted from Jones vector to xyz axis
        end
             
    end
    
end

