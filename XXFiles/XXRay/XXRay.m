classdef Ray 
    % RAY class:
    %   To represent all polarized ray objects
    %   The class supports constructors to construct an array of Ray
    %   objects from array of its properties.
    % Properties    
    %     Position % 3 X N position vector
    %     Direction % 3 X N Direction cosines
    %     Polarized % scalar: 1 for Polarized and 0 for not Polarized
    %     JonesVector % 2 X N complex valued jones vector in s-p axis [Jsmag&Jsphase;Jpmag&Jpphase]
    %     Wavelength % Wavelength in wavelength unit        
    %     PolarizationVector % 3 X N complex field vector     
    %     Vignated % 1 for true and 0 for false 
    
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
	% Jan 17,2014   Worku, Norman G.     Vectorized Constructor Version 
    
	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      
    properties        
        Position % 3 X N position vector
        Direction % 3 X N Direction cosines
        Polarized % scalar: 1 for Polarized and 0 for not Polarized
        JonesVector % 2 X N complex valued jones vector in s-p axis [Jsmag&Jsphase;Jpmag&Jpphase]
        Wavelength % 1 X N Wavelength in wavelength unit        
        PolarizationVector % 3 X N complex field vector  
        Vignated % scalar showing vignation
    end % Public properties
      
    methods       
        % Constructors methods
        function newRay = Ray(pos,dir,wav,pol,jonesVect) % Constructor  
            if nargin == 0
                % Empty constructor
                newRay.Position = [0;0;0]; % default position
                newRay.Direction = [0;0;1]; % default dirction
                newRay.Wavelength = 0.55; % default
                newRay.Polarized = 0; % default
                newRay.JonesVector = NaN*[1;2]; 
                newRay.PolarizationVector  = NaN*[1;2;3];  
                newRay.Vignated = 0;                 
            else
                if nargin == 1
                    dir = [0;0;1]; % default dirction
                    wav = 0.55;  % default
                    pol = 0; % default
                    jonesVect = NaN*[1;2]; 
                    polVector = NaN*[1;2;3];                    
                elseif nargin == 2
                    wav = 0.55; % default
                    pol = 0; % default
                    jonesVect = NaN*[1;2]; 
                    polVector = NaN*[1;2;3];                   
                elseif nargin == 3  
                    pol = 0; % default
                    jonesVect = NaN*[1;2]; 
                    polVector = NaN*[1;2;3]; 
                elseif nargin == 4
                    jonesVect = NaN*[1;2]; 
                    polVector = NaN*[1;2;3];                     
                elseif nargin == 5
                    if isnan(jonesVect(1,1))
                        jonesVect = NaN*[1;2]; 
                        polVector = NaN*[1;2;3];                    
                    else
                        % convertJVToPolVector shall operate on 2x1 matrix of 
                        % jones vector and  return 3XN matrix of polVector
                        polVector = convertJVToPolVector(jonesVect,dir);
                        % Jones Vector is the same for all rays
                        jonesVect = repmat(jonesVect,[1,size(polVector,2)]);
                    end
                else
                end
     
                % If the inputs are arrays the newRay becomes object array
                % That is when dir, pos and polVector = 3 X N matrix
                % jonesVect = 2 X 2 X N matrix

                % Determine the size of each inputs
                nPos = size(pos,2);
                nDir = size(dir,2);
                nJV = size(jonesVect,2);
                nWav = size(wav,2);
                nPol = size(pol,2);
                % The number of array to be initialized is maximum of all inputs
                nMax = max([nPos,nDir,nJV,nWav,nPol]);
                                
                % Set vignated properties to 0 for all rays
                vig = zeros(1,nMax);
                
                % Fill the smaller inputs to have nMax size by repeating their
                % last element                
                if nPos < nMax
                    pos = cat(2,pos,repmat(pos(:,end),[1,nMax-nPos]));
                end
                if nDir < nMax
                    dir = cat(2,dir,repmat(dir(:,end),[1,nMax-nDir]));
                end
                if nJV < nMax
                    jonesVect = cat(2,jonesVect,repmat(jonesVect(:,end),[1,nMax-nJV]));
                    polVector = cat(2,polVector,repmat(polVector(:,end),[1,nMax-nJV]));
                end
                if nWav < nMax
                    wav = cat(2,wav,repmat(wav(end),[1,nMax-nWav]));
                end
                if nPol < nMax
                    pol = cat(2,pol,repmat(pol(end),[1,nMax-nPol]));
                end
                
                % Preallocate object array
                newRay(nMax) = Ray;
                for kk = 1:nMax
                    newRay(kk).Position = pos(:,kk);
                    newRay(kk).Direction = dir(:,kk);
                    newRay(kk).Polarized = pol(kk); 
                    newRay(kk).JonesVector = jonesVect(:,kk);
                    newRay(kk).Wavelength = wav(kk);       
                    newRay(kk).PolarizationVector = polVector(:,kk);
                    newRay(kk).Vignated = vig(kk);
                end
            end
        end
    end
    
end

