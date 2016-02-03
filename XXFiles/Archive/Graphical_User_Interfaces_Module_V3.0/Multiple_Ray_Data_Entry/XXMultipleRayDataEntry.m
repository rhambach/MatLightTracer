function varargout = MultipleRayDataEntry(varargin)
% MULTIPLERAYDATAENTRY MATLAB code for MultipleRayDataEntry.fig
%      MULTIPLERAYDATAENTRY, by itself, creates a new MULTIPLERAYDATAENTRY or raises the existing
%      singleton*.
%
%      H = MULTIPLERAYDATAENTRY returns the handle to a new MULTIPLERAYDATAENTRY or the handle to
%      the existing singleton*.
%
%      MULTIPLERAYDATAENTRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MULTIPLERAYDATAENTRY.M with the given input arguments.
%
%      MULTIPLERAYDATAENTRY('Property','Value',...) creates a new MULTIPLERAYDATAENTRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MultipleRayDataEntry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MultipleRayDataEntry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MultipleRayDataEntry

% Last Modified by GUIDE v2.5 11-Oct-2013 14:58:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MultipleRayDataEntry_OpeningFcn, ...
                   'gui_OutputFcn',  @MultipleRayDataEntry_OutputFcn, ...
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


% --- Executes just before MultipleRayDataEntry is made visible.
function MultipleRayDataEntry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MultipleRayDataEntry (see VARARGIN)

% Choose default command line output for MultipleRayDataEntry
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

currentOpticalSystem = saveTheOpticalSystem;
  
if currentOpticalSystem.SurfaceArray(1).Thickness>10^10 %object at infinity
    %disable all the field parameter entries
    %only field angles allowed
    set(handles.txtRayBundlePx,'String','0','Enable','On');
    set(handles.txtRayBundlePy,'String','0','Enable','On');

end
% UIWAIT makes MultipleRayDataEntry wait for user response (see UIRESUME)
% uiwait(handles.MultipleRayDataEntry);


% --- Outputs from this function are returned to the command line.
function varargout = MultipleRayDataEntry_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtRayBundlePx_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundlePx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundlePx as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundlePx as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundlePx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundlePx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRayBundlePy_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundlePy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundlePy as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundlePy as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundlePy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundlePy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRayBundlePz_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundlePz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundlePz as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundlePz as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundlePz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundlePz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popPupilSampling.
function popPupilSampling_Callback(hObject, eventdata, handles)
% hObject    handle to popPupilSampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPupilSampling contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popPupilSampling


% --- Executes during object creation, after setting all properties.
function popPupilSampling_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPupilSampling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtNumberOfRays_Callback(hObject, eventdata, handles)
% hObject    handle to txtNumberOfRays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtNumberOfRays as text
%        str2double(get(hObject,'String')) returns contents of txtNumberOfRays as a double


% --- Executes during object creation, after setting all properties.
function txtNumberOfRays_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNumberOfRays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkRayBundlePolarized.
function chkRayBundlePolarized_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundlePolarized (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundlePolarized
if get(hObject,'Value')
    set(handles.txtRayBundleJsMag, 'Enable', 'On');
    set(handles.txtRayBundleJpMag', 'Enable', 'On');
    set(handles.txtRayBundleJsPhase', 'Enable', 'On');
    set(handles.txtRayBundleJpPhase', 'Enable', 'On');    
else
    set(handles.txtRayBundleJsMag, 'Enable', 'Off');
    set(handles.txtRayBundleJpMag', 'Enable', 'Off');
    set(handles.txtRayBundleJsPhase', 'Enable', 'Off');
    set(handles.txtRayBundleJpPhase', 'Enable', 'Off');      
end

% --- Executes on button press in btnRayBundleCancel.
function btnRayBundleCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnRayBundleCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(MultipleRayDataEntry,'Visible','Off');

% --- Executes on button press in btnRayBundleOk.
function btnRayBundleOk_Callback(hObject, eventdata, handles)
% hObject    handle to btnRayBundleOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global INF_OBJ_Z;

optSystem = saveTheOpticalSystem();
if abs(optSystem.SurfaceArray(1).Thickness) > 10^10 %object at infinity
    objThick = INF_OBJ_Z;
else
    objThick  = optSystem.SurfaceArray(1).Thickness;
end

[fieldPoint,PupSamplingType,numberOfRays, wavLen, Polarized,PolDistribution,...
    JonesVec,showSpotDiagram,showPolEllipse,showAmpTransMap,showPhaseMap,...
    showDiattMap,showRetardMap] = extractInitialRayBundleData(handles,objThick);

[multipleRayTracerResult,pupilCoordinates,pupilGridIndices] = optSystem.multipleRayTracer(wavLen,...
                 fieldPoint,numberOfRays,PupSamplingType,JonesVec);

%display the layout

nRay = length(multipleRayTracerResult);
for rayIndex = 1:1:nRay     
    if ~isempty(multipleRayTracerResult(rayIndex).RayIntersectionPoint)
       rayPathMatrix(:,:,rayIndex) =  multipleRayTracerResult(rayIndex).RayIntersectionPoint;       
    end
end

if PupSamplingType == 5 % the ray are meridional rays and so show 2D layout
     figure
     axesHandle = axes;
     plot2DLayout( optSystem,rayPathMatrix,axesHandle );
end
figure
axesHandle = axes;
plot3DLayout(optSystem,rayPathMatrix,axesHandle);  

hold off;


function txtRayBundleWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundleWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundleWavelength as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundleWavelength as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundleWavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundleWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnRayBundleMScript.
function btnRayBundleMScript_Callback(hObject, eventdata, handles)
% hObject    handle to btnRayBundleMScript (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function txtRayBundleJsMag_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJsMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundleJsMag as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundleJsMag as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundleJsMag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJsMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRayBundleJpMag_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJpMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundleJpMag as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundleJpMag as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundleJpMag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJpMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRayBundleJsPhase_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJsPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundleJsPhase as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundleJsPhase as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundleJsPhase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJsPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtRayBundleJpPhase_Callback(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJpPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRayBundleJpPhase as text
%        str2double(get(hObject,'String')) returns contents of txtRayBundleJpPhase as a double


% --- Executes during object creation, after setting all properties.
function txtRayBundleJpPhase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRayBundleJpPhase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkRayBundleSpotDiag.
function chkRayBundleSpotDiag_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundleSpotDiag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundleSpotDiag


% --- Executes on button press in chkRayBundlePolEllipseDiag.
function chkRayBundlePolEllipseDiag_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundlePolEllipseDiag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundlePolEllipseDiag


% --- Executes on button press in chkRayBundleAmpTransMap.
function chkRayBundleAmpTransMap_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundleAmpTransMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundleAmpTransMap


% --- Executes on button press in chkRayBundlePhaseMap.
function chkRayBundlePhaseMap_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundlePhaseMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundlePhaseMap


% --- Executes on button press in chkRayBundleDiattMap.
function chkRayBundleDiattMap_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundleDiattMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundleDiattMap


% --- Executes on button press in chkRayBundleRetardMap.
function chkRayBundleRetardMap_Callback(hObject, eventdata, handles)
% hObject    handle to chkRayBundleRetardMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkRayBundleRetardMap


% --- Executes on selection change in popPolDistribution.
function popPolDistribution_Callback(hObject, eventdata, handles)
% hObject    handle to popPolDistribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popPolDistribution contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popPolDistribution


% --- Executes during object creation, after setting all properties.
function popPolDistribution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPolDistribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function [fieldPoint,PupSamplingType,numberOfRays, wavLen, Polarized,PolDistribution,...
    JonesVec,showSpotDiagram,showPolEllipse,showAmpTransMap,showPhaseMap,showDiattMap,...
    showRetardMap] = extractInitialRayBundleData(handles,objThick)
FieldPointX=get(handles.txtRayBundlePx);
FieldPointX=str2num(FieldPointX.String);

FieldPointY=get(handles.txtRayBundlePy);
FieldPointY=str2num(FieldPointY.String);

% FieldPointZ=get(handles.txtRayBundlePz);
% FieldPointZ=str2num(FieldPointZ.String);
FieldPointZ = -objThick;

pupilSampling=get(handles.popPupilSampling);
pupilSampling=(pupilSampling.Value); %1: Cartesian 2: Polar Grid 3: Hexagonal 
%4: Isoenergetic Circular 5: Tangential Plane 6: Sagital Plane 7:Random

% currently only1,5, 6 and 7 are supported all others will be trated as 1
if pupilSampling == 2 || pupilSampling == 3 || pupilSampling == 4 
    pupilSampling = 1;
end

nRay=get(handles.txtNumberOfRays);
nRay=str2num(nRay.String);


polDist=get(handles.popPolDistribution);
polDist=(polDist.Value); % 1: fixed JV


jonesMagS = get(handles.txtRayBundleJsMag);
jonesMagS = str2num(jonesMagS.String);


jonesMagP = get(handles.txtRayBundleJpMag);
jonesMagP = str2num(jonesMagP.String);

jonesPhaseS = get(handles.txtRayBundleJsPhase);
jonesPhaseS = str2num(jonesPhaseS.String);

jonesPhaseP = get(handles.txtRayBundleJpPhase);
jonesPhaseP = str2num(jonesPhaseP.String);

polar=get(handles.chkRayBundlePolarized);
polar=polar.Value;

wavelength=get(handles.txtRayBundleWavelength);
wavelength=str2num(wavelength.String);

spotDiag=get(handles.chkRayBundleSpotDiag);
spotDiag=spotDiag.Value;

polEllipse=get(handles.chkRayBundlePolEllipseDiag);
polEllipse=polEllipse.Value;

ampTrans=get(handles.chkRayBundleAmpTransMap);
ampTrans=ampTrans.Value;

phase=get(handles.chkRayBundlePhaseMap);
phase=phase.Value;


diatt=get(handles.chkRayBundleDiattMap);
diatt=diatt.Value;

retard=get(handles.chkRayBundleRetardMap);
retard=retard.Value;

fieldPoint= [FieldPointX, FieldPointY, FieldPointZ];
PupSamplingType=pupilSampling;
numberOfRays=nRay;
wavLen = wavelength;
Polarized= polar;
PolDistribution=polDist;
JonesVec= [jonesMagS,jonesPhaseS;jonesMagP,jonesPhaseP];
showSpotDiagram=spotDiag;
showPolEllipse=polEllipse;
showAmpTransMap=ampTrans;
showPhaseMap=phase;
showDiattMap=diatt;
showRetardMap=retard;


% --- Executes on selection change in popFieldIndexMulti.
function popFieldIndexMulti_Callback(hObject, eventdata, handles)
% hObject    handle to popFieldIndexMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popFieldIndexMulti contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popFieldIndexMulti
global INF_OBJ_Z;
currentOpticalSystem = saveTheOpticalSystem;
if currentOpticalSystem.SurfaceArray(1).Thickness>10^10 % object at infinity       
    fldIndexMulti = get(hObject,'Value')-1;
    maxFldIndexDefinedMulti = currentOpticalSystem.NumberOfFieldPoints;
    if fldIndexMulti == 0 
        % only field angles allowed
        set(handles.txtRayBundlePx,'String','0','Enable','On');
        set(handles.txtRayBundlePy,'String','0','Enable','On');
    elseif fldIndexMulti > 0 
        if fldIndexMulti > maxFldIndexDefinedMulti
           set(hObject,'Value',maxFldIndexDefinedMulti+1);
           fldIndexMulti = maxFldIndexDefinedMulti;
        end
        % depending on the field type, extract field value selected from the
        % configuration window and write on the direction or position fields.
        % Then make the corresponding text boxes disabled
        switch currentOpticalSystem.FieldType
            case 2 % field is specified as object height
                % Using field height is not allowed for objects at infinity. Please specify its field angle
                msgbox 'Using field height is not allowed for objects at infinity. Please specify its field angle' ;                
                % disable all the field parameter entries
                % only field angles allowed
                set(handles.txtRayBundlePx,'String','0','Enable','Off');
                set(handles.txtRayBundlePy,'String','0','Enable','Off');            
            case 1 % field is specified as angle
                % extract direction from the field angle in configuration window,
                % and disable field direction entries                             
                angX = currentOpticalSystem.FieldPointMatrix(fldIndexMulti,1);
                angY = currentOpticalSystem.FieldPointMatrix(fldIndexMulti,2); 
                
                set(handles.txtRayBundlePx,'String',num2str(angX),'Enable','Off');
                set(handles.txtRayBundlePy,'String',num2str(angY),'Enable','Off');                           
        end        
    end
else
    fldIndexMulti = get(hObject,'Value')-1;
    maxFldIndexDefinedMulti = currentOpticalSystem.NumberOfFieldPoints;
    if fldIndexMulti == 0 
        %enable all the field parameter entries
        set(handles.txtRayBundlePx,'String','0','Enable','On');
        set(handles.txtRayBundlePy,'String','1','Enable','On');
    elseif fldIndexMulti > 0 
        if fldIndexMulti > maxFldIndexDefinedMulti
           set(hObject,'Value',maxFldIndexDefinedMulti+1);
           fldIndexMulti = maxFldIndexDefinedMulti;
        end
        % depending on the field type, extract field value selected from the
        % configuration window and write on the direction or position fields.
        % Then make the corresponding text boxes disabled
        switch currentOpticalSystem.FieldType
            case 2 % field is specified as object height
                posX = currentOpticalSystem.FieldPointMatrix(fldIndexMulti,1);
                posY = currentOpticalSystem.FieldPointMatrix(fldIndexMulti,2);               
                % disable all the field parameter entries
                % only field angles allowed
                set(handles.txtRayBundlePx,'String',num2str(posX),'Enable','Off');
                set(handles.txtRayBundlePy,'String',num2str(posY),'Enable','Off');            
            case 1 % field is specified as angle
                % extract direction from the field angle in configuration window,
                % and disable field direction entries                
                angX = currentOpticalSystem.FieldPointMatrix(fldIndexMulti,1);
                angY = currentOpticalSystem.FieldPointMatrix(fldIndexMulti,2); 
                
                set(handles.txtRayBundlePx,'String',num2str(angX),'Enable','Off');
                set(handles.txtRayBundlePy,'String',num2str(angY),'Enable','Off');                 
%                 
%                 %convert field angle to ray direction as in Zemax
%                 dz = sqrt(1/((tan (angX))^2+(tan (angY))^2+1));
%                 dx = dz*tan (angX);
%                 dy = dz*tan (angY);
% 
%                 set(handles.txtdx,'String',num2str(dx),'Enable','Off');
%                 set(handles.txtdy,'String',num2str(dy),'Enable','Off');
%                 set(handles.txtdz,'String',num2str(dz),'Enable','Off');  

%                 set(handles.txtPx,'String','0','Enable','On');
%                 set(handles.txtPy,'String','1','Enable','On');            
        end        
    end    
end
   


% --- Executes during object creation, after setting all properties.
function popFieldIndexMulti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popFieldIndexMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popWavLengthIndexMulti.
function popWavLengthIndexMulti_Callback(hObject, eventdata, handles)
% hObject    handle to popWavLengthIndexMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popWavLengthIndexMulti contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popWavLengthIndexMulti
currentOpticalSystem = saveTheOpticalSystem;
wavIndexMulti = get(hObject,'Value')-1;
maxWavIndexDefinedMulti = currentOpticalSystem.NumberOfWavelengths;
if wavIndexMulti == 0 % enter new wavelength
    % enable wavelength text box
    set(handles.txtRayBundleWavelength,'String','0.55','Enable','On');
elseif wavIndexMulti > 0 
    if  wavIndexMulti > maxWavIndexDefinedMulti
        set(hObject,'Value',maxWavIndexDefinedMulti+1);
        wavIndexMulti = maxWavIndexDefinedMulti;
    end
    % write the wavelength on the wavelength text box and disable it
    wavelength = currentOpticalSystem.WavelengthMatrix(wavIndexMulti,1);    
    set(handles.txtRayBundleWavelength,'String',num2str(wavelength),'Enable','Off');
else
end  

% --- Executes during object creation, after setting all properties.
function popWavLengthIndexMulti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popWavLengthIndexMulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
