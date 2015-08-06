function [ lensH ] = draw2DLens(surf1Position,rad1,conic1,semiDiam1, ...
    surf2Position,rad2,conic2,semiDiam2,axesHandle )
    % draw2DLens: Plots the 2 dimensional lay out of alens in meridional plane
    % given its two surfaces
    % Inputs
    %   surf1Position,rad1,conic1,semiDiam1: position, radius, conic constant and
    %   semidiameter of the surface 1 ( the same is true for the second surface)
    %   axesHandle: axes to plot the lens
    % Output
    %   lensH:  height of the lens drawn

    % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Written By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% Oct 14,2013   Worku, Norman G.     Original Version       Version 3.0

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    %check for vertxes on the meridional plane
    if surf1Position(1)~=0 || surf2Position(1)~=0 
        msgbox ('Non rotationally symetric surface');
    else

    %height of the lens is minimum of surfaces semidiameters and radius
    lensHeight = min(abs([rad1,semiDiam1,rad2,semiDiam2]));
    % steps sizes for plotting points
    angleSpacing = 0.001;
    yzSpacing = 0.001;

    if abs(rad1) < 1000 %for large radius consider as plane
        if conic1==0 %sphere
            theta1 = asin(lensHeight/rad1);
            t1=(-abs(theta1):angleSpacing:abs(theta1));
            vertices1 =  -rad1*[(cos(t1))' (sin(t1))'];
            vertices1 = [vertices1(:,1)+surf1Position(3) + rad1,...
                vertices1(:,2)+surf1Position(2) ];
        elseif conic1==-1 %paraboliod
            t1 = (-lensHeight:yzSpacing:lensHeight);
            vertices1 =  [((t1.^2)/(2*rad1))' (t1)'];
            vertices1 = [vertices1(:,1)+surf1Position(3) ,...
                vertices1(:,2)+surf1Position(2)];      
        elseif conic1 < -1 %hyperboliod

        elseif conic1 > 0 %oblate ellipsoid
        %     b = 
        elseif conic1 > -1 && conic1 < 0 %problate ellipsoid
            a = rad1/(conic1 + 1);
            b = sqrt(a*rad1);
            theta1 = asin(lensHeight/b);
            t1=(-abs(theta1):angleSpacing:abs(theta1));
            vertices1 =  -1*[a*(cos(t1))' b*(sin(t1))'];
            vertices1 = [vertices1(:,1)+surf1Position(3) + a,...
                vertices1(:,2)+surf1Position(2) ];    
        else

        end
    else
       vertices1 = [surf1Position(3),surf1Position(2)+lensHeight; surf1Position(3) ,surf1Position(2)-lensHeight]; 
    end

    if abs(rad2) < 1000 %consider as plane
        if conic2==0 %sphere
            theta2 = asin(lensHeight/rad2);
            t2=(-abs(theta2):angleSpacing:abs(theta2 ));
            vertices2 =  -rad2*[(cos(t2))' (sin(t2))'];
            vertices2 = [vertices2(:,1)+surf2Position(3) + rad2,...
                vertices2(:,2)+surf2Position(2)];
        elseif conic2==-1 %paraboliod
            t2 = -lensHeight:yzSpacing:lensHeight;
            vertices2 =  [((t2.^2)/(2*rad2))' (t2)'];
            vertices2 = [vertices2(:,1)+surf2Position(3),vertices2(:,2)+surf2Position(2)];    
        elseif conic2 < -1 %hyperboliod

        elseif conic2 > 0 %oblate ellipsoid

        elseif conic2 > -1 && conic2 < 0 %problate ellipsoid
            a = rad2/(conic2 + 1);
            b = sqrt(a*rad2);    
            theta2 = asin(lensHeight/b);
            t2=(-abs(theta2):angleSpacing:abs(theta2 ));
            vertices2 =  -1*[a*(cos(t2))' b*(sin(t2))'];
            vertices2 = [vertices2(:,1)+surf2Position(3) + a,vertices2(:,2)+surf2Position(2)];    
        else

        end
    else
       vertices2 = [surf2Position(3),surf2Position(2)+lensHeight; surf2Position(3) ,surf2Position(2)-lensHeight]; 
    end

    %check the continuity of the surface 2 data otherwise flipit upside down
    if ((vertices1(1,2) > vertices1(2,2) && vertices2(1,2) > vertices2(2,2))||...
            ((vertices1(1,2) < vertices1(2,2) && vertices2(1,2) < vertices2(2,2))) )
        vertices2 = flipud(vertices2);
    end

    lensVertices = [vertices1;vertices2];

    si=size(lensVertices);
    lensFaces = 1:1: si(1);

    patch('Faces',lensFaces,'Vertices',lensVertices,'FaceColor', [0.9 0.9 0.9],'Parent',axesHandle);
%     axis equal

    end
    lensH = lensHeight;
end

