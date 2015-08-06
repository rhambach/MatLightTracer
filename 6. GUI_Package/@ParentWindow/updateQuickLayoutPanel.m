function  updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex)
    aodHandles = parentWindow.ParentHandles;
    layoutType = get(aodHandles.popQuickLayoutType,'Value'); % 1 : None, 2: System 3: system or component
    layoutDim = get(aodHandles.popQuickLayoutDimension,'Value'); % 1 : 2D, 2: 3D
    plotIn2D = 0;
    axesHandle = aodHandles.axesQuickLayout;
    cla(axesHandle,'reset');
    switch layoutType
        case 1
            % Do nothing
            set(axesHandle,'Visible','off');
        case 2
            % plot the system layout
            set(axesHandle,'Visible','on');
            if layoutDim == 1
                plotIn2D = 1;
            end
            nPoints1 = 'default';
            nPoints2 = 'default';
            
            drawEdge = 1;
            [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow);
            surfaceArray = getNonDummySurfaceArray(updatedSystem);
            
            drawSurfaceArray...
                (surfaceArray,plotIn2D,nPoints1,nPoints2,...
                axesHandle,drawEdge);
        case 3
            % plot the component or surface layout
            set(axesHandle,'Visible','on');
            if layoutDim == 1
                plotIn2D = 1;
            end
            nPoints1 = 'default';
            nPoints2 = 'default';
            drawEdge = 1;
            [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow);
            systemDefType = updatedSystem.SystemDefinitionType;
            if strcmpi(systemDefType,'SurfaceBased')
                surfaceArray = updatedSystem.SurfaceArray(selectedSurfOrCompIndex);
                if strcmpi(surfaceArray.Type,'Dummy')
                    surfaceArray = [];
                end
            else
                surfaceArray = getComponentNonDummySurfaceArray(updatedSystem.ComponentArray(selectedSurfOrCompIndex));
            end
            if ~isempty(surfaceArray)
                drawSurfaceArray...
                    (surfaceArray,plotIn2D,nPoints1,nPoints2,...
                    axesHandle,drawEdge);
            end
            axis equal;
    end
end

