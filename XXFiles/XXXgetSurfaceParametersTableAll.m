function [ surfaceParametersTable_Basic,surfaceParametersTableDisplay_Basic,...
        surfaceParametersTable_TiltDecenter,surfaceParametersTableDisplay_TiltDecenter,...
        surfaceParametersTable_Aperture,surfaceParametersTableDisplay_Aperture] = ...
        getSurfaceParametersTableAll(currentSurface,parameterID)
    % getSurfaceParametersTable: returns the surface parameters table
    % cell matrix of Name-Value-Type and table to be displayed in the surface
    % defintion window.
    % Inputs:
    %   (currentSurface,parameterID)
    % Outputs:
    %   [ surfaceParametersTable_Basic,surfaceParametersTableDisplay_Basic,...
    %   surfaceParametersTable_TiltDecenter,surfaceParametersTableDisplay_TiltDecenter,...
    %   surfaceParametersTable_Aperture,surfaceParametersTableDisplay_Aperture]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
        
    % Basic surface parameters
    basicParamNames = {'Thickness','Glass','Coating'}';
    basicParamValues = {currentSurface.Thickness,currentSurface.Glass.Name,currentSurface.Coating.Name}';
    basicParamValuesDisp = basicParamValues;
    basicParamTypes = {'numeric','char','char'}';
    
    % Add additional surface type specific basic parameters
    surfaceDefinitionFileName = currentSurface.Type;
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceDefinitionFileName);
    returnFlag = 'SSPB'; % Other Basic parameters of the surface
    [ paramNames, paramTypes, defaultValue] = surfaceDefinitionHandle(returnFlag);
    surfaceParameters = currentSurface.UniqueParameters;
    
    nParam = length(paramNames);
    paramValues = cell(1,nParam);
    for kk = 1:nParam
        paramValues{kk} = surfaceParameters.(paramNames{kk});
        switch lower(class(paramValues{kk}))
            case lower('logical')
                if paramValues{kk}
                    paramValuesDisp{kk} = 'True';
                else
                    paramValuesDisp{kk} = 'False';
                end
            otherwise
                paramValuesDisp{kk} = paramValues{kk};
        end
    end
    
    surfaceParametersTable_Basic(1:3,1) = basicParamNames;
    surfaceParametersTable_Basic(1:3,2) = basicParamValues;
    surfaceParametersTable_Basic(1:3,3) = basicParamTypes;
    
    surfaceParametersTable_Basic(4:3+nParam,1) = paramNames;
    surfaceParametersTable_Basic(4:3+nParam,2) = paramValues;
    surfaceParametersTable_Basic(4:3+nParam,3) = paramTypes;
    
    
    surfaceParametersTableDisplay_Basic(1:3,1) = basicParamNames;
    surfaceParametersTableDisplay_Basic(1:3,2) = basicParamValuesDisp;
    surfaceParametersTableDisplay_Basic(1:3,3) =  {'Edit'};
    
    surfaceParametersTableDisplay_Basic(4:3+nParam,1) = paramNames;
    surfaceParametersTableDisplay_Basic(4:3+nParam,2) = paramValuesDisp;
    surfaceParametersTableDisplay_Basic(4:3+nParam,3) =  {'Edit'};
    
    % Tilt and decenter parameters
    tiltDecenterParamNames = {'TiltDecenterOrder','TiltX','TiltY','TiltZ','DecenterX','DecenterY','TiltMode'}';
    tiltDecenterParamValues = {currentSurface.TiltDecenterOrder,...
        currentSurface.TiltParameter(1),currentSurface.TiltParameter(2),currentSurface.TiltParameter(3),...
        currentSurface.DecenterParameter(1),currentSurface.DecenterParameter(2),...
        currentSurface.TiltMode}';
    tiltDecenterParamValuesDisp = tiltDecenterParamValues;
    tiltDecenterParamTypes = {'char','numeric','numeric','numeric','numeric','numeric',{'DAR','NAX','BEN'}}';
    
    
    surfaceParametersTable_TiltDecenter(:,1) = tiltDecenterParamNames;
    surfaceParametersTable_TiltDecenter(:,2) = tiltDecenterParamValues;
    surfaceParametersTable_TiltDecenter(:,3) =  tiltDecenterParamTypes;
    
    surfaceParametersTableDisplay_TiltDecenter(:,1) = tiltDecenterParamNames;
    surfaceParametersTableDisplay_TiltDecenter(:,2) = tiltDecenterParamValuesDisp;
    surfaceParametersTableDisplay_TiltDecenter(:,3) =  {'Edit'};
    
    % aperture  parameters
    apertureParamNames = {'ApertureType','HalfWidthX','HalfWidthY','DecenterX','DecenterY','ClearAperture','AdditionalEdge','AbsoluteAperture'}';
    apertureParamValues = {currentSurface.ApertureType,...
        currentSurface.ApertureParameter(1),currentSurface.ApertureParameter(2),currentSurface.ApertureParameter(3),...
        currentSurface.ApertureParameter(4),currentSurface.ClearAperture,currentSurface.AdditionalEdge,...
        currentSurface.AbsoluteAperture}';
    apertureParamValuesDisp = apertureParamValues;
    apertureParamTypes = {{'None' 'Floating' 'Circular' 'Rectangular' 'Elliptical'},'numeric','numeric','numeric','numeric','numeric','numeric','logical'}';
    
    
    surfaceParametersTable_Aperture(:,1) = apertureParamNames;
    surfaceParametersTable_Aperture(:,2) = apertureParamValues;
    surfaceParametersTable_Aperture(:,3) =  apertureParamTypes;
    
    surfaceParametersTableDisplay_Aperture(:,1) = apertureParamNames;
    surfaceParametersTableDisplay_Aperture(:,2) = apertureParamValuesDisp;
    surfaceParametersTableDisplay_Aperture(:,3) =  {'Edit'};
    
end

