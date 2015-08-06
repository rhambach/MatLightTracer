function InitializeSurfaceEditor()
 %Initialize the tables for standard data
columnName1 =   {'Surface', 'Name/Note', 'Surface Type', '', 'Radius', '', 'Thickness', '', 'Glass', '','Deviation Mode', '','Semi-Diameter', ''};
columnEditable1 =  [false true true false true false true false true false true false true false]; 
initialTable1 = {'OBJECT','','Plane','','Inf','','0','','','','','','','';...
                'STOP',  '','Plane','','Inf','','0','','','','+1 Refractive','','0','';...
                'IMAGE', '','Plane','','Inf','','0','','','','','','',''};
                     
sysTable1 = findobj('Tag','tblStandardData');
set(sysTable1 , 'ColumnFormat', {'char', 'char', {'Plane' 'Spherical' 'Conic Aspherical' 'Even Aspherical' 'Odd Aspherical'},'char',...
    'char', 'char','char', 'char', 'char', 'char', {'+1 Refractive' '-1 Reflective'}, 'char', 'char', 'char'});
set(sysTable1, 'Data', initialTable1,'ColumnEditable', columnEditable1,'ColumnName', columnName1);    


%Initialize the tables for aperture data
columnName2 =   {'Surface', 'Surface Type', 'Aperture Type', '', 'Aper Param1', '', 'Aper Param2', '', 'Aper Decent X', '', 'Aper Decent Y', ''};
columnEditable2 =  [false false true false true false true false true false true false ]; 
initialTable2 = {'OBJECT','Plane','Circular','','0','','0','','0','','0','';...
                 'STOP',  'Plane','Circular','','0','','0','','0','','0','';...
                 'IMAGE', 'Plane','Circular','','0','','0','','0','','0',''};
sysTable2 = findobj('Tag','tblApertureData');
set(sysTable2 , 'ColumnFormat', {'char', 'char', {'None' 'Circular' 'Rectangular' 'Elliptical'},'char', 'char', 'char','char', 'char', 'char', 'char', 'char', 'char'});
set(sysTable2, 'Data', initialTable2,'ColumnEditable', columnEditable2,'ColumnName', columnName2); 

%Initialize the tables for coating data
columnName3 =   {'Surface', 'Surface Type', 'Coating Type', '', 'Param1', '', 'Param2', '', 'Param3', '', 'Param4', ''};
columnEditable3 =  [false false true false true false true false true false true false]; 
initialTable3 = {'OBJECT','Plane','None','','0','','0','','0','','0','';...
                 'STOP',  'Plane','None','','0','','0','','0','','0','';...
                 'IMAGE', 'Plane','None','','0','','0','','0','','0',''};
sysTable3 = findobj('Tag','tblCoatingData');
set(sysTable3 , 'ColumnFormat', {'char', 'char', {'None' 'Jones Matrix' 'Multilayer Coating'},'char', 'char', 'char','char', 'char', 'char', 'char', 'char', 'char'});
set(sysTable3, 'Data', initialTable3,'ColumnEditable', columnEditable3,'ColumnName', columnName3); 

%Initialize the tables for aspheric data
columnName4 =   {'Surface', 'Surface Type', 'Conic', '', 'A1', '', 'A2', '', 'A3', ...
    '', 'A4', '', 'A5', '','A6', '','A7', '', 'A8', '', 'A9', '', 'A10', ...
    '', 'A11', '','A12', ''};
columnEditable4 =  [false false true false true false true false true ...
    false true false true false true false true false true false true false true...
    false true false true false]; 
initialTable4 = {'OBJECT','Plane','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','';...
                 'STOP',  'Plane','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','';...
                 'IMAGE', 'Plane','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0','','0',''};
sysTable4 = findobj('Tag','tblAsphericData');
set(sysTable4, 'Data', initialTable4,'ColumnEditable', columnEditable4,'ColumnName', columnName4); 

%Initialize the tables for tilt decenter data

% XXXX currently Tilt =>Successive rotation angle.Order Tilt Y->Tilt X -> Tilt Z
% XXXX only DAR tilt mode supported.

% Tilt and Decenter order = index of [dx,dy,tx,ty,tz]

columnName5 =   {'Surface', 'Surface Type', 'Order', '', 'Decenter X', '', 'Decenter Y', '', 'Tilt X', '',...
    'Tilt Y', '', 'Tilt Z', '', 'Tilt Mode', ''};
columnEditable5 =  [false false true false true false true false true false true false true false true false]; 
initialTable5 = {'OBJECT','Plane','DxDyDzTxTyTz','','0','','0','','0','','0','','0','','DAR','';...
                 'STOP',  'Plane','DxDyDzTxTyTz','','0','','0','','0','','0','','0','','DAR','';...
                 'IMAGE', 'Plane','DxDyDzTxTyTz','','0','','0','','0','','0','','0','','DAR',''};
sysTable5 = findobj('Tag','tblTiltDecenterData');
set(sysTable5 , 'ColumnFormat', {'char', 'char', 'char','char', 'char',...
     'char','char', 'char', 'char', 'char', 'char', 'char', 'char', 'char', {'DAR' 'NAX' 'BEN'},'char'});
set(sysTable5, 'Data', initialTable5,'ColumnEditable', columnEditable5,'ColumnName', columnName5); 
end

