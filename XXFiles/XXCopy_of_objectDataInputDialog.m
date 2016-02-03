function inputDialog = objectDataInputDialog(objectType)
%objectDataInputDialog: Defines a dilog box which is used to input object
% data based on its type. And returns an object constructed from the
% input data.

switch lower(objectType)
    case 'coating'
        coatingDataInputDialog;
    case 'galss'
        glassDataInputDialog;
end
inputDialog = 1;
end