function [ opened ] = openFromZemaxFile(zmxFullFileName,aodHandles)
%openFromZemaxFile: Imports and opens zmx files. 
% import zemax file
SavedOpticalSystem = importZemaxFile (zmxFullFileName);
opened = openSavedOpticalSystem(SavedOpticalSystem,aodHandles);
end
