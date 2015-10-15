function [stopElementIndex,stopSurfaceIndex,specified] = getStopElementIndex(optSystem)
    % getStopIndex: gives the stop index surface set by user
    stopElementIndex = 0;
    specified = 0;
    for kk=1:1:length(optSystem.OpticalElementArray)
        currentStopSurfaceIndex = optSystem.OpticalElementArray{kk}.StopSurfaceIndex;
        if currentStopSurfaceIndex
            stopSurfaceIndex = currentStopSurfaceIndex;
            stopElementIndex = kk;
            specified = 1;
            return;
        end
    end
end