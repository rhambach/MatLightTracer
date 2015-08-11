function mySurfaceArray = getComponentSurfaceArray(currentComponent)
    % getComponentSurfaceArray: Compute surface parameters of the currentComponent
    % parameter index
    % Input:
    %   ( currentComponent )
    % Output:
    %   [ mySurfaceArray ]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original version
    
    % <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    componentDefinitionFileName = currentComponent.Type;
    % Connect the component definition function
    componentDefinitionHandle = str2func(componentDefinitionFileName);
    returnFlag = 4; % surface array of the component
    firstTilt = currentComponent.FirstTilt;
    firstDecenter = currentComponent.FirstDecenter;
    firstTiltDecenterOrder = currentComponent.FirstTiltDecenterOrder;
    lastThickness = currentComponent.LastThickness;
    lastTiltMode = currentComponent.ComponentTiltMode;
    [ surfArray ] = componentDefinitionHandle(returnFlag,currentComponent.UniqueParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,lastThickness,lastTiltMode);
    % Make the stop surface
    for kk = 1:length(surfArray)
        surfArray(kk).IsStop = 0;
    end
    stopSurfaceInComponentIndex = currentComponent.StopSurfaceIndex;
    if stopSurfaceInComponentIndex
        surfArray(stopSurfaceInComponentIndex).IsStop = 1;
    end
    mySurfaceArray = surfArray;
end