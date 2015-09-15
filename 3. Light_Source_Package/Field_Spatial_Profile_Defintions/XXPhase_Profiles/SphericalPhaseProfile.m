function [ returnDataStruct] = SphericalPhaseProfile(returnFlag,spatialPhaseProfileParameters,inputDataStruct)
    % SphericalPhaseProfile A user defined function for Spherical spatial Phase Profile
    % The function returns differnt parameters when requested by the main program.
    % It follows the common format used for defining user defined spatial profiles.
    % spatialPhaseProfileParameters = values of {'Radius','DecenterX','DecenterY'}
    % inputDataStruct : Struct of all additional inputs (not included in the surface parameters)
    % required for computing the return. (Vary depending on the returnFlag)
    % returnFlag : An integer indicating what is requested. Depending on it the
    % returnDataStruct will have different fields
    % 1: Return the field names and initial values of spatialProfileParameters
    % which could be used in the Source definition GUI
    %   inputDataStruct:
    %       empty
    %   Output Struct:
    %       returnDataStruct.UniqueParametersStructFieldNames
    %       returnDataStruct.UniqueParametersStructFieldDisplayNames
    %       returnDataStruct.UniqueParametersStructFieldFormats
    %       returnDataStruct.DefaultUniqueParametersStruct
    % 2: Return the spatial phase profile for given meshgrid points xMesh and yMesh
    %   inputDataStruct:
    %       inputDataStruct.xMesh
    %       inputDataStruct.yMesh
    %   returnDataStruct:
    %       returnDataStruct.SpatialPhaseProfileMatrix,
    
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 19,2015   Worku, Norman G.     Original Version
    % Sep 09,2015   Worku, Norman G.     Edited to common user defined format
    
    %% Default input values
    if nargin < 1
        disp(['Error: The function SphericalPhaseProfile() needs atleast one argument',...
            'the return type.']);
        returnDataStruct = NaN;
        return;
    end
    if nargin < 2
        if returnFlag == 1
            % OK
        elseif returnFlag == 2
            % get the default parameters
            retF = 1;
            returnData = SphericalPhaseProfile(retF);
            spatialPhaseProfileParameters = returnData.DefaultUniqueParametersStruct;
        else
            disp(['Error: The function SphericalPhaseProfile() needs all three ',...
                'arguments the compute the required return.']);
            returnDataStruct = NaN;
            return;
        end
    end
    
    switch returnFlag(1)
        case 1 % Return the field names and initial values of spatialProfileParameters
            returnData1 = {'RadiusSpecification','Radius'};
            returnData2 = {'numeric','numeric'};
            returnData1_Disp = {'Radius Specification','Radius'};
            spatialProfileParametersStruct = struct();
            spatialProfileParametersStruct.RadiusSpecification = 1; % 'Relative' to wavelength
            spatialProfileParametersStruct.Radius = 0.5; %100 mm;
            returnData3 = spatialProfileParametersStruct;
            
            returnDataStruct.UniqueParametersStructFieldNames = returnData1;
            returnDataStruct.UniqueParametersStructFieldDisplayNames = returnData1_Disp;
            returnDataStruct.UniqueParametersStructFieldFormats = returnData2;
            returnDataStruct.DefaultUniqueParametersStruct = returnData3;
        case 2 % Return the spatial phase profile
            radius = spatialPhaseProfileParameters.Radius;
            decX = spatialPhaseProfileParameters.DecenterX;
            decY = spatialPhaseProfileParameters.DecenterY;
            
            x = inputDataStruct.xMesh;
            y = inputDataStruct.yMesh;
            
            % Compute the Spherical phase profile
            Phasexy
            returnDataStruct.SpatialProfileMatrix = Phasexy;  % (sizeX X sizeY) Matrix of normalized amplitude
    end
end