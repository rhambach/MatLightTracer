function [ SavedOpticalSystem saved ] = saveTheOpticalSystem (aodHandles)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

global INF_OBJ_Z;
global VIS_SURF_DATA;
global VIS_CONFIG_DATA;

button='Yes';
if ~validateOpticalSystem(aodHandles)
     button = questdlg('Invalid input detected. Do you want to continue saving?','Invalid Input');
end 

% hConfig = guidata(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA));
% hSurfaceData = guidata(SurfaceEditor('Visible',VIS_SURF_DATA));

hConfig = guidata(findobj('Tag','OpticalSystemConfiguration'));
hSurfaceData = guidata(findobj('Tag','SurfaceEditor'));

if strcmpi(button,'Yes')
    %System Configuration
    %aperture
    tempSystemApertureType=get(hConfig.popApertureType,'Value');
    tempSystemApertureValue=str2num(get(hConfig.txtApertureValue,'String'));

    %general
    tempLensName=get(hConfig.txtLensName,'String');
    tempLensNote=get(hConfig.txtLensNote,'String');
    tempLensUnit=get(hConfig.popLensUnit,'Value');
    tempWavelengthUnit=get(hConfig.popWavelengthUnit,'Value');

    % %polarization
    % tempPolarizedSystem  = get(findobj('Tag','chkPolarizedSystem'),'Value');
    % tempPolInputMethod   = get(findobj('Tag','popPolInputMethod'),'Value');
    % tempPolParam1        = str2num(get(findobj('Tag','txtPolParam1'),'String'));
    % tempPolParam2        = str2num(get(findobj('Tag','txtPolParam2'),'String'));
    % tempPolParam3        = str2num(get(findobj('Tag','txtPolParam3'),'String'));
    % tempPolParam4        = str2num(get(findobj('Tag','txtPolParam4'),'String'));

    %wavelength
    nWavelength          = str2num(get(hConfig.txtTotalWavelengthsSelected,'String'));
    tempPrimaryWavelengthIndex = get(hConfig.popPrimaryWavlenIndex,'Value');
    tempPredefinedWavlens      = get(hConfig.popPredefinedWavlens,'Value');
    tempWavelengthMatrix=[];
    for wlIndex = 1:1:nWavelength
        s1=strcat('txtWavlen', num2str(wlIndex));
        s2=strcat('txtWWav', num2str(wlIndex));

        tempWavelengthMatrix = [tempWavelengthMatrix;...
            str2double(get(findobj(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA),'Tag',s1),'String')),...
            str2double(get(findobj(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA),'Tag',s2),'String'))];
    end

    %fields
    nFieldPoint=str2num(get(hConfig.txtTotalFieldPointsSelected,'String'));
    tempAngle =get(hConfig.radioAngle,'Value');
    tempObjectHeight =get(hConfig.radioObjectHeight,'Value');
    tempImageHeight =get(hConfig.radioImageHeight,'Value');
    tempFieldPointMatrix=[];
    for fldIndex = 1:1:nFieldPoint

        s1=strcat('txtX', num2str(fldIndex));
        s2=strcat('txtY', num2str(fldIndex));
        s3=strcat('txtWFld', num2str(fldIndex));

        tempFieldPointMatrix = [tempFieldPointMatrix;...
            str2double(get(findobj(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA),'Tag',s1),'String')),...
            str2double(get(findobj(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA),'Tag',s2),'String')),...        
            str2double(get(findobj(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA),'Tag',s3),'String'))];
    end


    %Surface Data
    tempStandardData = get(hSurfaceData.tblStandardData,'data');
    tempAsphericData= get(hSurfaceData.tblAsphericData,'data');
    tempApertureData= get(hSurfaceData.tblApertureData,'data');
    tempCoatingData= get(hSurfaceData.tblCoatingData,'data');
    tempTiltDecenterData= get(hSurfaceData.tblTiltDecenterData,'data');

    sizeTblData = size(tempStandardData);
    nSurface = sizeTblData(1);

    % new optical system
    NewOpticalSystem = OpticalSystem;

    %Set optical systems properties
    NewOpticalSystem.NumberOfSurface = nSurface;
    %set aperture
    NewOpticalSystem.SystemApertureType=tempSystemApertureType;
    NewOpticalSystem.SystemApertureValue=tempSystemApertureValue;
    %set general
    NewOpticalSystem.LensName=tempLensName;
    NewOpticalSystem.LensNote=tempLensNote;
    NewOpticalSystem.WavelengthUnit=tempWavelengthUnit;
    NewOpticalSystem.LensUnit=tempLensUnit;
    
    NewOpticalSystem.Afocal = 0;
    % %set polarization
    % NewOpticalSystem.PolarizedSystem=tempPolarizedSystem;
    % NewOpticalSystem.PolarizationInputMethod=tempPolInputMethod;
    % NewOpticalSystem.PolarizationParameter=[tempPolParam1,tempPolParam2,tempPolParam3,tempPolParam4];

    %set wavelength
    NewOpticalSystem.NumberOfWavelengths=nWavelength;
    NewOpticalSystem.WavelengthMatrix=tempWavelengthMatrix;
    NewOpticalSystem.PrimaryWavelengthIndex=tempPrimaryWavelengthIndex;
    %set field
    NewOpticalSystem.FieldType=tempAngle*1+tempObjectHeight*2+tempImageHeight*3; %1 angle, 2 obj height, 3 image height
    NewOpticalSystem.NumberOfFieldPoints=nFieldPoint;
    NewOpticalSystem.FieldPointMatrix=tempFieldPointMatrix;

    %create empty surface array
    Surface.empty(nSurface,0);

    %Set optical system surfaces. 
    % Assume global ref is 1st surface of the lens  
    NewOpticalSystem.SurfaceArray(1).DecenterParameter = [0 0];
    NewOpticalSystem.SurfaceArray(1).TiltParameter = [0 0 0];

    %NewOpticalSystem.SurfaceArray(1).Position = [0,0,0];
    objLocation = -1*str2num(char(tempStandardData(1,7)));
    if abs(objLocation) > 10^10
        objLocation = -INF_OBJ_Z;
    end
    
    for k = 1:1:nSurface

        %standard data
        surface = tempStandardData(k,1);   
        if isequaln(char(surface),'OBJECT')
            NewOpticalSystem.SurfaceArray(k).ObjectSurface = 1;
        elseif isequaln(char(surface),'IMAGE')
            NewOpticalSystem.SurfaceArray(k).ImageSurface = 1;
        elseif isequaln(char(surface),'STOP')
            NewOpticalSystem.SurfaceArray(k).Stop = 1;
            NewOpticalSystem.StopIndex = k;
        else
            NewOpticalSystem.SurfaceArray(k).Stop = 0;
            NewOpticalSystem.SurfaceArray(k).ImageSurface = 0;
            NewOpticalSystem.SurfaceArray(k).ObjectSurface = 0;
        end   
        NewOpticalSystem.SurfaceArray(k).Comment       = char(tempStandardData(k,2));%text
        NewOpticalSystem.SurfaceArray(k).Type          = char(tempStandardData(k,3));%text
        NewOpticalSystem.SurfaceArray(k).Radius        = str2num(char(tempStandardData(k,5)));

        NewOpticalSystem.SurfaceArray(k).Thickness     = str2num(char(tempStandardData(k,7)));

        %get glass name and then SellmeierCoefficients from file
        glasName = strtrim(char(tempStandardData(k,9)));%text
        if strcmp(glasName,'')%An air space
                glasName = 'None';
                sellCoeff = [0 0 0 0 0 0];
                NewOpticalSystem.SurfaceArray(k).Glass         = Glass(glasName,sellCoeff);
        elseif ~isnan(str2double(glasName))%direcly specify refractive index
               sellCoeff = [str2double(glasName) 0 0 0 0 0];
                glasName = 'FixedIndexGlass';
                NewOpticalSystem.SurfaceArray(k).Glass         = Glass(glasName,sellCoeff);
        else %name of previously saved glass
            %look for the glass location in the catalogue 
            %load('f:\aoeGlassCatalogue.mat','AllGlass');
            load(which('aoeGlassCatalogue.mat'),'AllGlass');
            
            location = find(strcmpi({AllGlass.Name},glasName));
             if isempty(location)
                msgbox ([glasName,' : Undefined glass found in your system. So it is assumed as fixed index glass n=1.5']);
                glasName = 'FixedIndexGlass';
                sellCoeff = [1.5 0 0 0 0 0];
                NewOpticalSystem.SurfaceArray(k).Glass         = Glass(glasName,sellCoeff);
             else
                 NewOpticalSystem.SurfaceArray(k).Glass         = AllGlass(location(1));
             end
        end
        clear AllGlass

        NewOpticalSystem.SurfaceArray(k).DeviationMode = (char(tempStandardData(k,11)));
        NewOpticalSystem.SurfaceArray(k).SemiDiameter  = str2num(char(tempStandardData(k,13)));    


        %aperture data
        NewOpticalSystem.SurfaceArray(k).ApertureType      = char(tempApertureData(k,3));
        NewOpticalSystem.SurfaceArray(k).ApertureParameter = ...
            [str2num(char(tempApertureData(k,5))),str2num(char(tempApertureData(k,7))),...
            str2num(char(tempApertureData(k,9))),str2num(char(tempApertureData(k,11)))];

        %coating data
        coatType = char(tempCoatingData(k,3));
        switch coatType
            case 'None'
                coatName = 'None';
                TR =[NaN,NaN;NaN,NaN];
                Ts = TR(1);
                Tp = TR(2);
                Rs = TR(3);
                Rp = TR(4);
                permitivityProf = [NaN,NaN];
                rept = NaN;
                reverse = NaN;
                NewOpticalSystem.SurfaceArray(k).Coating = ...
        Coating(coatType,coatName,Ts,Tp,Rs,Rp,permitivityProf,rept,reverse);
            case 'Jones Matrix'
                coatName = 'Jones Matrix';
                TR =[str2num(char(tempCoatingData(k,5))),str2num(char(tempCoatingData(k,7))),...
                    str2num(char(tempCoatingData(k,9))),str2num(char(tempCoatingData(k,11)))];
                switch numel(TR)
                    case 0
                        Ts = 1;
                        Tp = 1;
                        Rs = 0;
                        Rp = 0;                        
                    case 1
                        Ts = TR(1);
                        Tp = 1;
                        Rs = 0;
                        Rp = 0;                         
                    case 2
                        Ts = TR(1);
                        Tp = TR(2);
                        Rs = 0;
                        Rp = 0;                         
                    case 3
                        Ts = TR(1);
                        Tp = TR(2);
                        Rs = TR(3);
                        Rp = 0;                         
                    case 4
                        Ts = TR(1);
                        Tp = TR(2);
                        Rs = TR(3);
                        Rp = TR(4);                         
                end

                permitivityProf = [NaN,NaN];
                rept = NaN;
                reverse = NaN;    
                NewOpticalSystem.SurfaceArray(k).Coating = ...
        Coating(coatType,coatName,Ts,Tp,Rs,Rp,permitivityProf,rept,reverse);
            case 'Multilayer Coating'
    %             coatName = char(tempCoatingData(k,5));
    %             FileName = strcat(coatName,'.mat');
                name = char(tempCoatingData(k,5));

                %check that the coating does exsist in the catalogue
                %load('f:\aoeCoatingCatalogue.mat','AllCoating','fileInfoCoating');
                load(which('aoeCoatingCatalogue.mat'),'AllCoating','fileInfoCoating');
                
                location = find(strcmpi({AllCoating.Name},name));
                if ~isempty(location(1))
                  % File exists.  Do stuff....
                  NewOpticalSystem.SurfaceArray(k).Coating = AllCoating(location(1));
                else
                  % File does not exist.
                  msgbox 'The coating file does not exsist in the catalogue.';
                end
                clear AllCoating;
                clear fileInfoCoating;
            end         

        %aspheric data
        NewOpticalSystem.SurfaceArray(k).ConicConstant          = str2num(char(tempAsphericData(k,3)));
        NewOpticalSystem.SurfaceArray(k).PloynomialCoefficients = ...
            [str2num(char(tempAsphericData(k,5))),str2num(char(tempAsphericData(k,7))),str2num(char(tempAsphericData(k,9))),...
            str2num(char(tempAsphericData(k,11))),str2num(char(tempAsphericData(k,13))),str2num(char(tempAsphericData(k,15))),...
            str2num(char(tempAsphericData(k,17))),str2num(char(tempAsphericData(k,19))),str2num(char(tempAsphericData(k,21))),...
            str2num(char(tempAsphericData(k,23))),str2num(char(tempAsphericData(k,25))),str2num(char(tempAsphericData(k,27)))];

        %tilt decenter data
        NewOpticalSystem.SurfaceArray(k).TiltDecenterOrder = char(tempTiltDecenterData(k,3));
        NewOpticalSystem.SurfaceArray(k).DecenterParameter = ...
            [str2num(char(tempTiltDecenterData(k,5))),str2num(char(tempTiltDecenterData(k,7)))];    
        NewOpticalSystem.SurfaceArray(k).TiltParameter     = ...
            [str2num(char(tempTiltDecenterData(k,9))),str2num(char(tempTiltDecenterData(k,11))),str2num(char(tempTiltDecenterData(k,13)))];
        NewOpticalSystem.SurfaceArray(k).TiltMode          = char(tempTiltDecenterData(k,15));

        %compute position from decenter and thickness
        %currently only DAR supported
        if k==1
            objThickness = abs(NewOpticalSystem.SurfaceArray(k).Thickness);
            if objThickness > 10^10 % Replace Inf with INF_OBJ_Z = 1 for graphing
                objThickness = INF_OBJ_Z;
            end
            % since global coord but shifted by objThickness
            refCoordinateTM = [1,0,0,0;0,1,0,0;0,0,1,-objThickness;0,0,0,1]; 
            
            surfaceCoordinateTM = refCoordinateTM;
            referenceCoordinateTM = refCoordinateTM;
            % set surface property
            NewOpticalSystem.SurfaceArray(k).SurfaceCoordinateTM = ...
                surfaceCoordinateTM;
            NewOpticalSystem.SurfaceArray(k).ReferenceCoordinateTM = ...
                referenceCoordinateTM;           
       else
            prevRefCoordinateTM = referenceCoordinateTM;
            prevSurfCoordinateTM = surfaceCoordinateTM;
            prevThickness = NewOpticalSystem.SurfaceArray(k-1).Thickness; 
            if prevThickness > 10^10 % Replace Inf with INF_OBJ_Z = 1 for object distance
                prevThickness = INF_OBJ_Z;
            end
            [surfaceCoordinateTM,referenceCoordinateTM] = NewOpticalSystem. ...
                    SurfaceArray(k).TiltAndDecenter(prevRefCoordinateTM,...
                    prevSurfCoordinateTM,prevThickness);
            % set surface property
            NewOpticalSystem.SurfaceArray(k).SurfaceCoordinateTM = surfaceCoordinateTM;
            NewOpticalSystem.SurfaceArray(k).ReferenceCoordinateTM = referenceCoordinateTM;
        
        end
        NewOpticalSystem.SurfaceArray(k).Position = (surfaceCoordinateTM (1:3,4))';  
    end
    
    SavedOpticalSystem = NewOpticalSystem;
    saved = 1;
else
    SavedOpticalSystem = [];
    saved = 0;
end
end

