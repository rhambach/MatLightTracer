function [diameterXNew,diameterYNew, boarderShape] = getSpatialShapeAndSize( harmonicFieldSource,boarderLevelIndex )
    %GETSPATIALSHAPEANDSIZE Summary of this function goes here
    %   Detailed explanation goes here
    
    % We have three field boarderLevelIndices
    % 1. Actual field size,
    % 2. + With smooth edge
    % 3. + With additional zero boarder
    % The boarderShape is that of the actual field and that with smooth edge.
    % The outer most shape is usually rectangulr.
    
    switch boarderLevelIndex
        case 1
            % 1. Actual field size,
            spatialProfileType = harmonicFieldSource.SpatialProfileType;
            spatialProfileParameter = harmonicFieldSource.SpatialProfileParameter;
            
            % Connect the surface definition function
            spatialDefinitionHandle = str2func(getSupportedSpatialProfiles(spatialProfileType));
            returnFlag = 2;
            [returnDataStruct] = spatialDefinitionHandle(returnFlag,spatialProfileParameter);
            actualFieldShape = returnDataStruct.BoarderShape;
            actualFieldSize = returnDataStruct.BoarderDiameter;
            
            fieldSizeSpecification = harmonicFieldSource.FieldSizeSpecification;
            if fieldSizeSpecification == 1 % relative
                relativeFieldSizeFactor = harmonicFieldSource.FieldSizeValue;
                diameterX = relativeFieldSizeFactor(1)*actualFieldSize(1);
                diameterY = relativeFieldSizeFactor(2)*actualFieldSize(2);
                boarderShape = actualFieldShape;
            elseif fieldSizeSpecification == 2 % absolute
                absoluteBoarderShape = harmonicFieldSource.FieldBoarderShape;
                absoluteFieldSize = harmonicFieldSource.FieldSizeValue;
                diameterX = absoluteFieldSize(1);
                diameterY = absoluteFieldSize(2);
                boarderShape = absoluteBoarderShape;
            end
            
                        % Consider the lateral offset. Increase the size so that the center of
            % the whole field is at origin.
            Cx = harmonicFieldSource.LateralPosition(1);
            Cy = harmonicFieldSource.LateralPosition(2);
%             Cx = 0;
%             Cy = 0;
            diameterXNew = diameterX + abs(Cx); %2*max(abs([Cx+diameterX/2,Cx-diameterX/2]));
            diameterYNew = diameterY + abs(Cy); %2*max(abs([Cy+diameterY/2,Cy-diameterY/2]));

% diameterXNew = diameterX;
%             diameterYNew = diameterY;
        case 2
            [diameterX1,diameterY1, boarderShape] = getSpatialShapeAndSize( harmonicFieldSource,1 );
            % 2. With smooth edge
            edgeSizeSpecification = harmonicFieldSource.SmoothEdgeSizeSpecification;
            if edgeSizeSpecification == 1 % Relative
                relativeEdgeSizeFactor = harmonicFieldSource.SmoothEdgeSizeValue;
                diameterX = diameterX1 + 2*diameterX1*relativeEdgeSizeFactor(1);
                diameterY = diameterY1 + 2*diameterY1*relativeEdgeSizeFactor(2);
            else
                absoluteEdgeSize = harmonicFieldSource.SmoothEdgeSizeValue;
                diameterX = diameterX1 + 2*absoluteEdgeSize(1);
                diameterY = diameterY1 + 2*absoluteEdgeSize(2);
            end
            diameterXNew = diameterX;
            diameterYNew = diameterY;
        case 3
            % 3. With additional zero boarder
            [diameterX2,diameterY2] = getSpatialShapeAndSize( harmonicFieldSource,2 );
            [ zeroBoarderAbsoluteSize1, zeroBoarderAbsoluteSize2] = getZeroBoarderAbsoluteSize( harmonicFieldSource );
            % The zero boarder should be increased to fit to the next pixel
            % edge
            diameterX = diameterX2 + 2*zeroBoarderAbsoluteSize1;
            diameterY = diameterY2 + 2*zeroBoarderAbsoluteSize2;
            boarderShape = 2; % rectangle

            diameterXNew = diameterX;
            diameterYNew = diameterY;
        otherwise
    end
    
    
end

