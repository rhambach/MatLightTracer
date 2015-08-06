function [ returnData1, returnData2, returnData3,returnData4 ] = BareGlass( returnFlag,coatingParameters,...
        wavLen,referenceWavLen,incAngle,indexBefore,indexAfter)
    %BareGlass A user defined function for BareGlass. 
    % The function returns differnt parameters when requested by the main program.
    % It follows the common format used for defining user defined coating.
    % Inputs:
    %   (returnFlag,coatingParameters,wavLen,referenceWavLen,incAngle,indexBefore,indexAfter)
    % Outputs: depends on the return flag
    %   returnFlag = 1
    %       Outputs: [FieldNames,FieldTypes,DefaultCoatingParameter]
    %   returnFlag = 2
    %       Outputs: [ampTransJonesMatrix, ampRefJonesMatrix, powTransJonesMatrix, powRefJonesMatrix]
    
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
            disp(['Error: The function BareGlass() needs two arguments',...
                'return type and coatingParameters.']);
            returnData1 = NaN;
            returnData2 = NaN;
            returnData3 = NaN;
            returnData4 = NaN;
            return;
        end
    elseif nargin < 2
        disp(['Error: The function BareGlass() needs two arguments',...
            'return type and coatingParameters.']);
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        returnData4 = NaN;
        return;
    elseif nargin < 7
        wavLen = NaN;
        referenceWavLen = NaN;
        incAngle = NaN;
        indexBefore = NaN;
        indexAfter = NaN;
    end
    
    %%
    switch returnFlag(1)
        case 1 % Return the field names and initial values of coatingParameters
            returnData1 = {'Unused'};
            returnData2 = {{'numeric'}};
            defaultCoatingParameter = struct();
            defaultCoatingParameter.Unused = 0;
            returnData3 = defaultCoatingParameter;
            returnData4 = NaN;
        case 2 % Return the Jones Matrices
            nRayAngle = size(incAngle,2);
            nRayWav = size(wavLen,2);
            if nRayAngle == 1
                nRay = nRayWav;
                incAngle = repmat(incAngle,[1,nRay]);
            elseif nRayWav == 1
                nRay = nRayAngle;
                wavLen = repmat(wavLen,[1,nRay]);
            elseif nRayAngle == nRayWav % Both wavLen and incAngle for all rays given
                nRay = nRayAngle;
            else
                disp(['Error: The size of Incident Angle and Wavelength should '...
                    'be equal or one of them should be 1.']);
                returnData1 = NaN;
                returnData2 = NaN;
                returnData3 = NaN;
                returnData4 = NaN;
                return;
            end
            
            refIndexAll = [];
            thicknessAll = [];
            
            wavLenInUm = wavLen/10^-6;
            ns = indexBefore;
            nc = indexAfter;
            
            [ampTs,ampRs,powTs,powRs]=computeMultilayerFresnelsCoefficients...
                (refIndexAll,thicknessAll,'TE',wavLenInUm,incAngle,ns,nc);
            [ampTp,ampRp,powTp,powRp]=computeMultilayerFresnelsCoefficients...
                (refIndexAll,thicknessAll,'TM',wavLenInUm,incAngle,ns,nc);
            
            
            ampTransJonesMatrix(1,1,:) = ampTs; ampTransJonesMatrix(1,2,:) = 0;
            ampTransJonesMatrix(2,1,:) = 0; ampTransJonesMatrix(2,2,:) = ampTp;
            
            ampRefJonesMatrix(1,1,:) = ampRs; ampRefJonesMatrix(1,2,:) = 0;
            ampRefJonesMatrix(2,1,:) = 0; ampRefJonesMatrix(2,2,:) = ampRp;
            
            powTransJonesMatrix(1,1,:) = powTs; powTransJonesMatrix(1,2,:) = 0;
            powTransJonesMatrix(2,1,:) = 0; powTransJonesMatrix(2,2,:) = powTp;
            
            powRefJonesMatrix(1,1,:) = powRs; powRefJonesMatrix(1,2,:) = 0;
            powRefJonesMatrix(2,1,:) = 0; powRefJonesMatrix(2,2,:) = powRp;
            
            returnData1 = ampTransJonesMatrix; % Amplitude transmission
            returnData2 = ampRefJonesMatrix; % Amplitude reflection
            returnData3 = powTransJonesMatrix; % Power transmission
            returnData4 = powRefJonesMatrix; % Power reflection
            
    end
    
end

