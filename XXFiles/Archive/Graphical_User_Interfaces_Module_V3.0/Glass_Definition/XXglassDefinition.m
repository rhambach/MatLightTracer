function varargout = glassDefinition(varargin)
% GLASSDEFINITION MATLAB code for glassDefinition.fig
%      GLASSDEFINITION, by itself, creates a new GLASSDEFINITION or raises the existing
%      singleton*.
%
%      H = GLASSDEFINITION returns the handle to a new GLASSDEFINITION or the handle to
%      the existing singleton*.
%
%      GLASSDEFINITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GLASSDEFINITION.M with the given input arguments.
%
%      GLASSDEFINITION('Property','Value',...) creates a new GLASSDEFINITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before glassDefinition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to glassDefinition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help glassDefinition

% Last Modified by GUIDE v2.5 01-Oct-2013 00:45:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @glassDefinition_OpeningFcn, ...
                   'gui_OutputFcn',  @glassDefinition_OutputFcn, ...
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


% --- Executes just before glassDefinition is made visible.
function glassDefinition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to glassDefinition (see VARARGIN)

% Choose default command line output for glassDefinition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes glassDefinition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = glassDefinition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtSelB1_Callback(hObject, eventdata, handles)
% hObject    handle to txtSelB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSelB1 as text
%        str2double(get(hObject,'String')) returns contents of txtSelB1 as a double


% --- Executes during object creation, after setting all properties.
function txtSelB1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSelB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSelB2_Callback(hObject, eventdata, handles)
% hObject    handle to txtSelB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSelB2 as text
%        str2double(get(hObject,'String')) returns contents of txtSelB2 as a double


% --- Executes during object creation, after setting all properties.
function txtSelB2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSelB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSelB3_Callback(hObject, eventdata, handles)
% hObject    handle to txtSelB3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSelB3 as text
%        str2double(get(hObject,'String')) returns contents of txtSelB3 as a double


% --- Executes during object creation, after setting all properties.
function txtSelB3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSelB3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSelC1_Callback(hObject, eventdata, handles)
% hObject    handle to txtSelC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSelC1 as text
%        str2double(get(hObject,'String')) returns contents of txtSelC1 as a double


% --- Executes during object creation, after setting all properties.
function txtSelC1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSelC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSelC2_Callback(hObject, eventdata, handles)
% hObject    handle to txtSelC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSelC2 as text
%        str2double(get(hObject,'String')) returns contents of txtSelC2 as a double


% --- Executes during object creation, after setting all properties.
function txtSelC2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSelC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSelC3_Callback(hObject, eventdata, handles)
% hObject    handle to txtSelC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSelC3 as text
%        str2double(get(hObject,'String')) returns contents of txtSelC3 as a double


% --- Executes during object creation, after setting all properties.
function txtSelC3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSelC3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cmdOpenGlass.
function cmdOpenGlass_Callback(hObject, eventdata, handles)
% hObject    handle to cmdOpenGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name = get(handles.txtGlassName,'String');
%check that the coating does exsist in the catalogue

%load('f:\aoeGlassCatalogue.mat','AllGlass');
load(which('aoeGlassCatalogue.mat'),'AllGlass');

location = find(strcmpi({AllGlass.Name},name));
if ~isempty(location)
  % File exists.  Do stuff....
  SC = AllGlass(location(1)).SellmeierCoefficients;
  set(handles.txtSelB1,'String',SC(1));
  set(handles.txtSelB2,'String',SC(2));
  set(handles.txtSelB3,'String',SC(3));
  set(handles.txtSelC1,'String',SC(4));
  set(handles.txtSelC2,'String',SC(5));
  set(handles.txtSelC3,'String',SC(6));  
else
  % File does not exist.
  msgbox 'The glass file does not exsist in the catalogue.'
end
clear AllGlass;






% --- Executes during object creation, after setting all properties.
function cmdOpenGlass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmdOpenGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in cmdNewGlass.
function cmdNewGlass_Callback(hObject, eventdata, handles)
% hObject    handle to cmdNewGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(glassDefinition);
glassDefinition;

% --- Executes on button press in cmdInsertGlass.
function cmdInsertGlass_Callback(hObject, eventdata, handles)
% hObject    handle to cmdInsertGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

name = get(handles.txtGlassName,'String');
selCoef = [str2double(get(handles.txtSelB1,'String')),str2double(get(handles.txtSelC1,'String')),...
    str2double(get(handles.txtSelB2,'String')),str2double(get(handles.txtSelC2,'String')),...
    str2double(get(handles.txtSelB3,'String')),str2double(get(handles.txtSelC3,'String'))];
newGlass = Glass(name,selCoef);

% glassCatalogueFullFileName = 'f:\aoeGlassCatalogue.mat';
% addGlassToGlasssCatalogue( newGlass,glassCatalogueFullFileName );

%load the glass catalogue file and add the new glass

%load('f:\aoeGlassCatalogue.mat','AllGlass');
load(which('aoeGlassCatalogue.mat'),'AllGlass');

%check that the glass doesnot exsist in the catalogue
location = find(strcmpi({AllGlass.Name},name));
if ~isempty(location)
   button = questdlg('The glass is already in the catalogue. Do you want to update it?','Glass Found','Yes','No','Cancel');
   switch button
       case 'Yes'
            AllGlass(location(1)) = newGlass;
            save(which('aoeGlassCatalogue.mat'),'AllGlass');
            clear AllGlass;

            %transfer the glass name to the surface editor
            selRow = getappdata(0,'surfIndexForGlass');
            tblData = get(findobj('Tag','tblStandardData'),'data');
            tblData{selRow,9} = name;     
            set(findobj('Tag','tblStandardData'), 'Data', tblData);
       case 'No' 
           selRow = getappdata(0,'surfIndexForGlass');
           tblData = get(findobj('Tag','tblStandardData'),'data');
           tblData{selRow,9} = '';     
           set(findobj('Tag','tblStandardData'), 'Data', tblData);            
       case 'Cancel'
           
   end
else
    AllGlass(length(AllGlass)+1) = newGlass;
    save(which('aoeGlassCatalogue.mat'),'AllGlass');
    clear AllGlass;

    %transfer the glass name to the surface editor
    selRow = getappdata(0,'surfIndexForGlass');
    tblData = get(findobj('Tag','tblStandardData'),'data');
    tblData{selRow,9} = name;     
    set(findobj('Tag','tblStandardData'), 'Data', tblData);
end
close(glassDefinition);




% --- Executes on button press in cmdCancelGlass.
function cmdCancelGlass_Callback(hObject, eventdata, handles)
% hObject    handle to cmdCancelGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selRow = getappdata(0,'surfIndexForGlass');
tblData = get(findobj('Tag','tblStandardData'),'data');
tblData{selRow,9} = '';     
set(findobj('Tag','tblStandardData'), 'Data', tblData); 
close(glassDefinition);
