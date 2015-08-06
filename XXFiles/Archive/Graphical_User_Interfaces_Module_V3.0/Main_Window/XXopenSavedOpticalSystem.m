% function [ opened ] = openSavedOpticalSystem(FileName,PathName)
function [ opened ] = openSavedOpticalSystem(fullFileName)

%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
global VIS_SURF_DATA;
global VIS_CONFIG_DATA;

% load([PathName '\' FileName]);
load(fullFileName);
% extract all data from the object SavedOpticalSystem object and load it to surface data
% editor.

%System configuration data
hConfig = guidata(OpticalSystemConfiguration('Visible','Off'));
VIS_CONFIG_DATA = 'Off';
%aperture
set(hConfig.popApertureType,'Value',SavedOpticalSystem.SystemApertureType);
set(hConfig.txtApertureValue,'String',SavedOpticalSystem.SystemApertureValue);

%general
set(hConfig.txtLensName,'String',SavedOpticalSystem.LensName);
set(hConfig.txtLensNote,'String',SavedOpticalSystem.LensNote);
set(hConfig.popLensUnit,'Value',SavedOpticalSystem.WavelengthUnit);
set(hConfig.popWavelengthUnit,'Value',SavedOpticalSystem.LensUnit);

% %polarization 
% set(findobj('Tag','chkPolarizedSystem'),'Value',SavedOpticalSystem.PolarizedSystem)
% 
% if SavedOpticalSystem.PolarizedSystem 
%     set(findobj('Tag','popPolInputMethod'),'Value',SavedOpticalSystem.PolarizationInputMethod)
%     set(findobj('Tag','txtPolParam1'),'String',SavedOpticalSystem.PolarizationParameter(1))
%     set(findobj('Tag','txtPolParam2'),'String',SavedOpticalSystem.PolarizationParameter(2))
%     set(findobj('Tag','txtPolParam3'),'String',SavedOpticalSystem.PolarizationParameter(3))
%     set(findobj('Tag','txtPolParam4'),'String',SavedOpticalSystem.PolarizationParameter(4))
% end 

%wavelength
set(hConfig.txtTotalWavelengthsSelected,'String',SavedOpticalSystem.NumberOfWavelengths)
set(hConfig.popPrimaryWavlenIndex,'Value',SavedOpticalSystem.PrimaryWavelengthIndex)
%set(findobj('Tag','popPredefinedWavlens'),'Value',SavedOpticalSystem.)

for wlIndex = 1:1:SavedOpticalSystem.NumberOfWavelengths
    s1=strcat('txtWavlen', num2str(wlIndex));
    s2=strcat('txtWWav', num2str(wlIndex));
    %s3=strcat('chkUseWav', num2str(wlIndex));
    set(findobj('Tag','chkUseWav','-and','String',wlIndex),'Value',1,'Enable','on');
    set(findobj('Tag',s1),'String',SavedOpticalSystem.WavelengthMatrix(wlIndex,1),'Enable','on');
    set(findobj('Tag',s2),'String',SavedOpticalSystem.WavelengthMatrix(wlIndex,2),'Enable','on');
end
%s4=strcat('chkUseWav', num2str(wlIndex+1));
set(findobj('Tag','chkUseWav','-and','String',wlIndex+1),'Value',0,'Enable','on');

%field
set(hConfig.txtTotalFieldPointsSelected,'String',SavedOpticalSystem.NumberOfFieldPoints);
set(hConfig.radioAngle,'Value',(SavedOpticalSystem.FieldType == 1));
set(hConfig.radioObjectHeight,'Value',(SavedOpticalSystem.FieldType == 2));
set(hConfig.radioImageHeight,'Value',(SavedOpticalSystem.FieldType == 3));


for fldIndex = 1:1:SavedOpticalSystem.NumberOfFieldPoints
    s1=strcat('txtX', num2str(fldIndex));
    s2=strcat('txtY', num2str(fldIndex));
    s3=strcat('txtWFld', num2str(fldIndex));
    %s4=strcat('chkUseFld', num2str(fldIndex));
    
    %set(findobj('Tag',s4),'Value',1,'Enable','on');
    set(findobj('Tag','chkUseFld','-and','String',fldIndex),'Value',1,'Enable','on');
    set(findobj('Tag',s1),'String',SavedOpticalSystem.FieldPointMatrix(fldIndex,1),'Enable','on');
    set(findobj('Tag',s2),'String',SavedOpticalSystem.FieldPointMatrix(fldIndex,2),'Enable','on');
    set(findobj('Tag',s3),'String',SavedOpticalSystem.FieldPointMatrix(fldIndex,3),'Enable','on');
end
%s5=strcat('chkUseFld', num2str(fldIndex+1));
set(findobj('Tag','chkUseFld','-and','String',fldIndex+1),'Value',0,'Enable','on');




%surface data
hSurfaceData = guidata(SurfaceEditor('Visible','On'));
VIS_SURF_DATA = 'On';
nSurface = SavedOpticalSystem.NumberOfSurface;
% savedTable = zeros(nSurface,15);
for k = 1:1:nSurface

    %standard data    
    if SavedOpticalSystem.SurfaceArray(k).ObjectSurface
        savedStandardData{k,1} = 'OBJECT';
    
    elseif SavedOpticalSystem.SurfaceArray(k).ImageSurface
        savedStandardData{k,1} = 'IMAGE';
    
    elseif SavedOpticalSystem.SurfaceArray(k).Stop 
        savedStandardData{k,1} = 'STOP';
    
    else 
        savedStandardData{k,1} = 'Surf';
    end    
    savedStandardData{k,2} = char(SavedOpticalSystem.SurfaceArray(k).Comment);
    savedStandardData{k,3} = char(SavedOpticalSystem.SurfaceArray(k).Type); 
    savedStandardData{k,4} = '';
    savedStandardData{k,5} = num2str(SavedOpticalSystem.SurfaceArray(k).Radius);  
    savedStandardData{k,6} = '';
    savedStandardData{k,7} = num2str(SavedOpticalSystem.SurfaceArray(k).Thickness);
    savedStandardData{k,8} = '';
    
    switch char(SavedOpticalSystem.SurfaceArray(k).Glass.Name)
        case 'None'
            glassDisplayName = '';
        case 'FixedIndexGlass'
            glassDisplayName = num2str(SavedOpticalSystem.SurfaceArray(k).Glass.SellmeierCoefficients(1));
        otherwise
            glassDisplayName = char(SavedOpticalSystem.SurfaceArray(k).Glass.Name);
    end
    savedStandardData{k,9} = glassDisplayName;
    savedStandardData{k,10} = '';
    
    savedStandardData{k,11} = char(SavedOpticalSystem.SurfaceArray(k).DeviationMode);
    savedStandardData{k,12} = '';
    savedStandardData{k,13} = num2str(SavedOpticalSystem.SurfaceArray(k).SemiDiameter);  
    savedStandardData{k,14} = '';
    
    %aperture data
    savedApertureData{k,1} = savedStandardData{k,1};
    savedApertureData{k,2} = savedStandardData{k,3};
    savedApertureData{k,3} = char(SavedOpticalSystem.SurfaceArray(k).ApertureType);
    savedApertureData{k,4} = '';
    savedApertureData{k,5} = num2str(SavedOpticalSystem.SurfaceArray(k).ApertureParameter(1));
    savedApertureData{k,6} = '';
    savedApertureData{k,7} = num2str(SavedOpticalSystem.SurfaceArray(k).ApertureParameter(2));
    savedApertureData{k,8} = '';
    savedApertureData{k,9} = num2str(SavedOpticalSystem.SurfaceArray(k).ApertureParameter(3));
    savedApertureData{k,10} = '';
    savedApertureData{k,11} = num2str(SavedOpticalSystem.SurfaceArray(k).ApertureParameter(4));
    savedApertureData{k,12} = '';
    
     %coating data
    savedCoatingData{k,1} = savedStandardData{k,1};
    savedCoatingData{k,2} = savedStandardData{k,3};
   
    savedCoatingData{k,3} = (SavedOpticalSystem.SurfaceArray(k).Coating.Type);
    savedCoatingData{k,4} = '';
    
    coatType = char(SavedOpticalSystem.SurfaceArray(k).Coating.Type);
    switch coatType
        case 'None'
            savedCoatingData{k,5} = '';
            savedCoatingData{k,6} = '';
            savedCoatingData{k,7} = '';
            savedCoatingData{k,8} = '';
            savedCoatingData{k,9} = '';
            savedCoatingData{k,10} = '';
            savedCoatingData{k,11} = ''; 
            savedCoatingData{k,12} = '';
        case 'Jones Matrix'
            savedCoatingData{k,5} = num2str(SavedOpticalSystem.SurfaceArray(k).Coating.FixedTs);
            savedCoatingData{k,6} = '';
            savedCoatingData{k,7} = num2str(SavedOpticalSystem.SurfaceArray(k).Coating.FixedTp);
            savedCoatingData{k,8} = '';
            savedCoatingData{k,9} = num2str(SavedOpticalSystem.SurfaceArray(k).Coating.FixedRs);
            savedCoatingData{k,10} = '';
            savedCoatingData{k,11} = num2str(SavedOpticalSystem.SurfaceArray(k).Coating.FixedRp); 
            savedCoatingData{k,12} = '';         
        case 'Multilayer Coating'
            savedCoatingData{k,5} = SavedOpticalSystem.SurfaceArray(k).Coating.Name;
            savedCoatingData{k,6} = '';
            savedCoatingData{k,7} = '';
            savedCoatingData{k,8} = '';
            savedCoatingData{k,9} = '';
            savedCoatingData{k,10} = '';
            savedCoatingData{k,11} = '';
            savedCoatingData{k,12} = '';        
    end

    
    %aspheric data
    savedAsphericData{k,1} = savedStandardData{k,1};
    savedAsphericData{k,2} = savedStandardData{k,3};
    savedAsphericData{k,3} = num2str(SavedOpticalSystem.SurfaceArray(k).ConicConstant);
    savedAsphericData{k,4} = '';
    savedAsphericData{k,5} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(1));
    savedAsphericData{k,6} = '';
    savedAsphericData{k,7} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(2));
    savedAsphericData{k,8} = '';
    savedAsphericData{k,9} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(3));
    savedAsphericData{k,10} = '';
    savedAsphericData{k,11} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(4));
    savedAsphericData{k,12} = '';
    savedAsphericData{k,13} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(5));
    savedAsphericData{k,14} = '';
    savedAsphericData{k,15} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(6));
    savedAsphericData{k,16} = '';
    savedAsphericData{k,17} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(7));
    savedAsphericData{k,18} = '';
    savedAsphericData{k,19} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(8));
    savedAsphericData{k,20} = '';
    savedAsphericData{k,21} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(9));
    savedAsphericData{k,22} = '';
    savedAsphericData{k,23} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(10));
    savedAsphericData{k,24} = '';
    savedAsphericData{k,25} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(11));
    savedAsphericData{k,26} = '';
    savedAsphericData{k,27} = num2str(SavedOpticalSystem.SurfaceArray(k).PloynomialCoefficients(12));
    savedAsphericData{k,28} = '';
    
    
    %tilt decenter data
    savedTiltDecenterData{k,1} = savedStandardData{k,1};
    savedTiltDecenterData{k,2} = savedStandardData{k,3};
    % Validate Data
    order = char(SavedOpticalSystem.SurfaceArray(k).TiltDecenterOrder);
    if validateInput(order,'TiltDecenterOrder')
        savedTiltDecenterData{k,3} = order;
    else
        % set default
        savedTiltDecenterData{k,3} = 'DxDyDzTxTyTz';
    end
%     savedTiltDecenterData{k,3} = char(SavedOpticalSystem.SurfaceArray(k).TiltDecenterOrder);
    savedTiltDecenterData{k,4} = '';
    savedTiltDecenterData{k,5} = num2str(SavedOpticalSystem.SurfaceArray(k).DecenterParameter(1));
    savedTiltDecenterData{k,6} = '';
    savedTiltDecenterData{k,7} = num2str(SavedOpticalSystem.SurfaceArray(k).DecenterParameter(2));
    savedTiltDecenterData{k,8} = '';
    savedTiltDecenterData{k,9} = num2str(SavedOpticalSystem.SurfaceArray(k).TiltParameter(1));
    savedTiltDecenterData{k,10} = '';
    savedTiltDecenterData{k,11} = num2str(SavedOpticalSystem.SurfaceArray(k).TiltParameter(2));
    savedTiltDecenterData{k,12} = '';
    savedTiltDecenterData{k,13} = num2str(SavedOpticalSystem.SurfaceArray(k).TiltParameter(3));
    savedTiltDecenterData{k,14} = '';
    savedTiltDecenterData{k,15} = char(SavedOpticalSystem.SurfaceArray(k).TiltMode);
    savedTiltDecenterData{k,16} = '';
    
end
sysTable1 = hSurfaceData.tblStandardData;
set(sysTable1, 'Data', savedStandardData);

sysTable2 = hSurfaceData.tblApertureData;
set(sysTable2, 'Data', savedApertureData);

sysTable3 = hSurfaceData.tblCoatingData;
set(sysTable3, 'Data', savedCoatingData);

sysTable4 = hSurfaceData.tblAsphericData;
set(sysTable4, 'Data', savedAsphericData);

sysTable5 = hSurfaceData.tblTiltDecenterData;
set(sysTable5, 'Data', savedTiltDecenterData);
opened = 1;
end

