function varargout = coatingDefinition(varargin)
% COATINGDEFINITION MATLAB code for coatingDefinition.fig
%      COATINGDEFINITION, by itself, creates a new COATINGDEFINITION or raises the existing
%      singleton*.
%
%      H = COATINGDEFINITION returns the handle to a new COATINGDEFINITION or the handle to
%      the existing singleton*.
%
%      COATINGDEFINITION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COATINGDEFINITION.M with the given input arguments.
%
%      COATINGDEFINITION('Property','Value',...) creates a new COATINGDEFINITION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coatingDefinition_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coatingDefinition_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coatingDefinition

% Last Modified by GUIDE v2.5 29-Sep-2013 16:43:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coatingDefinition_OpeningFcn, ...
                   'gui_OutputFcn',  @coatingDefinition_OutputFcn, ...
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


% --- Executes just before coatingDefinition is made visible.
function coatingDefinition_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coatingDefinition (see VARARGIN)

% Choose default command line output for coatingDefinition
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes coatingDefinition wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coatingDefinition_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function savedCoating = saveCoatingFile(handles) 
coatType = 'Multilayer Coating';
coatName = get(handles.txtCoatingName,'String');
rept = str2num(get(handles.txtRepetetion,'String'));
reverse = get(handles.chkReverse,'Value');
refractiveIndexProf = get(handles.tblRefractiveIndexProfile,'Data');

%validate input
if iscell(refractiveIndexProf)
    refInd = cell2mat(refractiveIndexProf(:,1));
    thik = cell2mat(refractiveIndexProf(:,2));
else
    refInd = (refractiveIndexProf(:,1));
    thik = (refractiveIndexProf(:,2));
end

if length(refInd)-length(thik) > 0
    msgbox 'Input error in refractive index profile';
    refInd = refInd(1:length(thik),:);
elseif length(refInd)-length(thik) < 0
    msgbox 'Input error in refractive index profile';
    thik = thik(1:length(refInd),:);        
end  
refractiveIndexProf = [refInd thik];
TR =[NaN,NaN;NaN,NaN];
Ts = TR(1);
Tp = TR(2);
Rs = TR(3);
Rp = TR(4);
savedCoating = Coating(coatType,coatName,Ts,Tp,Rs,Rp,refractiveIndexProf,rept,reverse);


% --- Executes on button press in cmdInsertCoating.
function cmdInsertCoating_Callback(hObject, eventdata, handles)
% hObject    handle to cmdInsertCoating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%setappdata(0,'surfI',eventdata.Indices(1));
%FileName = strcat(get(handles.txtCoatingName,'String'),'.mat');

%validate the epsilon profile

savedCoating = saveCoatingFile(handles);

fileInfoCoating = struct();
fileInfoCoating.Type = 'Coating';
fileInfoCoating.Date = date;
% if exist(FileName,'file')
%     button = questdlg('Coating already exists, do you want to replace?','Existing File');
%     switch button
%         case 'Yes'
%             save(FileName,'savedCoating','fileInfoCoating');
%         case 'No'
%         case 'Cancel'
%     end
% else
%      save(FileName,'savedCoating','fileInfoCoating');
% end

name = get(handles.txtCoatingName,'String');
%load the coating catalogue file and add the new glass
%load('f:\aoeCoatingCatalogue.mat','AllCoating');

load(which('aoeCoatingCatalogue.mat'),'AllCoating');
%check that the coating doesnot exsist in the catalogue
location = find(strcmpi({AllCoating.Name},name));
if ~isempty(location)
   button = questdlg('The coating is already in the catalogue. Do you want to update it?','Coating Found','Yes','No','Cancel');
   switch button
       case 'Yes'
            AllCoating(location(1)) = savedCoating;
            save(which('aoeCoatingCatalogue.mat'),'AllCoating','fileInfoCoating');
            clear AllCoating;
            clear fileInfoCoating;

            %transfer the coating name to the surface editor
            selRow = getappdata(0,'surfI');
            tblData = get(findobj('Tag','tblCoatingData'),'data');
            tblData{selRow,5} = get(handles.txtCoatingName,'String');     
            set(findobj('Tag','tblCoatingData'), 'Data', tblData);
       case 'No' 
            selRow = getappdata(0,'surfI');
            tblData = get(findobj('Tag','tblCoatingData'),'data');
            tblData{selRow,5} = '';     
            set(findobj('Tag','tblCoatingData'), 'Data', tblData);           
       case 'Cancel'
           
   end
else
    AllCoating(length(AllCoating)+1) = savedCoating;
    save(which('aoeCoatingCatalogue.mat'),'AllCoating','fileInfoCoating');
    clear AllCoating;
    clear fileInfoCoating;
        %transfer the coating name to the surface editor
    selRow = getappdata(0,'surfI');
    tblData = get(findobj('Tag','tblCoatingData'),'data');
    tblData{selRow,5} = get(handles.txtCoatingName,'String');     
    set(findobj('Tag','tblCoatingData'), 'Data', tblData);
end

close(coatingDefinition);

% to create a new glass catalog file
function createNewCoatingCatalogue(catName)
AllCoating = Coating('None','None',NaN,NaN,NaN,NaN,[NaN,NaN],NaN,NaN)
save(strcat('f:\',catName,'.mat'),'AllCoating');
save(strcat('f:\',catName,'.mat'),'AllCoating','-append');

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



function txtRepetetion_Callback(hObject, eventdata, handles)
% hObject    handle to txtRepetetion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtRepetetion as text
%        str2double(get(hObject,'String')) returns contents of txtRepetetion as a double


% --- Executes during object creation, after setting all properties.
function txtRepetetion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtRepetetion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkReverse.
function chkReverse_Callback(hObject, eventdata, handles)
% hObject    handle to chkReverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkReverse


% --- Executes on button press in cmdOpenCoating.
function cmdOpenCoating_Callback(hObject, eventdata, handles)
% hObject    handle to cmdOpenCoating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%FileName = strcat(get(handles.txtCoatingName,'String'),'.mat');

name = get(handles.txtCoatingName,'String');
%check that the coating does exsist in the catalogue

%load('f:\aoeCoatingCatalogue.mat','AllCoating','fileInfoCoating');
load(which('aoeCoatingCatalogue.mat'),'AllCoating','fileInfoCoating');

location = find(strcmpi({AllCoating.Name},name));
if ~isempty(location)
  % File exists.  Do stuff....
  set(handles.txtRepetetion,'String',AllCoating(location(1)).RepetitionNumber);
  set(handles.chkReverse,'Value',AllCoating(location(1)).UseInReverse);
  set(handles.tblRefractiveIndexProfile,'Data',AllCoating(location(1)).refractiveIndexProfile);
else
  % File does not exist.
  msgbox 'The coating file does not exsist in the catalogue.'
end
clear AllCoating;
clear fileInfoCoating;

% if exist(FileName,'file')
%   % File exists.  Do stuff....
%   load(FileName,'AllCoating','fileInfoCoating');
%   set(handles.txtRepetetion,'String',AllCoating.RepetitionNumber);
%   set(handles.chkReverse,'Value',AllCoating.UseInReverse);
%   set(handles.tblRefractiveIndexProfile,'Data',AllCoating.refractiveIndexProfile);
% else
%   % File does not exist.
%   msgbox 'The file does not exsists'
% end

% --- Executes on button press in cmdNewCoating.
function cmdNewCoating_Callback(hObject, eventdata, handles)
% hObject    handle to cmdNewCoating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(coatingDefinition);
coatingDefinition;


% --- Executes on button press in cmdCancel.
function cmdCancel_Callback(hObject, eventdata, handles)
% hObject    handle to cmdCancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(coatingDefinition);
