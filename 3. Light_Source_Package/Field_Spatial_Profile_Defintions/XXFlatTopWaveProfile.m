function [ returnData1, returnData2, returnData3] = FlatTopWaveProfile(...
        returnFlag,spatialProfileParameters,samplingPoints,samplingDistance)
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function FlatTopWaveProfile() needs 5 arguments.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 4
        disp(['Error: The function FlatTopWaveProfile() needs 4 arguments.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of spatialProfileParameters
            returnData1 = {'Shape','Diameter'};
            returnData2 = {{'Elliptical','Rectangular'},{'numeric','numeric'}};
            
            spatialProfileParametersStruct = struct();
            spatialProfileParametersStruct.Shape = 'Rectangular';
            spatialProfileParametersStruct.Diameter = [2*10^-3;2*10^-3];
            returnData3 = spatialProfileParametersStruct;
        case 2 % Return the spatial profile
            [~,shapeIndex] = ismember(spatialProfileParameters.Shape,getSupportedAbsoluteBoarderShapes);
            diameter = spatialProfileParameters.Diameter;
            [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance);
            [x,y] = meshgrid(xlin,ylin);
            
            % Compute the Flat Top profile
            U_xy = zeros(size(x));
            switch (shapeIndex)
                case 1 %lower('Elliptical')
                    isInsideTheEllipse = (((x).^2)/(0.5*diameter(1))^2) + (((y).^2)/(0.5*diameter(2))^2) <= 1;
                    U_xy(isInsideTheEllipse) = 1;
                case 2 % lower('Rectangular')
                    isInsideTheRectangle = abs(x) < 0.5*diameter(1) &...
                        abs(y) < 0.5*diameter(2);
                    U_xy(isInsideTheRectangle) = 1;
            end
            returnData1 = U_xy;  % (sizeX X sizeY) Matrix of normalized amplitude
            returnData2 = xlin; % (sizeX X sizeY) meshgrid of x
            returnData3 = ylin; % (sizeX X sizeY) meshgrid of y
        case 3 % Return the spatial profile shape and size(fieldDiameter)
            shapeIndex = find(ismember(spatialProfileParameters.Shape,getSupportedAbsoluteBoarderShapes));
            boarderShape = shapeIndex;
            [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance);
            diameterX = max(xlin) - min(xlin);
            diameterY = max(ylin) - min(ylin);
            
            returnData1 = boarderShape;
            returnData2 = [diameterX,diameterY]';
            returnData3 = NaN;
    end
    
    
end