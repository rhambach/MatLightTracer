function [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(currentSurface,tableName,rowNumber)
    % getSurfaceParameters: returns the surface parameter
    % paramName,paramType,paramValue,paramValueDisp
    % tablename = 'Basic','TiltDecenter','Aperture'. If the rowNumber is
    % specified then the data for specific row will be returned.
    
    if nargin == 2
        rowNumber = 0; % Return all parameters
    end
    
    if  rowNumber == 0 % Return all parameters
        switch tableName
            case 'Basic'
                paramNames{1,1} = 'Thickness';
                paramTypes{1,1} = 'numeric';
                paramValues{1,1} = currentSurface.Thickness;
                paramValuesDisp{1,1} = currentSurface.Thickness;
                
                paramNames{2,1} = 'Glass';
                paramTypes{2,1} = 'Glass';
                paramValues{2,1} = currentSurface.Glass;
                paramValuesDisp{2,1} = currentSurface.Glass.Name;
                
                paramNames{3,1} = 'Coating';
                paramTypes{3,1} = 'Coating';
                paramValues{3,1} = currentSurface.Coating;
                paramValuesDisp{3,1} = currentSurface.Coating.Name;

                % Add additional surface type specific basic parameters
                [ uniqueParamNames, uniqueParamFormats, uniqueParametersStruct] = ...
                    getSurfaceUniqueParameters( currentSurface);
                nUniqueParams = length(uniqueParamNames);
                for kk = 1:nUniqueParams
                    paramNames{3+kk,1} = uniqueParamNames{kk};
                    paramTypes{3+kk,1} = uniqueParamFormats{kk};
                    paramValues{3+kk,1} = uniqueParametersStruct.(uniqueParamNames{kk});
                    
                    switch lower(class(paramValues{3+kk,1}))
                        case lower('logical')
                            if paramValues{3+kk,1}
                                paramValuesDisp{3+kk,1}  = '1';
                            else
                                paramValuesDisp{3+kk,1} = '0';
                            end
                        otherwise
                            paramValuesDisp{3+kk,1}  = paramValues{3+kk,1};
                    end
                end
            case 'TiltDecenter'
                curentTiltDecenterOrder = currentSurface.TiltDecenterOrder;
                paramNames{1,1} = 'TiltDecenterOrder';
                paramTypes{1,1} = {'char'};
                paramValues{1,1} = curentTiltDecenterOrder;
                paramValuesDisp{1,1} = [curentTiltDecenterOrder{:}];
                
                paramNames{2,1} = 'TiltX';
                paramTypes{2,1} = 'numeric';
                paramValues{2,1} = currentSurface.Tilt(1);
                paramValuesDisp{2,1} = currentSurface.Tilt(1);
                
                paramNames{3,1} = 'TiltY';
                paramTypes{3,1} = 'numeric';
                paramValues{3,1} = currentSurface.Tilt(2);
                paramValuesDisp{3,1} = currentSurface.Tilt(2);
                
                paramNames{4,1} = 'TiltZ';
                paramTypes{4,1} = 'numeric';
                paramValues{4,1} = currentSurface.Tilt(3);
                paramValuesDisp{4,1} = currentSurface.Tilt(3);
                
                paramNames{5,1} = 'DecenterX';
                paramTypes{5,1} = 'numeric';
                paramValues{5,1} = currentSurface.Decenter(1);
                paramValuesDisp{5,1} = currentSurface.Decenter(1);
                
                paramNames{6,1} = 'DecenterY';
                paramTypes{6,1} = 'numeric';
                paramValues{6,1} = currentSurface.Decenter(2);
                paramValuesDisp{6,1} = currentSurface.Decenter(2);
                
                paramNames{7,1} = 'TiltMode';
                paramTypes{7,1} = {'DAR','NAX','BEN'};
                paramValues{7,1} = currentSurface.TiltMode;
                paramValuesDisp{7,1} = currentSurface.TiltMode;
                
            case 'Aperture'
                currentAperture = currentSurface.Aperture;
                apertTypeCellArray = GetSupportedApertureTypes;
                currentApertType = currentAperture.Type;
                
                paramNames{1,1} = 'Type';
                paramTypes{1,1} = apertTypeCellArray;
                paramValues{1,1} = currentApertType;
                paramValuesDisp{1,1} = currentApertType;
                
                decX = currentAperture.Decenter(1);
                decY = currentAperture.Decenter(2);
                
                paramNames{2,1} = 'DecenterX';
                paramTypes{2,1} = 'numeric';
                paramValues{2,1} = decX;
                paramValuesDisp{2,1} = decX;
                
                paramNames{3,1} = 'DecenterY';
                paramTypes{3,1} = 'numeric';
                paramValues{3,1} = decY;
                paramValuesDisp{3,1} = decY;
                
                rotation = currentAperture.Rotation;
                
                paramNames{4,1} = 'Rotation';
                paramTypes{4,1} = 'numeric';
                paramValues{4,1} = rotation;
                paramValuesDisp{4,1} = rotation;
                
                drawAbsolute = currentAperture.DrawAbsolute;
                
                paramNames{5,1} = 'DrawAbsolute';
                paramTypes{5,1} = 'logical';
                paramValues{5,1} = drawAbsolute;
                paramValuesDisp{5,1} = drawAbsolute;
                
                
                apertOuterShapeCellArray = GetSupportedApertureOuterShapes;
                currentApertOuterShape = currentAperture.OuterShape;
                
                paramNames{6,1} = 'OuterShape';
                paramTypes{6,1} = apertOuterShapeCellArray;
                paramValues{6,1} = currentApertOuterShape;
                paramValuesDisp{6,1} = currentApertOuterShape;
                
                additionalEdge = currentAperture.AdditionalEdge;
                
                paramNames{7,1} = 'AdditionalEdge';
                paramTypes{7,1} = 'numeric';
                paramValues{7,1} = additionalEdge;
                paramValuesDisp{7,1} = additionalEdge;
                
                % Add additional aperture type specific parameters
                [uniqueParamNames, uniqueParamFormats,uniqueParameterStruct] = getApertureUniqueParameters( currentAperture );
                
                apertureUniqueParameters = currentAperture.UniqueParameters;
                
                nUniqueParams = length(uniqueParamNames);
                for kk = 1:nUniqueParams
                    paramNames{7+kk,1} = uniqueParamNames{kk};
                    paramTypes{7+kk,1} = uniqueParamFormats{kk};
                    paramValues{7+kk,1} = apertureUniqueParameters.(uniqueParamNames{kk});
                    
                    switch lower(class(paramValues{7+kk,1}))
                        case lower('logical')
                            if paramValues{7+kk,1}
                                paramValuesDisp{7+kk,1}  = 'True';
                            else
                                paramValuesDisp{7+kk,1} = 'False';
                            end
                        otherwise
                            paramValuesDisp{7+kk,1}  = paramValues{7+kk,1};
                    end
                end
        end
    else
        switch tableName
            case 'Basic'
                switch rowNumber
                    case 1
                        paramNames{1,1} = 'Thickness';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = currentSurface.Thickness;
                        paramValuesDisp{1,1} = currentSurface.Thickness;
                    case 2
                        paramNames{1,1} = 'Glass';
                        paramTypes{1,1} = 'Glass';
                        paramValues{1,1} = currentSurface.Glass;
                        paramValuesDisp{1,1} = currentSurface.Glass.Name;
                    case 3
                        paramNames{1,1} = 'Coating';
                        paramTypes{1,1} = 'Coating';
                        paramValues{1,1} = currentSurface.Coating;
                        paramValuesDisp{1,1} = currentSurface.Coating.Name;
                    otherwise
                        % Add additional surface type specific basic parameters
                        [ uniqueParamNames, uniqueParamFormats, uniqueParametersStruct] = ...
                            getSurfaceUniqueParameters( currentSurface);
                        
                        uniqueParamIndex = rowNumber-3;
                        paramNames{1,1} = uniqueParamNames{uniqueParamIndex};
                        paramTypes{1,1} = uniqueParamFormats{uniqueParamIndex};
                        paramValues{1,1} = uniqueParametersStruct.(uniqueParamNames{uniqueParamIndex});
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
                curentTiltDecenterOrder = currentSurface.TiltDecenterOrder;
                switch rowNumber
                    case 1
                        paramNames{1,1} = 'TiltDecenterOrder';
                        paramTypes{1,1} = {'char'};
                        paramValues{1,1} = curentTiltDecenterOrder;
                        paramValuesDisp{1,1} = [curentTiltDecenterOrder{:}];
                    case 2
                        paramNames{1,1} = 'TiltX';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = currentSurface.Tilt(1);
                        paramValuesDisp{1,1} = currentSurface.Tilt(1);
                    case 3
                        paramNames{1,1} = 'TiltY';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = currentSurface.Tilt(2);
                        paramValuesDisp{1,1} = currentSurface.Tilt(2);
                    case 4
                        paramNames{1,1} = 'TiltY';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = currentSurface.Tilt(2);
                        paramValuesDisp{1,1} = currentSurface.Tilt(2);
                    case 5
                        paramNames{1,1} = 'DecenterX';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = currentSurface.Decenter(1);
                        paramValuesDisp{1,1} = currentSurface.Decenter(1);
                    case 6
                        paramNames{1,1} = 'DecenterY';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = currentSurface.Decenter(2);
                        paramValuesDisp{1,1} = currentSurface.Decenter(2);
                    case 7
                        paramNames{1,1} = 'TiltMode';
                        paramTypes{1,1} = {'DAR','NAX','BEN'};
                        paramValues{1,1} = currentSurface.TiltMode;
                        paramValuesDisp{1,1} = currentSurface.TiltMode;
                    otherwise
                end
            case 'Aperture'
                currentAperture = currentSurface.Aperture;
                apertTypeCellArray = GetSupportedApertureTypes;
                currentApertType = currentAperture.Type;
                
                switch rowNumber
                    case 1
                        paramNames{1,1} = 'Type';
                        paramTypes{1,1} = apertTypeCellArray;
                        paramValues{1,1} = currentApertType;
                        paramValuesDisp{1,1} = currentApertType;
                    case 2
                        decX = currentAperture.Decenter(1);
                        paramNames{1,1} = 'DecenterX';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = decX;
                        paramValuesDisp{1,1} = decX;
                    case 3
                        decY = currentAperture.Decenter(2);
                        paramNames{1,1} = 'DecenterY';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = decY;
                        paramValuesDisp{1,1} = decY;
                    case 4
                        rotation = currentAperture.Rotation;
                        
                        paramNames{1,1} = 'Rotation';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = rotation;
                        paramValuesDisp{1,1} = rotation;
                    case 5
                        drawAbsolute = currentAperture.DrawAbsolute;
                        
                        paramNames{1,1} = 'DrawAbsolute';
                        paramTypes{1,1} = 'logical';
                        paramValues{1,1} = drawAbsolute;
                        paramValuesDisp{1,1} = drawAbsolute;
                    case 6
                        apertOuterShapeCellArray = GetSupportedApertureOuterShapes;
                        currentApertOuterShape = currentAperture.OuterShape;
                        
                        paramNames{1,1} = 'OuterShape';
                        paramTypes{1,1} = apertOuterShapeCellArray;
                        paramValues{1,1} = currentApertOuterShape;
                        paramValuesDisp{1,1} = currentApertOuterShape;
                    case 7
                        additionalEdge = currentAperture.AdditionalEdge;
                        paramNames{1,1} = 'AdditionalEdge';
                        paramTypes{1,1} = 'numeric';
                        paramValues{1,1} = additionalEdge;
                        paramValuesDisp{1,1} = additionalEdge;
                    otherwise
                        % Add additional aperture type specific parameters
                        [uniqueParamNames, uniqueParamFormats,uniqueParameterStruct] = getApertureUniqueParameters( currentAperture );
                        apertureUniqueParameters = currentAperture.UniqueParameters;
                        
                        uniqueParamIndex = rowNumber-7;
                        paramNames{1,1} = uniqueParamNames{uniqueParamIndex};
                        paramTypes{1,1} = uniqueParamFormats{uniqueParamIndex};
                        paramValues{1,1} = apertureUniqueParameters.(uniqueParamNames{uniqueParamIndex});
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
        end
    end
end

