function [ convertedName ] = ComponentNameConverter( givenName,conversionType )
%ComponentNameConverter converts the full name to disp name of the
%component or vice versa
if nargin == 0
    convertedName = NaN;
    return;
elseif nargin == 1
    conversionType = 1;
end
[ dispNames,fullNames ] = GetSupportedComponents();
if conversionType == 1
    % Display name to full name converter
    convertedName = fullNames{find(strcmpi(dispNames,givenName))};    
else
    % Full name to display name converter
    convertedName = fullNames{find(strcmpi(fullNames,givenName))}; 
end
end

