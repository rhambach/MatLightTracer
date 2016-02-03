function varargout = phaseMap(varargin)
% PHASEMAP MATLAB code for phaseMap.fig
%      PHASEMAP, by itself, creates a new PHASEMAP or raises the existing
%      singleton*.
%
%      H = PHASEMAP returns the handle to a new PHASEMAP or the handle to
%      the existing singleton*.
%
%      PHASEMAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHASEMAP.M with the given input arguments.
%
%      PHASEMAP('Property','Value',...) creates a new PHASEMAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phaseMap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to phaseMap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phaseMap

% Last Modified by GUIDE v2.5 26-Oct-2013 20:59:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phaseMap_OpeningFcn, ...
                   'gui_OutputFcn',  @phaseMap_OutputFcn, ...
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


% --- Executes just before phaseMap is made visible.
function phaseMap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phaseMap (see VARARGIN)

% Choose default command line output for phaseMap
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phaseMap wait for user response (see UIRESUME)
% uiwait(handles.phaseMap);
% populate the surface index box
try
    currentOpticalSystem  = saveTheOpticalSystem ();
    nSurf = currentOpticalSystem.NumberOfSurface;
    for kk=1:1:nSurf
        surfIndexPop{kk} = num2str(kk);
    end
catch
    currentOpticalSystem = OpticalSystem;
    surfIndexPop = 'No';
end

set(handles.popSurfaceIndex,'String',surfIndexPop);

% --- Outputs from this function are returned to the command line.
function varargout = phaseMap_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when panelSettingPhaseMap is resized.
function panelSettingPhaseMap_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to panelSettingPhaseMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function popSurfaceIndex_Callback(hObject, eventdata, handles)
% hObject    handle to popSurfaceIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popSurfaceIndex as text
%        str2double(get(hObject,'String')) returns contents of popSurfaceIndex as a double


% --- Executes during object creation, after setting all properties.
function popSurfaceIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popSurfaceIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function popFieldIndex_Callback(hObject, eventdata, handles)
% hObject    handle to popFieldIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popFieldIndex as text
%        str2double(get(hObject,'String')) returns contents of popFieldIndex as a double

currentOpticalSystem  = saveTheOpticalSystem ();
fieldPointIndex = get(hObject,'Value');
maxFldIndexDefined = currentOpticalSystem.NumberOfFieldPoints;
if fieldPointIndex > maxFldIndexDefined
    set(hObject,'Value',maxFldIndexDefined);   
end

% --- Executes during object creation, after setting all properties.
function popFieldIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popFieldIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function popWavelengthIndex_Callback(hObject, eventdata, handles)
% hObject    handle to popWavelengthIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popWavelengthIndex as text
%        str2double(get(hObject,'String')) returns contents of popWavelengthIndex as a double

currentOpticalSystem  = saveTheOpticalSystem ();
wavLengthIndex = get(hObject,'Value');
maxWavIndexDefined = currentOpticalSystem.NumberOfWavelengths;
if wavLengthIndex > maxWavIndexDefined
    set(hObject,'Value',maxWavIndexDefined);   
end

% --- Executes during object creation, after setting all properties.
function popWavelengthIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWavelengthIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function popGridSampling_Callback(hObject, eventdata, handles)
% hObject    handle to popGridSampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of popGridSampling as text
%        str2double(get(hObject,'String')) returns contents of popGridSampling as a double


% --- Executes during object creation, after setting all properties.
function popGridSampling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popGridSampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function btnSetting_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnSetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelPhaseMap,'Visible','Off')
set(handles.panelSettingPhaseMap,'Visible','On')


% --------------------------------------------------------------------


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to txtMagJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMagJs as text
%        str2double(get(hObject,'String')) returns contents of txtMagJs as a double


% --- Executes during object creation, after setting all properties.
function txtMagJs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMagJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtMagJp_Callback(hObject, eventdata, handles)
% hObject    handle to txtMagJp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMagJp as text
%        str2double(get(hObject,'String')) returns contents of txtMagJp as a double


% --- Executes during object creation, after setting all properties.
function txtMagJp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMagJp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPhaseJs_Callback(hObject, eventdata, handles)
% hObject    handle to txtPhaseJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPhaseJs as text
%        str2double(get(hObject,'String')) returns contents of txtPhaseJs as a double


% --- Executes during object creation, after setting all properties.
function txtPhaseJs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPhaseJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPhaseJp_Callback(hObject, eventdata, handles)
% hObject    handle to txtPhaseJp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPhaseJp as text
%        str2double(get(hObject,'String')) returns contents of txtPhaseJp as a double


% --- Executes during object creation, after setting all properties.
function txtPhaseJp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPhaseJp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtMagJs_Callback(hObject, eventdata, handles)
% hObject    handle to txtMagJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMagJs as text
%        str2double(get(hObject,'String')) returns contents of txtMagJs as a double


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(polarizationEllipseMap);

% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentOpticalSystem2  = saveTheOpticalSystem ();
set(handles.panelPhaseMap,'Visible','On')
set(handles.panelSettingPhaseMap,'Visible','Off')

if ~validateOpticalSystem
%     msgbox ('The optical system is invalid.','Invalid System');
    cla(handles.axesPhase,'reset')
else
    surfIndex = (get(handles.popSurfaceIndex,'Value'));
    wavLenIndex = get(handles.popWavelengthIndex,'Value');
    wavLen = currentOpticalSystem2.WavelengthMatrix(wavLenIndex,1);
    fieldPointIndex = get(handles.popFieldIndex,'Value');
    fieldPoint = currentOpticalSystem2.FieldPointMatrix(fieldPointIndex,1:2);
    fieldPointType = currentOpticalSystem2.FieldType;    
    gridSize = 2*get(handles.popGridSampling,'Value')-1;
    
    magS = get(handles.txtMagJs);
    jonesMagS = str2num(magS.String);

    magP = get(handles.txtMagJp);
    jonesMagP = str2num(magP.String);

    phaseS = get(handles.txtPhaseJs);
    jonesPhaseS = str2num(phaseS.String)*pi/180;

    phaseP = get(handles.txtPhaseJp);
    jonesPhaseP = str2num(phaseP.String)*pi/180;

    JonesVec = [jonesMagS,jonesPhaseS;jonesMagP,jonesPhaseP];    
        

 
 numberOfRays = gridSize^2;
 samplingType = 1; % cartesian
set(handles.output,'Visible','On');

  currentOpticalSystem2.plotPhaseMap(handles.axesPhase, ...
     surfIndex,wavLen,fieldPoint,numberOfRays,samplingType,JonesVec)
end


% --------------------------------------------------------------------
function btnGrpah_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnGrpah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelPhaseMap,'Visible','On')
set(handles.panelSettingPhaseMap,'Visible','Off')


% --------------------------------------------------------------------
function btnUpdate_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnUpdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentOpticalSystem2  = saveTheOpticalSystem ();
set(handles.panelPhaseMap,'Visible','On')
set(handles.panelSettingPhaseMap,'Visible','Off')

if ~validateOpticalSystem
%     msgbox ('The optical system is invalid.','Invalid System');
    cla(handles.axesPhase,'reset')
else
    surfIndex = (get(handles.popSurfaceIndex,'Value'));
    wavLenIndex = get(handles.popWavelengthIndex,'Value');
    wavLen = currentOpticalSystem2.WavelengthMatrix(wavLenIndex,1);
    fieldPointIndex = get(handles.popFieldIndex,'Value');
    fieldPoint = currentOpticalSystem2.FieldPointMatrix(fieldPointIndex,1:2);
    fieldPointType = currentOpticalSystem2.FieldType;    
    gridSize = 2*get(handles.popGridSampling,'Value')-1;
    
    magS = get(handles.txtMagJs);
    jonesMagS = str2num(magS.String);

    magP = get(handles.txtMagJp);
    jonesMagP = str2num(magP.String);

    phaseS = get(handles.txtPhaseJs);
    jonesPhaseS = str2num(phaseS.String)*pi/180;

    phaseP = get(handles.txtPhaseJp);
    jonesPhaseP = str2num(phaseP.String)*pi/180;

    JonesVec = [jonesMagS,jonesPhaseS;jonesMagP,jonesPhaseP];    
        

 
 numberOfRays = gridSize^2;
 samplingType = 1; % cartesian
set(handles.output,'Visible','On');

  currentOpticalSystem2.plotPhaseMap(handles.axesPhase, ...
     surfIndex,wavLen,fieldPoint,numberOfRays,samplingType,JonesVec)
end