function [ paramNames,paramFormats,paramValues,paramValuesDisp] = ...
        getComponentParameters(currentComponent,tableName,rowNumber)
    % getComponentParameters: returns the component parameter
    % paramName,paramType,paramValue,paramValueDisp
    % tablename = 'Basic','TiltDecenter','Aperture'. If the rowNumber is
    % specified then the data for specific row will be returned.
    
    if nargin == 2
        rowNumber = 0; % Return all parameters
    end
    
    if  rowNumber == 0 % Return all parameters
        switch tableName
            case 'Basic'
                paramNames{1,1} = 'LastThickness';
                paramFormats{1,1} = 'numeric';
                paramValues{1,1} = currentComponent.LastThickness;
                paramValuesDisp{1,1} = currentComponent.LastThickness;
                
                % Add additional component type specific basic parameters
                componentDefinitionFileName = currentComponent.Type;
                % Connect the component definition function
                componentDefinitionHandle = str2func(componentDefinitionFileName);
                returnFlag = 2; % Other Basic parameters of the component
                %                 [ uniqueParamNames, uniqueParamFormats, defualtParameterStruct] = componentDefinitionHandle(returnFlag);
                [ returnDataStruct] = componentDefinitionHandle(returnFlag);
                uniqueParamNames = returnDataStruct.UniqueParametersStructFieldNames;
                uniqueParamFormats = returnDataStruct.UniqueParametersStructFieldFormats;
                
                componentParameters = currentComponent.UniqueParameters;
                
                nUniqueParams = length(uniqueParamNames);
                for kk = 1:nUniqueParams
                    paramNames{1+kk,1} = uniqueParamNames{kk};
                    paramFormats{1+kk,1} = uniqueParamFormats{kk};
                    paramValues{1+kk,1} = componentParameters.(uniqueParamNames{kk});
                    
                    currentParameter = paramValues{1+kk,1};
                    if isnumeric(currentParameter)||ischar(currentParameter)
                        paramValuesDisp{1+kk,1}  = currentParameter;
                    elseif islogical(currentParameter)
                        if currentParameter
                            paramValuesDisp{1+kk,1}  = '1';
                        else
                            paramValuesDisp{1+kk,1} = '0';
                        end
                    elseif isGlass(currentParameter) || isCoating(currentParameter)
                        paramValuesDisp{1+kk,1}  = componentParameters.(uniqueParamNames{kk}).Name;
                    elseif isSurface(currentParameter)
                        paramValuesDisp{1+kk,1}  = 'SQS';
                    else
                        paramValuesDisp{1+kk,1}  = 'INVALID';
                    end
                end
            case 'TiltDecenter'
                curentTiltDecenterOrder = currentComponent.FirstTiltDecenterOrder;
                paramNames{1,1} = 'TiltDecenterOrder';
                paramFormats{1,1} = {'char'};
                paramValues{1,1} = curentTiltDecenterOrder;
                paramValuesDisp{1,1} = [curentTiltDecenterOrder{:}];
                
                paramNames{2,1} = 'TiltX';
                paramFormats{2,1} = 'numeric';
                paramValues{2,1} = currentComponent.FirstTilt(1);
                paramValuesDisp{2,1} = currentComponent.FirstTilt(1);
                
                paramNames{3,1} = 'TiltY';
                paramFormats{3,1} = 'numeric';
                paramValues{3,1} = currentComponent.FirstTilt(2);
                paramValuesDisp{3,1} = currentComponent.FirstTilt(2);
                
                paramNames{4,1} = 'TiltZ';
                paramFormats{4,1} = 'numeric';
                paramValues{4,1} = currentComponent.FirstTilt(3);
                paramValuesDisp{4,1} = currentComponent.FirstTilt(3);
                
                paramNames{5,1} = 'DecenterX';
                paramFormats{5,1} = 'numeric';
                paramValues{5,1} = currentComponent.FirstDecenter(1);
                paramValuesDisp{5,1} = currentComponent.FirstDecenter(1);
                
                paramNames{6,1} = 'DecenterY';
                paramFormats{6,1} = 'numeric';
                paramValues{6,1} = currentComponent.FirstDecenter(2);
                paramValuesDisp{6,1} = currentComponent.FirstDecenter(2);
                
                paramNames{7,1} = 'ComponentTiltMode';
                paramFormats{7,1} = {'DAR','NAX','BEN'};
                paramValues{7,1} = currentComponent.ComponentTiltMode;
                paramValuesDisp{7,1} = currentComponent.ComponentTiltMode;
        end
    else
        switch tableName
            case 'Basic'
                switch rowNumber
                    case 1
                        paramNames{1,1} = 'LastThickness';
                        paramFormats{1,1} = 'numeric';
                        paramValues{1,1} = currentComponent.LastThickness;
                        paramValuesDisp{1,1} = currentComponent.LastThickness;
                    otherwise
                        % Add additional component type specific basic parameters
                        componentDefinitionFileName = currentComponent.Type;
                        % Connect the component definition function
                        componentDefinitionHandle = str2func(componentDefinitionFileName);
                        returnFlag = 2; % Other Basic parameters of the component
                        %                         [ uniqueParamNames, uniqueParamFormats, defualtParameterStruct] = componentDefinitionHandle(returnFlag);
                        [ returnDataStruct] = componentDefinitionHandle(returnFlag);
                        uniqueParamNames = returnDataStruct.UniqueParametersStructFieldNames;
                        uniqueParamFormats = returnDataStruct.UniqueParametersStructFieldFormats;
                        
                        componentParameters = currentComponent.UniqueParameters;
                        
                        uniqueParamIndex = rowNumber-1;
                        paramNames{1,1} = uniqueParamNames{uniqueParamIndex};
                        paramFormats{1,1} = uniqueParamFormats{uniqueParamIndex};
                        paramValues{1,1} = componentParameters.(uniqueParamNames{uniqueParamIndex});
                        switch lower(class(paramValues{1,1}))
                            case lower('logical')
                                if paramValues{1,1}
                                    paramValuesDisp{1,1}  = '1';
                                else
                                    paramValuesDisp{1,1} = '0';
                                end
                            otherwise
                                paramValuesDisp{1,1}  = paramValues{1,1};
                        end
                end
            case 'TiltDecenter'
                curentTiltDecenterOrder = currentComponent.FirstTiltDecenterOrder;
                switch rowNumber
                    case 1
                        paramNames{1,1} = 'TiltDecenterOrder';
                        paramFormats{1,1} = {'char'};
                        paramValues{1,1} = curentTiltDecenterOrder;
                        paramValuesDisp{1,1} = [curentTiltDecenterOrder{:}];
                    case 2
                        paramNames{1,1} = 'TiltX';
                        paramFormats{1,1} = 'numeric';
                        paramValues{1,1} = currentComponent.FirstTilt(1);
                        paramValuesDisp{1,1} = currentComponent.FirstTilt(1);
                    case 3
                        paramNames{1,1} = 'TiltY';
                        paramFormats{1,1} = 'numeric';
                        paramValues{1,1} = currentComponent.FirstTilt(2);
                        paramValuesDisp{1,1} = currentComponent.FirstTilt(2);
                    case 4
                        paramNames{1,1} = 'TiltY';
                        paramFormats{1,1} = 'numeric';
                        paramValues{1,1} = currentComponent.FirstTilt(2);
                        paramValuesDisp{1,1} = currentComponent.FirstTilt(2);
                    case 5
                        paramNames{1,1} = 'DecenterX';
                        paramFormats{1,1} = 'numeric';
                        paramValues{1,1} = currentComponent.FirstDecenter(1);
                        paramValuesDisp{1,1} = currentComponent.FirstDecenter(1);
                    case 6
                        paramNames{1,1} = 'DecenterY';
                        paramFormats{1,1} = 'numeric';
                        paramValues{1,1} = currentComponent.FirstDecenter(2);
                        paramValuesDisp{1,1} = currentComponent.FirstDecenter(2);
                    case 7
                        paramNames{1,1} = 'ComponentTiltMode';
                        paramFormats{1,1} = {'DAR','NAX','BEN'};
                        paramValues{1,1} = currentComponent.ComponentTiltMode;
                        paramValuesDisp{1,1} = currentComponent.ComponentTiltMode;
                    otherwise
                end
        end
    end
end

