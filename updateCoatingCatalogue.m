%% Chande glass catalogue from objetct to structure
clear
clc
load('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\New_Coating.mat');
ObjectArrayStruct(length(ObjectArray)) = struct(Coating);
for kk = 1:length(ObjectArray)
ObjectArrayStruct(kk) = struct(ObjectArray(kk));
ObjectArrayStruct(kk).ClassName = 'Coating';
end
ObjectArray = ObjectArrayStruct;
save('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\New_Coating2.mat','ObjectArray','FileInfoStruct')