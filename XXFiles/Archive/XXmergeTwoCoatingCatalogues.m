function [ merged ] = mergeTwoCoatingCatalogues...
    ( coatCatFullName1,coatCatFullName2,coatCatFullNameMerged )
%MERGETWOCOATINGCATALOGUES Merge two coating catalogues and save in a
% single file.

if isValidCoatingCatalogue( coatCatFullName1 ) && ...
        isValidCoatingCatalogue( coatCatFullName2 )
    %load the 1st coating catalogue file
    load(coatCatFullName1,'CoatingArray','FileInfoStruct');
    coatingArray1 = CoatingArray;
    clear CoatingArray;
    clear FileInfoStruct;
    %load the 2nd coating catalogue file
    load(coatCatFullName2,'CoatingArray','FileInfoStruct');
    coatingArray2 = CoatingArray;
    clear CoatingArray;
    clear FileInfoStruct;
    [ created ] = createNewCoatingCatalogue( coatCatFullNameMerged );
    for k1 = 2:length(coatingArray1)
        addCoatingToCoatingCatalogue( coatingArray1(k1),coatCatFullNameMerged )
    end
    for k2 = 2:length(coatingArray2)
        addCoatingToCoatingCatalogue( coatingArray2(k2),coatCatFullNameMerged )
    end
    merged = 1;
else
    merged = 0;
end
end

