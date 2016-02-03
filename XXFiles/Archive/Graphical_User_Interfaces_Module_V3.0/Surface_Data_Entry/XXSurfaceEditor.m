function varargout = SurfaceEditor(varargin)
% SURFACEEDITOR MATLAB code for SurfaceEditor.fig
%      SURFACEEDITOR, by itself, creates a new SURFACEEDITOR or raises the existing
%      singleton*.
%
%      H = SURFACEEDITOR returns the handle to a new SURFACEEDITOR or the handle to
%      the existing singleton*.
%
%      SURFACEEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SURFACEEDITOR.M with the given input arguments.
%
%      SURFACEEDITOR('Property','Value',...) creates a new SURFACEEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SurfaceEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SurfaceEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SurfaceEditor

% Last Modified by GUIDE v2.5 04-Jan-2014 03:41:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SurfaceEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @SurfaceEditor_OutputFcn, ...
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
function SurfaceEditor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SurfaceEditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global NEW_SURFACE_EDITOR_WINDOW;

NEW_SURFACE_EDITOR_WINDOW = 1;


% --- Executes just before SurfaceEditor is made visible.
function SurfaceEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SurfaceEditor (see VARARGIN)

% Choose default command line output for SurfaceEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SurfaceEditor wait for user response (see UIRESUME)
% uiwait(handles.SurfaceEditor);

global NEW_SURFACE_EDITOR_WINDOW;

if NEW_SURFACE_EDITOR_WINDOW
    % open with initial data
    InitializeSurfaceEditor();
    NEW_SURFACE_EDITOR_WINDOW = 0;
else
    % open with esxisting data
   % set(handles.SurfaceEditor,'Visible','On');
end




% --- Outputs from this function are returned to the command line.
function varargout = SurfaceEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnStandardData.
function btnStandardData_Callback(hObject, eventdata, handles)
% hObject    handle to btnStandardData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelStandardData,'Visible','On');
set(handles.panelAsphericData,'Visible','Off');
set(handles.panelAperture,'Visible','Off');
set(handles.panelTiltDecenter,'Visible','Off');
set(handles.panelCoating,'Visible','Off');

% --- Executes on button press in btnAsphericData.
function btnAsphericData_Callback(hObject, eventdata, handles)
% hObject    handle to btnAsphericData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelStandardData,'Visible','Off');
set(handles.panelAsphericData,'Visible','On');
set(handles.panelAsphericData,'Position',get(handles.panelStandardData,'Position'));
set(handles.panelAperture,'Visible','Off');
set(handles.panelTiltDecenter,'Visible','Off');
set(handles.panelCoating,'Visible','Off');
% --- Executes on button press in btnAperture.
function btnAperture_Callback(hObject, eventdata, handles)
% hObject    handle to btnAperture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelStandardData,'Visible','Off');
set(handles.panelAsphericData,'Visible','Off');
set(handles.panelAperture,'Visible','On');
set(handles.panelAperture,'Position',get(handles.panelStandardData,'Position'));
set(handles.panelTiltDecenter,'Visible','Off');
set(handles.panelCoating,'Visible','Off');

% --- Executes on button press in btnTiltDecenter.
function btnTiltDecenter_Callback(hObject, eventdata, handles)
% hObject    handle to btnTiltDecenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelStandardData,'Visible','Off');
set(handles.panelAsphericData,'Visible','Off');
set(handles.panelAperture,'Visible','Off');
set(handles.panelTiltDecenter,'Visible','On');
set(handles.panelTiltDecenter,'Position',get(handles.panelStandardData,'Position'));
set(handles.panelCoating,'Visible','Off');


% --- Executes on button press in btnCoating.
function btnCoating_Callback(hObject, eventdata, handles)
% hObject    handle to btnCoating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.panelStandardData,'Visible','Off');
set(handles.panelAsphericData,'Visible','Off');
set(handles.panelAperture,'Visible','Off');
set(handles.panelTiltDecenter,'Visible','Off');
set(handles.panelCoating,'Visible','On');
set(handles.panelCoating,'Position',get(handles.panelStandardData,'Position'));


% -------------------------------------------------------------------

% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnCancel.
function btnCancel_Callback(hObject, eventdata, handles)
% hObject    handle to btnCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnInsert.
function btnInsert_Callback(hObject, eventdata, handles)
% hObject    handle to btnInsert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InsertNewSurface(handles)

% --- Executes on button press in btnDelete.
function btnDelete_Callback(hObject, eventdata, handles)
% hObject    handle to btnDelete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RemoveThisSurface(handles)





% --- Executes when selected cell(s) is changed in tblStandardData.
function tblStandardData_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tblStandardData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

global SELECTED_CELL
global CAN_ADD
global CAN_REMOVE
SELECTED_CELL = cell2mat(struct2cell(eventdata)); %struct to matrix
if isempty(SELECTED_CELL)
    return
end


tblData = get(handles.tblStandardData,'data');
sizeTblData = size(tblData);

if SELECTED_CELL(2)==1 % only when the first column selected
    if SELECTED_CELL(1)==1 
        CAN_ADD = 0; 
        CAN_REMOVE = 0;
        columnEditable1 =  [false true true false true false true false true false true false true false];                     
        sysTable1 = findobj('Tag','tblStandardData');
        set(sysTable1,'ColumnEditable', columnEditable1);         
    elseif SELECTED_CELL(1)== sizeTblData(1)
        CAN_ADD = 1; 
        CAN_REMOVE = 0;
        columnEditable1 =  [false true true false true false true false true false true false true false];                     
        sysTable1 = findobj('Tag','tblStandardData');
        set(sysTable1,'ColumnEditable', columnEditable1);         
    else
        CAN_ADD = 1; 
        CAN_REMOVE = 1;  
        columnEditable1 =  [true true true false true false true false true false true false true false];                     
        sysTable1 = findobj('Tag','tblStandardData');
        set(sysTable1,'ColumnEditable', columnEditable1);  
    end
end

% --- Executes when user attempts to close SurfaceEditor.
function SurfaceEditor_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SurfaceEditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global VIS_SURF_DATA;
set(hObject,'Visible','Off');
VIS_SURF_DATA = 'Off';
%delete(hObject) 


 %%%%%%%%%%%%%%%%% User Defined Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function RemoveThisSurface(handles)
global SELECTED_CELL
global CAN_REMOVE

if isempty(SELECTED_CELL)
    return
end

if CAN_REMOVE
    removePosition=SELECTED_CELL(1)
 
    %update standard data table
    tblData1 = get(handles.tblStandardData,'data');
    sizeTblData1 = size(tblData1);
    parta1 = tblData1(1:removePosition-1,:);
    partb1 = tblData1(removePosition+1:sizeTblData1 ,:);
    newTable1 = [parta1; partb1];
    sysTable1 = findobj('Tag','tblStandardData');
    set(sysTable1, 'Data', newTable1);
       
    %update coating table
    tblData2 = get(handles.tblCoatingData,'data');
    sizeTblData2 = size(tblData2);
    parta2 = tblData2(1:removePosition-1,:);
    partb2 = tblData2(removePosition+1:sizeTblData2 ,:);
    newTable2 = [parta2; partb2];
    sysTable2 = findobj('Tag','tblCoatingData');
    set(sysTable2, 'Data', newTable2);
    
     %update aperture table
    tblData3 = get(handles.tblApertureData,'data');
    sizeTblData3 = size(tblData2);
    parta3 = tblData3(1:removePosition-1,:);
    partb3 = tblData3(removePosition+1:sizeTblData3 ,:);
    newTable3 = [parta3; partb3];
    sysTable3 = findobj('Tag','tblApertureData');
    set(sysTable3, 'Data', newTable3);
    
    %update Aspheric table
    tblData4 = get(handles.tblAsphericData,'data');
    sizeTblData4 = size(tblData2);
    parta4 = tblData4(1:removePosition-1,:);
    partb4 = tblData4(removePosition+1:sizeTblData4 ,:);
    newTable4 = [parta4; partb4];
    sysTable4 = findobj('Tag','tblAsphericData');
    set(sysTable4, 'Data', newTable4);   
    
     %update tilt decenter table
    tblData5 = get(handles.tblTiltDecenterData,'data');
    sizeTblData5 = size(tblData2);
    parta5 = tblData5(1:removePosition-1,:);
    partb5 = tblData5(removePosition+1:sizeTblData5 ,:);
    newTable5 = [parta5; partb5];
    sysTable5 = findobj('Tag','tblTiltDecenterData');
    set(sysTable5, 'Data', newTable5);      
end


function InsertNewSurface(handles)
global SELECTED_CELL
global CAN_ADD
if isempty(SELECTED_CELL)
    return
end
if CAN_ADD
    insertPosition=SELECTED_CELL(1)
    %update standard data table
    tblData1 = get(handles.tblStandardData,'data');
    sizeTblData1 = size(tblData1);
    parta1 = tblData1(1:insertPosition-1,:);
    newRow1 =  {'Surf','','Plane','','Inf','','0','','','','+1 Refractive','','0',''};
    partb1 = tblData1(insertPosition:sizeTblData1 ,:);
    newTable1 = [parta1; newRow1; partb1];
    sysTable1 = findobj('Tag','tblStandardData');
    set(sysTable1, 'Data', newTable1);
    
    %update coating table
    tblData2 = get(handles.tblCoatingData,'data');
    sizeTblData2 = size(tblData2);
    parta2 = tblData2(1:insertPosition-1,:);
    newRow2 =  {'Surf','Plane','None','','0','','0','','0','','0',''};
    partb2 = tblData2(insertPosition:sizeTblData2 ,:);
    newTable2 = [parta2; newRow2; partb2];
    sysTable2 = findobj('Tag','tblCoatingData');
    set(sysTable2, 'Data', newTable2);
    
     %update aperture table
    tblData3 = get(handles.tblApertureData,'data');
    sizeTblData3 = size(tblData2);
    parta3 = tblData3(1:insertPosition-1,:);
    newRow3 =  {'Surf','Plane','Circular','','0','','0','','0','','0',''};
    partb3 = tblData3(insertPosition:sizeTblData3 ,:);
    newTable3 = [parta3; newRow3; partb3];
    sysTable3 = findobj('Tag','tblApertureData');
    set(sysTable3, 'Data', newTable3);
    
    %update Aspheric table
    tblData4 = get(handles.tblAsphericData,'data');
    sizeTblData4 = size(tblData2);
    parta4 = tblData4(1:insertPosition-1,:);
    newRow4 =  {'Surf','Plane','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0',''};
    partb4 = tblData4(insertPosition:sizeTblData4 ,:);
    newTable4 = [parta4; newRow4; partb4];
    sysTable4 = findobj('Tag','tblAsphericData');
    set(sysTable4, 'Data', newTable4);   
    
     %update tilt decenter table
    tblData5 = get(handles.tblTiltDecenterData,'data');
    sizeTblData5 = size(tblData2);
    parta5 = tblData5(1:insertPosition-1,:);
    newRow5 =  {'Surf','Plane','DxDyDzTxTyTz','','0','','0','','0','','0','','0','','DAR',''};
    partb5 = tblData5(insertPosition:sizeTblData5 ,:);
    newTable5 = [parta5; newRow5; partb5];
    sysTable5 = findobj('Tag','tblTiltDecenterData');
    set(sysTable5, 'Data', newTable5);
    
    % If possible add here a code to select the first cell of newly added row
    % automatically
end
  


% --- Executes when entered data in editable cell(s) in tblStandardData.
function tblStandardData_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tblStandardData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
if eventdata.Indices(2) == 1    %if surface tag  is changed update all tables in the editor
    if (strcmpi(eventdata.PreviousData,'OBJECT'))||(strcmpi(eventdata.PreviousData,'IMAGE'))||(strcmpi(eventdata.PreviousData,'STOP'))
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         tblData1{eventdata.Indices(1),1} = eventdata.PreviousData;
         set(findobj('Tag','tblStandardData'), 'Data', tblData1);

    elseif (strcmpi(eventdata.NewData,'STOP')) ||(strcmpi(eventdata.NewData,'STO'))||(strcmpi(eventdata.NewData,'ST'))||(strcmpi(eventdata.NewData,'S'))
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         tblData2 = get(findobj('Tag','tblApertureData'),'data');
         tblData3 = get(findobj('Tag','tblCoatingData'),'data');
         tblData4 = get(findobj('Tag','tblAsphericData'),'data');
         tblData5 = get(findobj('Tag','tblTiltDecenterData'),'data');
         
         kk = 2;
         while ~strcmpi(tblData1{kk,1},'Image')
             
             if kk == eventdata.Indices(1)
                 surfTag = 'STOP';
             else
                 surfTag = 'Surf';
             end
             tblData1{kk,1} = surfTag;         
             set(findobj('Tag','tblStandardData'), 'Data', tblData1);  

             tblData2{kk,1} = surfTag;
             set(findobj('Tag','tblApertureData'), 'Data', tblData2);

             tblData3{kk,1} = surfTag;     
             set(findobj('Tag','tblCoatingData'), 'Data', tblData3);

             tblData4{kk,1} = surfTag;
             set(findobj('Tag','tblAsphericData'), 'Data', tblData4);

             tblData5{kk,1} = surfTag;
             set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData5); 
             
             kk = kk+1;
         end
    else
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         tblData1{eventdata.Indices(1),1} = eventdata.PreviousData;
         set(findobj('Tag','tblStandardData'), 'Data', tblData1);
    end
             
    columnEditable1 =  [false true true false true false true false true false true false true false];                     
    sysTable1 = findobj('Tag','tblStandardData');
    set(sysTable1,'ColumnEditable', columnEditable1);  
elseif eventdata.Indices(2) == 3 && ~(strcmpi(eventdata.NewData,''))   %if surface type is changed update all tables in the editor  
     if strcmpi(strtrim(eventdata.NewData),'Plane')
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         tblData1{eventdata.Indices(1),5} = 'Inf';
         set(findobj('Tag','tblStandardData'), 'Data', tblData1);         
     end
     
     tblData2 = get(findobj('Tag','tblApertureData'),'data');
     tblData2{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(findobj('Tag','tblApertureData'), 'Data', tblData2);
     
     tblData3 = get(findobj('Tag','tblCoatingData'),'data');
     tblData3{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;     
     set(findobj('Tag','tblCoatingData'), 'Data', tblData3);
     
     tblData4 = get(findobj('Tag','tblAsphericData'),'data');
     tblData4{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(findobj('Tag','tblAsphericData'), 'Data', tblData4);
     
     tblData5 = get(findobj('Tag','tblTiltDecenterData'),'data');
     tblData5{eventdata.Indices(1),eventdata.Indices(2)-1} = eventdata.NewData;
     set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData5);
 elseif eventdata.Indices(2) == 5 %if radius field changes    
     if isempty(str2num(eventdata.NewData))||any(imag(str2num(eventdata.NewData)))%if the radius field is not a number
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         tblData1{eventdata.Indices(1),5} = 'Inf';
         tblData1{eventdata.Indices(1),3} = 'Plane';
         set(findobj('Tag','tblStandardData'), 'Data', tblData1);
         
         %update other tables
         tblData2 = get(findobj('Tag','tblApertureData'),'data');
         tblData2{eventdata.Indices(1),2} = 'Plane';
         set(findobj('Tag','tblApertureData'), 'Data', tblData2);

         tblData3 = get(findobj('Tag','tblCoatingData'),'data');
         tblData3{eventdata.Indices(1),2} = 'Plane';     
         set(findobj('Tag','tblCoatingData'), 'Data', tblData3);

         tblData4 = get(findobj('Tag','tblAsphericData'),'data');
         tblData4{eventdata.Indices(1),2} = 'Plane';
         set(findobj('Tag','tblAsphericData'), 'Data', tblData4);

         tblData5 = get(findobj('Tag','tblTiltDecenterData'),'data');
         tblData5{eventdata.Indices(1),2} = 'Plane';
         set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData5);
     
     elseif strcmpi(strtrim(eventdata.NewData),'inf') % if radius is infinity
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         tblData1{eventdata.Indices(1),3} = 'Plane';
         set(findobj('Tag','tblStandardData'), 'Data', tblData1);
         
         %update other tables
         tblData2 = get(findobj('Tag','tblApertureData'),'data');
         tblData2{eventdata.Indices(1),2} = 'Plane';
         set(findobj('Tag','tblApertureData'), 'Data', tblData2);

         tblData3 = get(findobj('Tag','tblCoatingData'),'data');
         tblData3{eventdata.Indices(1),2} = 'Plane';     
         set(findobj('Tag','tblCoatingData'), 'Data', tblData3);

         tblData4 = get(findobj('Tag','tblAsphericData'),'data');
         tblData4{eventdata.Indices(1),2} = 'Plane';
         set(findobj('Tag','tblAsphericData'), 'Data', tblData4);

         tblData5 = get(findobj('Tag','tblTiltDecenterData'),'data');
         tblData5{eventdata.Indices(1),2} = 'Plane';
         set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData5);         
         
     else
         tblData1 = get(findobj('Tag','tblStandardData'),'data');
         if strcmpi(strtrim(tblData1{eventdata.Indices(1),3}),'Plane') 
             tblData1{eventdata.Indices(1),3} = 'Spherical';
             set(findobj('Tag','tblStandardData'), 'Data', tblData1);
             
         %update other tables
         tblData2 = get(findobj('Tag','tblApertureData'),'data');
         tblData2{eventdata.Indices(1),2} = 'Spherical';
         set(findobj('Tag','tblApertureData'), 'Data', tblData2);

         tblData3 = get(findobj('Tag','tblCoatingData'),'data');
         tblData3{eventdata.Indices(1),2} = 'Spherical';     
         set(findobj('Tag','tblCoatingData'), 'Data', tblData3);

         tblData4 = get(findobj('Tag','tblAsphericData'),'data');
         tblData4{eventdata.Indices(1),2} = 'Spherical';
         set(findobj('Tag','tblAsphericData'), 'Data', tblData4);

         tblData5 = get(findobj('Tag','tblTiltDecenterData'),'data');
         tblData5{eventdata.Indices(1),2} = 'Spherical';
         set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData5);             
             
             
         end       
     end
elseif eventdata.Indices(1) == 1 && eventdata.Indices(2) == 7 % if first thickness is changed
    if validateOpticalSystem

    else
         button = questdlg('Invalid input detected. Do you want to restore previous valid object thickness value?','Restore Object Thickness');
         if strcmpi(button,'Yes')
             tblData1 = get(findobj('Tag','tblStandardData'),'data');
             tblData1{eventdata.Indices(1),7} = eventdata.PreviousData;
             set(findobj('Tag','tblStandardData'), 'Data', tblData1);
         end
    end  
elseif eventdata.Indices(2) == 9 %if glass is changed
     if isempty(strtrim(eventdata.NewData))%An air space
         
     elseif strcmp(upper(strtrim(eventdata.NewData)),'NEW')%define new glass
         setappdata(0,'surfIndexForGlass',eventdata.Indices(1));
         glassDefinition;  
     elseif ~isnan(str2double(eventdata.NewData))%direcly specify refractive index
         
     else %name of previously saved glass
         %look for the glass in the catalogue and if not pop up error message
        
         % load('f:\aoeGlassCatalogue.mat','AllGlass');
        load(which('aoeGlassCatalogue.mat'),'AllGlass');        
        location = find(strcmpi({AllGlass.Name},strtrim(eventdata.NewData)));
        clear AllGlass
        if isempty(location)
           button = questdlg('The glass is not found in the catalogue. Do you want to add?','Glass Not Found');
           switch button
               case 'Yes'
                  setappdata(0,'surfIndexForGlass',eventdata.Indices(1));
                  glassDefinition;
               case 'No'
                   tblData = get(findobj('Tag','tblStandardData'),'data');
                   tblData{eventdata.Indices(1),9} = '';     
                   set(findobj('Tag','tblStandardData'), 'Data', tblData);                  
               case 'Cancel'
                   tblData = get(findobj('Tag','tblStandardData'),'data');
                   tblData{eventdata.Indices(1),9} = '';     
                   set(findobj('Tag','tblStandardData'), 'Data', tblData);
           end
        else
           tblData = get(findobj('Tag','tblStandardData'),'data');
           tblData{eventdata.Indices(1),9} = upper(tblData{eventdata.Indices(1),9});     
           set(findobj('Tag','tblStandardData'), 'Data', tblData);
        end
     
     end
elseif eventdata.Indices(2) == 13 %if semi diameter is changed and has no aperture defined

     %update aperture table
     tblData2 = get(findobj('Tag','tblApertureData'),'data');
     if strcmpi(tblData2{eventdata.Indices(1),3},'None')
         tblData2{eventdata.Indices(1),5} = eventdata.NewData;
     end
     
     set(findobj('Tag','tblApertureData'), 'Data', tblData2);

                            
end
 
   


% --- Executes when entered data in editable cell(s) in tblCoatingData.
function tblCoatingData_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tblCoatingData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

 if eventdata.Indices(2) == 3 
     switch eventdata.NewData
         case 'None'
            columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Param1', '', 'Param2', '', 'Param3', '', 'Param4', ''};
 
         case 'Jones Matrix'
             columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Ts', '', 'Tp', '', 'Rs', '', 'Rp', ''};

         case 'Multilayer Coating'
             columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Name', '', 'Layers', '', 'Repetetion', '', 'Reverse', ''};
             setappdata(0,'surfI',eventdata.Indices(1));
             coatingDefinition;
     end
    sysTable3 = findobj('Tag','tblCoatingData');
    set(sysTable3, 'ColumnName', columnName3); 
 end


% --- Executes when selected cell(s) is changed in tblCoatingData.
function tblCoatingData_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tblCoatingData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
  selRow = eventdata.Indices;
  if ~isempty(selRow)
     tblData = get(findobj('Tag','tblCoatingData'),'data');
     coatType = tblData{selRow(1),3};     

     switch coatType
         case 'None'
            columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Param1', '', 'Param2', '', 'Param3', '', 'Param4', ''};
 
         case 'Jones Matrix'
             columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Ts', '', 'Tp', '', 'Rs', '', 'Rp', ''};

         case 'Multilayer Coating'
             columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Name', '', 'Param2', '', 'Param3', '', 'Param4', ''};
     end
    sysTable3 = findobj('Tag','tblCoatingData');
    set(sysTable3, 'ColumnName', columnName3); 
  end


% --------------------------------------------------------------------
function tblStandardData_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to tblStandardData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in tblTiltDecenterData.
function tblTiltDecenterData_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tblTiltDecenterData (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
if eventdata.Indices(2) == 3  % 3rd row
    if isempty(eventdata.NewData)
        % restore previous data
           tblData = get(findobj('Tag','tblTiltDecenterData'),'data');
           tblData{eventdata.Indices(1),3} = eventdata.PreviousData;     
           set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData);
    else
        if validateInput(eventdata.NewData,'TiltDecenterOrder')
            % valid input so format the text
            orderStr = upper(eventdata.NewData);
            formatedOrder(1:2:11) = upper(orderStr(1:2:11));
            formatedOrder(2:2:12) = lower(orderStr(2:2:12));
            tblData = get(findobj('Tag','tblTiltDecenterData'),'data');
            tblData{eventdata.Indices(1),3} = formatedOrder;     
            set(findobj('Tag','tblTiltDecenterData'), 'Data', tblData);            
        else
            % invalid input so call gui to enter the tilt/decenter order
            setappdata(0,'surfIndexForTiltDecenter',eventdata.Indices(1));                
            tiltDecenterOrder            
        end
    end
end
  
