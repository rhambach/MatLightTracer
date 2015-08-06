function fullFileName = addCoatingCatalogue(myParent,catlogueFullFileName)
    
    aodHandles = myParent.ParentHandles;
    % If no catalogue full file name is not given then create a new catalogue
    if nargin == 0
        msgbox('Error: The function addCoatingCatalogue needs atleast one input argument.');
        fullFileName = NaN;
        return;
    elseif nargin == 1
        catalogueFileName = char(cellstr(inputdlg('Enter New Catalogue Name','New Catalogue Name',1,{'CoatingCat01'})));
        if ~isempty(catalogueFileName)
            catloguePathName = [pwd,'\Catalogue_Files\'];
            catlogueFullFileName = [catloguePathName,catalogueFileName,'.mat'];
            [ fullFileName ] = createNewObjectCatalogue('Coating', catlogueFullFileName,'ask' );
            [catloguePathName,catalogueFileName,ext] = fileparts(fullFileName);
            
            % Add a row with the new coating catalogue
            % aodHandles = myParent.ParentHandles;
            tblData1 = get(aodHandles.tblCoatingCatalogues,'data');
            newRow1 =  {[true],[catalogueFileName],[fullFileName]};
            newTable1 = [tblData1; newRow1];
            set(aodHandles.tblCoatingCatalogues, 'Data', newTable1);
            set(aodHandles.txtTotalCoatingCataloguesSelected, 'String',...
                str2double(get(aodHandles.txtTotalCoatingCataloguesSelected, 'String'))+1);
        else
            msgbox('Error: Empty catalogue file name.');
            fullFileName = NaN;
            return;
        end
    elseif nargin == 2
        [isValidCatalogue,~,~,relatedCatalogueFullFileNames] = isValidObjectCatalogue('Coating', catlogueFullFileName );
        
        if isValidCatalogue
            
            % If the catalogue is not in the default folder then make copy and
            % Add the catlaogue to ...\Catalogue_Files folder
            [catloguePathName,catalogueFileName,ext] = fileparts(catlogueFullFileName);
            if ~strcmpi([pwd,'\Catalogue_Files'],catloguePathName)
                copyfile(catlogueFullFileName,[pwd,'\Catalogue_Files\',catalogueFileName,ext])
            end
            fullFileName = [pwd,'\Catalogue_Files\',catalogueFileName,ext];
            
            % check if the catalogue is already in the imported list of
            % catalogues
            tblData1 = get(aodHandles.tblCoatingCatalogues,'data');
            alreadyExsist = 0;
            if ~isempty(tblData1)
                alreadyExsist = sum(cell2mat(cellfun(@(x) strcmpi(x,fullFileName),...
                    tblData1(:,3), 'UniformOutput', false)));
                if alreadyExsist
                    disp([catalogueFileName, ' already exists.']);
                    return;
                else
                    
                end
            end
            % Add a row with the new coating catalogue
            % aodHandles = myParent.ParentHandles;
            tblData1 = get(aodHandles.tblCoatingCatalogues,'data');
            newRow1 =  {[true],[catalogueFileName],[fullFileName]};
            newTable1 = [tblData1; newRow1];
            set(aodHandles.tblCoatingCatalogues, 'Data', newTable1);
            set(aodHandles.txtTotalCoatingCataloguesSelected, 'String',...
                str2double(get(aodHandles.txtTotalCoatingCataloguesSelected, 'String'))+1);
        else
            % check if the catalogue file exists anywhere in the pc
            [cataloguePathName,catalogueFileName,ext] = fileparts(catlogueFullFileName);
            if isempty(relatedCatalogueFullFileNames)
                msgbox(['Error: The catalogue ',catalogueFileName,ext,' does not exist.']);
                fullFileName = NaN;
                return;
            elseif strcmpi(relatedCatalogueFullFileNames,catlogueFullFileName)
                msgbox(['Error: The catalogue ',catalogueFileName,ext,' is an invalid catalogue.']);
                fullFileName = NaN;
                return;
            else
                % Try with the all newCatlogueFullFileNames
                for pp = 1:size(relatedCatalogueFullFileNames,1)
                    if isValidObjectCatalogue('Coating', relatedCatalogueFullFileNames{pp,:} )
                        fullFileName = addGlassCatalogue(myParent,relatedCatalogueFullFileNames{pp,:});
                        return;
                    end
                    
                end
                
            end
        end
        
    end
end