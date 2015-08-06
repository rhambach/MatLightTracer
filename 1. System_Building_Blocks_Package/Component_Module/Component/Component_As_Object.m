classdef Component
    % Component Class:
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
    %                                    definitions
    
    properties
        Type % (String) - The component type. It is the same as the component definition function name.
        Comment % (String) - Component comment
        StopSurfaceIndex % (Numeric) - Index of the Stop surface with in the component or 0 if the stop surface is not in the component.
        UniqueParameters % (Struct) - Structure containg the parameters used for different types of component.
        FirstTiltDecenterOrder %  (Cell Array) - 6 elements showing the order in which
        % tilt and decenter operations are done.
        FirstTilt % (Vector 3x1) - [Tilt X, Tilt Y, Tilt Z] in degrees
        FirstDecenter % (Vector 2x1) - [Decenter X,Decenter Y]
        ComponentTiltMode %  (String) - Coordinate system for subsequent components
        % DAR: Decenter and return, NAX: New axis, BEN: Bend surface
        LastThickness % (Numeric) - Thickness directly after the component to the next component
        % tilt decenter data of the first surface of the component
        ClassName % (String) - Name of the class. Here it is just redundunt but used to identify structures representing different objects when struct are used instead of objects.
    end
    
    methods
        % Constructor
        function newComponent = Component(compType,uniqueParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,compTiltMode,lastThickness)
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
                lastThickness = 5;
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
                lastThickness = 5;
            elseif nargin == 2
                firstTilt = [0,0,0];
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                compTiltMode = 'DAR';
                lastThickness = 5;
            elseif nargin == 3
                firstDecenter = [0,0];
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                compTiltMode = 'DAR';
                lastThickness = 5;
            elseif nargin == 4
                firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
                compTiltMode = 'DAR';
                lastThickness = 5;
            elseif nargin == 5
                compTiltMode = 'DAR';
                lastThickness = 5;
            elseif nargin == 6
                lastThickness = 5;
            else
                
            end
            newComponent.Type = compType;
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
    end
    methods(Static)
        function newObj = InputGUI()
            newObj = ObjectInputDialog(MyHandle(Component()));
        end
    end
end

