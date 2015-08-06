function [ fullName ] = createLensCatalogue(lensCatalogueFullName,ask_replace )
    % createLensCatalogue: Create a new Lens catalogue in matlab and intialize
    % empty array of Lens struct.

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%	Optical System Design Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% July 28,2014   Worku, Norman G.     Original Version        
    
    % Default values
    if nargin == 0
        % Put the new lens catalogue in the same folder as the function
        % importZMX.m
        defaultFileName = which ('importZMX.m');
        [pathstr,name,ext] = fileparts(defaultFileName);   
        lensCatalogueFullName = [pathstr,'\ImportedLensCatalogue.mat'];
        ask_replace = 'ask';
    elseif nargin == 1
        % If path string is not specified use the default path string
        if isempty(fileparts(lensCatalogueFullName))
            defaultFileName = which ('importZMX.m');
            [pathstr,name,ext] = fileparts(defaultFileName);   
            lensCatalogueFullName = [pathstr,'\',lensCatalogueFullName];
        end
        ask_replace = 'ask';
    end

    switch lower(ask_replace)
        case lower('ask')
            Ask = 1;
            Replace = 0;
        case lower('replace')
            Ask = 0;
            Replace = 1;
    end

    %check if the catalogue already exsit
    if exist(lensCatalogueFullName,'file')
        [pathstr,name,ext] = fileparts(lensCatalogueFullName);
        alternativeName = fullfile(pathstr,[name,'1',ext]);
        if Ask
            button = ...
                questdlg(strcat('There already exists a Lens catalogue named ', ...
                name, '. Do you want to create the catalogue with new name: ',...
                name, '1 ?'),'New Catalogue Name','Yes Save','No Replace','Yes Save');
            switch button
                case 'Yes Save'
                    newLensCatalogueFullName = alternativeName;
                    fullName = createLensCatalogue(newLensCatalogueFullName );
                case 'No Replace'
                    % delete the exsisting and create anew one
                    delete(lensCatalogueFullName);
                    fullName = createLensCatalogue(lensCatalogueFullName );
            end
        else
            % delete the exsisting and create anew one
            delete(lensCatalogueFullName);
            fullName = createLensCatalogue(lensCatalogueFullName );
        end
    else
        LensArray = orderfields(struct...
            ('FileName',{},'NumberOfSurfaces',{},'SurfaceArray',{},...
            'SystemApertureType',{},'EntrancePupilDiameter',{},...
            'ObjectSpaceNA',{}, 'ObjectConeAngle',{},...
            'WorkingFNumber',{},'ImageSpaceFNumber',{},...
            'EnvironmentalData',{},'FieldType',{},...
            'NumberOfFieldPoints',{},'FieldNormalization',{},...
            'FieldPointMatrix',{},'AfocalImageSpace',{},...
            'TelecentricObjectSpace',{},'IterateSolves',{},...
            'NumberOfWavelengths',{},'WavelengthMatrix',{},...
            'PrimaryWavelengthIndex',{},'GlassCatalogues',{},...
            'ApodizationType',{},'ApodizationFactor',{},...
            'GlobalReference',{},'FNumberComputation',{},...
            'Mode',{},'LensName',{},'LensNote',{},...
            'ParaxialIgnoreCB',{},'ReferenceOPD',{},...
            'LensUnit',{},'WavelengthUnit',{},...
            'SoftwareVersion',{}));

        FileInfoStruct =  struct();   
        FileInfoStruct.Type = 'Lens';  
        FileInfoStruct.Date = fix(clock); % Clock = [YYYY MM DD HH MM SS]
        save(lensCatalogueFullName,'LensArray','FileInfoStruct');
        save(lensCatalogueFullName,'LensArray','FileInfoStruct','-append');
        fullName = lensCatalogueFullName;
    end
end

