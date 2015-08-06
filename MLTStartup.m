% Simply call the parent window class
function mainFigHandle = MLTStartup()


warning ('off','all');

% get current path and change current directory to this folder. Assumed
% that the startUp function will be in the toolbox folder where all other
% folders exist.
fullFileName = which([mfilename,'.m']);
[pathstr,name,ext] = fileparts(fullFileName);
if isdeployed
    % The toolbox is already in the matlab path while installed
else
    % add the toolbox folder with all subfolders to the matlab path
    addpath(genpath(pathstr));
end
cd (pathstr);

mainFigHandle = ParentWindow;
end
