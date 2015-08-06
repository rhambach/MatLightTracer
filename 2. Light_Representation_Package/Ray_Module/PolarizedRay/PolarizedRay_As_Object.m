classdef PolarizedRay
    % POLARIZEDRAY class:
    %   To represent all polarized ray objects
    %   The class supports constructors to construct an array of Ray
    %   objects from array of its properties.
    % Properties
    %     Position % 3 X N position vector in meter
    %     Direction % 3 X N Direction cosines
    %     Wavelength % Wavelength in meter
    %     Vignated % 1 for true and 0 for false    
    %     JonesVector % 2 X N complex valued jones vector in s-p axis [Jsmag&Jsphase;Jpmag&Jpphase]
    %     PolarizationVector % 3 X N complex field vector
    
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
    % Oct 14,2014   Worku, Norman G.     Original Version       Version 3.0
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    properties
        Position % 3 X N position vector in meter
        Direction % 3 X N Direction cosines
        Wavelength % 1 X N Wavelength in meter
        Vignated % scalar showing vignation
        
        JonesVector % 2 X N complex valued jones vector in s-p axis [Jsmag&Jsphase;Jpmag&Jpphase]
        PolarizationVector % 3 X N complex field vector
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects.    

    end % Public properties
    
    methods
        % Constructors methods
        function newPolarizedRay = PolarizedRay(scalarRay,jonesVector) % Constructor
            if nargin == 0
                % Empty constructor
                scalarRay = ScalarRay;
                newPolarizedRay.Position = scalarRay.Position;
                newPolarizedRay.Direction = scalarRay.Direction; 
                newPolarizedRay.Wavelength = scalarRay.Wavelength; 
                newPolarizedRay.Vignated = scalarRay.Vignated;
                
                jonesVector = NaN*[0;0];
                polarizationVector = NaN*[0;0;0];
                
                newPolarizedRay.JonesVector = jonesVector;
                newPolarizedRay.PolarizationVector = polarizationVector;
                newPolarizedRay.ClassName = 'PolarizedRay';
                return;
            elseif nargin == 1
                jonesVector = NaN*[0;0];
            else
            end
            
            % If the inputs are arrays the newRay becomes object array
            % That is when dir, pos and polVector = 3 X N matrix
            % jonesVect = 2 X 2 X N matrix
            
            % Determine the size of each inputs
            nScalarRay = size(scalarRay,2);
            nJV = size(jonesVector,2);
            % The number of array to be initialized is maximum of all inputs
            nMax = max([nScalarRay,nJV]);
            
            % Fill the smaller inputs to have nMax size by repeating their
            % last element
            if nScalarRay < nMax
                scalarRay = cat(2,scalarRay,repmat(scalarRay(end),[1,nMax-nScalarRay]));
            end
            if nJV < nMax
                jonesVector = cat(2,jonesVector,repmat(jonesVector(:,end),[1,nMax-nJV]));
            end
            
            % Preallocate object array
            newPolarizedRay(nMax) = PolarizedRay;
            for kk = 1:nMax                
                newPolarizedRay(kk).Position = scalarRay(kk).Position;
                newPolarizedRay(kk).Direction = scalarRay(kk).Direction; 
                newPolarizedRay(kk).Wavelength = scalarRay(kk).Wavelength; 
                newPolarizedRay(kk).Vignated = scalarRay(kk).Vignated;
                
                newPolarizedRay(kk).JonesVector = jonesVector(:,kk);
                newPolarizedRay(kk).PolarizationVector = NaN*[0;0;0];
                newPolarizedRay(kk).ClassName = 'PolarizedRay';
            end
        end
    end
    
    methods(Static)
        function newObj = InputGUI()
            newObj = ObjectInputDialog(MyHandle(PolarizedRay()));
        end
    end    
end

% end

