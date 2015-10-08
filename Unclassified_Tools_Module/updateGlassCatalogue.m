% %% Chande glass catalogue from objetct to structure
% clear
% clc
% load('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\MISC_AGF.mat');
% ObjectArrayStruct(length(ObjectArray)) = struct(Glass);
% for kk = 1:length(ObjectArray)
% ObjectArrayStruct(kk) = struct(ObjectArray(kk));
% ObjectArrayStruct(kk).ClassName = 'Glass';
% end
% ObjectArray = ObjectArrayStruct;
% save('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\MISC_AGF2.mat','ObjectArray','FileInfoStruct')
%
% clear
% clc
% load('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\SCHOTT_AGF.mat');
% ObjectArrayStruct(length(ObjectArray)) = struct(Glass);
% for kk = 1:length(ObjectArray)
% ObjectArrayStruct(kk) = struct(ObjectArray(kk));
% ObjectArrayStruct(kk).ClassName = 'Glass';
% end
% ObjectArray = ObjectArrayStruct;
% save('X:\MatLightTracer_June_26_2015_Working_Version\Catalogue_Files\SCHOTT_AGF2.mat','ObjectArray','FileInfoStruct')

% %% Chande glass catalogue .Parameters to .UniqueParameters
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\MISC_AGF.mat');
% NewObjectArray(length(ObjectArray)) = Glass();
% for kk = 1:length(ObjectArray)
%         NewObjectArray(kk).Name = ObjectArray(kk).Name;
%         NewObjectArray(kk).Type = ObjectArray(kk).Type;
%         NewObjectArray(kk).UniqueParameters = ObjectArray(kk).Parameters;
%         NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
%         NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
%         NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
%         NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
%         NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
%         NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
%         NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\MISC_AGF2.mat','ObjectArray','FileInfoStruct')
%
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\SCHOTT_AGF.mat');
% NewObjectArray(length(ObjectArray)) = Glass();
% for kk = 1:length(ObjectArray)
%         NewObjectArray(kk).Name = ObjectArray(kk).Name;
%         NewObjectArray(kk).Type = ObjectArray(kk).Type;
%         NewObjectArray(kk).UniqueParameters = ObjectArray(kk).Parameters;
%         NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
%         NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
%         NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
%         NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
%         NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
%         NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
%         NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\SCHOTT_AGF2.mat','ObjectArray','FileInfoStruct')
%
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\GlassCat01.mat');
% NewObjectArray(length(ObjectArray)) = Glass();
% for kk = 1:length(ObjectArray)
%         NewObjectArray(kk).Name = ObjectArray(kk).Name;
%         NewObjectArray(kk).Type = ObjectArray(kk).Type;
%         NewObjectArray(kk).UniqueParameters = ObjectArray(kk).Parameters;
%         NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
%         NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
%         NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
%         NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
%         NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
%         NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
%         NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\GlassCat02.mat','ObjectArray','FileInfoStruct')
%
%
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\INFRARED_AGF.mat');
% NewObjectArray(length(ObjectArray)) = Glass();
% for kk = 1:length(ObjectArray)
%         NewObjectArray(kk).Name = ObjectArray(kk).Name;
%         NewObjectArray(kk).Type = ObjectArray(kk).Type;
%         NewObjectArray(kk).UniqueParameters = ObjectArray(kk).Parameters;
%         NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
%         NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
%         NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
%         NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
%         NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
%         NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
%         NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\INFRARED_AGF2.mat','ObjectArray','FileInfoStruct')

% %% Chande glass catalogue .Parameters to .UniqueParameters
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\MISC_AGF.mat');
% NewObjectArray = ObjectArray;
% zemaxFormulaList = {'Schott','Sellmeier1','Sellmeier2',...
%                 'Sellmeier3','Sellmeier4','Sellmeier5','Herzberger',...
%                 'Conrady','HandbookOfOptics1','HandbookOfOptics2',...
%                 'Extended', 'Extended2', 'Extended3'};
% for kk = 1:length(ObjectArray)
%     if strcmpi(NewObjectArray(kk).Type,'ZemaxFormula')
%         formulaName = NewObjectArray(kk).UniqueParameters.FormulaType;
%         [a,formulaIndex] = ismember(formulaName,zemaxFormulaList);
%         if formulaIndex
%         NewObjectArray(kk).UniqueParameters.FormulaType = formulaIndex;
%         end
%     end
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\MISC_AGF2.mat','ObjectArray','FileInfoStruct')
%
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\SCHOTT_AGF.mat');
% NewObjectArray = ObjectArray;
% zemaxFormulaList = {'Schott','Sellmeier1','Sellmeier2',...
%                 'Sellmeier3','Sellmeier4','Sellmeier5','Herzberger',...
%                 'Conrady','HandbookOfOptics1','HandbookOfOptics2',...
%                 'Extended', 'Extended2', 'Extended3'};
% for kk = 1:length(ObjectArray)
%     if strcmpi(NewObjectArray(kk).Type,'ZemaxFormula')
%         formulaName = NewObjectArray(kk).UniqueParameters.FormulaType;
%         [a,formulaIndex] = ismember(formulaName,zemaxFormulaList);
%         if formulaIndex
%         NewObjectArray(kk).UniqueParameters.FormulaType = formulaIndex;
%         end
%     end
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\SCHOTT_AGF2.mat','ObjectArray','FileInfoStruct')
%
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\GlassCat01.mat');
% NewObjectArray = ObjectArray;
% zemaxFormulaList = {'Schott','Sellmeier1','Sellmeier2',...
%                 'Sellmeier3','Sellmeier4','Sellmeier5','Herzberger',...
%                 'Conrady','HandbookOfOptics1','HandbookOfOptics2',...
%                 'Extended', 'Extended2', 'Extended3'};
% for kk = 1:length(ObjectArray)
%     if strcmpi(NewObjectArray(kk).Type,'ZemaxFormula')
%         formulaName = NewObjectArray(kk).UniqueParameters.FormulaType;
%         [a,formulaIndex] = ismember(formulaName,zemaxFormulaList);
%         if formulaIndex
%         NewObjectArray(kk).UniqueParameters.FormulaType = formulaIndex;
%         end
%     end
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\GlassCat02.mat','ObjectArray','FileInfoStruct')
%
%
% clear
% clc
% load('D:\MatLightTracer_GitHub\Catalogue_Files\INFRARED_AGF.mat');
% NewObjectArray = ObjectArray;
% zemaxFormulaList = {'Schott','Sellmeier1','Sellmeier2',...
%                 'Sellmeier3','Sellmeier4','Sellmeier5','Herzberger',...
%                 'Conrady','HandbookOfOptics1','HandbookOfOptics2',...
%                 'Extended', 'Extended2', 'Extended3'};
% for kk = 1:length(ObjectArray)
%     if strcmpi(NewObjectArray(kk).Type,'ZemaxFormula')
%         formulaName = NewObjectArray(kk).UniqueParameters.FormulaType;
%         [a,formulaIndex] = ismember(formulaName,zemaxFormulaList);
%         if formulaIndex
%         NewObjectArray(kk).UniqueParameters.FormulaType = formulaIndex;
%         end
%     end
% end
% ObjectArray = NewObjectArray;
% save('D:\MatLightTracer_GitHub\Catalogue_Files\INFRARED_AGF2.mat','ObjectArray','FileInfoStruct')

%% Add .SavedIndex property to all glasses
clear
clc
load('D:\MatLightTracer_GitHub\Catalogue_Files\MISC_AGF.mat');
NewObjectArray(length(ObjectArray)) = Glass();
for kk = 1:length(ObjectArray)
    NewObjectArray(kk).Name = ObjectArray(kk).Name;
    NewObjectArray(kk).Type = ObjectArray(kk).Type;
    NewObjectArray(kk).UniqueParameters = ObjectArray(kk).UniqueParameters;
    NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
    NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
    NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
    NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
    NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
    NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
    NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
    NewObjectArray(kk).SavedIndex = kk;
end
ObjectArray = NewObjectArray;
save('D:\MatLightTracer_GitHub\Catalogue_Files\MISC_AGF2.mat','ObjectArray','FileInfoStruct')

clear
clc
load('D:\MatLightTracer_GitHub\Catalogue_Files\SCHOTT_AGF.mat');
NewObjectArray(length(ObjectArray)) = Glass();
for kk = 1:length(ObjectArray)
    NewObjectArray(kk).Name = ObjectArray(kk).Name;
    NewObjectArray(kk).Type = ObjectArray(kk).Type;
    NewObjectArray(kk).UniqueParameters = ObjectArray(kk).UniqueParameters;
    NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
    NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
    NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
    NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
    NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
    NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
    NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
    NewObjectArray(kk).SavedIndex = kk;
end
ObjectArray = NewObjectArray;
save('D:\MatLightTracer_GitHub\Catalogue_Files\SCHOTT_AGF2.mat','ObjectArray','FileInfoStruct')

clear
clc
load('D:\MatLightTracer_GitHub\Catalogue_Files\GlassCat01.mat');
NewObjectArray(length(ObjectArray)) = Glass();
for kk = 1:length(ObjectArray)
    NewObjectArray(kk).Name = ObjectArray(kk).Name;
    NewObjectArray(kk).Type = ObjectArray(kk).Type;
    NewObjectArray(kk).UniqueParameters = ObjectArray(kk).UniqueParameters;
    NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
    NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
    NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
    NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
    NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
    NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
    NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
    NewObjectArray(kk).SavedIndex = kk;
end
ObjectArray = NewObjectArray;
save('D:\MatLightTracer_GitHub\Catalogue_Files\GlassCat02.mat','ObjectArray','FileInfoStruct')


clear
clc
load('D:\MatLightTracer_GitHub\Catalogue_Files\INFRARED_AGF.mat');
NewObjectArray(length(ObjectArray)) = Glass();
for kk = 1:length(ObjectArray)
    NewObjectArray(kk).Name = ObjectArray(kk).Name;
    NewObjectArray(kk).Type = ObjectArray(kk).Type;
    NewObjectArray(kk).UniqueParameters = ObjectArray(kk).UniqueParameters;
    NewObjectArray(kk).InternalTransmittance = ObjectArray(kk).InternalTransmittance;
    NewObjectArray(kk).ResistanceData = ObjectArray(kk).ResistanceData;
    NewObjectArray(kk).ThermalData = ObjectArray(kk).ThermalData;
    NewObjectArray(kk).OtherData = ObjectArray(kk).OtherData;
    NewObjectArray(kk).WavelengthRange  = ObjectArray(kk).WavelengthRange;
    NewObjectArray(kk).Comment = ObjectArray(kk).Comment;
    NewObjectArray(kk).ClassName = ObjectArray(kk).ClassName;
    NewObjectArray(kk).SavedIndex = kk;
end
ObjectArray = NewObjectArray;
save('D:\MatLightTracer_GitHub\Catalogue_Files\INFRARED_AGF2.mat','ObjectArray','FileInfoStruct')
