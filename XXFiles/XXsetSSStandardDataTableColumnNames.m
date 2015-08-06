function setSSStandardDataTableColumnNames (aodHandles,surfaceType)
% Initialize the panel and table for standard data
    surfDefinition = surfaceType;
    surfaceDefinitionHandle = str2func(surfDefinition);
    returnFlag = 1;
    [fieldNames,fieldFormat,initialData] = surfaceDefinitionHandle(returnFlag);
    nColumns = size(fieldNames,2);
    columnNames = fieldNames;
    columnWidth = num2cell(100*ones(1,nColumns));
    columnEditable = num2cell(ones(1,nColumns));
    columnFormat = fieldFormat;
    
    hGetSupportedSurfaces = str2func('GetSupportedSurfaces');
    supportedSurfaces = hGetSupportedSurfaces();
    
    
    columnName1 =   {'Surface', 'Name/Note', 'Surface Type', '',...
       'Thickness', '', 'Glass', '','Coating', '',columnNames{:}};
    columnWidth1 = {80, 100, 120, 15, 80, 15, 80, 15, 80, 15,columnWidth{:}};
    columnEditable1 =  [false true true false true false true false true ...
        false columnEditable{:}];
    set(aodHandles.tblSSStandardData, 'ColumnFormat', ...
        {'char', 'char',{supportedSurfaces{:}},'char','char', 'char','char', 'char',...
        'char', 'char', columnFormat{:}});
    set(aodHandles.tblSSStandardData,'ColumnEditable', logical(columnEditable1),...
        'ColumnName', columnName1,'ColumnWidth',columnWidth1);
    
end