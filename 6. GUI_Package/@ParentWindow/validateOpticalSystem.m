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
    %   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    aodHandles = parentWindow.ParentHandles;
    message = ('Valid system.');
    valid = 1;
    tempStandardData = get(aodHandles.tblStandardData,'data');
    objThickness = str2num(tempStandardData{1,7});
    
    tempAngle = get(aodHandles.radioAngle,'Value');
    tempObjectHeight = get(aodHandles.radioObjectHeight,'Value');
    tempImageHeight = get(aodHandles.radioImageHeight,'Value');
    
    tempSystemApertureType = get(aodHandles.popApertureType,'Value');
    tempSystemApertureValue = str2num(get(aodHandles.txtApertureValue,'String'));
    
    % check for validity of input
    % if object is at infinity, object NA is not defined and object height can
    % not be used for field
    if abs(objThickness) > 10^10
        if tempObjectHeight
            message = ('For objects at infinity, object height can not be used as field lease correct.');
            valid = 0;
        elseif tempSystemApertureType==2
            message = ('For objects at infinity, object space NA can not be used as system aperture. Please correct.');
            valid = 0;
        else
            
        end
    else
        
    end
    
    % check for existance of stop surface
    tempStandardData = get(aodHandles.tblStandardData,'data');
    sizeTblData = size(tempStandardData);
    nSurface = sizeTblData(1);
    stopIndex = 0;
    for k = 1:1:nSurface
        %standard data
        surface = tempStandardData(k,1);
        if isequaln(char(surface),'STOP')
            stopIndex = k;
        else
            
        end
    end
    if ~stopIndex
        % No stop defined
        message = ('No stop is defined for your system.');
        valid = 0;
    end
    
    
    % Check for existance and validity of catalogue files. Remove all
    % invalid catalogues from the catalogue list table
    
    % Coating Catalogue
    tableDataCoatingCat = get(aodHandles.tblCoatingCatalogues,'data');
    if ~isempty(tableDataCoatingCat)
        validCoatingCat = [];
        for cc = 1:size(tableDataCoatingCat,1)
            coatingCatName = tableDataCoatingCat{cc,3};
            if isValidObjectCatalogue('coating', coatingCatName)
                validCoatingCat = [validCoatingCat,cc];
            end
        end
        validTableDataCoatingCat = tableDataCoatingCat(validCoatingCat,:);
        set(aodHandles.tblCoatingCatalogues,'data',validTableDataCoatingCat);
        totalCoatingCatalogueSelected = sum([validTableDataCoatingCat{:,1}]);
        set(aodHandles.txtTotalCoatingCataloguesSelected, 'String',...
            totalCoatingCatalogueSelected);
    else
        message = 'Error: No Coating catalogue found. Valid optical system needs at least one Coating catalogue. So create a new Coating catalogue first.';
        valid = 0;
    end
    % Glass Catalogue
    tableDataGlassCat = get(aodHandles.tblGlassCatalogues,'data');
    if ~isempty(tableDataGlassCat)
        validGlassCat = [];
        for gg = 1:size(tableDataGlassCat,1)
            glassCatName = tableDataGlassCat{gg,3};
            if isValidObjectCatalogue('glass', glassCatName)
                validGlassCat = [validGlassCat,gg];
            end
        end
        validTableDataGlassCat = tableDataGlassCat(validGlassCat,:);
        set(aodHandles.tblGlassCatalogues,'data',validTableDataGlassCat);
        totalGlassCatalogueSelected = sum([validTableDataGlassCat{:,1}]);
        set(aodHandles.txtTotalGlassCataloguesSelected, 'String',...
            totalGlassCatalogueSelected);        
    else
         message = 'Error: No Glass catalogue found. Valid optical system needs at least one Glass catalogue. Create a new Glass catalogue first.';
         valid = 0;
    end
    validSystem = valid;
end

