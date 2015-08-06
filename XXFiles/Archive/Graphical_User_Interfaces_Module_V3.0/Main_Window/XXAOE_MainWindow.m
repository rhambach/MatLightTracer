function varargout = AOE_MainWindow(varargin)
% AOE_MAINWINDOW MATLAB code for AOE_MainWindow.fig
%      AOE_MAINWINDOW, by itself, creates a new AOE_MAINWINDOW or raises the existing
%      singleton*.
%
%      H = AOE_MAINWINDOW returns the handle to a new AOE_MAINWINDOW or the handle to
%      the existing singleton*.
%
%      AOE_MAINWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AOE_MAINWINDOW.M with the given input arguments.
%
%      AOE_MAINWINDOW('Property','Value',...) creates a new AOE_MAINWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AOE_MainWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AOE_MainWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AOE_MainWindow

% Last Modified by GUIDE v2.5 21-Feb-2014 04:35:11

% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
%   Written By: Worku, Norman Girma  
%   Advisor: Prof. Herbert Gross
%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
%	Optical System Design and Simulation Research Group
%   Institute of Applied Physics
%   Friedrich-Schiller-University of Jena   

% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
% Date----------Modified By ---------Modification Detail--------Remark
% Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0

% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AOE_MainWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @AOE_MainWindow_OutputFcn, ...
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
function AOE_MainWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AOE_MainWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes just before AOE_MainWindow is made visible.
function AOE_MainWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AOE_MainWindow (see VARARGIN)

% Choose default command line output for AOE_MainWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes AOE_MainWindow wait for user response (see UIRESUME)
% uiwait(handles.AOE_MainWindow);

% Make the mainwindow fullscreen
% set(hObject, 'units','normalized','outerposition',[0 0 1 1]);






% --- Outputs from this function are returned to the command line.
function varargout = AOE_MainWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%openNewOpticalSystem()

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
function menuRayTrace_Callback(hObject, eventdata, handles)
% hObject    handle to menuRayTrace (see GCBO)
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
function menuSingleRayTrace_Callback(hObject, eventdata, handles)
% hObject    handle to menuSingleRayTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SingleRayDataEntry

% --------------------------------------------------------------------
function menuSurfaceProperties_Callback(hObject, eventdata, handles)
% hObject    handle to menuSurfaceProperties (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VIS_SURF_DATA;
set(findobj('Tag','SurfaceEditor'),'Visible','On');
VIS_SURF_DATA = 'On';

% --------------------------------------------------------------------
function menuSystemConfiguration_Callback(hObject, eventdata, handles)
% hObject    handle to menuSystemConfiguration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VIS_CONFIG_DATA;
set(findobj('Tag','OpticalSystemConfiguration'),'Visible','On');
VIS_CONFIG_DATA = 'On';

% --------------------------------------------------------------------
function menuNew_Callback(hObject, eventdata, handles)
% hObject    handle to menuNew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

openNewOpticalSystem()
% InitializeSurfaceEditor();
% InitializeOpticalSystemConfiguration();


% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OPTICAL_SYSTEM
[FileName,PathName] = uigetfile('*.mat','Select Optical System file');
fullFileName = [PathName '\' FileName];
% openSavedOpticalSystem(FileName,PathName)
openSavedOpticalSystem(fullFileName);
OPTICAL_SYSTEM.Saved = true;
OPTICAL_SYSTEM.PathName = PathName;
OPTICAL_SYSTEM.FileName = FileName;

% --------------------------------------------------------------------
function menuSave_Callback(hObject, eventdata, handles)
% hObject    handle to menuSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveMySystem();




% --------------------------------------------------------------------
function menuSavaAs_Callback(hObject, eventdata, handles)
% hObject    handle to menuSavaAs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveMySystemAs();


% --------------------------------------------------------------------
function menuClose_Callback(hObject, eventdata, handles)
% hObject    handle to menuClose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closeAllWindows();

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


% --------------------------------------------------------------------
function menu2DSystemLayout_Callback(hObject, eventdata, handles)
% hObject    handle to menu2DSystemLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% opticalSystem = saveTheOpticalSystem();
% plot2DLayout( opticalSystem )
system2DLayoutDiagram
% --------------------------------------------------------------------
function menu3DSystemLayout_Callback(hObject, eventdata, handles)
% hObject    handle to menu3DSystemLayout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% opticalSystem = saveTheOpticalSystem();
% plot3DLayout( opticalSystem )
system3DLayoutDiagram

% --------------------------------------------------------------------
function menuUserManual_Callback(hObject, eventdata, handles)
% hObject    handle to menuUserManual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  web(['G:\MSc_Photonics_2st_Semster_Docs\OOP_version_of_Basic_Ray_Tracer'...
%      '\Ray_Tracer_Toolbox_3.0_(OOP_Version)_Final_Compilation\Optical_Ray_Trace_Analyzer_Toolbox\User_Manual'...
%      '\Build html documentation\UserManualVersion10.html'])
 web(which('UserManualVersion10.html'))
 
 
 % --------------------------------------------------------------------
function menuAbout_Callback(hObject, eventdata, handles)
% hObject    handle to menuAbout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
About;

% --------------------------------------------------------------------
function menuImport_Callback(hObject, eventdata, handles)
% hObject    handle to menuImport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuExport_Callback(hObject, eventdata, handles)
% hObject    handle to menuExport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes when user attempts to close AOE_MainWindow.
function AOE_MainWindow_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to AOE_MainWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
closeAllWindows();


% --------------------------------------------------------------------
function menuImportGlassCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportGlassCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Read from excel sheet downloaded from Schott website
[FileName,PathName] = uigetfile('*.xls','Select Glasss Catalogue File');
% 'G:\MSc Photonics 2st Semster Docs\OOP version of Basic Ray Tracer\...
% Ray Tracer Toolbox 2.1 (OOP Version)\DatabaseFiles\...
% schott_optical_glass_catalogue_excel_april_2013.xls';
fullFileName = [PathName,'\',FileName];
[ndata, text, alldata]  = xlsread(fullFileName,'A5:L200');
tableSize = size(alldata);

%open the catalogue file
prompt = {'Enter Catalogue Name:'};
dlg_title = 'New Catalogue';
num_lines = 1;
def = {strcat('aoe_',FileName)};
options.Resize='on';
options.WindowStyle='normal';
answer = cell2mat(inputdlg(prompt,dlg_title,num_lines,def,options));

glassCatalogueFullFileName = strcat('f:\',answer,'.mat');
createNewGlassCatalogue(glassCatalogueFullFileName);
%add each glass to the catalogue
for kk=1:tableSize(1)
    name = cell2mat(alldata(kk,1));
    if isnan(name)
        break;
    end
    selCoef = [cell2mat(alldata(kk,7)),cell2mat(alldata(kk,8)),cell2mat(alldata(kk,9)),...
        cell2mat(alldata(kk,10)),cell2mat(alldata(kk,11)),cell2mat(alldata(kk,12))];
    newGlass = Glass(num2str(name),selCoef);
    addGlassToGlassCatalogue( newGlass,glassCatalogueFullFileName );
end

% --------------------------------------------------------------------
function menuCoatingCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuCoatingCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuImportZMXFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportZMXFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.zmx','Select Zemax file');
openFromZemaxFile(FileName,PathName);


% --------------------------------------------------------------------
function menuMultipleRayTrace_Callback(hObject, eventdata, handles)
% hObject    handle to menuMultipleRayTrace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MultipleRayDataEntry;


% --------------------------------------------------------------------
function menuCoatingAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuCoatingAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuPermitivityProfile_Callback(hObject, eventdata, handles)
% hObject    handle to menuPermitivityProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingPermitivityProfile;

% --------------------------------------------------------------------
function menuRefractiveIndexProfile_Callback(hObject, eventdata, handles)
% hObject    handle to menuRefractiveIndexProfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingRefractiveIndexProfile;

% --------------------------------------------------------------------
function menuTransmissionVsAngle_Callback(hObject, eventdata, handles)
% hObject    handle to menuTransmissionVsAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingTransmissionVsAngle;


% --------------------------------------------------------------------
function menuReflectionVsAngle_Callback(hObject, eventdata, handles)
% hObject    handle to menuReflectionVsAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingReflectionVsAngle;

% --------------------------------------------------------------------
function menuDiattenuationVsAngle_Callback(hObject, eventdata, handles)
% hObject    handle to menuDiattenuationVsAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingDiattenuationVsAngle;

% --------------------------------------------------------------------
function menuRetardanceVsAngle_Callback(hObject, eventdata, handles)
% hObject    handle to menuRetardanceVsAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingRetardanceVsAngle;


% --------------------------------------------------------------------
function menuTransmissionVsWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to menuTransmissionVsWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingTransmissionVsWavelength;

% --------------------------------------------------------------------
function menuReflectionVsWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to menuReflectionVsWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingReflectionVsWavelength;


% --------------------------------------------------------------------
function menuDiattenuationVsWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to menuDiattenuationVsWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingDiattenuationVsWavelength;


% --------------------------------------------------------------------
function menRetardanceVsWavelength_Callback(hObject, eventdata, handles)
% hObject    handle to menRetardanceVsWavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
coatingRetardanceVsWavelength;


% --------------------------------------------------------------------
function menuOpticalSystem_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpticalSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuSpotDiagram_Callback(hObject, eventdata, handles)
% hObject    handle to menuSpotDiagram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
spotDiagram;

% --------------------------------------------------------------------
function menuPolarizationEllipseMap_Callback(hObject, eventdata, handles)
% hObject    handle to menuPolarizationEllipseMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
polarizationEllipseMap;

% --------------------------------------------------------------------
function menuParaxialAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuParaxialAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SavedOpticalSystem = saveTheOpticalSystem ();
SavedOpticalSystem.performParaxialAnalysis;

% --------------------------------------------------------------------
function menuPolarizationAbberation_Callback(hObject, eventdata, handles)
% hObject    handle to menuPolarizationAbberation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuAmplitudeTransmissionMap_Callback(hObject, eventdata, handles)
% hObject    handle to menuAmplitudeTransmissionMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
amplitudeTransmissionMap;

% --------------------------------------------------------------------
function menuPhaseMap_Callback(hObject, eventdata, handles)
% hObject    handle to menuPhaseMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
phaseMap;

% --------------------------------------------------------------------
function menuWavefrontDiattenuationMap_Callback(hObject, eventdata, handles)
% hObject    handle to menuWavefrontDiattenuationMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wavefrontDiattenuationMap;

% --------------------------------------------------------------------
function menuWavefrontRetardanceMap_Callback(hObject, eventdata, handles)
% hObject    handle to menuWavefrontRetardanceMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
wavefrontRetardanceMap;


% --------------------------------------------------------------------
function menuCoating_Callback(hObject, eventdata, handles)
% hObject    handle to menuCoating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuNewCoating_Callback(hObject, eventdata, handles)
% hObject    handle to menuNewCoating (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuImportOpticalSystem_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportOpticalSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuExportOpticalSystem_Callback(hObject, eventdata, handles)
% hObject    handle to menuExportOpticalSystem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuNewCoatingCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuNewCoatingCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuCoatingCatalogueAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuCoatingCatalogueAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuImportCoatingCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuImportCoatingCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuExportCoatingCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuExportCoatingCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuGlass_Callback(hObject, eventdata, handles)
% hObject    handle to menuGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuProgramminReference_Callback(hObject, eventdata, handles)
% hObject    handle to menuProgramminReference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% web(['G:\MSc_Photonics_2st_Semster_Docs\OOP_version_of_Basic_Ray_Tracer'...
%      '\Ray_Tracer_Toolbox_3.0_(OOP_Version)_Final_Compilation'...
%      '\doc\index.html'])
 web(which('index.html'))
% --------------------------------------------------------------------
function menuNewGlass_Callback(hObject, eventdata, handles)
% hObject    handle to menuNewGlass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuGlassAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuGlassAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuGlassCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuGlassCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuNewGlassCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuNewGlassCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuExportGlassCatalogue_Callback(hObject, eventdata, handles)
% hObject    handle to menuExportGlassCatalogue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuGlassCatalogueAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuGlassCatalogueAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuDispersionGraph_Callback(hObject, eventdata, handles)
% hObject    handle to menuDispersionGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuOpticalSystemAnalysis_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpticalSystemAnalysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuImageAtBfp_Callback(hObject, eventdata, handles)
% hObject    handle to menuImageAtBfp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% determine the back focal length of the optical system
SavedOpticalSystem = saveTheOpticalSystem ();
bfl = SavedOpticalSystem.getBackFocalLength;

% set the last thickness = bfl
tblData1 = get(findobj('Tag','tblStandardData'),'data');
imgSurfIndex = SavedOpticalSystem.NumberOfSurface;
tblData1{imgSurfIndex-1,7} = num2str(bfl);
set(findobj('Tag','tblStandardData'), 'Data', tblData1); 


% --- Executes when AOE_MainWindow is resized.
function AOE_MainWindow_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to AOE_MainWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
