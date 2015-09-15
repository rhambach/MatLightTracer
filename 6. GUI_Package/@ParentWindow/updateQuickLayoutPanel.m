function  updateQuickLayoutPanel(parentWindow,selectedSurfOrCompIndex)
    % Updates the quick system layout and the paraxial parameters in task
    % bar.
    
    % Quick system layout
    aodHandles = parentWindow.ParentHandles;
    layoutType = get(aodHandles.popQuickLayoutType,'Value'); % 1 : None, 2: System 3: system or component
    layoutDim = get(aodHandles.popQuickLayoutDimension,'Value'); % 1 : 2D, 2: 3D
    plotIn2D = 0;
    axesHandle = aodHandles.axesQuickLayout;
    cla(axesHandle,'reset');
    [ updatedSystem,saved] = getCurrentOpticalSystem (parentWindow);
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
            if IsSurfaceBased(updatedSystem) 
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
    
    % Quick system paraxial properties
    totalTrack = getTotalTrack(updatedSystem);
    effl = getEffectiveFocalLength(updatedSystem);
    angMag = getAngularMagnification(updatedSystem);
    objNA = getObjectNA(updatedSystem);
    imageNA = getImageNA(updatedSystem);
    
    set(aodHandles.lblTaskBar(1),'String',['System Total Track : ',num2str(totalTrack)]);
    set(aodHandles.lblTaskBar(2),'String',['Effective Focal Length : ',num2str(effl)]);
    set(aodHandles.lblTaskBar(3),'String',['Angular Magnification : ',num2str(angMag)]);
    set(aodHandles.lblTaskBar(4),'String',['Object Space NA : ',num2str(objNA)]);
    set(aodHandles.lblTaskBar(5),'String',['Image Space NA : ',num2str(imageNA)]);
end

