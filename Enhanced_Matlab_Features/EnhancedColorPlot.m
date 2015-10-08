function [ pcolorHandle,mainAxesHandle ] = EnhancedColorPlot( input_args,...
        sectionPlotAxesHandle,interpolationMethod,lineColor,lineWidth )
    %EnhancedColorPlot This is enahnced version of matlab pcolor function.
    % The enahncement is addition of cross sectional viewing feature
    % The user can easily draw a line on a pcolor plot and then the cross
    % sectional 1D plot will be displayed in a new figure. Awesome -:)
    if nargin < 1
        mainAxesHandle = axes;
        input_args = {mainAxesHandle,peaks};
    end
    pcolorHandle = pcolor(input_args{:});
    mainAxesHandle = get(pcolorHandle,'parent');
    shading(mainAxesHandle,'interp');
    grid(mainAxesHandle,'off');
    
    if nargin < 2
        figure;
        sectionPlotAxesHandle = axes;
    end
    
    if nargin < 3
        interpolationMethod = 'spline'; %'linear', 'nearest', 'pchip','cubic', or 'spline'
    end
    if nargin < 4
        lineColor = 'w';
    end
    if nargin < 5
        lineWidth = 1.0;
    end
    
    hold on;
    maxZ = max(max(get(pcolorHandle,'ZData')));
    mainAxesHandle = get(pcolorHandle,'Parent');
    hold(mainAxesHandle,'on');
    arrowHandle = quiver3(mainAxesHandle, 0,0,maxZ,0,0,0,0,'color',lineColor,...
        'LineWidth',lineWidth ) ;
    set(pcolorHandle,'ButtonDownFcn',{@mouseButtonDown_Callback,mainAxesHandle,...
        arrowHandle,pcolorHandle,sectionPlotAxesHandle,interpolationMethod})
    
    
    mainFigure = ancestor(mainAxesHandle,'Figure');
    crossSectionFigure = ancestor(sectionPlotAxesHandle,'Figure');
    
    
    set(mainFigure,'CloseRequestFcn',{@mainFigureCloseRequest_Callback,...
        crossSectionFigure});
    % Set name of the cross section window
    set(crossSectionFigure,'Name',['Cross section view of Figure ',...
        num2str(get(mainFigure,'Number'))]);
    if crossSectionFigure ~= mainFigure
        set(crossSectionFigure,'CloseRequestFcn',{@crossSectionFigureCloseRequest_Callback});
    end
    
    
end

function mouseButtonDown_Callback(hObject,~,axesHandle,arrowHandle,...
        pcolorHandle,sectionPlotAxesHandle,interpolationMethod)
    initialCoord = get(axesHandle,'CurrentPoint');
    initialX = initialCoord(1,1);
    initialY = initialCoord(1,2);
    set(arrowHandle,'XData',initialX,'YData',initialY,'UData',0,'VData',0);
    %disp('mouse down event')
    
    fig = ancestor(hObject,'figure');
    % get the values and store them in the figure's appdata
    props.WindowButtonMotionFcn = get(fig,'WindowButtonMotionFcn');
    props.WindowButtonUpFcn = get(fig,'WindowButtonUpFcn');
    
    setappdata(fig,'TestGuiCallbacks',props);
    
    set(fig,'WindowButtonMotionFcn',{@windowButtonMotion_Callback,axesHandle,...
        arrowHandle,initialX,initialY,pcolorHandle,sectionPlotAxesHandle,...
        interpolationMethod})
    set(fig,'WindowButtonUpFcn',{@windowButtonUp_Callback,axesHandle,arrowHandle,...
        initialX,initialY,pcolorHandle,sectionPlotAxesHandle,interpolationMethod})
end

% ---------------------------
function windowButtonMotion_Callback(~,~,mainAxesHandle,arrowHandle,initialX,...
        initialY,pcolorHandle,sectionPlotAxesHandle,interpolationMethod)
    currentCoord = get(mainAxesHandle,'CurrentPoint');
    currentX = currentCoord(1,1);
    currentY = currentCoord(1,2);
    UData = currentX - initialX;
    VData = currentY - initialY;
    updateArrow(arrowHandle,UData,VData);
    crossSectionTitle = get(mainAxesHandle,'title');
    crossSectionTitle = crossSectionTitle.String;
    crossSectionZLable = get(mainAxesHandle,'zlabel');
    crossSectionZLable = crossSectionZLable.String;
    crossSectionXLable = 'Position (m)';
    updateCrossSectionPlot(pcolorHandle,arrowHandle,sectionPlotAxesHandle,...
         interpolationMethod,crossSectionTitle,crossSectionZLable,crossSectionXLable);
    %disp(['motion event '])
end
% ---------------------------
function windowButtonUp_Callback(hObject,~,mainAxesHandle,arrowHandle,initialX,...
        initialY,pcolorHandle,sectionPlotAxesHandle,interpolationMethod)
    currentCoord = get(mainAxesHandle,'CurrentPoint');
    currentX = currentCoord(1,1);
    currentY = currentCoord(1,2);
    UData = currentX - initialX;
    VData = currentY - initialY;
    updateArrow(arrowHandle,UData,VData);
    
    crossSectionTitle = get(mainAxesHandle,'title');
    crossSectionTitle = crossSectionTitle.String;
    crossSectionZLable = get(mainAxesHandle,'zlabel');
    crossSectionZLable = crossSectionZLable.String;
    crossSectionXLable = 'Position (m)';
    
    updateCrossSectionPlot(pcolorHandle,arrowHandle,sectionPlotAxesHandle,...
        interpolationMethod,crossSectionTitle,crossSectionZLable,crossSectionXLable);
    %disp('mouse up event')
    
    fig = ancestor(hObject,'figure');
    
    props = getappdata(fig,'TestGuiCallbacks');
    set(fig,props);
    setappdata(fig,'TestGuiCallbacks',[]);
end
function updateArrow(arrowHandle,UData,VData)
    set(arrowHandle,'UData',UData,'VData',VData);
end

function updateCrossSectionPlot(pcolorHandle,arrowHandle,sectionPlotAxesHandle,...
        interpolationMethod,crossSectionTitle,crossSectionZLable,crossSectionXLable)
    % Get the pcolor plot data
    xData = get(pcolorHandle,'XData');
    yData = get(pcolorHandle,'YData');
    
    % If XData and yData are ngrids thenconvert to meshgrids
    if size(xData,1) == 1 || size(xData,2) == 1
        [X,Y] = meshgrid(xData,yData);
    else
        X = xData;
        Y = yData;
    end
    
    V = get(pcolorHandle,'CData');
    % get the arrow (required cross sectionj) initial and final points
    initialX = get(arrowHandle,'XData');
    initialY = get(arrowHandle,'YData');
    finalX = initialX + get(arrowHandle,'UData');
    finalY = initialY + get(arrowHandle,'VData');
    nq = sqrt(sum((size(X)).^2)); %nCrossSectionSampling
    xq = (linspace(initialX,finalX,nq))';
    yq = (linspace(initialY,finalY,nq))';
    
    
    % Use the given interpolation method and obtain the ZData of the color
    % plot at the given sampling points
    Vq = interp2(X,Y,V,xq,yq,interpolationMethod);
    
    pos = sqrt((xq-initialX).^2+(yq-initialY).^2);
    % Plot the cross section view
    cla(sectionPlotAxesHandle,'reset')
    plot(sectionPlotAxesHandle,pos,Vq);
    
    % Set  title,xlabel,ylabel of the cross section axes
    if isempty(crossSectionTitle)
        crossSectionTitle = 'Untitled';
    end
    if isempty(crossSectionXLable)
        crossSectionXLable = 'Unlabled';
    end
    if isempty(crossSectionZLable)
        crossSectionZLable = 'Unlabled';
    end
    title(sectionPlotAxesHandle,crossSectionTitle);
    xlabel(sectionPlotAxesHandle,crossSectionXLable);%,'XTick',[1:3],'XTickLabel',{'1','50','100'});
    ylabel(sectionPlotAxesHandle,crossSectionZLable);
    axis tight
end

function crossSectionFigureCloseRequest_Callback(~,~)
    % Do nothing Disabling closing the cross section figure alone
    beep on
    beep
    beep off
end
function mainFigureCloseRequest_Callback(hObject,~,crossSectionFigure)
    % Close both the main and cross section figure
    delete(crossSectionFigure);
    delete(hObject);
end
