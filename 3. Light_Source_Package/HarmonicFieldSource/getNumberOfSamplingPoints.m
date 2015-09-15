function [ Nx,Ny ] = getNumberOfSamplingPoints( harmonicFieldSource,samplingDistanceX,samplingDistanceY )
    %GETNUMBEROFSAMPLINGPOINTS Summary of this function goes here
    %   Detailed explanation goes here
    
    if nargin < 1
        disp('Error: The function getNumberOfSamplingPoints requires atleast an input sargument of harmonicFieldSource.');
        Nx = NaN;
        Ny = NaN;
        return;
    end
    if nargin < 3
        % Use the default sampling parameters of the source
        if harmonicFieldSource.SamplingParameterType == 1
            % Sample number is specifed (actual field + smooth edge)
            Nx = (harmonicFieldSource.SamplingParameterValues(1));
            Ny = (harmonicFieldSource.SamplingParameterValues(2));
            
            % Make sure that the numbewr of sampling points are odd
            Nx = floor(Nx/2)*2 + 1;
            Ny = floor(Ny/2)*2 + 1;
        else
            % Sampling distance specified directly
            samplingDistanceX = harmonicFieldSource.SamplingParameterValues(1);
            samplingDistanceY = harmonicFieldSource.SamplingParameterValues(2);
            
            % get field size (actual field + smooth edge) BoarderLevelIndex = 2
            boarderLevelIndex = 2;
            [diameterX2,diameterY2] = getSpatialShapeAndSize( harmonicFieldSource,boarderLevelIndex );
            Nx = (diameterX2/samplingDistanceX) + 1;
            Ny = (diameterY2/samplingDistanceY) + 1;
            
            % Make sure that the numbewr of sampling points are odd
            Nx = floor(Nx/2)*2 + 1;
            Ny = floor(Ny/2)*2 + 1;
        end
    else
        % If dx and dy are given then calculate the sampling numbers
        % direclty
        % get field size (actual field + smooth edge) BoarderLevelIndex = 2
        boarderLevelIndex = 2;
        [diameterX2,diameterY2] = getSpatialShapeAndSize( harmonicFieldSource,boarderLevelIndex );
        Nx = (diameterX2/samplingDistanceX) + 1;
        Ny = (diameterY2/samplingDistanceY) + 1;
        
        % Make sure that the numbewr of sampling points are odd
        Nx = floor(Nx/2)*2 + 1;
        Ny = floor(Ny/2)*2 + 1;
    end   
end

