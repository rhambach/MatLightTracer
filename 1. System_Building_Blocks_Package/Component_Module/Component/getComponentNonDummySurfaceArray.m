function myNonDummySurfaceArray = getComponentNonDummySurfaceArray(currentComponent)
    % getComponentNonDummySurfaceArray: Compute surface parameters of the currentComponent
    % and return the non dummy array.
    % Input:
    %   ( currentComponent )
    % Output:
    %   [ myNonDummySurfaceArray ]
    
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
    mySurfaceArray = getComponentSurfaceArray(currentComponent);
    nSurface = size(mySurfaceArray);
    nonDummySurfaceIndices = [];
    for kk = 1:nSurface
        if ~strcmpi(mySurfaceArray(kk).Type,'Dummy')
            nonDummySurfaceIndices = [nonDummySurfaceIndices,kk];
        end
    end
    myNonDummySurfaceArray = mySurfaceArray(nonDummySurfaceIndices);
end