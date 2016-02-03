function varargout = tiltDecenterOrder(varargin)
% TILTDECENTERORDER MATLAB code for tiltDecenterOrder.fig
%      TILTDECENTERORDER, by itself, creates a new TILTDECENTERORDER or raises the existing
%      singleton*.
%
%      H = TILTDECENTERORDER returns the handle to a new TILTDECENTERORDER or the handle to
%      the existing singleton*.
%
%      TILTDECENTERORDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TILTDECENTERORDER.M with the given input arguments.
%
%      TILTDECENTERORDER('Property','Value',...) creates a new TILTDECENTERORDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tiltDecenterOrder_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tiltDecenterOrder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tiltDecenterOrder

% Last Modified by GUIDE v2.5 20-Dec-2013 00:50:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tiltDecenterOrder_OpeningFcn, ...
                   'gui_OutputFcn',  @tiltDecenterOrder_OutputFcn, ...
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


% --- Executes just before tiltDecenterOrder is made visible.
function tiltDecenterOrder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tiltDecenterOrder (see VARARGIN)

% Choose default command line output for tiltDecenterOrder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tiltDecenterOrder wait for user response (see UIRESUME)
% uiwait(handles.tiltDecenterOrder);


% --- Outputs from this function are returned to the command line.
function varargout = tiltDecenterOrder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dx5.
function dx5_Callback(hObject, eventdata, handles)
% hObject    handle to dx5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dx5


% --- Executes on button press in dx4.
function dx4_Callback(hObject, eventdata, handles)
% hObject    handle to dx4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dx4


% --- Executes on button press in dx3.
function dx3_Callback(hObject, eventdata, handles)
% hObject    handle to dx3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dx3


% --- Executes on button press in dx2.
function dx2_Callback(hObject, eventdata, handles)
% hObject    handle to dx2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dx2


% --- Executes on button press in dx.
function dx_Callback(hObject, eventdata, handles)
% hObject    handle to dx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dx


% --- Executes on button press in cmdOk.
function cmdOk_Callback(hObject, eventdata, handles)
% hObject    handle to cmdOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% extract the order of tilt and decenter operations
dx = get(handles.popDx,'Value');
dy = get(handles.popDy,'Value');
dz = get(handles.popDz,'Value');

tx = get(handles.popTx,'Value');
ty = get(handles.popTy,'Value');
tz = get(handles.popTz,'Value');

% check that no operations is assigned the same index.
a = [dx,dy,dz,tx,ty,tz];
anyRepeated = length(unique(a)) < length(a);
if anyRepeated
    % Construct a questdlg to load default order
    choice = questdlg('All operations should have unique index. Do you want to load the default order?', ...
        'Load Default Order', ...
        'Yes','No','No');
    % Handle response
    switch choice
        case 'Yes'
            set(handles.popDx,'Value',1);
            set(handles.popDy,'Value',2);
            set(handles.popDy,'Value',3);
            
            set(handles.popTx,'Value',4);
            set(handles.popTy,'Value',5);
            set(handles.popTz,'Value',6);
        case 'No'
    end 
else
    orderStr(2*dx-1:2*dx) = 'Dx';
    orderStr(2*dy-1:2*dy) = 'Dy';
    orderStr(2*dz-1:2*dz) = 'Dz';
        
    orderStr(2*tx-1:2*tx) = 'Tx';
    orderStr(2*ty-1:2*ty) = 'Ty';
    orderStr(2*tz-1:2*tz) = 'Tz';    
end

%transfer the glass name to the surface editor
selRow = getappdata(0,'surfIndexForTiltDecenter');
tblData = get(findobj('Tag','tblTiltDecenterData'),'data');
tblData{selRow,3} = orderStr;     
set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData);

close(tiltDecenterOrder);



% --- Executes on selection change in popDx.
function popDx_Callback(hObject, eventdata, handles)
% hObject    handle to popDx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popDx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popDx


% --- Executes during object creation, after setting all properties.
function popDx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popDx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popDy.
function popDy_Callback(hObject, eventdata, handles)
% hObject    handle to popDy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popDy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popDy


% --- Executes during object creation, after setting all properties.
function popDy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popDy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popTx.
function popTx_Callback(hObject, eventdata, handles)
% hObject    handle to popTx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popTx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTx


% --- Executes during object creation, after setting all properties.
function popTx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popTy.
function popTy_Callback(hObject, eventdata, handles)
% hObject    handle to popTy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popTy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTy


% --- Executes during object creation, after setting all properties.
function popTy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popTz.
function popTz_Callback(hObject, eventdata, handles)
% hObject    handle to popTz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popTz contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTz


% --- Executes during object creation, after setting all properties.
function popTz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popDz.
function popDz_Callback(hObject, eventdata, handles)
% hObject    handle to popDz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popDz contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popDz


% --- Executes during object creation, after setting all properties.
function popDz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popDz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
