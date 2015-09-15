function [ zeroBoarderSamplePoints1, zeroBoarderSamplePoints2] = getZeroBoarderSamplePoints( harmonicFieldSource )
    %GETZEROBOARDERSIZE Summary of this function goes here
    %   Detailed explanation goes here
    [ zeroBoarderAbsoluteSize1, zeroBoarderAbsoluteSize2] = getZeroBoarderAbsoluteSize( harmonicFieldSource );
    [ dx,dy ] = getSamplingDistance( harmonicFieldSource );
    zeroBoarderSamplePoints1 = (zeroBoarderAbsoluteSize1/dx) + 1;
    zeroBoarderSamplePoints2 = (zeroBoarderAbsoluteSize2/dy) + 1;  
end

