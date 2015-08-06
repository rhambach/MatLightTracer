function [ saved ] = saveToMATFile( optSystem,pathName,fileName )
    %saveToMATFile: Save the optical system to a MAT file
    fileInfo = struct();
    fileInfo.Type = 'Optical System';
    fileInfo.Date = date;
    SavedOpticalSystem = optSystem;
    save([pathName, fileName], 'SavedOpticalSystem','fileInfo');
    saved  =  1;
end

