function [ returnData1, returnData2, returnData3 ] = IdealDispersive(...
        returnFlag,glassParameters,wavelength,derivativeOrder)
    %IDEALDISPERSIVE : Defn of glass with three parameters n,v,dpgf and the
    % Currently the dispersion is not computed but in the future it shall
    % be included as done for Model glass in zemax.
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
            disp(['Error: The function IdealDispersive() needs two arguments',...
                'return type and glassParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function IdealDispersive() needs two arguments',...
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
            returnData1 = {'RefractiveIndex','AbbeNumber','DeltaRelativePartialDispersion','ReferenceWavelength'};
            returnData2 = {{'numeric'},{'numeric'},{'numeric'},{'numeric'}};
            defaultGlassParameter = struct();
            defaultGlassParameter.RefractiveIndex = 1;
            defaultGlassParameter.AbbeNumber = 0;
            defaultGlassParameter.DeltaRelativePartialDispersion = 0;
            defaultGlassParameter.ReferenceWavelength = 0.55*10^-6;
            returnData3 = defaultGlassParameter;
        case 2 % Return the refractive index of given derivative order
            nWav = size(wavelength,2);
            refWavLen = glassParameters.ReferenceWavelength;
            
            if derivativeOrder == 0
                n = glassParameters.RefractiveIndex;
            else
                % shall be corrected in the future, The 1st derivative of
                % this model glass shall be computed correctly
                n = 0;
            end
            v = glassParameters.AbbeNumber;
            Dpgf = glassParameters.DeltaRelativePartialDispersion;
            
            % At the moment the glass parameters are kept constant for all
            % wavelengths, but in the future it should be modified to Model
            % glass type of zemax which computes the refractive index at
            % different wavelelngths from the three parameters  !!!
            
            returnData1 = n*ones(1,nWav);
            returnData2 = NaN;
            returnData3 = NaN;
    end
    
    
end

