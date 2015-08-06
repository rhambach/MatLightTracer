function [ saved ] = saveMySystem()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

global OPTICAL_SYSTEM

if OPTICAL_SYSTEM.Saved
    SavedOpticalSystem = saveTheOpticalSystem ();
    PathName = OPTICAL_SYSTEM.PathName ;
    FileName = OPTICAL_SYSTEM.FileName;
    
    fileInfo = struct();
    fileInfo.Type = 'Optical System';
    fileInfo.Date = date;
    
    save([PathName '\' FileName], 'SavedOpticalSystem','fileInfo');
else
    SavedOpticalSystem = saveTheOpticalSystem ();
    [FileName,PathName] = uiputfile('New Optical System.mat','Save As');
    
    fileInfo = struct();
    fileInfo.Type = 'Optical System';
    fileInfo.Date = date;
    
    save([PathName '\' FileName], 'SavedOpticalSystem','fileInfo');
end
SavedOpticalSystem.Saved = true;
SavedOpticalSystem.PathName = PathName;
SavedOpticalSystem.FileName = FileName;
OPTICAL_SYSTEM = SavedOpticalSystem;

saved = 1;
end

