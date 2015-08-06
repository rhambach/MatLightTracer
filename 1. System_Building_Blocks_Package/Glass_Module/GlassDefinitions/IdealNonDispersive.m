function [ returnData1, returnData2, returnData3 ] = IdealNonDispersive(...
        returnFlag,glassParameters,wavelength,derivativeOrder)
    %IDEALDISPERSIVE : Defn of glass with fixed index
    % The function returns differnt parameters when requested by the main program.
    % It follows the common format used for defining user defined coating.
    % Inputs:
    %   (returnFlag,glassParameters,wavelength,derivativeOrder)
    % Outputs: depends on the return flag
    %   returnFlag = 1
    %       Outputs: [FieldNames,FieldTypes,DefaultGlassParameterStruct]
    %   returnFlag = 2
    %       Outputs: [refractiveIndex]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 19,2015   Worku, Norman G.     Original Version   
    %% Default input vaalues
    if nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function IdealNonDispersive() needs two arguments',...
                'return type and glassParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function IdealNonDispersive() needs two arguments',...
            'return type and glassParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    elseif nargin == 2
        wavelength = 0.55*10^-6;
        derivativeOrder = 0;
    elseif nargin == 3
        derivativeOrder = 0;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of glassParameters
            returnData1 = {'RefractiveIndex','ReferenceWavelength'};
            returnData2 = {{'numeric'},{'numeric'}};
            defaultGlassParameter = struct();
            defaultGlassParameter.RefractiveIndex = 1;
            defaultGlassParameter.ReferenceWavelength = 0.55*10^-6;
            returnData3 = defaultGlassParameter;
        case 2 % Return the refractive index of given derivative order
            nWav = size(wavelength,2);
            refWavLen = glassParameters.ReferenceWavelength;
            if derivativeOrder == 0
                n = glassParameters.RefractiveIndex;
            else
                n = 0;
            end
            % constant refractive index for all wavelengths           
            returnData1 = n*ones(1,nWav); % refractive index
            returnData2 = NaN; % 
            returnData3 = NaN;
    end
    
    
end

