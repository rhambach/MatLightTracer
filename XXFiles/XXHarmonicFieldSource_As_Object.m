classdef HarmonicFieldSource
    %SOURCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Source definitions
        % Ray tracing field points
        %         RayFieldType % Type of field specified either 'ObjectHeight' or 'Angle'
        %         RayFieldPointMatrix % matrix of X field, Y field & Weight
        % (either object height or angle)
        
        % Position, orientation and Dimensions
        LateralPosition % [X;Y] position
        Direction % direction cosine in the direction. The field will be
        % defined in the plane perpendicular to this direction
        
        DistanceToInputPlane
        FieldSizeSpecification % 'Relative' to the lateral profile or 'Absolute'
        
        % For 'Relative' to the lateral profil, the boarder shape is taken
        % directly and the size is scaled with size factor
        RelativeFieldSizeFactor % for relative dimenssioning
        % for absolute dimensioning
        AbsoluteBoarderShape % 'Elliptical' or 'Rectangular'
        AbsoluteFieldSize % [size x , size y]
        
        % additional edge width
        EdgeSizeSpecification % 'Relative' or 'Absolute'
        RelativeEdgeSizeFactor % for relative dimenssioning
        AbsoluteEdgeSize % for absolute
        
        % Source sampling
        SamplingPoints
        SamplingDistance
        AdditionalBoarderSamplePoints
        
        % Spatial parameters
        SpatialProfileType
        SpatialProfileParameter
        
        % Spectral parameter
        SpectralProfileType
        SpectralProfileParameter
        
        % Polarization
        PolarizationProfileType % Linear, Circular or JonesVector
        PolarizationProfileParameter % Angle or Direction or JonesVector
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects.    

    end
    
    methods
        function newHarmonicFieldSource = HarmonicFieldSource(...
                lateralPosition,direction,distanceToInputPlane,fieldSizeSpecification,...
                relativeFieldSizeFactor,absoluteBoarderShape,absoluteFieldSize,...
                edgeSizeSpecification,relativeEdgeSizeFactor,absoluteEdgeSize,...
                samplingPoints,samplingDistance,additionalBoarderSamplePoints,...
                spatialProfileType,spatialProfileParameter,...
                spectralProfileType,spectralProfileParameter,...
                polarizationProfileType,polarizationProfileParameter)
            
            if nargin == 0
                lateralPosition = [0,0]';% [X;Y] position
                direction = [0,0,1]';% direction cosine in the direction. The field will be
                % defined in the plane perpendicular to this direction
                distanceToInputPlane = 10*10^-3;
                fieldSizeSpecification = 'Relative'; % 'Relative' to the lateral profile or 'Absolute'
                relativeFieldSizeFactor = 1; % for relative dimenssioning
                absoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
                
            elseif nargin == 1
                direction = [0,0,1]';% direction cosine in the direction. The field will be
                % defined in the plane perpendicular to this direction
                distanceToInputPlane = 10*10^-3;
                fieldSizeSpecification = 'Relative'; % 'Relative' to the lateral profile or 'Absolute'
                relativeFieldSizeFactor = 1; % for relative dimenssioning
                absoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 2
                distanceToInputPlane = 10*10^-3;
                fieldSizeSpecification = 'Relative'; % 'Relative' to the lateral profile or 'Absolute'
                relativeFieldSizeFactor = 1; % for relative dimenssioning
                absoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 3
                fieldSizeSpecification = 'Relative'; % 'Relative' to the lateral profile or 'Absolute'
                relativeFieldSizeFactor = 1; % for relative dimenssioning
                absoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 4
                relativeFieldSizeFactor = 1; % for relative dimenssioning
                absoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 5
                absoluteBoarderShape = 'Elliptical' ;% 'Elliptical' or 'Rectangular'
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 6
                absoluteFieldSize = [1,1]'; % [size x , size y]
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 7
                edgeSizeSpecification = 'Relative'; % 'Relative' or 'Absolute'
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 8
                relativeEdgeSizeFactor = 0.1; % for relative dimenssioning
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 9
                absoluteEdgeSize = 1; % for absolute
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 10
                samplingPoints = [64,64]';
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 11
                samplingDistance = [10^-6,10^-6]';
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 12
                additionalBoarderSamplePoints = 5;
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 13
                spatialProfileType = 'GaussianWaveProfile';
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 14
                [~,~,spatialProfileParameter] = getSpatialProfileParameters(spatialProfileType);
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 15
                spectralProfileType = 'GaussianPowerSpectrum';
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 16
                [~,~,spectralProfileParameter] = getSpectralProfileParameters(spectralProfileType);
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 17
                polarizationProfileType = 'LinearPolarization'; % Linear, Circular or JonesVector
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
            elseif nargin == 18
                [~,~,polarizationProfileParameter] = getPolarizationProfileParameters(polarizationProfileType);
                
            else
            end
            
            
            newHarmonicFieldSource.LateralPosition = lateralPosition;
            newHarmonicFieldSource.Direction = direction;
            
            newHarmonicFieldSource.DistanceToInputPlane = distanceToInputPlane;
            newHarmonicFieldSource.FieldSizeSpecification = fieldSizeSpecification;
            
            % For 'Relative' to the lateral profil, the boarder shape is taken
            % directly and the size is scaled with size factor
            newHarmonicFieldSource.RelativeFieldSizeFactor = relativeFieldSizeFactor;
            % for absolute dimensioning
            newHarmonicFieldSource.AbsoluteBoarderShape = absoluteBoarderShape;
            newHarmonicFieldSource.AbsoluteFieldSize = absoluteFieldSize;
            
            % additional edge width
            newHarmonicFieldSource.EdgeSizeSpecification = edgeSizeSpecification;
            newHarmonicFieldSource.RelativeEdgeSizeFactor = relativeEdgeSizeFactor;
            newHarmonicFieldSource.AbsoluteEdgeSize = absoluteEdgeSize;
            
            % Source sampling
            newHarmonicFieldSource.SamplingPoints = samplingPoints;
            newHarmonicFieldSource.SamplingDistance = samplingDistance;
            newHarmonicFieldSource.AdditionalBoarderSamplePoints = additionalBoarderSamplePoints;
            
            % Spatial parameters
            newHarmonicFieldSource.SpatialProfileType = spatialProfileType;
            newHarmonicFieldSource.SpatialProfileParameter = spatialProfileParameter;
            
            % Spectral parameter
            newHarmonicFieldSource.SpectralProfileType = spectralProfileType;
            newHarmonicFieldSource.SpectralProfileParameter = spectralProfileParameter;
            
            % Polarization
            newHarmonicFieldSource.PolarizationProfileType = polarizationProfileType;
            newHarmonicFieldSource.PolarizationProfileParameter = polarizationProfileParameter;
            newHarmonicFieldSource.ClassName = 'HarmonicFieldSource';
        end
        
    end
    
end

