function [linearRGBGradient,demoImage] = computeLinearColorGradient(RGB1,RGB2,nLevels)
    % computeLinearColorGradient used to generate a linear gradient between 2 given colors,
    % that can be used as colormap in your figures.
    %
    % INPUT:
    % - RGB1: color vector given as Intensity or RGB color. Initial value.
    % - RGB2: same as RGB1. This is the final value of the gradient.
    % - nLevels: number of colors or elements of the gradient.
    %
    % OUTPUT:
    % - linearRGBGradient: a matrix of depth*3 elements containing colormap (or gradient).
    % - demoImage: a nLevel*10*3 RGB image that can be used to display the result demo.
    %
    % EXAMPLES:
    %  [linearRGBGradient,demoImage] = computeLinearColorGradient([1 0 0],[0.5 0.8 1],128);
    %  ---- See the gradient generated------------
    % image(demoImage); %display an image with the color gradient.
    %  ---- Use the gradient as color map ------------
    % surf(peaks)
    % colormap(linearRGBGradient);
    
    if nargin < 2
        disp(['Error: The function computeLinearColorGradient requires atleast the',...
            'initial and final RGB values.']);
        linearRGBGradient = NaN;
        demoImage = NaN;
        return;
    end
    if nargin < 3
        nLevels = 64;
    end
    
    %If RGB1 or RGB2 is not a valid RGB vector return an error.
    if numel(RGB1)~=3
        error('Color RGB1 is not a valir RGB vector');
    end
    if numel(RGB2)~=3
        error('Color RGB2 is not a valir RGB vector');
    end
    
    if max(RGB1)>1&&max(RGB1)<=255
        %warn if RGB values are given instead of Intensity values. Convert and
        %keep procesing.
        warning('color RGB1 is not given as intensity values. Trying to convert');
        RGB1 = RGB1./255;
    elseif max(RGB1)>255||min(RGB1)<0
        error('RGB1 values are not valid.')
    end
    
    if max(RGB2)>1&&max(RGB2)<=255
        %warn if RGB values are given instead of Intensity values. Convert and
        %keep procesing.
        warning('Color RGB2 is not given as intensity values. Trying to convert');
        RGB2 = RGB2./255;
    elseif max(RGB2)>255||min(RGB2)<0
        error('RGB2 values are not valid.')
    end
    
    % determine increment step for each color channel.
    dr = (RGB2(1)-RGB1(1))/(nLevels-1);
    dg = (RGB2(2)-RGB1(2))/(nLevels-1);
    db = (RGB2(3)-RGB1(3))/(nLevels-1);
    
    % initialize gradient matrix.
    linearRGBGradient = zeros(nLevels,3);
    % initialize matrix for each color. Needed for the image. Size 10*nlevel.
    r = zeros(10,nLevels);
    g = zeros(10,nLevels);
    b = zeros(10,nLevels);
    %for each color step, increase/reduce the value of Intensity data.
    for j = 1:nLevels
        linearRGBGradient(j,1) = RGB1(1)+dr*(j-1);
        linearRGBGradient(j,2) = RGB1(2)+dg*(j-1);
        linearRGBGradient(j,3) = RGB1(3)+db*(j-1);
        r(:,j) = linearRGBGradient(j,1);
        g(:,j) = linearRGBGradient(j,2);
        b(:,j) = linearRGBGradient(j,3);
    end
    
    % merge R G B matrix and obtain our demo image.
    demoImage=cat(3,r,g,b);
