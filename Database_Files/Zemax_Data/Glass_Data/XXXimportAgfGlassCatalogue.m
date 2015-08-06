function [ imported ] = importAgfGlassCatalogue( myParent,agfFullFileName )
    % importAgfGlassCatalogue: importes glass catalogue from ANSI Glass File (AGF) 
    % which is zemax format.
    % Input:
    %  myParent: Object defining the currnt parent window
	%  agfFullFileName:	Full file name of .AGF file including its path. It is an optional argument.
    % Output:
    %  importedGlassArray: Struct array with all glass data

    % <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage >>>>>>>>>>>>>>>>>>>>>>>>>>>>   
    
	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
    %   Part of Optical System Analysis Toolbox in Matlab
	%	Optical System Design Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% July 28,2014   Worku, Norman G.     Original Version        
    
    % Get the file name and path name of the AGF file
    
if nargin < 1
    disp('Error: The function "importAgfGlassCatalogue" needs atleast one argument.');
    return;
elseif nargin == 1
    [FileName,PathName] = uigetfile('*.agf','Select AGF File');
    if ~isempty(FileName)&&~isempty(PathName)
        [pathstr,name,ext] = fileparts(FileName);
    else
        imported = 0;
        return;
    end
elseif nargin == 2
    [pathstr,name,ext] = fileparts(agfFullFileName);
    FileName = [name,ext];
    PathName = pathstr;
end

if (FileName~=0) % FileName = 0 when no file is selected
    fullFileName = [PathName,'\',FileName];
    % convert unicode to ascii format running DOS command
    command = ['TYPE "',fullFileName,'">"temAsciiFile"'];
    status = dos(command);
    % read the input file
    inputAgfFile = fopen('temAsciiFile', 'r');
    agfGlassTypes = {'Schott','Sellmeier1','Herzberger','Sellmeier2',...
        'Conrady','Sellmeier3','HandbookOfOptics1','HandbookOfOptics2',...
        'Sellmeier4','Extended','Sellmeier5', 'Extended2'};
    glassCounter = 0;
    glassCatalogueFullFileName = myParent.addNewGlassCatalogue([name,'_AGF']);
    
    while ~feof(inputAgfFile)
        % read the next valid line
        currentLine = fgets(inputAgfFile);
        % read the line as space separated string
        currentLineArray = strread(currentLine,'%s');
        if isempty(currentLineArray)
          continue
        end
        % The first element of the array is the 2 character AGF code
        agfCode = char(currentLineArray(1,:));
        switch upper(agfCode)
            case 'NM' % Name
                glass_name = char(currentLineArray(2,:));
                dispersion_formula_No = str2num(char(currentLineArray(3,:)));
                MIL_No = str2num(char(currentLineArray(4,:)));
                Nd = str2num(char(currentLineArray(5,:)));
                Vd = str2num(char(currentLineArray(6,:)));
                Exclude_Sub = str2num(char(currentLineArray(7,:)));
                status = str2num(char(currentLineArray(8,:)));
                melt_freq = str2num(char(currentLineArray(9,:)));
                
                glassName = upper(glass_name);
                glassType = char(agfGlassTypes(dispersion_formula_No));
            case 'ED' % Extra data
                TCE70 = str2num(char(currentLineArray(2,:)));
                TCE300 = str2num(char(currentLineArray(3,:)));
                density = str2num(char(currentLineArray(4,:)));
                dPgF = str2num(char(currentLineArray(5,:)));
                Ignore_Thermal_Exp = str2num(char(currentLineArray(6,:)));
            case 'CD' % Coefficient Data
                glassParameters = (str2num(char((currentLineArray(2:11)))));
                
                % Now the glass can be defined
                glassCounter = glassCounter + 1;
                newGlass = Glass(glassName,glassType,glassParameters);
                addObjectToAODObjectCatalogue...
                    ('glass', newGlass,glassCatalogueFullFileName,'replace' );
            otherwise
                % Do nothing just ignoring all other glass properties
        end
    end
    imported = 1;
else
    imported = 0;
    return;
end

