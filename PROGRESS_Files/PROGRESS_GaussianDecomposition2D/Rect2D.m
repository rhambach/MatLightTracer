function newRect2D = Rect2D( amplitude,center_x,center_y,width_x,width_y )
    %RECTSIGNAL1D Summary of this function goes here
    %   Detailed explanation goes here
    if nargin < 1
        amplitude = 1;
    end
    if nargin < 2
        center_x = [0];
    end        
    if nargin < 3
        center_y = [0];
    end
    if nargin < 4
        width_x = 1;
    end
    if nargin < 5
        width_y = 1;
    end

    nRect = length(amplitude);
    newRect2D.Amplitude = amplitude;
    newRect2D.CenterX = center_x;
    newRect2D.CenterY = center_y;
    newRect2D.WidthX = width_x;
    newRect2D.WidthY = width_y;
    newRect2D.nRect = nRect;
    
    newRect2D.ClassName = 'Rect2D';
end

