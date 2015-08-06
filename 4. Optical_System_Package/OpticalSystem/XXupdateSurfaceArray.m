function [ optSystem ] = updateSurfaceArray( optSystem )
%UPDATESURFACEARRAY Updates the nondummysurfacearray and surface tilt and decenter parameters to the
%current surface array of the optical system. This allows user to just
%update the surface array parameters and call this function to do the same
%for NonDummySurfaceArray. Ray tracing and other analysis use the NonDummySurfaceArray

    %Surface Data    
    nSurface = size(optSystem.SurfaceArray,2);
    %% Now write all the data to an optical system object        
    %Set optical systems properties
    optSystem.NumberOfSurfaces = nSurface;   
    %create empty surface array
    Surface.empty(nSurface,0);

    %Set optical system surfaces. 
    % Assume global ref is 1st surface of the lens  
    optSystem.SurfaceArray(1).DecenterParameter = [0 0];
    optSystem.SurfaceArray(1).TiltParameter = [0 0 0];

    objLocation = -1*optSystem.SurfaceArray(1).Thickness;
    if abs(objLocation) > 10^10 % Infinite object distance replaced with 0
        objLocation = 0;
    end
    NonDummySurface = ones(1,nSurface);
    for k = 1:1:nSurface
        %standard data
       if strcmpi(optSystem.SurfaceArray(k).Type,'Dummy')
            NonDummySurface(k) = 0;
       end        
        % get glass name and then SellmeierCoefficients from file
        glassName = optSystem.SurfaceArray(k).Glass.Name;% text
        if strcmpi(glassName,'Mirror')
            % Just take the glass of the non dummy surface before the mirror 
            % but with the new name "MIRROR"
            for pp = k-1:-1:1
                if NonDummySurface(pp)
                    prevNonDummySurface = pp;
                    break;
                end
            end
            aodObject = optSystem.SurfaceArray(prevNonDummySurface).Glass;
            aodObject.Name = 'MIRROR';            
            optSystem.SurfaceArray(k).Glass = aodObject; 
        elseif strcmpi(glassName,'None')
             optSystem.SurfaceArray(k).Glass = Glass;
        elseif ~isempty(glassName)
            % check for its existance and extract the glass among selected catalogues
            objectType = 'glass';
            objectName = glassName;
            if isempty(str2num(glassName)) % If the glass name is specified
                % Glass Catalogue
                glassCatalogueListFullNames = optSystem.GlassCataloguesList;
                objectCatalogueListFullNames = glassCatalogueListFullNames;
                objectIndex = 0;
                for pp = 1:size(objectCatalogueListFullNames,1)
                    objectCatalogueFullName = objectCatalogueListFullNames{pp};
                    [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                        (objectType,objectName,objectCatalogueFullName );
                    if objectIndex ~= 0
                        break;
                    end
                end
                
                if  objectIndex ~= 0
                    optSystem.SurfaceArray(k).Glass = aodObject;
                else
                    disp(['Error: The glass after surface ',num2str(k),' is not found so it is ignored.']);
                    optSystem.SurfaceArray(k).Glass = Glass;
                end                
            else
                % Fixed Index Glass
                % str2num can be used to convert array of strings to number.
                ndvdpg = str2num(glassName); 
                if length(ndvdpg) == 1
                    nd = ndvdpg(1);
                    vd = 0;
                    pd = 0;
                elseif length(ndvdpg) == 2
                    nd = ndvdpg(1);
                    vd = ndvdpg(2);
                    pd = 0;
                elseif length(ndvdpg) == 3
                    nd = ndvdpg(1);
                    vd = ndvdpg(2);
                    pd = ndvdpg(3);
                else
                end
                glassName = [num2str((nd),'%.4f '),',',...
                            num2str((vd),'%.4f '),',',...
                            num2str((pd),'%.4f ')];
                aodObject = Glass(glassName,'FixedIndex',[nd,vd,pd,0,0,0,0,0,0,0]');
                optSystem.SurfaceArray(k).Glass = aodObject;
            end
        else
            optSystem.SurfaceArray(k).Glass = Glass;
        end
             
        % coating data
        coatName = optSystem.SurfaceArray(k).Coating.Name ;
        
        if ~isempty(coatName)
            % check for its existance and extract the coating among selected catalogues
            objectType = 'coating';
            objectName = coatName;
            % Coating Catalogue
            coatingCatalogueListFullNames = optSystem.CoatingCataloguesList;            
            objectCatalogueListFullNames = coatingCatalogueListFullNames;
            objectIndex = 0;
            for pp = 1:size(objectCatalogueListFullNames,1)
                objectCatalogueFullName = objectCatalogueListFullNames{pp};
                [ aodObject,objectIndex ] = extractObjectFromAODObjectCatalogue...
                    (objectType,objectName,objectCatalogueFullName );
                if objectIndex ~= 0
                    break;
                end
            end
            
            if  objectIndex ~= 0
                % change the default wavelength of coating to the current primary wavelength
                primaryWavLenInUm = optSystem.getPrimaryWavelength*10^6;
                aodObject.CoatingParameters.WavelengthInUm = primaryWavLenInUm;
                optSystem.SurfaceArray(k).Coating = aodObject;
            else
                disp(['Error: The coating of surface ',num2str(k),' is not found so it is ignored.']);
                optSystem.SurfaceArray(k).Coating = Coating;
            end
        else
            optSystem.SurfaceArray(k).Coating = Coating;
        end

%         % Other surface type specific standard data
%         [fieldNames,fieldFormat,initialData] = optSystem.SurfaceArray(k).getOtherStandardDataFields;
%         optSystem.SurfaceArray(k).OtherStandardData = struct;
%         for ff = 1:10
%             optSystem.SurfaceArray(k).OtherStandardData.(fieldNames{ff}) = ...
%                 (tempStandardData{k,ff+10});
%         end       
             

        % compute position from decenter and thickness
        if k==1 % Object surface
            objThickness = abs(optSystem.SurfaceArray(k).Thickness);
            if objThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for graphing
                objThickness = 0;
            end
            % since global coord but shifted by objThickness
            refCoordinateTM = [1,0,0,0;0,1,0,0;0,0,1,-objThickness;0,0,0,1]; 
            
            surfaceCoordinateTM = refCoordinateTM;
            referenceCoordinateTM = refCoordinateTM;
            % set surface property
            optSystem.SurfaceArray(k).SurfaceCoordinateTM = ...
                surfaceCoordinateTM;
            optSystem.SurfaceArray(k).ReferenceCoordinateTM = ...
                referenceCoordinateTM;           
       else
            prevRefCoordinateTM = referenceCoordinateTM;
            prevSurfCoordinateTM = surfaceCoordinateTM;
            prevThickness = optSystem.SurfaceArray(k-1).Thickness; 
            if prevThickness > 10^10 % Replace Inf with INF_OBJ_Z = 0 for object distance
                prevThickness = 0;
            end
            [surfaceCoordinateTM,referenceCoordinateTM] = optSystem. ...
                    SurfaceArray(k).TiltAndDecenter(prevRefCoordinateTM,...
                    prevSurfCoordinateTM,prevThickness);
            % set surface property
            optSystem.SurfaceArray(k).SurfaceCoordinateTM = surfaceCoordinateTM;
            optSystem.SurfaceArray(k).ReferenceCoordinateTM = referenceCoordinateTM;
        
        end
        optSystem.SurfaceArray(k).Position = (surfaceCoordinateTM (1:3,4))';  
    end
    
    optSystem.NonDummySurfaceIndices = find(NonDummySurface);
    optSystem.NumberOfNonDummySurfaces = length(optSystem.NonDummySurfaceIndices);
    optSystem.NonDummySurfaceArray  = optSystem.SurfaceArray(optSystem.NonDummySurfaceIndices);
end

