function [ fieldPoint, weight ] = getSystemFieldPoints( optSystem,index )
    %getSystemFieldPoints returns the system field points with corresponding
    %weight for given index. If index is not given or == 0, then all
    %field points in the field point matrix will be returned.
    if nargin < 2
        index = 0;
    end
    fieldPointMatrix = optSystem.FieldPointMatrix;
    
    if index == 0
        fieldPoint = fieldPointMatrix(:,1:2);
        weight = fieldPointMatrix(:,3);
    else
        fieldPoint = fieldPointMatrix(index,1:2);
        weight = fieldPointMatrix(index,3);
    end
    
end

