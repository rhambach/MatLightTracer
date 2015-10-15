function [ fieldPointXYInSI, weight ] = getSystemFieldPoints( optSystem,indices )
    %getSystemFieldPoints returns the system field points with corresponding
    %weight for given index. If index is not given or == 0, then all
    %field points in the field point matrix will be returned.
    
    if nargin < 2
        indices = 0;
    end
    fieldPointMatrix = optSystem.FieldPointMatrix;
    
    if length(indices) == 1 && indices == 0
        fieldPointXY = (fieldPointMatrix(:,1:2))';
        weight = (fieldPointMatrix(:,3))';
    else
        fieldPointXY = (fieldPointMatrix(indices,1:2))';
        weight = (fieldPointMatrix(indices,3))';
    end
    
    switch lower(getSupportedFieldTypes(optSystem.FieldType))
        case lower('ObjectHeight')
            % Change to field points to meter
            fieldPointXYInSI = fieldPointXY*getLensUnitFactor(optSystem);
        case lower('Angle')
            % Field values are in degree so Do nothing.
            fieldPointXYInSI = fieldPointXY;
    end
    
end

