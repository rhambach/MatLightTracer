function [stopIndex, specified] = getStopComponentIndex(optSystem)
    % getStopIndex: gives the stop index surface set by user
    stopIndex = 0;
    specified = 0;
    for kk=1:1:getNumberOfComponents(optSystem)
        if optSystem.ComponentArray(kk).StopSurfaceIndex
            stopIndex = kk;
            specified = 1;
            return;
        end
    end
    
    specified = 0;
    
    if stopIndex == 0
        disp('Error: The stop surface is not fixed. So the first surface is used instead.');
        stopIndex = 1;
    end
end