function [fieldNames,fieldFormat,initialData] = getOtherStandardDataFields( surface )
    %GETOTHERSTANDARDDATAFIELDS Returns the field names, formats, and initial
    %values of all standard data fields which are specific to this surface type
    
    surfaceType = surface.Type;
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'SSPB';
    [fieldNames,fieldFormat,initialData] = surfaceDefinitionHandle(returnFlag);
    
end

