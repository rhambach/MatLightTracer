function  displayOpticalSystemDetail(parentWindow)
    aodHandles = parentWindow.AODParentHandles;
    % Plot the system layout
    plotIn2D = ~(get(aodHandles.chk3DSystemLayout,'Value'));
    nPoints1 = 'default';
    nPoints2 = 'default';
    axesHandle = aodHandles.axesSystemLayout;
    drawEdge = 1;
    surfaceArray = aodHandles.OpticalSystem.getNonDummySurfaceArray;
    cla(aodHandles.axesSystemLayout,'reset');
    drawSurfaceArray...
        (surfaceArray,plotIn2D,nPoints1,nPoints2,...
        axesHandle,drawEdge);
    % Display quick system analysis
    
end

