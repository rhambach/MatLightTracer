function [ yf,uf ] = paraxialRayTracer( optSystem,yi,ui,initialSurf,finalSurf,wavlenInM,referenceWavlenInM )
    %PARAXIALRAYTRACER performs paraxial ray trace through optical system using
    %yni algorithm.
    if nargin < 6
        disp('Error: Mising argument in paraxialRayTracer function. So calculation is aborted.');
        yf = NaN;
        uf = NaN;
        return;
    elseif nargin == 6
        referenceWavlenInM = wavlenInM(1);
    else
    end
    
    % Determine the start and end indeces in non dummy surface array
%     nSurface = getNumberOfSurfaces(optSystem);
%     nNonDummySurface = getNumberOfNonDummySurfaces(optSystem);
%     nonDummySurfaceArray = getNonDummySurfaceArray(optSystem);
%     nonDummySurfaceIndices = getNonDummySurfaceIndices(optSystem);
    
    [ nonDummySurfaceArray,nNonDummySurface,nonDummySurfaceIndices,...
        surfaceArray,nSurface ] = getNonDummySurfaceArray(optSystem);
    
%         startNonDummyIndex = initialNonDummySurf;
%         endNonDummyIndex = finalNonDummySurf;
        
    if initialSurf==finalSurf
        yf=yi;
        uf=ui;
    elseif initialSurf < finalSurf
        y = yi;
        u = ui;
        %forward trace
        indicesAfterStartSurf = find(nonDummySurfaceIndices>=initialSurf);
        startNonDummyIndex = indicesAfterStartSurf(1);
        indicesBeforeEndSurf = find(nonDummySurfaceIndices<=finalSurf);
        endNonDummyIndex = indicesBeforeEndSurf(end);
        reverseTracing = 0;
        
        for surfIndex = startNonDummyIndex+1:1:endNonDummyIndex
            
            indexBefore = getRefractiveIndex(nonDummySurfaceArray(surfIndex-1).Glass,wavlenInM);
            indexAfter = getRefractiveIndex(nonDummySurfaceArray(surfIndex).Glass,wavlenInM);
            surface = nonDummySurfaceArray(surfIndex);
            
            % translate the paraxial ray for next trace
            t = nonDummySurfaceArray(surfIndex-1).Thickness;
            if t > 10^10
                t = 10^10;
            end
            yBefore = y + t*u;
            uBefore = u;
            if strcmpi(nonDummySurfaceArray(surfIndex).Glass.Name,'MIRROR')
                reflection = 1;
            else
                reflection = 0;
            end
            
            [ yAfter,uAfter ] = traceParaxialRaysToThisSurface(surface,yBefore,uBefore,...
                indexBefore,indexAfter,reverseTracing,reflection,wavlenInM,referenceWavlenInM);
            
            y = yAfter;
            u = uAfter;
            
            %             yPrev = yNext;
            %             uPrev = uNext;
            % 			t=thick(surfIndex);
            % 			c=curv(surfIndex+1);
            % 			n=refIndex(surfIndex);
            % 			nPrime=refIndex(surfIndex+1);
            %
            % 			if t~=Inf
            % 				y=y+t*u;
            % 			end
            % 			paI=u+y*c; %The yui method generates the paraxial angles of incidence
            % 			% during the trace and is probably the most common method used in computer programs.
            % 			u=u+((n/nPrime)-1)*paI;
        end
        yf = y;
        uf = u;
    elseif initialSurf > finalSurf
        y = yi;
        u = -ui;
        %reverse trace
        
        indicesAfterEndSurf = find(nonDummySurfaceIndices>=finalSurf);
        endNonDummyIndex = indicesAfterEndSurf(1);
        indicesBeforeStartSurf = find(nonDummySurfaceIndices<=initialSurf);
        startNonDummyIndex = indicesBeforeStartSurf(end);
        
        reverseTracing = 1;
        
        for surfIndex = startNonDummyIndex:-1:endNonDummyIndex+1
            indexBefore = getRefractiveIndex(nonDummySurfaceArray(surfIndex-1).Glass,wavlenInM);
            indexAfter = getRefractiveIndex(nonDummySurfaceArray(surfIndex).Glass,wavlenInM);
            surface = nonDummySurfaceArray(surfIndex);
            yAfter = y;
            uAfter = u;
            if strcmpi(nonDummySurfaceArray(surfIndex).Glass.Name,'MIRROR')
                reflection = 1;
            else
                reflection = 0;
            end
            [ yBefore,uBefore ] = traceParaxialRaysToThisSurface(surface,yAfter,uAfter,...
                indexBefore,indexAfter,reverseTracing,reflection,wavlenInM,referenceWavlenInM);
            
            % translate the paraxial ray to prev surface
            t = nonDummySurfaceArray(surfIndex-1).Thickness;
            if t > 10^10
                t = 0;
            end
            y = yBefore + t*uBefore;
            u = uBefore;
            %             yPrev = yNext;
            %             uPrev = uNext;
        end
        yf = y;
        uf = -u;
        
        % 		y=yi;
        % 		u=-ui;
        % 		for surfIndex=initialSurf:-1:1+finalSurf
        % 			t=thick(surfIndex-1);
        % 			c=-curv(surfIndex);
        % 			indexBefore=refIndex(surfIndex);
        % 			indexAfter=refIndex(surfIndex-1);
        %
        % 			paI=u+y*c;
        % 			u=(u+((indexBefore/indexAfter)-1)*paI);
        % 			if t~=Inf
        % 			   y=y+t*u;
        % 			end
        % 		end
        % 		yf=y;
        % 		uf=-u;
    else
        
    end
    
end

