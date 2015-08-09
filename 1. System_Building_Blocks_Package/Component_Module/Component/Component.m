function newComponent = Component(compType,uniqueParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,compTiltMode,lastThickness)
    % Component Struct:
    %
    %   Defines optical components such as sequence of interface,lens,prism.
    %   This is used in the optical systems which are defined in the
    %   component based manner.
    %
    % Example Calls:
    %
    % newComponent = Component()
    %   Returns a defualt 'SequenceOfSurfaces' component.
    %
    % newComponent = Component(compType)
    %   Returns a default component of given compType
    %
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0
    % Jun 17,2015   Worku, Norman G.     Support the user defined coating
    %
    if nargin == 0
        % Make single surface component by default
        compType = 'SequenceOfSurfaces';
        % Connect the component definition function
        componentDefinitionHandle = str2func(compType);
        returnFlag = 2; % Basic parameters of the component
        [ paramNames, paramTypes, defaultValueStruct] = componentDefinitionHandle(returnFlag);
        uniqueParameters = defaultValueStruct;
        
        firstTilt = [0,0,0];
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 10;
    elseif nargin == 1
        % Connect the component definition function
        componentDefinitionHandle = str2func(compType);
        returnFlag = 2; % Basic parameters of the component
        [ paramNames, paramTypes, defaultValueStruct] = componentDefinitionHandle(returnFlag);
        uniqueParameters = defaultValueStruct;
        
        firstTilt = [0,0,0];
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 10;
    elseif nargin == 2
        firstTilt = [0,0,0];
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 10;
    elseif nargin == 3
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 4
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 10;
    elseif nargin == 5
        compTiltMode = 'DAR';
        lastThickness = 10;
    elseif nargin == 6
        lastThickness = 10;
    else
        
    end
    newComponent.Type = compType;
    newComponent.Name = compType;
    newComponent.Comment = '';
    newComponent.StopSurfaceIndex = 0;
    newComponent.LastThickness = lastThickness;
    newComponent.FirstTiltDecenterOrder = firstTiltDecenterOrder;
    newComponent.FirstTilt = firstTilt;
    newComponent.FirstDecenter = firstDecenter;
    newComponent.ComponentTiltMode = compTiltMode;
    newComponent.UniqueParameters = uniqueParameters;
    newComponent.ClassName = 'Component';
end


