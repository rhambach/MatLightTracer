function [ isMeritFunction ] = isMeritFunction( currentMeritFunction )
    %ISMeritFunction Summary of this function goes here
    %   Detailed explanation goes here
    isMeritFunction = 0;
    if isstruct(currentMeritFunction)
        if isfield(currentMeritFunction,'ClassName') && strcmpi(currentMeritFunction.ClassName,'MeritFunction')
           isMeritFunction = 1; 
        end
    else
        if strcmpi(class(currentMeritFunction),'MeritFunction')
            isMeritFunction = 1; 
        end
    end
    
end

