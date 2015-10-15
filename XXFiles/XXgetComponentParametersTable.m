function [ componentParametersTable,componentParametersTableDisplay ] = ...
        getComponentParametersTable(currentComponent)
    % getComponentParametersTable: returns the component parameters table
    % cell matrix of Name-Value-Type and table to be displayed in the component
    % defintion window.
    % Input:
    %   ( currentComponent )
    % Output:
    %   [ componentParametersTable,componentParametersTableDisplay ]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original version
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    componentDefinitionFileName = currentComponent.Type;
    % Connect the component definition function
    componentDefinitionHandle = str2func(componentDefinitionFileName);
    returnFlag = 2; % Basic parameters of the component
    %     [ paramNames, paramTypes, defaultValue] = componentDefinitionHandle(returnFlag);
    returnDataStruct = componentDefinitionHandle(returnFlag);
    paramNames = returnDataStruct.UniqueParametersStructFieldNames;
    paramFormats = returnDataStruct.UniqueParametersStructFieldFormats;
    defaultValue = returnDataStruct.DefaultUniqueParametersStruct;
    
    componentParameters = currentComponent.Parameters;
    
    nParam = length(paramNames);
    paramValues = cell(1,nParam);
    for kk = 1:nParam
        paramValues{kk} = componentParameters.(paramNames{kk});
        switch lower(class(paramValues{kk}))
            case lower('Surface')
                paramValuesDisp{kk} = 'SQS';
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
    
    componentParametersTable(:,1) = paramNames;
    componentParametersTable(:,2) = paramValues;
    componentParametersTable(:,3) = paramFormats;
    
    
    componentParametersTableDisplay(:,1) = paramNames;
    componentParametersTableDisplay(:,2) = paramValuesDisp;
    componentParametersTableDisplay(:,3) = {'Edit'};
end

