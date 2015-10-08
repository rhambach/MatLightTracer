function newHarmonicField = HarmonicField(Ex,Ey,sampDistX,sampDistY,wavelen,center,direction,domain)
    if nargin == 0
        N = 65;
        Ex = zeros(N,N);
        Ex(24:40,24:40) = 1;
        Ey = zeros(N,N);
        d = (2*10^-3)/N;
        sampDistX = d;
        sampDistY = d;
        wavelen = 0.55*10^-6;
        center = [0,0]';
        direction = [0,0,1]';
        domain = 1;% 1 for Spatial domain, and 2 for spatial frequency 
    elseif nargin > 0 && nargin < 5
        disp('Error: You need to enter all input parameters (Ex,Ey,sampDistX,sampDistY,wavelen) or nothing.');
        newHarmonicField = HarmonicField;
        return;
    elseif nargin == 5
        center = [0,0]';
        direction = [0,0,1]';
        domain = 1;
    elseif nargin == 6
        direction = [0,0,1]';
        domain = 1;
    elseif nargin == 7
        domain = 1;  % spatial domain  
    else
        if (size(Ex,1)~= size(Ey,1))||(size(Ex,2)~= size(Ey,2))
            disp('Error: Sizes of Ex and Ey must be the same');
            return;
        end
    end
    
    % Make the field size ODD in both side (zero padding to the
    % right and bottom of the matrices)
    nPoints1Ex = size(Ex,1);
    nPoints2Ex = size(Ex,2);
    nPoints1Ey = size(Ey,1);
    nPoints2Ey = size(Ey,2);
    
    if (nPoints1Ex == nPoints1Ey)&&(nPoints2Ex == nPoints2Ey)
        nPoints1 = nPoints1Ex;
        nPoints2 = nPoints2Ex;
    else
        disp('Error: Ex and Ey must be of the same size');
        return;
    end
    
    if ~mod(nPoints1,2)
        nPoints1 = nPoints1 + 1;
        Ex = [Ex,zeros(nPoints2,1)];
        Ey = [Ey,zeros(nPoints2,1)];
    end
    if ~mod(nPoints2,2)
        nPoints2 = nPoints2 + 1;
        Ex = [Ex;zeros(1,nPoints1)];
        Ey = [Ey;zeros(1,nPoints1)];
    end
    newHarmonicField.ComplexAmplitude = cat(3,Ex,Ey);
    newHarmonicField.SamplingDistance = [sampDistX;sampDistY];
    newHarmonicField.Wavelength = wavelen;
    newHarmonicField.Center = center;
    newHarmonicField.Direction = direction;
    newHarmonicField.Domain = domain; % 1 for Spatial domain, and 2 for spatial frequency 
    newHarmonicField.ClassName = 'HarmonicField';
end
% yet to be defined
function [Ez,x_lin,y_lin] = computeEz(harmonicField)
    disp('Erorr: computeEz not implemented yet.');
    Ez = NaN;
    x_lin = NaN;
    y_lin = NaN;
end

function [Hx,X,Y] = computeHx(harmonicField)
    disp('Erorr: computeHx not implemented yet.');
    Hx = NaN;
end
function [Hy,X,Y] = computeHy(harmonicField)
    disp('Erorr: computeHy not implemented yet.');
    Hy = NaN;
end
function [Hz,X,Y] = computeHz(harmonicField)
    disp('Erorr: computeHz not implemented yet.');
    Hz = NaN;
end

