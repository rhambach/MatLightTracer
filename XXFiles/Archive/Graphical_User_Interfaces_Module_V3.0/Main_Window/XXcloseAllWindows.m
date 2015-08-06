function [ closed ] = closeAllWindows()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Construct a questdlg with three options
choice = questdlg('Do you want to save changes to your optical system?', ...
	'Save Changes', ...
	'Yes','No','Cancel','Cancel');
% Handle response
switch choice
    case 'Yes'
        saveMySystem();
        delete(findobj('Tag','OpticalSystemConfiguration'));
        delete(findobj('Tag','SurfaceEditor'));
        delete(findobj('Tag','AOE_MainWindow'));
        delete(findobj('Tag','NewMainWindow'));
    case 'No'
        delete(findobj('Tag','OpticalSystemConfiguration'));
        delete(findobj('Tag','SurfaceEditor'));
        delete(findobj('Tag','AOE_MainWindow'));
        delete(findobj('Tag','NewMainWindow'));
    case 'Cancel'
end
closed = 1;
end

