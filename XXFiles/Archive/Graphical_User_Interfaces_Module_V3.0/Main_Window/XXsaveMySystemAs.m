function [ saved ] = saveMySystemAs()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global OPTICAL_SYSTEM
OPTICAL_SYSTEM = OpticalSystem;
SavedOpticalSystem = saveTheOpticalSystem ();

[FileName,PathName] = uiputfile('New Optical System.mat','Save As');
SavedOpticalSystem.Saved = true;
SavedOpticalSystem.PathName = PathName;
SavedOpticalSystem.FileName = FileName;

fileInfo = struct();
fileInfo.Type = 'Optical System';
fileInfo.Date = date;

save([PathName '\' FileName], 'SavedOpticalSystem','fileInfo');

OPTICAL_SYSTEM = SavedOpticalSystem;
saved = 1;
end

