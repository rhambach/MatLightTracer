function [ opened ] = openFromMATFile(parentWindow,fullFileName)
% openFromMATFile : Open an optical system from MAT file
% Member of ParentWindow class

    % Load the MAT file with variable SavedOpticalSystem which defines the
    % optical system object. 
    load(fullFileName);
    [pathstr,name,ext] = fileparts(fullFileName);
    pathName = pathstr;
    fileName = [name,ext];
%     SavedOpticalSystem.NumberOfSurfaces = size(SavedOpticalSystem.SurfaceArray,2);
    opened = openSavedOpticalSystem(parentWindow,SavedOpticalSystem,pathName, fileName);
end
