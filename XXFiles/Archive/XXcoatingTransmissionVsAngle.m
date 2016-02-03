function varargout = coatingTransmissionVsAngle(varargin)
% COATINGTRANSMISSIONVSANGLE MATLAB code for coatingTransmissionVsAngle.fig
%      COATINGTRANSMISSIONVSANGLE, by itself, creates a new COATINGTRANSMISSIONVSANGLE or raises the existing
%      singleton*.
%
%      H = COATINGTRANSMISSIONVSANGLE returns the handle to a new COATINGTRANSMISSIONVSANGLE or the handle to
%      the existing singleton*.
%
%      COATINGTRANSMISSIONVSANGLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COATINGTRANSMISSIONVSANGLE.M with the given input arguments.
%
%      COATINGTRANSMISSIONVSANGLE('Property','Value',...) creates a new COATINGTRANSMISSIONVSANGLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coatingTransmissionVsAngle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coatingTransmissionVsAngle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coatingTransmissionVsAngle

% Last Modified by GUIDE v2.5 26-Oct-2013 21:00:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coatingTransmissionVsAngle_OpeningFcn, ...
                   'gui_OutputFcn',  @coatingTransmissionVsAngle_OutputFcn, ...
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


% --- Executes just before coatingTransmissionVsAngle is made visible.
function coatingTransmissionVsAngle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coatingTransmissionVsAngle (see VARARGIN)

% Choose default command line output for coatingTransmissionVsAngle
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coatingTransmissionVsAngle wait for user response (see UIRESUME)
% uiwait(handles.coatingTransmissionVsAngle);

% populate the surface index box
currentOpticalSystem  = saveTheOpticalSystem ();
nSurf = currentOpticalSystem.NumberOfSurface;
surfIndexPop{1}='New Coating';
for kk=2:1:nSurf-1
    surfIndexPop{kk} = num2str(kk);
end
set(handles.popSurfaceIndex,'String',surfIndexPop);

% --- Outputs from this function are returned to the command line.
function varargout = coatingTransmissionVsAngle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when panelSettingTransVsAng is resized.
function panelSettingTransVsAng_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to panelSettingTransVsAng (see GCBO)
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



function txtMinAngle_Callback(hObject, eventdata, handles)
% hObject    handle to txtMinAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMinAngle as text
%        str2double(get(hObject,'String')) returns contents of txtMinAngle as a double


% --- Executes during object creation, after setting all properties.
function txtMinAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMinAngle (see GCBO)
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
wavLengthIndex = get(hObject,'Value')-1;
maxWavIndexDefined = currentOpticalSystem.NumberOfWavelengths;
if wavLengthIndex == 0 % enter new wavelength
    %enable wavelength text box
    set(handles.txtWavelength,'String','0.55','Enable','On');
elseif wavLengthIndex > 0 
    if wavLengthIndex > maxWavIndexDefined
       set(hObject,'Value',maxWavIndexDefined+1); 
       wavLengthIndex = maxWavIndexDefined;
    end
    %write the wavelength on the wavelength text box and disable it
    wavelength = currentOpticalSystem.WavelengthMatrix(wavLengthIndex,1);
    set(handles.txtWavelength,'String',num2str(wavelength),'Enable','Off');
else
    
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



function txtMaxAngle_Callback(hObject, eventdata, handles)
% hObject    handle to txtMaxAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMaxAngle as text
%        str2double(get(hObject,'String')) returns contents of txtMaxAngle as a double


% --- Executes during object creation, after setting all properties.
function txtMaxAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMaxAngle (see GCBO)
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
set(handles.panelGraphTransVsAng,'Visible','Off')
set(handles.panelSettingTransVsAng,'Visible','On')



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



function txtWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavelength as text
%        str2double(get(hObject,'String')) returns contents of txtWavelength as a double


% --- Executes during object creation, after setting all properties.
function txtWavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavelength (see GCBO)
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
wavLenIndex = (get(handles.popWavelengthIndex,'Value'))-1;

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
wavLen = str2num(get(handles.txtWavelength,'String'));
minAngle = str2num(get(handles.txtMinAngle,'String'));
maxAngle = str2num(get(handles.txtMaxAngle,'String'));

set(handles.panelGraphTransVsAng,'Visible','On')
set(handles.panelSettingTransVsAng,'Visible','Off')

ref_s = [];
ref_p = [];
if surfIndex == 1
    refIndices = inputdlg({'Index before coating','Index after coating'}, 'Refractive Indices');
    indexBefore = str2num(refIndices{1});
    indexAfter = str2num(refIndices{2});
else
    indexBefore = currentOpticalSystem1.SurfaceArray(surfIndex-1).Glass.getRefractiveIndex(wavLen);
    indexAfter = currentOpticalSystem1.SurfaceArray(surfIndex).Glass.getRefractiveIndex(wavLen);
end
set(handles.output,'Visible','On');

currentOpticalSystem1.SurfaceArray(surfIndex).Coating.plotCoatingTransmissionVsAngle(handles.axesTransVsAng,wavLen,...
            minAngle,maxAngle,indexBefore,indexAfter);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function btnUpdate_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currentOpticalSystem1  = saveTheOpticalSystem ();
% Check for inputs
surfIndex = (get(handles.popSurfaceIndex,'Value'));
wavLenIndex = (get(handles.popWavelengthIndex,'Value'))-1;

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
wavLen = str2num(get(handles.txtWavelength,'String'));
minAngle = str2num(get(handles.txtMinAngle,'String'));
maxAngle = str2num(get(handles.txtMaxAngle,'String'));

set(handles.panelGraphTransVsAng,'Visible','On')
set(handles.panelSettingTransVsAng,'Visible','Off')

ref_s = [];
ref_p = [];
if surfIndex == 1
    refIndices = inputdlg({'Index before coating','Index after coating'}, 'Refractive Indices');
    indexBefore = str2num(refIndices{1});
    indexAfter = str2num(refIndices{2});
else
    indexBefore = currentOpticalSystem1.SurfaceArray(surfIndex-1).Glass.getRefractiveIndex(wavLen);
    indexAfter = currentOpticalSystem1.SurfaceArray(surfIndex).Glass.getRefractiveIndex(wavLen);
end
set(handles.output,'Visible','On');

currentOpticalSystem1.SurfaceArray(surfIndex).Coating.plotCoatingTransmissionVsAngle(handles.axesTransVsAng,wavLen,...
            minAngle,maxAngle,indexBefore,indexAfter);


% --------------------------------------------------------------------
function btnGraph_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to btnUpdate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelGraphTransVsAng,'Visible','On')
set(handles.panelSettingTransVsAng,'Visible','Off')
