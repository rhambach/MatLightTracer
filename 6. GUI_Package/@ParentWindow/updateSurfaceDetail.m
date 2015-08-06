function updateSurfaceDetail( parentWindow,selectedSurfaceIndex )
    %UPDATESURFACEORCOMPONENTDETAIL Displays the current selected surface
    %or component detail
    
    aodHandles = parentWindow.ParentHandles;    
    [ currentOpticalSystem,saved] = getCurrentOpticalSystem (parentWindow);
    
    selectedSurface = currentOpticalSystem.SurfaceArray(selectedSurfaceIndex);
    % Display surface parmeters
    [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'Basic');
    editColumn = repmat({' '},[size(paramNames,1),1]);
    surfaceParametersTableDisplay_Basic = [paramNames,paramValuesDisp,editColumn];
    set(aodHandles.tblSurfaceBasicParameters, ...
        'Data', surfaceParametersTableDisplay_Basic);
    
    [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'Aperture');
    editColumn = repmat({' '},[size(paramNames,1),1]);
    surfaceParametersTableDisplay_Aperture = [paramNames,paramValuesDisp,editColumn];
    set(aodHandles.tblSurfaceApertureParameters, ...
        'Data', surfaceParametersTableDisplay_Aperture);
    
    [ paramNames,paramTypes,paramValues,paramValuesDisp] = ...
        getSurfaceParameters(selectedSurface,'TiltDecenter');
    editColumn = repmat({' '},[size(paramNames,1),1]);
    surfaceParametersTableDisplay_TiltDecenter = [paramNames,paramValuesDisp,editColumn];
    set(aodHandles.tblSurfaceTiltDecenterParameters, ...
        'Data', surfaceParametersTableDisplay_TiltDecenter);
   parentWindow.ParentHandles =  aodHandles;
end

