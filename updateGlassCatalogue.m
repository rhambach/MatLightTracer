%% Chande glass catalogue from objetct to structure
clear
clc
load('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\MISC_AGF.mat');
ObjectArrayStruct(length(ObjectArray)) = struct(Glass);
for kk = 1:length(ObjectArray)
ObjectArrayStruct(kk) = struct(ObjectArray(kk));
ObjectArrayStruct(kk).ClassName = 'Glass';
end
ObjectArray = ObjectArrayStruct;
save('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\MISC_AGF2.mat','ObjectArray','FileInfoStruct')

clear
clc
load('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\SCHOTT_AGF.mat');
ObjectArrayStruct(length(ObjectArray)) = struct(Glass);
for kk = 1:length(ObjectArray)
ObjectArrayStruct(kk) = struct(ObjectArray(kk));
ObjectArrayStruct(kk).ClassName = 'Glass';
end
ObjectArray = ObjectArrayStruct;
save('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\SCHOTT_AGF2.mat','ObjectArray','FileInfoStruct')
