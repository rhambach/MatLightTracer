function [ returnData1, returnData2, returnData3] = ExampleSpatialProfile(...
        returnFlag,spatialProfileParameters,samplingPoints,samplingDistance)
    %% Default input vaalues
    if nargin < 2
        disp(['Error: The function ExampleSpatialProfile() needs two arguments',...
            'return type and spatialProfileParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of spatialProfileParameters
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            spatialProfileParametersStruct = struct();
            spatialProfileParametersStruct.Unused = 0;
            returnData3 = spatialProfileParametersStruct;
        case 2 % Return the spatial profile
            returnData1 = [];  % (sizeX X sizeY) Matrix of normalized amplitude
            returnData2 = NaN; % (sizeX X sizeY X 2) meshgrid of x and y
            returnData3 = NaN;
        case 3 % Return the spatial profile shape and size
            returnData1 = 'Elliptical';
            returnData2 = 2*[outerRadiusX,outerRadiusY]';
            returnData3 = NaN;
    end
end