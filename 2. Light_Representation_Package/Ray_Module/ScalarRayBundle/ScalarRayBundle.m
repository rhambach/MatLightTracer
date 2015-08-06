function [ newScalarRayBundle ] = ScalarRayBundle( pos,dir,wav,nRays )
    %ScalarRayBundle Summary of this function goes here
    %   Detailed explanation goes here
    if nargin == 0
        % Empty constructor
        newScalarRayBundle.Position = [0;0;0]; % default position
        newScalarRayBundle.Direction = [0;0;1]; % default dirction
        newScalarRayBundle.Wavelength = 0.55*10^-6; % default
        newScalarRayBundle.ClassName = 'ScalarRayBundle';
    else
        if nargin == 1
            dir = [0;0;1]; % default dirction
            wav = 0.55*10^-6;  % default
        elseif nargin == 2
            wav = 0.55*10^-6; % default
        else
        end
        
        % If the inputs are arrays the newRay becomes object array
        % That is when dir, pos  = 3 X N matrix
        
        % Determine the size of each inputs
        nPos = size(pos,2);
        nDir = size(dir,2);
        nWav = size(wav,2);
        % The number of array to be initialized is maximum of all inputs
        nMax = max([nPos,nDir,nWav]);
        
        if nargin > 3
            % limit nMax to the nRays
            nMax = nRays;
        end
        % Fill the smaller inputs to have nMax size by repeating their
        % last element
        if nPos < nMax
            pos = cat(2,pos,repmat(pos(:,end),[1,nMax-nPos]));
        else
            pos = pos(:,1:nMax);
        end
        if nDir < nMax
            dir = cat(2,dir,repmat(dir(:,end),[1,nMax-nDir]));
        else
            dir = dir(:,1:nMax);
        end
        if nWav < nMax
            wav = cat(2,wav,repmat(wav(end),[1,nMax-nWav]));
        else
            wav = wav(:,1:nMax);
        end
        
        newScalarRayBundle = ScalarRayBundle;
        newScalarRayBundle.Position = pos;
        newScalarRayBundle.Direction = dir;
        newScalarRayBundle.Wavelength = wav;
        newScalarRayBundle.ClassName = 'ScalarRayBundle';
    end
end

