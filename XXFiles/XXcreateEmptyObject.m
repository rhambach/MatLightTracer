function newEmptyObject = createEmptyObject(objectType)
    %CREATEEMPTYOBJECT returns an empty object/struct odf a given type
    if strcmpi(objectType,'Coating')
        newEmptyObject = struct('Type',{},'Name',{},'UniqueParameters',{},'ClassName',{});
    elseif strcmpi(objectType,'Glass')
        newEmptyObject = struct('Type',{},'Name',{},'Parameters',{},'ClassName',{});
    else
        
    end
end

