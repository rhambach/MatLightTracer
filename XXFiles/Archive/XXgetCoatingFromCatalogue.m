     function coating = getCoatingFromCatalogue(name)
     % check that the coating does exsist in the catalogue
     coatingCataloguePath = which(aodCoatingCatalogue.mat);
     load(coatingCataloguePath,'AllCoating','FileInfoStruct');
     location = find(strcmpi({AllCoating.Name},name));
     if ~isempty(location)
       % File exists.  Do stuff....
         coating = AllCoating(location);
     else
       % File does not exist.
       msgbox 'The coating file does not exsist in the catalogue.'
       coating = [];
       return;
     end
     clear AllCoating;
     clear 'FileInfoStruct';
     end