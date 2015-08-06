function varargout = OpticalSystemConfiguration(varargin)
% OPTICALSYSTEMCONFIGURATION MATLAB code for OpticalSystemConfiguration.fig
%      OPTICALSYSTEMCONFIGURATION, by itself, creates a new OPTICALSYSTEMCONFIGURATION or raises the existing
%      singleton*.
%
%      H = OPTICALSYSTEMCONFIGURATION returns the handle to a new OPTICALSYSTEMCONFIGURATION or the handle to
%      the existing singleton*.
%
%      OPTICALSYSTEMCONFIGURATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTICALSYSTEMCONFIGURATION.M with the given input arguments.
%
%      OPTICALSYSTEMCONFIGURATION('Property','Value',...) creates a new OPTICALSYSTEMCONFIGURATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OpticalSystemConfiguration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OpticalSystemConfiguration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OpticalSystemConfiguration

% Last Modified by GUIDE v2.5 14-Sep-2013 09:47:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OpticalSystemConfiguration_OpeningFcn, ...
                   'gui_OutputFcn',  @OpticalSystemConfiguration_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes during object creation, after setting all properties.
function OpticalSystemConfiguration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OpticalSystemConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global NEW_SYSTEM_CONFIGURATION_WINDOW;
NEW_SYSTEM_CONFIGURATION_WINDOW = 1;





% --- Executes just before OpticalSystemConfiguration is made visible.
function OpticalSystemConfiguration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OpticalSystemConfiguration (see VARARGIN)

% Choose default command line output for OpticalSystemConfiguration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OpticalSystemConfiguration wait for user response (see UIRESUME)
% uiwait(handles.OpticalSystemConfiguration);

global NEW_SYSTEM_CONFIGURATION_WINDOW;

if NEW_SYSTEM_CONFIGURATION_WINDOW
    % open with initial data
    InitializeOpticalSystemConfiguration();
    NEW_SYSTEM_CONFIGURATION_WINDOW = 0;
else
    % open with esxisting data
    %set(handles.OpticalSystemConfiguration,'Visible','On');
end



% --- Outputs from this function are returned to the command line.
function varargout = OpticalSystemConfiguration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in btnAperture.
function btnAperture_Callback(hObject, eventdata, handles)
% hObject    handle to btnPolarization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.panelPolarization,'Visible','Off');
set(handles.panelAperture,'Visible','On');
set(handles.panelGeneral,'Visible','Off');
set(handles.panelFieldPoints,'Visible','Off');
set(handles.panelWavelengths,'Visible','Off');


% --- Executes on button press in btnPolarization.
% function btnPolarization_Callback(hObject, eventdata, handles)
% % hObject    handle to btnPolarization (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% %set(handles.panelPolarization,'Visible','On');
% %set(handles.panelPolarization,'Position',get(handles.panelAperture,'Position'));
% set(handles.panelAperture,'Visible','Off');
% set(handles.panelGeneral,'Visible','Off');
% set(handles.panelFieldPoints,'Visible','Off');
% set(handles.panelWavelengths,'Visible','Off');

% --- Executes on button press in btnGeneral.
function btnGeneral_Callback(hObject, eventdata, handles)
% hObject    handle to btnGeneral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set(handles.panelPolarization,'Visible','Off');
set(handles.panelAperture,'Visible','Off');
set(handles.panelGeneral,'Visible','On');
set(handles.panelGeneral,'Position',get(handles.panelAperture,'Position'));
set(handles.panelFieldPoints,'Visible','Off');
set(handles.panelWavelengths,'Visible','Off');

% --- Executes on button press in btnWavelengths.
function btnWavelengths_Callback(hObject, eventdata, handles)
% hObject    handle to btnWavelengths (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.panelPolarization,'Visible','Off');
set(handles.panelAperture,'Visible','Off');
set(handles.panelGeneral,'Visible','Off');
set(handles.panelWavelengths,'Visible','On');
set(handles.panelWavelengths,'Position',get(handles.panelAperture,'Position'));
set(handles.panelFieldPoints,'Visible','Off');


% --- Executes on button press in btnFieldPoints.
function btnFieldPoints_Callback(hObject, eventdata, handles)
% hObject    handle to btnFieldPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(handles.panelPolarization,'Visible','Off');
set(handles.panelAperture,'Visible','Off');
set(handles.panelGeneral,'Visible','Off');
set(handles.panelWavelengths,'Visible','Off');
set(handles.panelFieldPoints,'Visible','On');
set(handles.panelFieldPoints,'Position',get(handles.panelAperture,'Position'));

% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VIS_CONFIG_DATA;
if validateOpticalSystem
    set(findobj('Tag','OpticalSystemConfiguration'),'Visible','Off');
    VIS_CONFIG_DATA = 'Off';    
else
    
end


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VIS_CONFIG_DATA;
if validateOpticalSystem
    set(findobj('Tag','OpticalSystemConfiguration'),'Visible','Off');
    VIS_CONFIG_DATA = 'Off';
else
    
end







% % --- Executes on button press in chkPolarizedSystem.
% function chkPolarizedSystem_Callback(hObject, eventdata, handles)
% % hObject    handle to chkPolarizedSystem (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hint: get(hObject,'Value') returns toggle state of chkPolarizedSystem
% if get(hObject,'Value')
%     set(findobj('Tag','popPolInputMethod'), 'Enable', 'On');
%     set(findobj('Tag','txtPolParam1'), 'Enable', 'On');
%     set(findobj('Tag','txtPolParam2'), 'Enable', 'On');
%     set(findobj('Tag','txtPolParam3'), 'Enable', 'On');
%     set(findobj('Tag','txtPolParam4'), 'Enable', 'On');    
% else
%     set(findobj('Tag','popPolInputMethod'), 'Enable', 'Off');
%     set(findobj('Tag','txtPolParam1'), 'Enable', 'Off');
%     set(findobj('Tag','txtPolParam2'), 'Enable', 'Off');
%     set(findobj('Tag','txtPolParam3'), 'Enable', 'Off');
%     set(findobj('Tag','txtPolParam4'), 'Enable', 'Off');
% end
% 
% 
% % --- Executes on selection change in popPolInputMethod.
% function popPolInputMethod_Callback(hObject, eventdata, handles)
% % hObject    handle to popPolInputMethod (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: contents = cellstr(get(hObject,'String')) returns popPolInputMethod contents as cell array
% %        contents{get(hObject,'Value')} returns selected item from popPolInputMethod
% %x=contents{get(hObject,'Value')}
% 
% switch get(hObject,'Value')
%    case 1
%       set(findobj('Tag','lblParam1'), 'String', 'Es (Amp)');
%       set(findobj('Tag','lblParam2'), 'String', 'Phase S (Deg)');
%       set(findobj('Tag','lblParam3'), 'String', 'Ep (Amp)');
%       set(findobj('Tag','lblParam4'), 'String', 'Phase P (Deg)');   
%       set(findobj('Tag','lblParam5'), 'String', 'Param5'); 
%       set(findobj('Tag','lblParam6'), 'String', 'Param6'); 
% 
%       set(findobj('Tag','txtPolParam1'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam2'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam3'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam4'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam5'), 'Enable', 'Off', 'String',0);
%       set(findobj('Tag','txtPolParam6'), 'Enable', 'Off', 'String',0);
% 
%    case 2
%       set(findobj('Tag','lblParam1'), 'String', 'Ex ');
%       set(findobj('Tag','lblParam2'), 'String', 'Phase Ex (Deg)');
%       set(findobj('Tag','lblParam3'), 'String', 'Ey (Amp)');
%       set(findobj('Tag','lblParam4'), 'String', 'Phase Ey (Deg)');
%       set(findobj('Tag','lblParam5'), 'String', 'Ez (Amp)'); 
%       set(findobj('Tag','lblParam6'), 'String', 'Phase Ez (Deg)'); 
%       
%       set(findobj('Tag','txtPolParam1'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam2'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam3'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam4'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam5'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam6'), 'Enable', 'On', 'String',0);
%       
%    case 3
%       set(findobj('Tag','lblParam1'), 'String', 'S0');
%       set(findobj('Tag','lblParam2'), 'String', 'S1');
%       set(findobj('Tag','lblParam3'), 'String', 'S2');
%       set(findobj('Tag','lblParam4'), 'String', 'S3');
%       set(findobj('Tag','lblParam5'), 'String', 'Param5'); 
%       set(findobj('Tag','lblParam6'), 'String', 'Param6'); 
%       
%       set(findobj('Tag','txtPolParam1'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam2'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam3'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam4'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam5'), 'Enable', 'Off', 'String',0);
%       set(findobj('Tag','txtPolParam6'), 'Enable', 'Off', 'String',0);
%       
%    case 4
%       set(findobj('Tag','lblParam1'), 'String', 'Semi Major Axis (a)');
%       set(findobj('Tag','lblParam2'), 'String', 'Semi Minor Axis (b)');
%       set(findobj('Tag','lblParam3'), 'String', 'Orientation (Deg)');
%       set(findobj('Tag','lblParam4'), 'String', 'Param4');
%       set(findobj('Tag','lblParam5'), 'String', 'Param5'); 
%       set(findobj('Tag','lblParam6'), 'String', 'Param6'); 
%       
%       set(findobj('Tag','txtPolParam1'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam2'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam3'), 'Enable', 'On', 'String',0);
%       set(findobj('Tag','txtPolParam4'), 'Enable', 'Off', 'String',0);
%       set(findobj('Tag','txtPolParam5'), 'Enable', 'Off', 'String',0);
%       set(findobj('Tag','txtPolParam6'), 'Enable', 'Off', 'String',0);
%       
%       
%    otherwise
%       statements
% end


% --- Executes during object creation, after setting all properties.
function popPolInputMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPolInputMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in popApertureType.
function popApertureType_Callback(hObject, eventdata, handles)
% hObject    handle to popApertureType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popApertureType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popApertureType


% --- Executes during object creation, after setting all properties.
function popApertureType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popApertureType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtParam1_Callback(hObject, eventdata, handles)
% hObject    handle to txtParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtParam1 as text
%        str2double(get(hObject,'String')) returns contents of txtParam1 as a double


% --- Executes during object creation, after setting all properties.
function txtParam1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtParam2_Callback(hObject, eventdata, handles)
% hObject    handle to txtParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtParam2 as text
%        str2double(get(hObject,'String')) returns contents of txtParam2 as a double


% --- Executes during object creation, after setting all properties.
function txtParam2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on selection change in popApertureValue.
function popApertureValue_Callback(hObject, eventdata, handles)
% hObject    handle to popApertureValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popApertureValue contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popApertureValue


% --- Executes during object creation, after setting all properties.
function popApertureValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popApertureValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popLensUnit.
function popLensUnit_Callback(hObject, eventdata, handles)
% hObject    handle to popLensUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popLensUnit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popLensUnit


% --- Executes during object creation, after setting all properties.
function popLensUnit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popLensUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popTiltDecenterOrder.
function popTiltDecenterOrder_Callback(hObject, eventdata, handles)
% hObject    handle to popTiltDecenterOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popTiltDecenterOrder contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTiltDecenterOrder


% --- Executes during object creation, after setting all properties.
function popTiltDecenterOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTiltDecenterOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtLensName_Callback(hObject, eventdata, handles)
% hObject    handle to txtLensName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtLensName as text
%        str2double(get(hObject,'String')) returns contents of txtLensName as a double


% --- Executes during object creation, after setting all properties.
function txtLensName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtLensName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txtLensNote_Callback(hObject, eventdata, handles)
% hObject    handle to txtLensNote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtLensNote as text
%        str2double(get(hObject,'String')) returns contents of txtLensNote as a double


% --- Executes during object creation, after setting all properties.
function txtLensNote_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtLensNote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popCoordAfterSurface.
function popCoordAfterSurface_Callback(hObject, eventdata, handles)
% hObject    handle to popCoordAfterSurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCoordAfterSurface contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCoordAfterSurface


% --- Executes during object creation, after setting all properties.
function popCoordAfterSurface_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCoordAfterSurface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWavelenUnit.
function popWavelenUnit_Callback(hObject, eventdata, handles)
% hObject    handle to popWavelenUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWavelenUnit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWavelenUnit


% --- Executes during object creation, after setting all properties.
function popWavelenUnit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWavelenUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPolParam1_Callback(hObject, eventdata, handles)
% hObject    handle to txtPolParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPolParam1 as text
%        str2double(get(hObject,'String')) returns contents of txtPolParam1 as a double


% --- Executes during object creation, after setting all properties.
function txtPolParam1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPolParam1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPolParam2_Callback(hObject, eventdata, handles)
% hObject    handle to txtPolParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPolParam2 as text
%        str2double(get(hObject,'String')) returns contents of txtPolParam2 as a double


% --- Executes during object creation, after setting all properties.
function txtPolParam2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPolParam2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPolParam3_Callback(hObject, eventdata, handles)
% hObject    handle to txtPolParam3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPolParam3 as text
%        str2double(get(hObject,'String')) returns contents of txtPolParam3 as a double


% --- Executes during object creation, after setting all properties.
function txtPolParam3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPolParam3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPolParam4_Callback(hObject, eventdata, handles)
% hObject    handle to txtPolParam4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPolParam4 as text
%        str2double(get(hObject,'String')) returns contents of txtPolParam4 as a double


% --- Executes during object creation, after setting all properties.
function txtPolParam4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPolParam4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtApertureValue_Callback(hObject, eventdata, handles)
% hObject    handle to txtApertureValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtApertureValue as text
%        str2double(get(hObject,'String')) returns contents of txtApertureValue as a double


% --- Executes during object creation, after setting all properties.
function txtApertureValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtApertureValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in btnUsePredefined.
function btnUsePredefined_Callback(hObject, eventdata, handles)
% hObject    handle to btnUsePredefined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popPredefinedWavlens.
function popPredefinedWavlens_Callback(hObject, eventdata, handles)
% hObject    handle to popPredefinedWavlens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPredefinedWavlens contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popPredefinedWavlens


% --- Executes during object creation, after setting all properties.
function popPredefinedWavlens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPredefinedWavlens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popWavelengthUnit.
function popWavelengthUnit_Callback(hObject, eventdata, handles)
% hObject    handle to popWavelengthUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWavelengthUnit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWavelengthUnit


% --- Executes during object creation, after setting all properties.
function popWavelengthUnit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWavelengthUnit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkUseWav.
function chkUseWav_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav

%don't let all checkboxes to be cleared

if get(hObject,'Value')
        set(findobj('Tag','txtTotalWavelengthsSelected'), 'String',...
        str2num(get(findobj('Tag','txtTotalWavelengthsSelected'), 'String'))+1);
            
        s1=strcat('txtWavlen', get(hObject,'String'));
        s2=strcat('txtWWav', get(hObject,'String'));       
        set(findobj('Tag',s1), 'String', '0.55', 'Enable', 'On');
        set(findobj('Tag',s2), 'String', '1', 'Enable', 'On');      
        set(findobj('Tag','chkUseWav','-and',....
            'String',str2num(get(hObject,'String'))+1), 'Enable', 'On');
else
    if str2num(get(findobj('Tag','txtTotalWavelengthsSelected'), 'String'))==1
         set(hObject,'Value',1);
    else
        set(hObject,'Value',1);
        ii=str2num(get(hObject,'String'));
        while ii<str2num(get(findobj('Tag','txtTotalWavelengthsSelected'), 'String'))
            s1=strcat('txtWavlen', num2str(ii));
            s2=strcat('txtWWav',  num2str(ii));   
            
            s1p=strcat('txtWavlen', num2str(ii+1));
            s2p=strcat('txtWWav',  num2str(ii+1)); 
            
            set(findobj('Tag',s1), 'String', get(findobj('Tag',s1p), 'String'));    
            set(findobj('Tag',s2), 'String', get(findobj('Tag',s2p), 'String')); 
            ii=ii+1;
        end
        s1=strcat('txtWavlen', num2str(ii));
        s2=strcat('txtWWav',  num2str(ii)); 
        
        set(findobj('Tag','chkUseWav','-and',....
            'String',ii), 'Enable', 'On','Value',0);
        
        set(findobj('Tag','chkUseWav','-and',....
            'String',ii+1), 'Enable', 'Off','Value',0);
        
        set(findobj('Tag',s1), 'String', '0.55', 'Enable', 'Off');
        set(findobj('Tag',s2), 'String', '1', 'Enable', 'Off');
                   
        set(findobj('Tag','txtTotalWavelengthsSelected'), 'String',ii-1); 
               
    end             
end


% --- Executes on button press in chkUseWav.
function chkUseWav2_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav3_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav4_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav5_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav6_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav7_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav8_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav


% --- Executes on button press in chkUseWav.
function chkUseWav9_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseWav (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseWav



function txtWavlen1_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen1 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen1 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav1_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav1 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav1 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen2_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen2 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen2 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav2_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav2 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav2 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen3_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen3 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen3 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav3_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav3 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav3 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen4_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen4 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen4 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav4_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav4 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav4 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen5_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen5 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen5 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav5_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav5 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav5 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen6_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen6 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen6 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav6_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav6 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav6 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen7_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen7 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen7 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav7_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav7 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav7 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen8_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen8 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen8 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav8_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav8 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav8 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavlen9_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavlen9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavlen9 as text
%        str2double(get(hObject,'String')) returns contents of txtWavlen9 as a double


% --- Executes during object creation, after setting all properties.
function txtWavlen9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavlen9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWWav9_Callback(hObject, eventdata, handles)
% hObject    handle to txtWWav9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWWav9 as text
%        str2double(get(hObject,'String')) returns contents of txtWWav9 as a double


% --- Executes during object creation, after setting all properties.
function txtWWav9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWWav9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in chkUseFld.
function chkUseFld2_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld3_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld4_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld5_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld6_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld7_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld8_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld


% --- Executes on button press in chkUseFld.
function chkUseFld9_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld



function txtX1_Callback(hObject, eventdata, handles)
% hObject    handle to txtX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX1 as text
%        str2double(get(hObject,'String')) returns contents of txtX1 as a double


% --- Executes during object creation, after setting all properties.
function txtX1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY1_Callback(hObject, eventdata, handles)
% hObject    handle to txtY1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY1 as text
%        str2double(get(hObject,'String')) returns contents of txtY1 as a double


% --- Executes during object creation, after setting all properties.
function txtY1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld1_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld1 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld1 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX2_Callback(hObject, eventdata, handles)
% hObject    handle to txtX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX2 as text
%        str2double(get(hObject,'String')) returns contents of txtX2 as a double


% --- Executes during object creation, after setting all properties.
function txtX2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY2_Callback(hObject, eventdata, handles)
% hObject    handle to txtY2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY2 as text
%        str2double(get(hObject,'String')) returns contents of txtY2 as a double


% --- Executes during object creation, after setting all properties.
function txtY2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld2_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld2 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld2 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX3_Callback(hObject, eventdata, handles)
% hObject    handle to txtX3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX3 as text
%        str2double(get(hObject,'String')) returns contents of txtX3 as a double


% --- Executes during object creation, after setting all properties.
function txtX3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY3_Callback(hObject, eventdata, handles)
% hObject    handle to txtY3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY3 as text
%        str2double(get(hObject,'String')) returns contents of txtY3 as a double


% --- Executes during object creation, after setting all properties.
function txtY3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld3_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld3 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld3 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX4_Callback(hObject, eventdata, handles)
% hObject    handle to txtX4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX4 as text
%        str2double(get(hObject,'String')) returns contents of txtX4 as a double


% --- Executes during object creation, after setting all properties.
function txtX4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY4_Callback(hObject, eventdata, handles)
% hObject    handle to txtY4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY4 as text
%        str2double(get(hObject,'String')) returns contents of txtY4 as a double


% --- Executes during object creation, after setting all properties.
function txtY4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld4_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld4 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld4 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX5_Callback(hObject, eventdata, handles)
% hObject    handle to txtX5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX5 as text
%        str2double(get(hObject,'String')) returns contents of txtX5 as a double


% --- Executes during object creation, after setting all properties.
function txtX5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY5_Callback(hObject, eventdata, handles)
% hObject    handle to txtY5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY5 as text
%        str2double(get(hObject,'String')) returns contents of txtY5 as a double


% --- Executes during object creation, after setting all properties.
function txtY5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld5_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld5 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld5 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX6_Callback(hObject, eventdata, handles)
% hObject    handle to txtX6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX6 as text
%        str2double(get(hObject,'String')) returns contents of txtX6 as a double


% --- Executes during object creation, after setting all properties.
function txtX6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY6_Callback(hObject, eventdata, handles)
% hObject    handle to txtY6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY6 as text
%        str2double(get(hObject,'String')) returns contents of txtY6 as a double


% --- Executes during object creation, after setting all properties.
function txtY6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld6_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld6 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld6 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX7_Callback(hObject, eventdata, handles)
% hObject    handle to txtX7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX7 as text
%        str2double(get(hObject,'String')) returns contents of txtX7 as a double


% --- Executes during object creation, after setting all properties.
function txtX7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY7_Callback(hObject, eventdata, handles)
% hObject    handle to txtY7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY7 as text
%        str2double(get(hObject,'String')) returns contents of txtY7 as a double


% --- Executes during object creation, after setting all properties.
function txtY7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld7_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld7 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld7 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX8_Callback(hObject, eventdata, handles)
% hObject    handle to txtX8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX8 as text
%        str2double(get(hObject,'String')) returns contents of txtX8 as a double


% --- Executes during object creation, after setting all properties.
function txtX8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY8_Callback(hObject, eventdata, handles)
% hObject    handle to txtY8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY8 as text
%        str2double(get(hObject,'String')) returns contents of txtY8 as a double


% --- Executes during object creation, after setting all properties.
function txtY8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld8_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld8 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld8 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtX9_Callback(hObject, eventdata, handles)
% hObject    handle to txtX9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtX9 as text
%        str2double(get(hObject,'String')) returns contents of txtX9 as a double


% --- Executes during object creation, after setting all properties.
function txtX9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtY9_Callback(hObject, eventdata, handles)
% hObject    handle to txtY9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY9 as text
%        str2double(get(hObject,'String')) returns contents of txtY9 as a double


% --- Executes during object creation, after setting all properties.
function txtY9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWFld9_Callback(hObject, eventdata, handles)
% hObject    handle to txtWFld9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWFld9 as text
%        str2double(get(hObject,'String')) returns contents of txtWFld9 as a double


% --- Executes during object creation, after setting all properties.
function txtWFld9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWFld9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPrimaryWavlenIndex.
function popPrimaryWavlenIndex_Callback(hObject, eventdata, handles)
% hObject    handle to popPrimaryWavlenIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPrimaryWavlenIndex contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popPrimaryWavlenIndex


% --- Executes during object creation, after setting all properties.
function popPrimaryWavlenIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPrimaryWavlenIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when user attempts to close OpticalSystemConfiguration.
function OpticalSystemConfiguration_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to OpticalSystemConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

global VIS_CONFIG_DATA;
if validateOpticalSystem()
    set(hObject,'Visible','Off');
    VIS_CONFIG_DATA = 'Off';
else
    
end
%delete(hObject)

% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuEdit_Callback(hObject, eventdata, handles)
% hObject    handle to menuEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuOptimization_Callback(hObject, eventdata, handles)
% hObject    handle to menuOptimization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuTools_Callback(hObject, eventdata, handles)
% hObject    handle to menuTools (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuHelp_Callback(hObject, eventdata, handles)
% hObject    handle to menuHelp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuView_Callback(hObject, eventdata, handles)
% hObject    handle to menuView (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuGenerateMatlabScript_Callback(hObject, eventdata, handles)
% hObject    handle to menuGenerateMatlabScript (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuRayTrace_Callback(hObject, eventdata, handles)
% hObject    handle to menuRayTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSurfaceProperties_Callback(hObject, eventdata, handles)
% hObject    handle to menuSurfaceProperties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSystemConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to menuSystemConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuNew_Callback(hObject, eventdata, handles)
% hObject    handle to menuNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSave_Callback(hObject, eventdata, handles)
% hObject    handle to menuSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSavaAs_Callback(hObject, eventdata, handles)
% hObject    handle to menuSavaAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuClose_Callback(hObject, eventdata, handles)
% hObject    handle to menuClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuOldVersionScript_Callback(hObject, eventdata, handles)
% hObject    handle to menuOldVersionScript (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuNewVersionScript_Callback(hObject, eventdata, handles)
% hObject    handle to menuNewVersionScript (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function txtTotalWavelengthsSelected_Callback(hObject, eventdata, handles)
% hObject    handle to txtTotalWavelengthsSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTotalWavelengthsSelected as text
%        str2double(get(hObject,'String')) returns contents of txtTotalWavelengthsSelected as a double


% --- Executes during object creation, after setting all properties.
function txtTotalWavelengthsSelected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTotalWavelengthsSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtTotalFieldPointsSelected_Callback(hObject, eventdata, handles)
% hObject    handle to txtTotalFieldPointsSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTotalFieldPointsSelected as text
%        str2double(get(hObject,'String')) returns contents of txtTotalFieldPointsSelected as a double


% --- Executes during object creation, after setting all properties.
function txtTotalFieldPointsSelected_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTotalFieldPointsSelected (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%% User Defined %%%%%%%%%%%%%%%


% function InitializeOpticalSystemConfiguration()
% %initialize Aperture tab
% systemApertureTypes = {'Enterance Pupil Diameter','Object Space NA'};
% set(findobj('Tag','popApertureType'), 'String', systemApertureTypes,'Value',1.0);
% set(findobj('Tag','txtApertureValue'), 'String', '0');
% 
% %initialize General tab
% set(findobj('Tag','txtLensName'), 'String', 'Lens 1');
% set(findobj('Tag','txtAddNote'), 'String', 'Note 1');
% lensUnits={'milimeter(mm)','centimeter(cm)','meter(m)'};
% wavelengthUnits={'nanometer(nm)','micrometer(um)'};
% set(findobj('Tag','popLensUnit'), 'String', lensUnits,'Value',1.0);
% set(findobj('Tag','popWavelengthUnit'), 'String', wavelengthUnits,'Value',1.0);
% 
% % %initialize Polarization tab
% % polInputMethod={'Jones Vector','Field Vector','Stokes Vector','Ellipse'};
% % set(findobj('Tag','popPolInputMethod'), 'String', polInputMethod,'Value',1.0);
% 
% set(findobj('Tag','lblParam1'), 'String', 'Es (Amp)');
% set(findobj('Tag','lblParam2'), 'String', 'Phase S (Deg)');
% set(findobj('Tag','lblParam3'), 'String', 'Ep (Amp)');
% set(findobj('Tag','lblParam4'), 'String', 'Phase P (Deg)');  
% set(findobj('Tag','lblParam5'), 'String', 'Param5'); 
% set(findobj('Tag','lblParam6'), 'String', 'Param6'); 
%       
% set(findobj('Tag','chkPolarizedSystem'), 'Enable', 'On', 'Value',0.0);
% set(findobj('Tag','popPolInputMethod'), 'Enable', 'Off');
% set(findobj('Tag','txtPolParam1'), 'Enable', 'Off', 'String',0);
% set(findobj('Tag','txtPolParam2'), 'Enable', 'Off', 'String',0);
% set(findobj('Tag','txtPolParam3'), 'Enable', 'Off', 'String',0);
% set(findobj('Tag','txtPolParam4'), 'Enable', 'Off', 'String',0);
% set(findobj('Tag','txtPolParam5'), 'Enable', 'Off', 'String',0);
% set(findobj('Tag','txtPolParam6'), 'Enable', 'Off', 'String',0);
% 
% %initialize Wavelength tab
% predefinedWavelength={'FdC(Visible)','F''eC''(Visible)','F','F''','d','e','C','C''','HeNe'};
% set(findobj('Tag','popPredefinedWavlens'), 'String', predefinedWavelength,'Value',1.0);
% set(findobj('Tag','popPrimaryWavlenIndex'), 'String', '1','Value',1.0);
% 
% set(findobj('Tag','chkUseWav','-and','String','1'),'Value',1.0);
% set(findobj('Tag','txtWavelen1'), 'String', '0.55');
% set(findobj('Tag','txtWWav1'), 'String', '1');
% set(findobj('Tag','txtTotalWavelengthsSelected'), 'String', '1');
% 
% set(findobj('Tag','chkUseWav','-and','String','1'), 'Enable', 'On');
% set(findobj('Tag','chkUseWav','-and','String','2'), 'Enable', 'On');
% set(findobj('Tag','chkUseWav','-and','String','3'), 'Enable', 'Off');
% set(findobj('Tag','chkUseWav','-and','String','4'), 'Enable', 'Off');
% set(findobj('Tag','chkUseWav','-and','String','5'), 'Enable', 'Off');
% set(findobj('Tag','chkUseWav','-and','String','6'), 'Enable', 'Off');
% set(findobj('Tag','chkUseWav','-and','String','7'), 'Enable', 'Off');
% set(findobj('Tag','chkUseWav','-and','String','8'), 'Enable', 'Off');
% set(findobj('Tag','chkUseWav','-and','String','9'), 'Enable', 'Off');
% 
% 
% set(findobj('Tag','txtWavelen1'), 'Enable', 'On');
% set(findobj('Tag','txtWavelen2'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen3'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen4'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen5'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen6'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen7'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen8'), 'Enable', 'Off');
% set(findobj('Tag','txtWavelen9'), 'Enable', 'Off');
% 
% set(findobj('Tag','txtWWav1'), 'Enable', 'On');
% set(findobj('Tag','txtWWav2'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav3'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav4'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav5'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav6'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav7'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav8'), 'Enable', 'Off');
% set(findobj('Tag','txtWWav9'), 'Enable', 'Off');
% 
% %initialize Field points tab
% set(findobj('Tag','radioAngle'),'Value',1.0);
% 
% set(findobj('Tag','chkUseFld1'),'Value',1.0);
% set(findobj('Tag','txtX1'), 'String', '0');
% set(findobj('Tag','txtY1'), 'String', '0');
% set(findobj('Tag','txtWFld1'), 'String', '1');
% set(findobj('Tag','txtTotalFieldPointsSelected'), 'String', '1');
% 
% set(findobj('Tag','chkUseFld','-and','String','1'), 'Enable', 'On');
% set(findobj('Tag','chkUseFld','-and','String','2'), 'Enable', 'On');
% set(findobj('Tag','chkUseFld','-and','String','3'), 'Enable', 'Off');
% set(findobj('Tag','chkUseFld','-and','String','4'), 'Enable', 'Off');
% set(findobj('Tag','chkUseFld','-and','String','5'), 'Enable', 'Off');
% set(findobj('Tag','chkUseFld','-and','String','6'), 'Enable', 'Off');
% set(findobj('Tag','chkUseFld','-and','String','7'), 'Enable', 'Off');
% set(findobj('Tag','chkUseFld','-and','String','8'), 'Enable', 'Off');
% set(findobj('Tag','chkUseFld','-and','String','9'), 'Enable', 'Off');
% 
% set(findobj('Tag','txtX1'), 'Enable', 'On');
% set(findobj('Tag','txtX2'), 'Enable', 'Off');
% set(findobj('Tag','txtX3'), 'Enable', 'Off');
% set(findobj('Tag','txtX4'), 'Enable', 'Off');
% set(findobj('Tag','txtX5'), 'Enable', 'Off');
% set(findobj('Tag','txtX6'), 'Enable', 'Off');
% set(findobj('Tag','txtX7'), 'Enable', 'Off');
% set(findobj('Tag','txtX8'), 'Enable', 'Off');
% set(findobj('Tag','txtX9'), 'Enable', 'Off');
% 
% set(findobj('Tag','txtY1'), 'Enable', 'On');
% set(findobj('Tag','txtY2'), 'Enable', 'Off');
% set(findobj('Tag','txtY3'), 'Enable', 'Off');
% set(findobj('Tag','txtY4'), 'Enable', 'Off');
% set(findobj('Tag','txtY5'), 'Enable', 'Off');
% set(findobj('Tag','txtY6'), 'Enable', 'Off');
% set(findobj('Tag','txtY7'), 'Enable', 'Off');
% set(findobj('Tag','txtY8'), 'Enable', 'Off');
% set(findobj('Tag','txtY9'), 'Enable', 'Off');
% 
% set(findobj('Tag','txtWFld1'), 'Enable', 'On');
% set(findobj('Tag','txtWFld2'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld3'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld4'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld5'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld6'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld7'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld8'), 'Enable', 'Off');
% set(findobj('Tag','txtWFld9'), 'Enable', 'Off');


% --- Executes on button press in chkUseFld.
function chkUseFld_Callback(hObject, eventdata, handles)
% hObject    handle to chkUseFld (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkUseFld

if get(hObject,'Value')
        set(findobj('Tag','txtTotalFieldPointsSelected'), 'String',...
        str2num(get(findobj('Tag','txtTotalFieldPointsSelected'), 'String'))+1);
            
        s1=strcat('txtX', get(hObject,'String'));
        s2=strcat('txtY', get(hObject,'String'));
        s3=strcat('txtWFld', get(hObject,'String'));      
        
        set(findobj('Tag',s1), 'String', '0', 'Enable', 'On');
        set(findobj('Tag',s2), 'String', '0', 'Enable', 'On');
        set(findobj('Tag',s3), 'String', '1', 'Enable', 'On');      
        set(findobj('Tag','chkUseFld','-and',....
            'String',str2num(get(hObject,'String'))+1), 'Enable', 'On');
else
    if str2num(get(findobj('Tag','txtTotalFieldPointsSelected'), 'String'))==1
         set(hObject,'Value',1);
    else
        set(hObject,'Value',1);
        ii=str2num(get(hObject,'String'));
        while ii<str2num(get(findobj('Tag','txtTotalFieldPointsSelected'), 'String'))
            s1=strcat('txtX', num2str(ii));
            s2=strcat('txtY', num2str(ii));
            s3=strcat('txtWFld',  num2str(ii));   
            
            s1p=strcat('txtX', num2str(ii+1));
            s2p=strcat('txtY', num2str(ii+1));
            s3p=strcat('txtWFld',  num2str(ii+1)); 
            
            set(findobj('Tag',s1), 'String', get(findobj('Tag',s1p), 'String'));    
            set(findobj('Tag',s2), 'String', get(findobj('Tag',s2p), 'String')); 
            set(findobj('Tag',s3), 'String', get(findobj('Tag',s3p), 'String'));
            ii=ii+1;
        end
        s1=strcat('txtX', num2str(ii));
        s2=strcat('txtY', num2str(ii));
        s3=strcat('txtWFld',  num2str(ii)); 
        
        set(findobj('Tag','chkUseFld','-and',....
            'String',ii), 'Enable', 'On','Value',0);
        
        set(findobj('Tag','chkUseFld','-and',....
            'String',ii+1), 'Enable', 'Off','Value',0);
        
        set(findobj('Tag',s1), 'String', '0', 'Enable', 'Off');
        set(findobj('Tag',s2), 'String', '0', 'Enable', 'Off');
        set(findobj('Tag',s3), 'String', '1', 'Enable', 'Off');
                   
        set(findobj('Tag','txtTotalFieldPointsSelected'), 'String',ii-1); 
               
    end             
end



function txtPolParam5_Callback(hObject, eventdata, handles)
% hObject    handle to txtPolParam5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPolParam5 as text
%        str2double(get(hObject,'String')) returns contents of txtPolParam5 as a double


% --- Executes during object creation, after setting all properties.
function txtPolParam5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPolParam5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPolParam6_Callback(hObject, eventdata, handles)
% hObject    handle to txtPolParam6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPolParam6 as text
%        str2double(get(hObject,'String')) returns contents of txtPolParam6 as a double


% --- Executes during object creation, after setting all properties.
function txtPolParam6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPolParam6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
