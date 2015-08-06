function varargout = SingleRayDataEntry(varargin)
% SINGLERAYDATAENTRY MATLAB code for SingleRayDataEntry.fig
%      SINGLERAYDATAENTRY, by itself, creates a new SINGLERAYDATAENTRY or raises the existing
%      singleton*.
%
%      H = SINGLERAYDATAENTRY returns the handle to a new SINGLERAYDATAENTRY or the handle to
%      the existing singleton*.
%
%      SINGLERAYDATAENTRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGLERAYDATAENTRY.M with the given input arguments.
%
%      SINGLERAYDATAENTRY('Property','Value',...) creates a new SINGLERAYDATAENTRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SingleRayDataEntry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SingleRayDataEntry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SingleRayDataEntry

% Last Modified by GUIDE v2.5 11-Oct-2013 14:56:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SingleRayDataEntry_OpeningFcn, ...
                   'gui_OutputFcn',  @SingleRayDataEntry_OutputFcn, ...
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


% --- Executes just before SingleRayDataEntry is made visible.
function SingleRayDataEntry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SingleRayDataEntry (see VARARGIN)

% Choose default command line output for SingleRayDataEntry
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
currentOpticalSystem = saveTheOpticalSystem(aodHandles);
  
if currentOpticalSystem.SurfaceArray(1).Thickness>10^10 %object at infinity
    %disable all the field parameter entries
    %only field angles allowed
    set(handles.txtPx,'String','0','Enable','Off');
    set(handles.txtPy,'String','1','Enable','Off');
    
    set(handles.txtdx,'String','0','Enable','Off');
    set(handles.txtdy,'String','0','Enable','Off');
    set(handles.txtdz,'String','1','Enable','Off');
end
% UIWAIT makes SingleRayDataEntry wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SingleRayDataEntry_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in chkPolarized.
function chkPolarized_Callback(hObject, eventdata, handles)
% hObject    handle to chkPolarized (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkPolarized
if get(hObject,'Value')
    set(handles.txtMagJs, 'Enable', 'On');
    set(handles.txtMagJp', 'Enable', 'On');
    set(handles.txtPhaJs', 'Enable', 'On');
    set(handles.txtPhaJp', 'Enable', 'On');    
else
    set(handles.txtMagJs, 'Enable', 'Off');
    set(handles.txtMagJp', 'Enable', 'Off');
    set(handles.txtPhaJs', 'Enable', 'Off');
    set(handles.txtPhaJp', 'Enable', 'Off');      
end

% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnOk.
function btnOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INF_OBJ_Z;

opticalSystem = saveTheOpticalSystem();
if abs(opticalSystem.SurfaceArray(1).Thickness) > 10^10
    objThick = INF_OBJ_Z;
else
    objThick  = opticalSystem.SurfaceArray(1).Thickness;
end
% pupilLocationZ = opticalSystem.getEntrancePupilLocation;

%Retrieve input data from the GUI
[Direc, Posit, Wavelen, Polar, JonesVec] = extractInitialRayData(handles,objThick);

newRay = Ray;
newRay.Direction = Direc;
newRay.Position = Posit;
newRay.Polarized = Polar;
newRay.JonesVector = JonesVec;
newRay.Wavelength = Wavelen;

tic
polarizedRayTracerResult = opticalSystem.tracePolarizedRay(newRay);
toc

%display on the command window
format long;
if isempty(polarizedRayTracerResult)
    msgbox 'Ray trace failed. Look the command window for detail error.';
else
    disp('Ray Position');
    polarizedRayTracerResult.RayIntersectionPoint
    disp('Ray Direction');
    polarizedRayTracerResult.ExitRayDirection
    disp('Surface Normals');
    polarizedRayTracerResult.SurfaceNormal
    disp('Incident Angle');
    polarizedRayTracerResult.IncidenceAngle
    disp('Path Length');
    polarizedRayTracerResult.PathLength
    if newRay.Polarized
        disp('Polarization Vector Before Coating');
        polarizedRayTracerResult.PolarizationVectorBeforeCoating
        disp('Polarization Vector After Coating');
        polarizedRayTracerResult.PolarizationVectorAfterCoating
        
        surfIndex = opticalSystem.NumberOfSurface;
               
        % for test
        for kk=1:1:surfIndex
        [ellBeforeCoating,ellAfterCoating] = polarizedRayTracerResult.getPolarizationEllipseParameters(kk);
        disp(['Ellipse Parameters after Surf : ',num2str(kk)]);
        Ellipicity = ellAfterCoating(2)/ellAfterCoating(1)        
        Orientation = ellAfterCoating(4)
        disp(['Rotation (1 CW/-1 CCW) = ',num2str(ellAfterCoating(3))]);
        disp('----------------------------------------------------------');
        disp('----------------------------------------------------------');
        end
    end
    %display the layout
    figure;
    axesHandle=axes;
    if ~isempty(polarizedRayTracerResult.RayIntersectionPoint)
        rayPathMatrix(:,:,1) = polarizedRayTracerResult.RayIntersectionPoint;    
    end
    if Posit(1)==0 && Direc (1) == 0 % the ray is meridional ray and so show 2D layout
         plot2DLayout( opticalSystem,rayPathMatrix,axesHandle );
    end
    figure;
    axesHandle=axes;
    plot3DLayout(opticalSystem,rayPathMatrix,axesHandle);    
end



function txtMagJs_Callback(hObject, eventdata, handles)
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



function txtPhaJs_Callback(hObject, eventdata, handles)
% hObject    handle to txtPhaJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPhaJs as text
%        str2double(get(hObject,'String')) returns contents of txtPhaJs as a double


% --- Executes during object creation, after setting all properties.
function txtPhaJs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPhaJs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPhaJp_Callback(hObject, eventdata, handles)
% hObject    handle to txtPhaJp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPhaJp as text
%        str2double(get(hObject,'String')) returns contents of txtPhaJp as a double


% --- Executes during object creation, after setting all properties.
function txtPhaJp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPhaJp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPx_Callback(hObject, eventdata, handles)
% hObject    handle to txtPx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPx as text
%        str2double(get(hObject,'String')) returns contents of txtPx as a double


% --- Executes during object creation, after setting all properties.
function txtPx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPy_Callback(hObject, eventdata, handles)
% hObject    handle to txtPy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPy as text
%        str2double(get(hObject,'String')) returns contents of txtPy as a double


% --- Executes during object creation, after setting all properties.
function txtPy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPz_Callback(hObject, eventdata, handles)
% hObject    handle to txtPz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPz as text
%        str2double(get(hObject,'String')) returns contents of txtPz as a double


% --- Executes during object creation, after setting all properties.
function txtPz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtdx_Callback(hObject, eventdata, handles)
% hObject    handle to txtdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtdx as text
%        str2double(get(hObject,'String')) returns contents of txtdx as a double


% --- Executes during object creation, after setting all properties.
function txtdx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtdy_Callback(hObject, eventdata, handles)
% hObject    handle to txtdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtdy as text
%        str2double(get(hObject,'String')) returns contents of txtdy as a double


% --- Executes during object creation, after setting all properties.
function txtdy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtdy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtdz_Callback(hObject, eventdata, handles)
% hObject    handle to txtdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtdz as text
%        str2double(get(hObject,'String')) returns contents of txtdz as a double


% --- Executes during object creation, after setting all properties.
function txtdz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtdz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtWavLen_Callback(hObject, eventdata, handles)
% hObject    handle to txtWavLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtWavLen as text
%        str2double(get(hObject,'String')) returns contents of txtWavLen as a double


% --- Executes during object creation, after setting all properties.
function txtWavLen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtWavLen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cmdMScript.
function cmdMScript_Callback(hObject, eventdata, handles)
% hObject    handle to cmdMScript (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Retrieve input data from the GUI
[Direc, Posit, Wavelen, Polar, JonesVec] = extractInitialRayData(handles);
newRay = Ray;
newRay.Direction = Direc;
newRay.Position = Posit;
newRay.Polarized = Polar;
newRay.JonesVector = JonesVec;
newRay.Wavelength = Wavelen;
opticalSystem = saveTheOpticalSystem();

%take the z coordinate of initial ray 
newRay.Position(3) = opticalSystem.SurfaceArray(1).Position(3);
generateNewScript( opticalSystem, newRay );


function [Direc, Posit, Wavelen, Polar, JonesVec] = extractInitialRayData(handles,objThick)

positionX=get(handles.txtPx);
positionX=str2num(positionX.String);

positionY=get(handles.txtPy);
positionY=str2num(positionY.String);

% positionZ=get(handles.txtPz);
% positionZ=str2num(positionZ.String);
positionZ = -objThick;


directionX=get(handles.txtdx);
directionX=str2num(directionX.String);

directionY=get(handles.txtdy);
directionY=str2num(directionY.String);

directionZ=get(handles.txtdz);
directionZ=str2num(directionZ.String);


% 
% if positionX == Inf || positionY == Inf
%                 %compute position of the cheif ray with specified direction at
%                 %the object plane (behind 1st lens surf)
%                 positionX = (objThick+pupilLocationZ)*directionX/directionZ;
%                 positionY = (objThick+pupilLocationZ)*directionY/directionZ;
%                 
% end

jonesMagS = get(handles.txtMagJs);
jonesMagS = str2num(jonesMagS.String);


jonesMagP = get(handles.txtMagJp);
jonesMagP = str2num(jonesMagP.String);

jonesPhaseS = get(handles.txtPhaJs);
jonesPhaseS = str2num(jonesPhaseS.String)*pi/180;

jonesPhaseP = get(handles.txtPhaJp);
jonesPhaseP = str2num(jonesPhaseP.String)*pi/180;

polarized=get(handles.chkPolarized);
polarized=polarized.Value;

wavelength=get(handles.txtWavLen);
wavelength=str2num(wavelength.String);

Direc = [directionX, directionY, directionZ];
Posit = [positionX, positionY, positionZ];
Wavelen = wavelength;
Polar = polarized;
JonesVec = [jonesMagS,jonesPhaseS;jonesMagP,jonesPhaseP];


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on selection change in popFieldIndexSingle.
function popFieldIndexSingle_Callback(hObject, eventdata, handles)
% hObject    handle to popFieldIndexSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popFieldIndexSingle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popFieldIndexSingle
global INF_OBJ_Z;
currentOpticalSystem = saveTheOpticalSystem;
if currentOpticalSystem.SurfaceArray(1).Thickness>10^10 %object at infinity
    fldIndexSingle = get(hObject,'Value')-1;
    maxFldIndexDefinedSingle = currentOpticalSystem.NumberOfFieldPoints;
    if fldIndexSingle == 0 
        % field parameter entries not possible with object at infinity
        msgbox 'Entering ray data directly is not allowed for objects at infinity. Please specify its field angle' ;
        %disable all the field parameter entries
        %only field angles allowed
        set(handles.txtPx,'String','0','Enable','Off');
        set(handles.txtPy,'String','1','Enable','Off');

        set(handles.txtdx,'String','0','Enable','Off');
        set(handles.txtdy,'String','0','Enable','Off');
        set(handles.txtdz,'String','1','Enable','Off');        
    elseif fldIndexSingle > 0 
        if fldIndexSingle > maxFldIndexDefinedSingle
           set(hObject,'Value',maxFldIndexDefinedSingle+1);
           fldIndexSingle = maxFldIndexDefinedSingle;
        end
        %depending on the field type, extract field value selected from the
        %configuration window and write on the direction or position fields.
        %Then make the corresponding text boxes disabled
        switch currentOpticalSystem.FieldType
            case 2%field is specified as object height
                %Using field height is not allowed for objects at infinity. Please specify its field angle
                msgbox 'Using field height is not allowed for objects at infinity. Please specify its field angle' ;                
                %disable all the field parameter entries
                %only field angles allowed
                set(handles.txtPx,'String','0','Enable','Off');
                set(handles.txtPy,'String','1','Enable','Off');

                set(handles.txtdx,'String','0','Enable','Off');
                set(handles.txtdy,'String','0','Enable','Off');
                set(handles.txtdz,'String','1','Enable','Off');            
            case 1 %field is specified as angle
                
                angX = currentOpticalSystem.FieldPointMatrix(fldIndexSingle,1)*pi/180;
                angY = currentOpticalSystem.FieldPointMatrix(fldIndexSingle,2)*pi/180;  
                
                %convert field angle to ray direction as in Zemax
                dz = sqrt(1/((tan (angX))^2+(tan (angY))^2+1));
                dx = dz*tan (angX);
                dy = dz*tan (angY);

                set(handles.txtdx,'String',num2str(dx),'Enable','Off');
                set(handles.txtdy,'String',num2str(dy),'Enable','Off');
                set(handles.txtdz,'String',num2str(dz),'Enable','Off');  


                set(handles.txtPx,'String','0','Enable','On');
                set(handles.txtPy,'String','1','Enable','On');            
        end
      
    end

else
    fldIndexSingle = get(hObject,'Value')-1;
    maxFldIndexDefinedSingle =  currentOpticalSystem.NumberOfFieldPoints;
          
    if fldIndexSingle == 0 
        %enable all the field parameter entries
        set(handles.txtPx,'String','0','Enable','On');
        set(handles.txtPy,'String','1','Enable','On');

        set(handles.txtdx,'String','0','Enable','On');
        set(handles.txtdy,'String','0','Enable','On');
        set(handles.txtdz,'String','1','Enable','On');
    elseif fldIndexSingle > 0 
        if fldIndexSingle > maxFldIndexDefinedSingle
           set(hObject,'Value',maxFldIndexDefinedSingle+1);
           fldIndexSingle = maxFldIndexDefinedSingle;
        end
        %depending on the field type, extract field value selected from the
        %configuration window and write on the direction or position fields.
        %Then make the corresponding text boxes disabled
        switch currentOpticalSystem.FieldType
        case 2%field is specified as object height
                
                posX = currentOpticalSystem.FieldPointMatrix(fldIndexSingle,1);
                posY = currentOpticalSystem.FieldPointMatrix(fldIndexSingle,2);
                
                set(handles.txtPx,'String',num2str(posX),'Enable','Off');
                set(handles.txtPy,'String',num2str(posY),'Enable','Off');

                set(handles.txtdx,'String','0','Enable','On');
                set(handles.txtdy,'String','0','Enable','On');
                set(handles.txtdz,'String','1','Enable','On');                 
        case 1%field is specified as angle
                
                angX = currentOpticalSystem.FieldPointMatrix(fldIndexSingle,1)*pi/180;
                angY = currentOpticalSystem.FieldPointMatrix(fldIndexSingle,2)*pi/180;                

                %convert field angle to ray direction as in Zemax
                dz = sqrt(1/((tan (angX))^2+(tan (angY))^2+1));
                dx = dz*tan (angX);
                dy = dz*tan (angY);

                set(handles.txtdx,'String',num2str(dx),'Enable','Off');
                set(handles.txtdy,'String',num2str(dy),'Enable','Off');
                set(handles.txtdz,'String',num2str(dz),'Enable','Off');    
                
                set(handles.txtPx,'String','0','Enable','On');
                set(handles.txtPy,'String','1','Enable','On');                
        end
        
  
    end
end

% --- Executes during object creation, after setting all properties.
function popFieldIndexSingle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popFieldIndexSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWavlengthIndexSingle.
function popWavlengthIndexSingle_Callback(hObject, eventdata, handles)
% hObject    handle to popWavlengthIndexSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWavlengthIndexSingle contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWavlengthIndexSingle

currentOpticalSystem = saveTheOpticalSystem;


wavIndexSingle = get(hObject,'Value')-1;
maxWavIndexDefinedSingle = str2num(get(findobj('Tag','txtTotalWavelengthsSelected'),'String'));
if wavIndexSingle == 0 % enter new wavelength
    %enable wavelength text box
    set(handles.txtWavLen,'String','0.55','Enable','On');
elseif wavIndexSingle > 0 
    if wavIndexSingle > maxWavIndexDefinedSingle
       set(hObject,'Value',maxWavIndexDefinedSingle+1); 
       wavIndexSingle = maxWavIndexDefinedSingle;
    end
    %write the wavelength on the wavelength text box and disable it
%     s1=strcat('txtWavlen', num2str(wavIndexSingle));
%     wavelength = str2double(get(findobj('Tag',s1),'String')); 
    wavelength = currentOpticalSystem.WavelengthMatrix(wavIndexSingle,1);
    set(handles.txtWavLen,'String',num2str(wavelength),'Enable','Off');
else
    
end

% --- Executes during object creation, after setting all properties.
function popWavlengthIndexSingle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWavlengthIndexSingle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
