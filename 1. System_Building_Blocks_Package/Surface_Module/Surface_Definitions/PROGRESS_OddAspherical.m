function [ returnData1, returnData2] = OddAspherical(...
    returnFlag,surfaceParameters,rayPosition,rayDirection,indexBefore,...
    indexAfter,wavlenInM,surfNormal,reflection,xyCoordinateMeshGrid,refWavlenInM)
%ODDASPHERICAL surface definition for Odd spherical
% surfaceParameters = values of {'Radius','Conic','GratingDensity','DiffractionOrder','ExtraData'}

switch returnFlag(1)
    case 1 % 'ProgrammableSurfaceDataFields' table field names and initial values in Surface Editor GUI
        switch returnFlag(2)
            case 1 % Return the 'ProgrammableSurfaceDataFields' table field names
                % returnData1 = {'Radius','Conic','GratingDensity','DiffractionOrder'};
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};                
            case 2 % Return the 'ProgrammableSurfaceDataFields' table field initial values
                % returnData1 = {'Inf','0','0','0'};
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};                
            case 3 % Return the 'ProgrammableSurfaceDataFields' table field data types
                % returnData1 = {'numeric','numeric','numeric','numeric'};
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};
        end
    case 2 % 'Extra Data' table field names and initial values in Surface Editor GUI
        switch returnFlag(2)
            case 1 % Return the 'Extra Data' table field names
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};
            case 2 % Return the 'Extra Data' table field initial values
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};
        end         
    case 3 % Return path length to the surface intersection points for given 
        % incident Ray parameters
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};        
    case 4 % Return the surface intersection points and surface normal for
           % given incident Ray parameters
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};
    case 5 % Return the surface sag at given xyGridPoints % Used for plotting the surface
                returnData1 = {'Unused'};
                returnData2 = {'Unused'};
end
end

