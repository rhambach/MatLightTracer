function [ validSystem,message ] = validateOpticalSystem(parentWindow)
    % validateOpticalSystem: Validates all input parameters of the optical system
    % Retuns invalid flag and displays the error on the command window if the inputs
    % of the system are not valid.
    % Member of ParentWindow class
    
    
    % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    aodHandles = parentWindow.ParentHandles;
    mm = 0;
    valid = 1;
    
    % Condition 1 & 2: If object is at infinity, object NA is not defined and
    % object height can not be used for field
    objThickness = aodHandles.OpticalSystem.SurfaceArray(1).Thickness;
    tempFieldType = aodHandles.OpticalSystem.FieldType;
    tempSystemApertureType = aodHandles.OpticalSystem.SystemApertureType;
    tempSystemApertureValue = aodHandles.OpticalSystem.SystemApertureValue;
    
    if abs(objThickness) > 10^10
        if tempFieldType == 1 %'ObjectHeight'
            mm = mm + 1;
            message{mm} = (['For objects at infinity, object height can not be',...
                ' used as field please correct. By default the object will',...
                ' be placed at finite distance']);
            aodHandles.OpticalSystem.SurfaceArray(1).Thickness = 10;
            valid(mm) = 0;
        end
        if tempSystemApertureType == 2% 'OBNA'
            mm = mm + 1;
            message{mm} = (['For objects at infinity, object space NA can not',...
                ' be used as system aperture. Please correct.By default the',...
                ' object will be placed at finite distance']);
            aodHandles.OpticalSystem.SurfaceArray(1).Thickness = 10;
            valid(mm) = 0;
        end
    else
        
    end
    
    % Condition 3: There should always be a stop surface
    [stopIndex, specified] = getStopSurfaceIndex(aodHandles.OpticalSystem);
    if ~specified
        % No stop defined
        mm = mm + 1;
        message{mm} = (['No stop is defined for your system. By default the ',...
            'first surface next to object will be assigned as stop.']);
        if IsSurfaceBased(aodHandles.OpticalSystem)
            aodHandles.OpticalSystem.SurfaceArray(2).IsStop = 1;
        else
            aodHandles.OpticalSystem.ComponentArray(2).StopSurfaceIndex = 1;
        end
        valid(mm) = 0;
    end
    
    
    % Condition 4: Is the system aperture is defined as float by stop then
    % the stop surface aperture can not be flaoting. Rather it should be
    % circular (fixed)
    tempSystemApertureType = aodHandles.OpticalSystem.SystemApertureType;
    [stopIndex, specified] = getStopSurfaceIndex(aodHandles.OpticalSystem);
    if tempSystemApertureType == 3 && ...
            strcmpi(aodHandles.OpticalSystem.SurfaceArray(stopIndex).Aperture.Type,...
            'FloatingCircularAperture')
        mm = mm + 1;
        message{mm} = (['When the system aperture is defined as float by stop, ',...
            'the stop surface aperture can not be flaoting. So the stop',...
            ' surface aperture is changed to Circular aperture']);
        oldAperture = aodHandles.OpticalSystem.SurfaceArray(stopIndex).Aperture;
        diam = oldAperture.UniqueParameters.Diameter;
        apertDecenter = oldAperture.Decenter;
        apertRotInDeg = oldAperture.Rotation;
        drawAbsolute = oldAperture.DrawAbsolute;
        outerShape = oldAperture.OuterShape;
        additionalEdge = oldAperture.AdditionalEdge;
        
        newCircularAperture = Aperture('CircularAperture');
        newCircularAperture.UniqueParameters.SmallDiameter = 0;
        newCircularAperture.UniqueParameters.LargeDiameter = diam;
        newCircularAperture.Decenter = apertDecenter;
        newCircularAperture.Rotation = apertRotInDeg;
        newCircularAperture.DrawAbsolute = drawAbsolute;
        newCircularAperture.OuterShape = outerShape;
        newCircularAperture.AdditionalEdge = additionalEdge;
        
        aodHandles.OpticalSystem.SurfaceArray(stopIndex).Aperture = newCircularAperture;
        valid(mm) = 0;
    end
    
    % Condition 5 - 8: Check for existance and validity of catalogue files. Remove all
    % invalid catalogues from the catalogue list table
    
    % Coating Catalogue
    coatingCatalogueList = aodHandles.OpticalSystem.CoatingCataloguesList;
    if ~isempty(coatingCatalogueList)
        invalidCoatingCat = [];
        for cc = 1:size(coatingCatalogueList,1)
            coatingCatFullName = coatingCatalogueList{cc};
            if ~isValidObjectCatalogue('coating', coatingCatFullName)
                invalidCoatingCat = [invalidCoatingCat,cc];
            end
        end
        if isempty(invalidCoatingCat)
            
        else
            mm = mm + 1;
            message{mm} = 'Error: Some Invalid Coating catalogue found. So they are just removed.';
            valid(mm) = 0;
            
            coatingCatalogueList{invalidCoatingCat} = [];
            aodHandles.OpticalSystem.CoatingCataloguesList = coatingCatalogueList;
        end
    else
        mm = mm + 1;
        message{mm} = 'Error: No Coating catalogue found. Valid optical system needs at least one Coating catalogue. So create a new Coating catalogue first.';
        valid(mm) = 0;
    end
    
    % Glass Catalogue
    glassCatalogueList = aodHandles.OpticalSystem.GlassCataloguesList;
    if ~isempty(glassCatalogueList)
        invalidGlassCat = [];
        for gg = 1:size(glassCatalogueList,1)
            glassCatFullName = glassCatalogueList{gg};
            if ~isValidObjectCatalogue('glass', glassCatFullName)
                invalidGlassCat = [invalidGlassCat,gg];
            end
        end
        if isempty(invalidCoatingCat)
            
        else
            mm = mm + 1;
            message{mm} = 'Error: Some Invalid Glass catalogue found. So they are just removed.';
            valid(mm) = 0;
            
            glassCatalogueList{invalidGlassCat} = [];
            aodHandles.OpticalSystem.GlassCataloguesList = glassCatalogueList;
        end
    else
        mm = mm + 1;
        message{mm} = 'Error: No Glass catalogue found. Valid optical system needs at least one Glass catalogue. Create a new Glass catalogue first.';
        valid(mm) = 0;
    end
    
    parentWindow.ParentHandles = aodHandles;
    if sum(valid) < mm
        validSystem = 0;
    else
        validSystem = 1;
        message = 'Success Valid System!!';
    end
end

