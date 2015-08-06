function [ returnData1, returnData2, returnData3] = GaussianWaveProfile(...
        returnFlag,spatialProfileParameters,samplingPoints,samplingDistance)
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function GaussianWaveProfile() needs 5 arguments.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 5
        disp(['Error: The function GaussianWaveProfile() needs 5 arguments.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of spatialProfileParameters
            returnData1 = {'Type','Order','CentralWavelength','WaistRadius','WaistDistance'};
            returnData2 = {{'HermiteGaussianMode','LaguerreGaussianMode'},{'numeric','numeric'},{'numeric'},{'numeric','numeric'},{'numeric','numeric'}};
            
            spatialProfileParametersStruct = struct();
            spatialProfileParametersStruct.Type = 'HermiteGaussianMode';
            spatialProfileParametersStruct.Order = [0;0];
            spatialProfileParametersStruct.CentralWavelength = 550*10^-9;
            spatialProfileParametersStruct.WaistRadius = [10^-3;10^-3];
            spatialProfileParametersStruct.WaistDistance = [0;0];
            returnData3 = spatialProfileParametersStruct;
        case 2 % Return the spatial profile
            
            % NB. The formula of ideal gaussian wave from VirtualLab are used
            % here
            type = spatialProfileParameters.Type;
            order = spatialProfileParameters.Order;
            %         mSquare = spatialProfileParameters.MSquareParameter;
            centralLambda = spatialProfileParameters.CentralWavelength;
            waistRadius = spatialProfileParameters.WaistRadius;
            waistDistance = spatialProfileParameters.WaistDistance;
            
            w0_x = waistRadius(1);
            z_x = waistDistance(1);
            zR_x = (pi*(w0_x)^2)/(centralLambda);
            wz_x = w0_x*sqrt(1+(z_x/zR_x)^2);
            if z_x == 0
                R_x = Inf;
            else
                R_x = z_x*(1+(zR_x/z_x)^2);
            end
            m = order(1);
            
            w0_y = waistRadius(2);
            z_y = waistDistance(2);
            zR_y = (pi*(w0_y)^2)/(centralLambda);
            wz_y = w0_y*sqrt(1+(z_y/zR_y)^2);
            if z_y == 0
                R_y = Inf;
            else
                R_y = z_y*(1+(zR_y/z_y)^2);
            end
            n = order(2);
            k = 2*pi/(centralLambda);
            [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance);
            [x,y] = meshgrid(xlin,ylin);
            
            % Compute the Gaussian profile
            switch lower(type)
                case lower('HermiteGaussianMode')
                    % NB: For astigmatic case the function should be rechecked.
                    U_xy = (exp(-(x.^2)/(wz_x^2)).*exp(1i*(-(k*z_x/2) - k*((x.^2)/(2*R_x)) + 0.5*atan(z_x/zR_x)))).*...
                        exp(-(y.^2)/(wz_y^2)).*exp(1i*(-(k*z_y/2) - k*((y.^2)/(2*R_y)) + 0.5*atan(z_y/zR_y))).*...
                        exp(1i*(m*atan(z_x/zR_x)+n*atan(z_y/zR_y))).*...
                        Hermite(m,(sqrt(2)*x)./(wz_x)).*Hermite(n,(sqrt(2)*y)./(wz_y));
                    
                case lower('LaguerreGaussianMode')
                    % NB: For astigmatic case the function should be rechecked.
                    disp('Currently LaguerreGaussianMode is not supported.');
                    U_xy = NaN;
                    return;
                    %                 U_xy = (exp(-(x.^2)/(wz_x^2)).*exp(1i*(-(k*z_x/2) - k*((x.^2)/(2*Rz_x)) + 0.5*atan(z_x/zR_x)))).*...
                    %                     exp(-(y.^2)/(wz_y^2)).*exp(1i*(-(k*z_y/2) - k*((y.^2)/(2*Rz_y)) + 0.5*atan(z_y/zR_y))).*...
                    %                     exp(1i*(m*atan(x./y)+(2*m+n)*atan(z_x/zR_x))).*...
                    %                     Laguerre(m,n,(2*(x.^2+y.^2)/wz_x.^2));
                    
            end
            
            returnData1 = U_xy;  % (sizeX X sizeY) Matrix of normalized amplitude
            returnData2 = xlin; % (sizeX X sizeY) meshgrid of x
            returnData3 = ylin; % (sizeX X sizeY) meshgrid of y
        case 3 % Return the spatial profile shape and size(fieldDiameter)
            boarderShape = 'Elliptical';
            [xlin,ylin] = generateSamplingGridVectors(samplingPoints,samplingDistance);
            diameterX = max(xlin) - min(xlin);
            diameterY = max(ylin) - min(ylin);
            
            returnData1 = boarderShape;
            returnData2 = [diameterX,diameterY]';
            returnData3 = NaN;
    end
    
    
end