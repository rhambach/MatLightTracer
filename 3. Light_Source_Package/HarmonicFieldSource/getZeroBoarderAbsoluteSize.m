function [ zeroBoarderAbsoluteSize1, zeroBoarderAbsoluteSize2] = getZeroBoarderAbsoluteSize( harmonicFieldSource )
    %GETZEROBOARDERSIZE Summary of this function goes here
    %   Detailed explanation goes here
    if harmonicFieldSource.ZeroBoarderSizeSpecification == 1
        % Relative
        % Get the aabsolute field size first
        zeroBoarderSizeValue = harmonicFieldSource.ZeroBoarderSizeValue;
        [fieldSize1,fieldSize2] = getSpatialShapeAndSize( harmonicFieldSource,2 );
        zeroBoarderAbsoluteSize1 = zeroBoarderSizeValue(1)*fieldSize1;
        zeroBoarderAbsoluteSize2 = zeroBoarderSizeValue(2)*fieldSize2;
    else
        % Absolute
        zeroBoarderSizeValue = harmonicFieldSource.ZeroBoarderSizeValue;
        zeroBoarderAbsoluteSize1 = zeroBoarderSizeValue(1);
        zeroBoarderAbsoluteSize2 = zeroBoarderSizeValue(2);
    end    
    
end

