function [ parentWindow ] = fromComponentEditorToSurfaceEditor( parentWindow )
%FROMCOMPONENTEDITORTOSURFACEEDITOR Generates surface parameters from
%component editor and put on the surface editor.
aodHandles = parentWindow.AODParentHandles;
componentArray = aodHandles.ComponentArray;
nComponent = size(componentArray,2);

totalSurfaceArray = [];
for tt = 1:nComponent
    totalSurfaceArray = [totalSurfaceArray,componentArray(tt).getSurfaceArray];
end


    nSurface = size(totalSurfaceArray,2);
    % initializ
    savedStandardData = cell(nSurface,14);
    savedApertureData = cell(nSurface,12);
    savedAsphericData = cell(nSurface,28);
    savedGratingData = cell(nSurface,6);
    savedTiltDecenterData = cell(nSurface,16);

    for k = 1:1:nSurface
        %standard data    
        if totalSurfaceArray(k).ObjectSurface|| k == 1
            savedStandardData{k,1} = 'OBJECT';

        elseif totalSurfaceArray(k).ImageSurface || k == nSurface
            savedStandardData{k,1} = 'IMAGE';

        elseif totalSurfaceArray(k).Stop 
            savedStandardData{k,1} = 'STOP';
            
        else 
            savedStandardData{k,1} = 'Surf';
        end    
        savedStandardData{k,2} = char(totalSurfaceArray(k).Comment);
        savedStandardData{k,3} = char(totalSurfaceArray(k).Type); 
        savedStandardData{k,4} = '';
        savedStandardData{k,5} = num2str(totalSurfaceArray(k).Radius);  
        savedStandardData{k,6} = '';
        savedStandardData{k,7} = num2str(totalSurfaceArray(k).Thickness);
        savedStandardData{k,8} = '';

        switch char(totalSurfaceArray(k).Glass.Name)
            case 'None'
                glassDisplayName = '';
            case 'FixedIndexGlass'
                glassDisplayName = ...
                [num2str(totalSurfaceArray(k).Glass.GlassParameters(1),'%.4f '),',',...
                 num2str(totalSurfaceArray(k).Glass.GlassParameters(2),'%.4f '),',',...
                 num2str(totalSurfaceArray(k).Glass.GlassParameters(3),'%.4f ')];
            otherwise
                glassDisplayName = upper(char(totalSurfaceArray(k).Glass.Name));
        end
        savedStandardData{k,9} = glassDisplayName;
        savedStandardData{k,10} = '';

        savedStandardData{k,11} = num2str(totalSurfaceArray(k).ClearAperture);
        savedStandardData{k,12} = '';
        savedStandardData{k,13} = upper(num2str(totalSurfaceArray(k).Coating.Name));  
        savedStandardData{k,14} = '';
        
        % aperture data
        savedApertureData{k,1} = savedStandardData{k,1};
        savedApertureData{k,2} = savedStandardData{k,3};
        savedApertureData{k,3} = char(totalSurfaceArray(k).ApertureType);
        savedApertureData{k,4} = '';
        savedApertureData{k,5} = num2str(totalSurfaceArray(k).ApertureParameter(1));
        savedApertureData{k,6} = '';
        savedApertureData{k,7} = num2str(totalSurfaceArray(k).ApertureParameter(2));
        savedApertureData{k,8} = '';
        savedApertureData{k,9} = num2str(totalSurfaceArray(k).ApertureParameter(3));
        savedApertureData{k,10} = '';
        savedApertureData{k,11} = num2str(totalSurfaceArray(k).ApertureParameter(4));
        savedApertureData{k,12} = '';

        %aspheric data
        savedAsphericData{k,1} = savedStandardData{k,1};
        savedAsphericData{k,2} = savedStandardData{k,3};
        savedAsphericData{k,3} = num2str(totalSurfaceArray(k).ConicConstant);
        savedAsphericData{k,4} = '';
        savedAsphericData{k,5} = num2str(totalSurfaceArray(k).PloynomialCoefficients(1));
        savedAsphericData{k,6} = '';
        savedAsphericData{k,7} = num2str(totalSurfaceArray(k).PloynomialCoefficients(2));
        savedAsphericData{k,8} = '';
        savedAsphericData{k,9} = num2str(totalSurfaceArray(k).PloynomialCoefficients(3));
        savedAsphericData{k,10} = '';
        savedAsphericData{k,11} = num2str(totalSurfaceArray(k).PloynomialCoefficients(4));
        savedAsphericData{k,12} = '';
        savedAsphericData{k,13} = num2str(totalSurfaceArray(k).PloynomialCoefficients(5));
        savedAsphericData{k,14} = '';
        savedAsphericData{k,15} = num2str(totalSurfaceArray(k).PloynomialCoefficients(6));
        savedAsphericData{k,16} = '';
        savedAsphericData{k,17} = num2str(totalSurfaceArray(k).PloynomialCoefficients(7));
        savedAsphericData{k,18} = '';
        savedAsphericData{k,19} = num2str(totalSurfaceArray(k).PloynomialCoefficients(8));
        savedAsphericData{k,20} = '';
        savedAsphericData{k,21} = num2str(totalSurfaceArray(k).PloynomialCoefficients(9));
        savedAsphericData{k,22} = '';
        savedAsphericData{k,23} = num2str(totalSurfaceArray(k).PloynomialCoefficients(10));
        savedAsphericData{k,24} = '';
        savedAsphericData{k,25} = num2str(totalSurfaceArray(k).PloynomialCoefficients(11));
        savedAsphericData{k,26} = '';
        savedAsphericData{k,27} = num2str(totalSurfaceArray(k).PloynomialCoefficients(12));
        savedAsphericData{k,28} = '';

        % grating data
        savedGratingData{k,1} = savedStandardData{k,1};
        savedGratingData{k,2} = savedStandardData{k,3};
        if isprop(totalSurfaceArray(k),'GratingLineDensity')
            savedGratingData{k,3} = num2str(totalSurfaceArray(k).GratingLineDensity);
        end
        savedGratingData{k,4} = '';
        if isprop(totalSurfaceArray(k),'DiffractionOrder')
            savedGratingData{k,5} = num2str(totalSurfaceArray(k).DiffractionOrder);
        end
        savedGratingData{k,6} = '';

        %tilt decenter data
        savedTiltDecenterData{k,1} = savedStandardData{k,1};
        savedTiltDecenterData{k,2} = savedStandardData{k,3};
        % Validate Data
        order = char(totalSurfaceArray(k).TiltDecenterOrder);
        if isValidGeneralInput(order,'TiltDecenterOrder')
            savedTiltDecenterData{k,3} = order;
        else
            % set default
            savedTiltDecenterData{k,3} = 'DxDyDzTxTyTz';
        end
        savedTiltDecenterData{k,4} = '';
        savedTiltDecenterData{k,5} = num2str(totalSurfaceArray(k).DecenterParameter(1));
        savedTiltDecenterData{k,6} = '';
        savedTiltDecenterData{k,7} = num2str(totalSurfaceArray(k).DecenterParameter(2));
        savedTiltDecenterData{k,8} = '';
        savedTiltDecenterData{k,9} = num2str(totalSurfaceArray(k).TiltParameter(1));
        savedTiltDecenterData{k,10} = '';
        savedTiltDecenterData{k,11} = num2str(totalSurfaceArray(k).TiltParameter(2));
        savedTiltDecenterData{k,12} = '';
        savedTiltDecenterData{k,13} = num2str(totalSurfaceArray(k).TiltParameter(3));
        savedTiltDecenterData{k,14} = '';
        savedTiltDecenterData{k,15} = char(totalSurfaceArray(k).TiltMode);
        savedTiltDecenterData{k,16} = '';

    end
    sysTable1 = aodHandles.tblStandardData;
    set(sysTable1, 'Data', savedStandardData);

    sysTable2 = aodHandles.tblApertureData;
    set(sysTable2, 'Data', savedApertureData);

    sysTable4 = aodHandles.tblAsphericData;
    set(sysTable4, 'Data', savedAsphericData);

    sysTable5 = aodHandles.tblTiltDecenterData;
    set(sysTable5, 'Data', savedTiltDecenterData);
    
    sysTable6 = aodHandles.tblGratingData;
    set(sysTable6, 'Data', savedGratingData);
    
    parentWindow.AODParentHandles = aodHandles;
end

