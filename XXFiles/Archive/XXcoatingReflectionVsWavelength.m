function varargout = coatingReflectionVsWavelength(varargin)
% COATINGREFLECTIONVSWAVELENGTH MATLAB code for coatingReflectionVsWavelength.fig
%      COATINGREFLECTIONVSWAVELENGTH, by itself, creates a new COATINGREFLECTIONVSWAVELENGTH or raises the existing
%      singleton*.
%
%      H = COATINGREFLECTIONVSWAVELENGTH returns the handle to a new COATINGREFLECTIONVSWAVELENGTH or the handle to
%      the existing singleton*.
%
%      COATINGREFLECTIONVSWAVELENGTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COATINGREFLECTIONVSWAVELENGTH.M with the given input arguments.
%
%      COATINGREFLECTIONVSWAVELENGTH('Property','Value',...) creates a new COATINGREFLECTIONVSWAVELENGTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coatingReflectionVsWavelength_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coatingReflectionVsWavelength_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coatingReflectionVsWavelength

% Last Modified by GUIDE v2.5 26-Oct-2013 20:36:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coatingReflectionVsWavelength_OpeningFcn, ...
                   'gui_OutputFcn',  @coatingReflectionVsWavelength_OutputFcn, ...
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


% --- Executes just before coatingReflectionVsWavelength is made visible.
function coatingReflectionVsWavelength_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coatingReflectionVsWavelength (see VARARGIN)

% Choose default command line output for coatingReflectionVsWavelength
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coatingReflectionVsWavelength wait for user response (see UIRESUME)
% uiwait(handles.coatingReflectionVsWavelength);

% populate the surface index box
currentOpticalSystem  = saveTheOpticalSystem ();
nSurf = currentOpticalSystem.NumberOfSurface;
surfIndexPop{1}='New Coating';
for kk=2:1:nSurf-1
    surfIndexPop{kk} = num2str(kk);
end
set(handles.popSurfaceIndex,'String',surfIndexPop);

% --- Outputs from this function are returned to the command line.
function varargout = coatingReflectionVsWavelength_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when panelSettingRefVsAng is resized.
function panelSettingRefVsAng_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to panelSettingRefVsAng (see GCBO)
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
currentOpticalSystem  = saveTheOpticalSystem ();
surfIndex = get(hObject,'Value');

if surfIndex == 1 % enter new coating
    % enable coating name text box
    set(handles.txtCoatingName,'String','None','Enable','On'); 
elseif surfIndex > 1
    % write the coating name on the text box and disable it
    coating = currentOpticalSystem.SurfaceArray(surfIndex).Coating;
    set(handles.txtCoatingName,'String',coating.Name,'Enable','Off');
else
    
end

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



function txtMinWavLen_Callback(hObject, eventdata, handles)
% hObject    handle to txtMinWavLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMinWavLen as text
%        str2double(get(hObject,'String')) returns contents of txtMinWavLen as a double


% --- Executes during object creation, after setting all properties.
function txtMinWavLen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMinWavLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtIncAngle_Callback(hObject, eventdata, handles)
% hObject    handle to txtIncAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtIncAngle as text
%        str2double(get(hObject,'String')) returns contents of txtIncAngle as a double
currentOpticalSystem  = saveTheOpticalSystem ();
wavLengthIndex = get(hObject,'Value')-1;
maxWavIndexDefined = currentOpticalSystem.NumberOfWavelengths;
if wavLengthIndex == 0 % enter new wavelength
    %enable wavelength text box
    set(handles.txtWavelengthStep,'String','0.01','Enable','On');
elseif wavLengthIndex > 0 
    if wavLengthIndex > maxWavIndexDefined
       set(hObject,'Value',maxWavIndexDefined+1); 
       wavLengthIndex = maxWavIndexDefined;
    end
    %write the wavelength on the wavelength text box and disable it
    wavelength = currentOpticalSystem.WavelengthMatrix(wavLengthIndex,1);
    set(handles.txtWavelengthStep,'String',num2str(wavelength),'Enable','Off');
else
    
end

% --- Executes during object creation, after setting all properties.
function txtIncAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtIncAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtMaxWavLen_Callback(hObject, eventdata, handles)
% hObject    handle to txtMaxWavLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMaxWavLen as text
%        str2double(get(hObject,'String')) returns contents of txtMaxWavLen as a double


% --- Executes during object creation, after setting all properties.
function txtMaxWavLen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMaxWavLen (see GCBO)
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
set(handles.panelGraphRefVsAng,'Visible','Off')
set(handles.panelSettingRefVsAng,'Visible','On')



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtCoatingName_Callback(hObject, eventdata, handles)
% hObject    handle to txtCoatingName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtCoatingName as text
%        str2double(get(hObject,'String')) returns contents of txtCoatingName as a double


% --- Executes during object creation, after setting all properties.
function txtCoatingName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtCoatingName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavelengthStep_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavelengthStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavelengthStep as text
%        str2double(get(hObject,'String')) returns contents of txtWavelengthStep as a double


% --- Executes during object creation, after setting all properties.
function txtWavelengthStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavelengthStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currentOpticalSystem1  = saveTheOpticalSystem ();
% Check for inputs
surfIndex = (get(handles.popSurfaceIndex,'Value'));
incAngle = str2num(get(handles.txtIncAngle,'String'));

if surfIndex==1
    % Read coating from the catalogue
    name = get(handles.txtCoatingName,'String');
    % check that the coating does exsist in the catalogue
    %load('f:\aoeCoatingCatalogue.mat','AllCoating');
    load('f:\aoeCoatingCatalogue.mat','AllCoating');
    location = find(strcmpi({AllCoating.Name},name));
    if ~isempty(location)
      % File exists.  Do stuff....
        coating = AllCoating(location);
    else
      % File does not exist.
      msgbox 'The coating file does not exsist in the catalogue.'
      return;
    end
    clear AllCoating;
else
    % Read the coating from the surface index
    coating = currentOpticalSystem1.SurfaceArray(surfIndex).Coating;
end
wavLenStep = str2num(get(handles.txtWavelengthStep,'String'));
minWavLen = str2num(get(handles.txtMinWavLen,'String'));
maxWavLen = str2num(get(handles.txtMaxWavLen,'String'));

set(handles.panelGraphRefVsAng,'Visible','On')
set(handles.panelSettingRefVsAng,'Visible','Off')

ref_s = [];
ref_p = [];
wavLen = 0.55; % or take systems primary wavelength
if surfIndex == 1
    refIndices = inputdlg({'Index before coating','Index after coating'}, 'Refractive Indices');
    indexBefore = str2num(refIndices{1});
    indexAfter = str2num(refIndices{2});
else
    indexBefore = currentOpticalSystem1.SurfaceArray(surfIndex-1).Glass.getRefractiveIndex(wavLen);
    indexAfter = currentOpticalSystem1.SurfaceArray(surfIndex).Glass.getRefractiveIndex(wavLen);
end
set(handles.output,'Visible','On');

currentOpticalSystem1.SurfaceArray(surfIndex).Coating.plotCoatingReflectionVsWavelength(handles.axesRefVsAng,wavLen,...
            minWavLen,maxWavLen,wavLenStep,indexBefore,indexAfter);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function btnUpdate_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnUpdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentOpticalSystem1  = saveTheOpticalSystem ();
% Check for inputs
surfIndex = (get(handles.popSurfaceIndex,'Value'));
incAngle = str2num(get(handles.txtIncAngle,'String'));

if surfIndex==1
    % Read coating from the catalogue
    name = get(handles.txtCoatingName,'String');
    % check that the coating does exsist in the catalogue
    %load('f:\aoeCoatingCatalogue.mat','AllCoating');
    load('f:\aoeCoatingCatalogue.mat','AllCoating');
    location = find(strcmpi({AllCoating.Name},name));
    if ~isempty(location)
      % File exists.  Do stuff....
        coating = AllCoating(location);
    else
      % File does not exist.
      msgbox 'The coating file does not exsist in the catalogue.'
      return;
    end
    clear AllCoating;
else
    % Read the coating from the surface index
    coating = currentOpticalSystem1.SurfaceArray(surfIndex).Coating;
end
wavLenStep = str2num(get(handles.txtWavelengthStep,'String'));
minWavLen = str2num(get(handles.txtMinWavLen,'String'));
maxWavLen = str2num(get(handles.txtMaxWavLen,'String'));

set(handles.panelGraphRefVsAng,'Visible','On')
set(handles.panelSettingRefVsAng,'Visible','Off')

ref_s = [];
ref_p = [];
wavLen = 0.55; % or take systems primary wavelength
if surfIndex == 1
    refIndices = inputdlg({'Index before coating','Index after coating'}, 'Refractive Indices');
    indexBefore = str2num(refIndices{1});
    indexAfter = str2num(refIndices{2});
else
    indexBefore = currentOpticalSystem1.SurfaceArray(surfIndex-1).Glass.getRefractiveIndex(wavLen);
    indexAfter = currentOpticalSystem1.SurfaceArray(surfIndex).Glass.getRefractiveIndex(wavLen);
end
set(handles.output,'Visible','On');

currentOpticalSystem1.SurfaceArray(surfIndex).Coating.plotCoatingReflectionVsWavelength(handles.axesRefVsAng,wavLen,...
            minWavLen,maxWavLen,wavLenStep,indexBefore,indexAfter);


% --------------------------------------------------------------------
function btnGraph_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelGraphRefVsAng,'Visible','On')
set(handles.panelSettingRefVsAng,'Visible','Off')
