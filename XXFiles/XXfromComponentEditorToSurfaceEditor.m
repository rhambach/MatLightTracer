function [ parentWindow ] = fromComponentEditorToSurfaceEditor( parentWindow )
%FROMCOMPONENTEDITORTOSURFACEEDITOR Generates surface parameters from
%component editor and put on the surface editor.
aodHandles = parentWindow.ParentHandles;
componentArray = aodHandles.ComponentArray;
nComponent = size(componentArray,2);

totalSurfaceArray = [];
for tt = 1:nComponent
    totalSurfaceArray = [totalSurfaceArray,componentArray(tt).getSurfaceArray];
end


    nSurface = size(totalSurfaceArray,2);
    % initializ
    savedStandardData = cell(nSurface,20);
    savedApertureData = cell(nSurface,15);
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
        savedStandardData{k,5} = (totalSurfaceArray(k).Thickness);  
        savedStandardData{k,6} = '';

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
        savedStandardData{k,7} = glassDisplayName;
        savedStandardData{k,8} = '';
        
        savedStandardData{k,9} = upper(num2str(totalSurfaceArray(k).Coating.Name));  
        savedStandardData{k,10} = '';

        % Other surface type specific standard data
        [fieldNames,fieldFormat,initialData] = totalSurfaceArray(k).getOtherStandardDataFields;
         try
                for ff = 1:10
                    savedStandardData{k,10 + ff} = (totalSurfaceArray(k).OtherStandardData.(fieldNames{ff}));
                end
         catch
                for ff = 1:10
                    savedStandardData{k,10 + ff} = initialData{ff};
                end
         end
        
        
        % aperture data
        savedApertureData{k,1} = savedStandardData{k,1};
        savedApertureData{k,2} = savedStandardData{k,3};
        savedApertureData{k,3} = char(totalSurfaceArray(k).ApertureType);
        savedApertureData{k,4} = '';
        savedApertureData{k,5} = (totalSurfaceArray(k).ApertureParameter(1));
        savedApertureData{k,6} = '';
        savedApertureData{k,7} = (totalSurfaceArray(k).ApertureParameter(2));
        savedApertureData{k,8} = '';
        savedApertureData{k,9} = (totalSurfaceArray(k).ApertureParameter(3));
        savedApertureData{k,10} = '';
        savedApertureData{k,11} = (totalSurfaceArray(k).ApertureParameter(4));
        savedApertureData{k,12} = '';
        
        savedApertureData{k,13} = (totalSurfaceArray(k).ClearAperture);
        savedApertureData{k,14} = (totalSurfaceArray(k).AdditionalEdge);
        savedApertureData{k,15} = logical(totalSurfaceArray(k).AbsoluteAperture);        

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
        savedTiltDecenterData{k,5} = (totalSurfaceArray(k).DecenterParameter(1));
        savedTiltDecenterData{k,6} = '';
        savedTiltDecenterData{k,7} = (totalSurfaceArray(k).DecenterParameter(2));
        savedTiltDecenterData{k,8} = '';
        savedTiltDecenterData{k,9} = (totalSurfaceArray(k).TiltParameter(1));
        savedTiltDecenterData{k,10} = '';
        savedTiltDecenterData{k,11} = (totalSurfaceArray(k).TiltParameter(2));
        savedTiltDecenterData{k,12} = '';
        savedTiltDecenterData{k,13} = (totalSurfaceArray(k).TiltParameter(3));
        savedTiltDecenterData{k,14} = '';
        savedTiltDecenterData{k,15} = char(totalSurfaceArray(k).TiltMode);
        savedTiltDecenterData{k,16} = '';

    end
    sysTable1 = aodHandles.tblStandardData;
    set(sysTable1, 'Data', savedStandardData);

    sysTable2 = aodHandles.tblApertureData;
    set(sysTable2, 'Data', savedApertureData);

    sysTable5 = aodHandles.tblTiltDecenterData;
    set(sysTable5, 'Data', savedTiltDecenterData);

    parentWindow.ParentHandles = aodHandles;
end

