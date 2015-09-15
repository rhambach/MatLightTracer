function mainFigHandle = harmonicFieldSetViewer( variableInputArgument,fontSize,fontName )
    %HarmonicFieldSetViewer Displays a window to view the harmonic field set
    % variableInputArgument could be a harmonic field, a harmonic field
    % source or 'CurrentHarmonicFieldSource'
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    
    % Default Input
    if nargin < 1
        % Get all catalogues from current folder
        variableInputArgument = HarmonicFieldSet;
    end
    if nargin < 2
        fontSize = 9.5;
    end
    if nargin < 3
        fontName = 'FixedWidth';
    end
    
    figureHandle.FontName = fontName;
    figureHandle.FontSize = fontSize;
    figureHandle.HarmonicFieldSet = variableInputArgument;
    % Allows dynamic source extraction while defining and viewing source simultanoulsly
    harmonicFieldSet = extractCurrrentHarmonicFieldSet(figureHandle);
    figureHandle.MainFigureHandle = figure( ...
        'Units', 'normalized', ...
        'Name', 'Harmonic Field Set Viewer', ...
        'MenuBar', 'figure', ...
        'Toolbar','figure',...
        'NumberTitle', 'off', ...
        'Units','normalized',...
        'Position',[0.35,0.2,0.3,0.6],...
        'Color', get(0,'DefaultUicontrolBackgroundColor'), ...
        'Resize', 'on');
    
    % Build the GUI
    %% Edit Standard Toolbar by removing the first two toolbar buttons
    % New Figure and Open File as they don't make sense in our case
    stdToolBar = (findall(...
        figureHandle.MainFigureHandle,'Type','uitoolbar'));
    stdToolBarBtns = allchild(stdToolBar);
    set(stdToolBarBtns(end),'Visible','off');
    set(stdToolBarBtns(end-1),'Visible','off');
    % Add a refresh button at the end
    updateIcon = rand(19,23,3)*0;
    updateIcon(4:17,5:7,:) = 1;
    updateIcon(4:17,16:18,:) = 1;
    updateIcon(15:17,5:16,:) = 1;
    
    
    figureHandle.btnRefresh = uitoggletool(stdToolBar,...
        'CData',updateIcon,...
        'Separator','on',...
        'TooltipString','Update',...
        'HandleVisibility','on');
    
    % Add a new menu for Manipulation of the displayed field
    menuFieldManipulation = uimenu('Label','Feild Manipulation');
    uimenu(menuFieldManipulation,'Label','Add Spherical Phase','Callback',{@menuAddSphericalPhase_Callback,figureHandle});
    uimenu(menuFieldManipulation,'Label','Fourier Transform (x->k)','Callback',{@menuFFT_Callback,figureHandle},...
        'Separator','on');
    uimenu(menuFieldManipulation,'Label','Inverse Fourier Transform (k->x)','Callback',{@menuFFT_Callback,figureHandle});
    
    
    figureHandle.panelSetting = uipanel( ...
        'Parent', figureHandle.MainFigureHandle, ...
        'Tag', 'panelSetting', ...
        'Units','Normalized',...
        'Position', [0.0,0.90,1.0,0.10], ...
        'FontSize',fontSize,'FontName',fontName,...
        'Visible','On');
    
    figureHandle.panelColorPlot = uipanel( ...
        'Parent', figureHandle.MainFigureHandle, ...
        'Tag', 'panelColorPlot', ...
        'Units','Normalized',...
        'Position', [0.0,0.35,1.0,0.55], ...
        'FontSize',fontSize,'FontName',fontName,...
        'Visible','On');
    
    figureHandle.panelLinePlot = uipanel( ...
        'Parent', figureHandle.MainFigureHandle, ...
        'Tag', 'panelLinePlot', ...
        'Units','Normalized',...
        'Position', [0.0,0.05,1.0,0.30], ...
        'FontSize',fontSize,'FontName',fontName,...
        'Visible','On');
    
    figureHandle.panelTaskBar = uipanel( ...
        'Parent', figureHandle.MainFigureHandle, ...
        'Tag', 'panelTaskBar', ...
        'Units','Normalized',...
        'Position', [0.0,0.0,1.0,0.05], ...
        'FontSize',fontSize,'FontName',fontName,...
        'Visible','On');
    
    %         figureHandle.txtGlassName = uicontrol( ...
    %         'Parent', figureHandle.panelLinePlot, ...
    %         'Tag', 'txtGlassName', ...
    %         'Style', 'text', ...
    %         'HorizontalAlignment','left',...
    %         'Units','Normalized',...
    %         'Position', [0.0,0.0,1,1], ...
    %         'BackgroundColor', [1 1 1], ...
    %         'FontSize',18,'FontName','symbol',...
    %         'String', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz');
    % --------------------------------------------------------------------
    figureHandle.buttonGroupFieldComponent = uibuttongroup( ...
        'Parent', figureHandle.panelSetting, ...
        'Units','Normalized',...
        'Position',[0.0 0.5 0.25 0.5]);
    
    % Create three radio buttons in the button group.
    figureHandle.rbtnEx = uicontrol(figureHandle.buttonGroupFieldComponent,'Style',...
        'radiobutton',...
        'String','Ex',...
        'Units','Normalized', ...
        'FontSize',fontSize,'FontName',fontName,...
        'Position',[0.0 0.0 0.3 1.0]);
    
    figureHandle.rbtnEy = uicontrol(figureHandle.buttonGroupFieldComponent,'Style','radiobutton',...
        'String','Ey',...
        'Units','Normalized', ...
        'FontSize',fontSize,'FontName',fontName,...
        'Position',[0.35 0.0 0.3 1.0]);
    
    figureHandle.rbtnEz = uicontrol(figureHandle.buttonGroupFieldComponent,'Style','radiobutton',...
        'String','Ez',...
        'Units','Normalized', ...
        'FontSize',fontSize,'FontName',fontName,...
        'Position',[0.7 0.0 0.3 1.0]);
    % --------------------------------------------------------------------
    figureHandle.buttonGroupParameterToShow = uibuttongroup( ...
        'Parent', figureHandle.panelSetting, ...
        'Units','Normalized',...
        'Position',[0.25 0.5 0.55 0.5]);
    
    
    % Create three radio buttons in the button group.
    figureHandle.rbtnReal = uicontrol(figureHandle.buttonGroupParameterToShow,'Style',...
        'radiobutton',...
        'String','Re',...
        'Units','Normalized',...
        'Position',[0.0 0.0 0.15 1.0], ...
        'FontSize',fontSize,'FontName',fontName);
    
    figureHandle.rbtnImaginary = uicontrol(figureHandle.buttonGroupParameterToShow,'Style','radiobutton',...
        'String','Im',...
        'Units','Normalized',...
        'Position',[0.15 0.0 0.15 1.0], ...
        'FontSize',fontSize,'FontName',fontName);
    
    figureHandle.rbtnAmplitude = uicontrol(figureHandle.buttonGroupParameterToShow,'Style','radiobutton',...
        'String','A',...
        'Units','Normalized',...
        'Position',[0.3 0.0 0.15 1.0], ...
        'FontSize',fontSize,'FontName',fontName);
    figureHandle.rbtnPhase = uicontrol(figureHandle.buttonGroupParameterToShow,'Style','radiobutton',...
        'String','F',...
        'Units','Normalized',...
        'Position',[0.45 0.0 0.15 1.0],...
        'FontSize',fontSize*1.3,'FontName','symbol');
    
    figureHandle.rbtnEllipseOrientation = uicontrol(figureHandle.buttonGroupParameterToShow,'Style','radiobutton',...
        'String','q',...
        'Units','Normalized',...
        'Position',[0.70 0.0 0.15 1.0],...
        'FontSize',fontSize*1.3,'FontName','symbol');
    figureHandle.rbtnEllipseEccentricity = uicontrol(figureHandle.buttonGroupParameterToShow,'Style','radiobutton',...
        'String','e',...
        'Units','Normalized',...
        'Position',[0.85 0.0 0.15 1.0],...
        'FontSize',fontSize*1.3,'FontName','symbol');
    
    % --------------------------------------------------------------------
    %     figureHandle.lblPlane = uicontrol( ...
    %         'Parent', figureHandle.panelSetting, ...
    %         'Tag', 'lblPlane', ...
    %         'Style', 'text', ...
    %         'HorizontalAlignment','left',...
    %         'Units','Normalized',...
    %         'Position', [0.81,0.35,0.10,0.5], ...
    %         'FontSize',fontSize,'FontName',fontName,...
    %         'String', 'Plane');
    %
    %     figureHandle.popPlane = uicontrol( ...
    %         'Parent', figureHandle.panelSetting, ...
    %         'Tag', 'popPlane', ...
    %         'Style', 'popupmenu', ...
    %         'HorizontalAlignment','left',...
    %         'Units','Normalized',...
    %         'Position', [0.90,0.40,0.1,0.5], ...
    %         'BackgroundColor', [1 1 1], ...
    %         'FontSize',fontSize,'FontName',fontName,...
    %         'String', {'XY','YZ','XZ'});
    
    figureHandle.chkShowPolarizationEllipse = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'chkShowPolarizationEllipse', ...
        'Style', 'checkbox', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.81,0.55,0.20,0.35], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', 'Pol Ellipse');
    % --------------------------------------------------------------------
    figureHandle.lblSpectralComponent = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'lblSpectralComponent', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.00,0.00,0.35,0.350], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', 'Spectral Component Index');
    
    nSpectralComponents = length(getFrequencyVector( harmonicFieldSet ));
    
    AllSpectralComponentIndices = [num2cell(1:nSpectralComponents)];
    figureHandle.popSpectralComponent = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'popSpectralComponent', ...
        'Style', 'popupmenu', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.35,0.00,0.10,0.40], ...
        'BackgroundColor', [1 1 1], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', AllSpectralComponentIndices);
    
    figureHandle.lblCurrentWavelength = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'lblSpectralComponent', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.47,0.00,0.18,0.350], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', 'Wavelength ');
    
    currentWavelengthIndex = get(figureHandle.popSpectralComponent,'Value');
    currentWavelength = harmonicFieldSet.HarmonicFieldArray(currentWavelengthIndex).Wavelength;
    figureHandle.txtCurrentWavelength = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'lblSpectralComponent', ...
        'Style', 'edit', ...
        'HorizontalAlignment','left',...
        'Units','Normalized','enable','off',...
        'Position', [0.650,0.05,0.15,0.35], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', currentWavelength);
    
    %    figureHandle.chkShowPolarizationEllipse = uicontrol( ...
    %         'Parent', figureHandle.panelSetting, ...
    %         'Tag', 'chkShowPolarizationEllipse', ...
    %         'Style', 'checkbox', ...
    %         'HorizontalAlignment','left',...
    %         'Units','Normalized',...
    %         'Position', [0.81,0.05,0.20,0.35], ...
    %         'FontSize',fontSize,'FontName',fontName,...
    %         'String', 'Pol Ellipse');
    figureHandle.lblPlane = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'lblPlane', ...
        'Style', 'text', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.81,0.05,0.10,0.3], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', 'Plane');
    
    figureHandle.popPlane = uicontrol( ...
        'Parent', figureHandle.panelSetting, ...
        'Tag', 'popPlane', ...
        'Style', 'popupmenu', ...
        'HorizontalAlignment','left',...
        'Units','Normalized',...
        'Position', [0.90,0.05,0.1,0.35], ...
        'BackgroundColor', [1 1 1], ...
        'FontSize',fontSize,'FontName',fontName,...
        'String', {'XY','YZ','XZ'},...
        'enable','off');
    
    % --------------------------------------------------------------------
    figureHandle.axesColorPlot = axes( ...
        'parent',figureHandle.panelColorPlot,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units', 'Normalized',...
        'Position', [0.15,0.15, 0.7, 0.75]);
    
    
    % --------------------------------------------------------------------
    figureHandle.axesLinePlot = axes( ...
        'parent',figureHandle.panelLinePlot,...
        'FontSize',fontSize,'FontName', fontName,...
        'Units', 'Normalized',...
        'Position', [0.15,0.25, 0.7, 0.60]);
    % Callbacks
    set(figureHandle.buttonGroupFieldComponent,'SelectionChangedFcn',...
        {@buttonGroupFieldComponent_SelectionChangedFcn,figureHandle});
    set(figureHandle.buttonGroupParameterToShow,'SelectionChangedFcn',...
        {@buttonGroupParameterToShow_SelectionChangedFcn,figureHandle});
    set(figureHandle.btnRefresh,'ClickedCallback', {@btnRefresh_Callback,figureHandle});
    set(figureHandle.chkShowPolarizationEllipse,'Callback', {@chkShowPolarizationEllipse_Callback,figureHandle});
    % --------------------------------------------------------------------
    updateHarmonicFieldSetViewer(figureHandle)
    
end
function chkShowPolarizationEllipse_Callback(hObject, ~, figureHandle)
    % hObject    handle to checkbox1 (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    
    % Hint: get(hObject,'Value') returns toggle state of checkbox1
    updateHarmonicFieldSetViewer(figureHandle)
    
    if (get(hObject,'Value') == get(hObject,'Max'))
        % 	display('Selected');
    else
        % 	display('Not selected');
    end
end

function btnRefresh_Callback(~,~,figureHandle)
    updateHarmonicFieldSetViewer(figureHandle)
end
function menuAddSphericalPhase_Callback(~,~,figureHandle)
    fontName = figureHandle.FontName;
    fontSize = figureHandle.FontSize;
    harmonicFieldSet = extractCurrrentHarmonicFieldSet(figureHandle);
    
    % Get the spherical phase radius
    prompt = {'Enter the spherical phase radius :','Enter the refractive index :'};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'0.01','1'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    sphericalPhaseRad = str2num(answer{1});
    refractiveIndex = str2num(answer{2});
    
    if isempty(sphericalPhaseRad)
        sphericalPhaseRad = Inf;
    end
    if isempty(refractiveIndex)
        refractiveIndex = 1;
    end
    
    [ modifiedHarmonicFieldSet ] = addSphericalPhase( harmonicFieldSet,sphericalPhaseRad,refractiveIndex );
    % Open a new harmonuic field viewer window
    
    harmonicFieldSetViewer( modifiedHarmonicFieldSet,fontSize,fontName );
end

function menuFFT_Callback(~,~,figureHandle)
    fontName = figureHandle.FontName;
    fontSize = figureHandle.FontSize;
    harmonicFieldSet = extractCurrrentHarmonicFieldSet(figureHandle);
    % Get the spherical phase radius
    prompt = {'Enter the scaling factor : '};
    dlg_title = 'Input';
    num_lines = 1;
    defaultans = {'1'};
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    scalingFactor = str2num(answer{1});
    
    if isempty(scalingFactor)
        scalingFactor = 1;
    end
    
    [ modifiedHarmonicFieldSet ] = computeFieldFFT( harmonicFieldSet,scalingFactor);
    % Open a new harmonuic field viewer window
    
    harmonicFieldSetViewer( modifiedHarmonicFieldSet,fontSize,fontName );
end

function menuIFFT_Callback(~,~,figureHandle)
    fontName = figureHandle.FontName;
    fontSize = figureHandle.FontSize;
    harmonicFieldSet = extractCurrrentHarmonicFieldSet(figureHandle);
    [ modifiedHarmonicFieldSet ] = computeFieldIFFT( harmonicFieldSet);
    % Open a new harmonuic field viewer window
    
    harmonicFieldSetViewer( modifiedHarmonicFieldSet,fontSize,fontName );
end


function buttonGroupFieldComponent_SelectionChangedFcn(~,~,figureHandle)
    updateHarmonicFieldSetViewer(figureHandle)
end
function buttonGroupParameterToShow_SelectionChangedFcn(~,~,figureHandle)
    updateHarmonicFieldSetViewer(figureHandle)
end

function updateHarmonicFieldSetViewer(figureHandle)
    harmonicFieldSet = extractCurrrentHarmonicFieldSet(figureHandle);
    fontSize = figureHandle.FontSize;
    fontName = figureHandle.FontName;
    colorPlotAxes = figureHandle.axesColorPlot;
    % Clear the color plot axis
    cla(colorPlotAxes,'reset')
    
    % Read all setting parameters
    showEx = get(figureHandle.rbtnEx,'Value');
    showEy = get(figureHandle.rbtnEy,'Value');
    showEz = get(figureHandle.rbtnEz,'Value');
    
    showReal = get(figureHandle.rbtnReal,'Value');
    showImaginary = get(figureHandle.rbtnImaginary,'Value');
    showAmplitude = get(figureHandle.rbtnAmplitude,'Value');
    showPhase = get(figureHandle.rbtnPhase,'Value');
    
    showEllipseOrientation = get(figureHandle.rbtnEllipseOrientation,'Value');
    showEllipseEccentricity = get(figureHandle.rbtnEllipseEccentricity,'Value');
    
    selectedSpectralIndex = get(figureHandle.popSpectralComponent,'Value');
    showPolarizationEllipse = get(figureHandle.chkShowPolarizationEllipse,'Value');
    selectedPlane = get(figureHandle.popPlane,'Value');
    
    % Plot the required quantity
    [ allExIn3D,allEyIn3D,xMesh,yMesh,freq_vec ] = complexAmplitudeIn3D( harmonicFieldSet );
    nFreq = length(freq_vec);
    if selectedSpectralIndex > nFreq
        selectedSpectralIndex = nFreq;
        set(figureHandle.popSpectralComponent,'Value',nFreq);
    end
    Ex = allExIn3D(:,:,selectedSpectralIndex);
    Ey = allEyIn3D(:,:,selectedSpectralIndex);
    Nx = size(allExIn3D,1);
    Ny = size(allExIn3D,2);
    
    
    if showEx
        complexAmplitude = Ex;
        fieldComponent = 'Ex';
    elseif showEy
        complexAmplitude = Ey;
        fieldComponent = 'Ey';
    elseif showEz
        msgbox('Error: Ez can not be computed currently.');
        fieldComponent = 'Ez';
        return;
        %         Ex = allExIn3D(:,:,selectedSpectralIndex);
        %         Ey = allEyIn3D(:,:,selectedSpectralIndex);
        %         Ez = function of Ex,Ey and K
    end
    
    minAmpThreshold = 10^-3;
    if showReal
        requestedValue = real(complexAmplitude);
        valueDisplayedName = 'Real Part';
    elseif showImaginary
        requestedValue = imag(complexAmplitude);
        valueDisplayedName = 'Imaginary Part';
    elseif showAmplitude
        requestedValue = abs(complexAmplitude);
        valueDisplayedName = 'Amplitude';
    elseif showPhase
        requestedValue = angle(complexAmplitude);
        valueDisplayedName = 'Phase (rad)';
        % Avoid phase of very negligible amplitude values
        amplitude = abs(complexAmplitude);
        requestedValue(amplitude < minAmpThreshold) = 0;
    elseif showEllipseOrientation
        [ semiMajorAxisIn3D,semiMinorAxisIn3D,directionIn3D,orientationAngleIn3D] =...
            polarizationEllipseParametersIn3D( harmonicFieldSet,selectedPlane );
        requestedValue = orientationAngleIn3D(:,:,selectedSpectralIndex);
        %         msgbox('Error: showEllipseOrientation can not be computed currently.');
        fieldComponent = 'Combined';
        valueDisplayedName = 'Ellipse Orientation \theta';
        % Avoid phase of very negligible amplitude values
        amplitude = abs(complexAmplitude);
        requestedValue(amplitude < minAmpThreshold) = 0;
        %         return;
    elseif showEllipseEccentricity
        [ semiMajorAxisIn3D,semiMinorAxisIn3D,directionIn3D,orientationAngleIn3D] =...
            polarizationEllipseParametersIn3D( harmonicFieldSet,selectedPlane );
        a = semiMajorAxisIn3D(:,:,selectedSpectralIndex);
        b = semiMinorAxisIn3D(:,:,selectedSpectralIndex);
        e = sqrt((a.^2-b.^2)./(a.^2));
        complexEntry = imag(e)~=0;
        if sum(sum(complexEntry))
            e(imag(e)~=0) = sqrt((b.^2-a.^2)./(b.^2));
        end
        requestedValue = e;
        
        %         msgbox('Error: showEllipseEccentricity can not be computed currently.');
        fieldComponent = 'Combined';
        valueDisplayedName = 'Ellipse Eccentricity \eps';
        
        % Avoid phase of very negligible amplitude values
        amplitude = abs(complexAmplitude);
        requestedValue(amplitude < minAmpThreshold) = 0;
        %         return;
    else
        
    end
    
    
    input_args = {colorPlotAxes,xMesh,yMesh,requestedValue};
    sectionPlotAxesHandle = figureHandle.axesLinePlot;
    sectionTitle = 'Cross sectional view';
    sectionXlabel = 'Position (m)';
    sectionZlable = [valueDisplayedName,' ,  ',fieldComponent];
    interpolationMethod = 'linear';%'spline';
    lineColor = 'w';
    lineWidth = 1.0;
    
    modified_pcolor( input_args,...
        sectionPlotAxesHandle,sectionTitle,sectionXlabel,sectionZlable,interpolationMethod,lineColor,lineWidth );
    
    title(colorPlotAxes,[valueDisplayedName, ' , Component : ',fieldComponent])
    xlabel(colorPlotAxes,'X Axis (m)') % x-axis label
    ylabel(colorPlotAxes,'Y Axis (m)') % y-axis label
    
    c = colorbar(colorPlotAxes);
    c.Label.String = [valueDisplayedName,' ,  ',fieldComponent];
    
    axis(colorPlotAxes,'tight');
    grid(colorPlotAxes,'off');
    shading(colorPlotAxes,'interp');
    
    if showPolarizationEllipse
        [ semiMajorAxisIn3D,semiMinorAxisIn3D,directionIn3D,orientationAngleIn3D] =...
            polarizationEllipseParametersIn3D( harmonicFieldSet,selectedPlane );
        % Show only course sampling
        courseSampFact = 10;
        courseSampleX = [1:floor(Nx/courseSampFact):Nx];
        courseSampleY = [1:floor(Ny/courseSampFact):Ny];
        
        cx = xMesh(courseSampleX,courseSampleY);
        cy = yMesh(courseSampleX,courseSampleY);
        
        a = semiMajorAxisIn3D(courseSampleX,courseSampleY,selectedSpectralIndex);
        b = semiMinorAxisIn3D(courseSampleX,courseSampleY,selectedSpectralIndex);
        
        % Normalize a and b to maximum r value
        minDimension = min(max(max(xMesh)) - min(min(xMesh)),max(max(yMesh)) - min(min(yMesh)));
        nEllipse = max(length(courseSampleX),length(courseSampleY));
        maxEllipseRadius = max(max([a(:),b(:)])); % 0.5*minDimension/nEllipse;
        a = a*((0.5*minDimension/nEllipse)/maxEllipseRadius);
        b = b*((0.5*minDimension/nEllipse)/maxEllipseRadius);
        
        phi = orientationAngleIn3D(courseSampleX,courseSampleY,selectedSpectralIndex);
        direction  = directionIn3D(courseSampleX,courseSampleY,selectedSpectralIndex);
        hold(colorPlotAxes,'on');
        plotEllipse(a(:),b(:),cx(:),cy(:),phi(:),direction(:),colorPlotAxes);
        hold(colorPlotAxes,'on');
    end
    
end

% Modified version of  pcolor
function [ pcolorHandle,mainAxesHandle ] = modified_pcolor( input_args,...
        sectionPlotAxesHandle,sectionTitle,sectionXlabel,sectionZlable,...
        interpolationMethod,lineColor,lineWidth )
    %EnhancedColorPlot This is enahnced version of matlab pcolor function.
    % The enahncement is addition of cross sectional viewing feature
    % The user can easily draw a line on a pcolor plot and then the cross
    % sectional 1D plot will be displayed in a new figure. Awesome -:)
    if nargin < 1
        mainAxesHandle = axes;
        input_args = {mainAxesHandle,peaks};
    end
    hold(input_args{1},'on');
    pcolorHandle = pcolor(input_args{:});
    mainAxesHandle = get(pcolorHandle,'parent');
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
        arrowHandle,pcolorHandle,sectionPlotAxesHandle,sectionTitle,sectionXlabel,...
        sectionZlable,interpolationMethod})
end

function mouseButtonDown_Callback(hObject,~,axesHandle,arrowHandle,...
        pcolorHandle,sectionPlotAxesHandle,sectionTitle,sectionXlabel,...
        sectionZlable,interpolationMethod)
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
        sectionTitle,sectionXlabel,sectionZlable,interpolationMethod})
    set(fig,'WindowButtonUpFcn',{@windowButtonUp_Callback,axesHandle,arrowHandle,...
        initialX,initialY,pcolorHandle,sectionPlotAxesHandle,sectionTitle,...
        sectionXlabel,sectionZlable,interpolationMethod})
end

% ---------------------------
function windowButtonMotion_Callback(~,~,mainAxesHandle,arrowHandle,initialX,...
        initialY,pcolorHandle,sectionPlotAxesHandle,sectionTitle,sectionXlabel,...
        sectionZlable,interpolationMethod)
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
        interpolationMethod,sectionTitle,sectionZlable,sectionXlabel);
    %disp(['motion event '])
end
% ---------------------------
function windowButtonUp_Callback(hObject,~,mainAxesHandle,arrowHandle,initialX,...
        initialY,pcolorHandle,sectionPlotAxesHandle,sectionTitle,sectionXlabel,...
        sectionZlable,interpolationMethod)
    currentCoord = get(mainAxesHandle,'CurrentPoint');
    currentX = currentCoord(1,1);
    currentY = currentCoord(1,2);
    UData = currentX - initialX;
    VData = currentY - initialY;
    updateArrow(arrowHandle,UData,VData);
    
    updateCrossSectionPlot(pcolorHandle,arrowHandle,sectionPlotAxesHandle,...
        interpolationMethod,sectionTitle,sectionZlable,sectionXlabel);
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

function harmonicFieldSet = extractCurrrentHarmonicFieldSet(figureHandle)
    variableData = figureHandle.HarmonicFieldSet;
    if isHarmonicFieldSet(variableData)
        harmonicFieldSet = (variableData);
    elseif isHarmonicField(variableData)
        % If single harmonic field is passed then convert it to a harmonic
        % field set
        harmonicFieldSet = HarmonicFieldSet(variableData);
    elseif strcmpi(variableData,'CurrentHarmonicFieldSource')
        % To view the harmonic field source being built using harmonic field
        % source editor window, one can pass harmonicFieldSet = 'CurrentHarmonicFieldSource'
        harmonicFieldSource = getappdata(0,'HarmonicFieldSource');
        harmonicFieldSet = (getHarmonicFieldSet(harmonicFieldSource));
    end
end
