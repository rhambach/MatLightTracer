function [ returnData1, returnData2, returnData3  ] = RectangularAperture...
        ( returnFlag,apertureParameters,xyVector)
    %RECTANGULARAPERTURE  Defn of aperture with rectangular shape.
    % Inputs:
    %   (returnFlag,apertureParameters,xyVector )
    %    NB. The xyVector should be given with respect to the center of the
    %    unrotated and undecentered aperture..
    % Outputs: depends on the return flag
    %   returnFlag = 1
    %       Outputs: [FieldNames,FieldTypes,DefaultApertureParameterStruct]
    %   returnFlag = 2
    %       Outputs: [OuterApertureType,OuterApertureUniqueParameters]
    %   returnFlag = 3
    %       Outputs: [umInsideTheMainAperture]
    %   returnFlag = 4
    %       Outputs: [umInsideTheOuterAperture]
    
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
    if nargin == 0
        disp(['Error: The function RectangularAperture() needs either one or three arguments',...
            'return type, apertureParameters and xyVector.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;
    elseif nargin == 1
        if returnFlag == 1
            % Just continue
        else
            disp(['Error: The function RectangularAperture() needs three arguments',...
                'return type, apertureParameters, and xyVector.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    elseif (nargin == 2)
        if returnFlag == 1 || returnFlag == 2
            % Just continue
        else
            disp(['Error: The function RectangularAperture() needs three arguments',...
                'return type, apertureParameters and xyVector.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            return;
        end
    else
        
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of apertureParameters
            returnData1 = {'DiameterX','DiameterY'};
            returnData2 = {{'numeric'},{'numeric'}};
            defaultApertureParameter = struct();
            defaultApertureParameter.DiameterX = 2;
            defaultApertureParameter.DiameterY = 2;
            defaultApertureParameter.AdditionalEdge = 0.1;
            returnData3 = defaultApertureParameter;
        case 2 % Return the maximum radius in x and y axis
            maximumRadiusXY(1) = (apertureParameters.DiameterX)/2;
            maximumRadiusXY(2) = (apertureParameters.DiameterY)/2;
            returnData1 = maximumRadiusXY;
            returnData2 = NaN;
            returnData3 = NaN;
        case 3 % Return the if the given points in xyVector are inside or outside the aperture.
            semiDiamX = (apertureParameters.DiameterX)/2;
            semiDiamY = (apertureParameters.DiameterY)/2;
            pointX = xyVector(:,1);
            pointY = xyVector(:,2);
            umInsideTheMainAperture = abs(pointX) < semiDiamX &...
                abs(pointY) < semiDiamY;
            returnData1 = umInsideTheMainAperture;
            returnData2 = NaN;
            returnData3 = NaN;
    end 
end

