function NewHarmonicFieldSet = HarmonicFieldSet(arrayOfHarmonicFields,refIndex)
    if nargin == 0
        arrayOfHarmonicFields =  HarmonicField();
        refIndex = 1;
    elseif nargin == 1
        if length(arrayOfHarmonicFields) > 1
            refIndex = floor(length(arrayOfHarmonicFields)/2);
        else
            refIndex = 1;
        end
    else
        
    end
    NewHarmonicFieldSet.ReferenceFieldIndex = refIndex;
    nFields = length(arrayOfHarmonicFields);
    
    
    % If each harmonic field has different center, make the center of all
    % fields components to be that of the reference field.
    centerRef = arrayOfHarmonicFields(refIndex).Center;
    newInterpolatedArrayOfField = arrayOfHarmonicFields;
    for ff = 1:nFields
        centerCurrent = arrayOfHarmonicFields(ff).Center;
        if (centerRef(1)~= centerCurrent(1))||(centerRef(2)~= centerCurrent(2))
            % Interpolate the field to coordinate centered at
            % centerRef
            newCx = centerRef(1);
            newCy = centerRef(2);
            interpMethod = 'cubic';
            [ interpolatedField ] = interpolateField(...
                arrayOfHarmonicFields(ff),interpMethod,newCx,newCy );
            
            newInterpolatedArrayOfField(ff) = interpolatedField;
        else
            newInterpolatedArrayOfField(ff) = arrayOfHarmonicFields(ff);
        end
    end
    NewHarmonicFieldSet.HarmonicFieldArray = newInterpolatedArrayOfField;
    NewHarmonicFieldSet.Center = centerRef;
    NewHarmonicFieldSet.ClassName = 'HarmonicFieldSet';
end


