function newRect1D = Rect1D( amplitude,center,width,edgeFactor )
    %RECTSIGNAL1D Summary of this function goes here
    %   Detailed explanation goes here
    if nargin == 0
        amplitude = 1;
        center = [0];
        width = 1;
        edgeFactor = 0.05;
    elseif nargin == 1
        center = [0,0];
        width = 1;
        edgeFactor = 0.05;
    elseif nargin == 2
        width = 1;
        edgeFactor = 0.05;
    elseif nargin == 3
        edgeFactor = 0.05;
    else
    end
    newRect1D.Amplitude = amplitude;
    newRect1D.Center = center;
    newRect1D.Width = width;
    newRect1D.EdgeFactor = edgeFactor;
    
    newRect1D.ClassName = 'Rect1D';
end

