function [surfaceCoordinateTM,nextReferenceCoordinateTM] = TiltAndDecenter...
        (surf,refCoordinateTM,prevSurfCoordinateTM,prevThickness)
    % TiltAndDecenter: Update the coordinate transformation matrix
    % of the surface.

    % For detailed see the documentation of the 
    % CoordinateTransformationMatrix function 
    Tx = surf.TiltParameter(1);
    Ty = surf.TiltParameter(2);
    Tz = surf.TiltParameter(3);

    Dx = surf.DecenterParameter(1);
    Dy = surf.DecenterParameter(2);
    Dz = prevThickness;

    order = surf.TiltDecenterOrder;
    tiltMode = surf.TiltMode;

    surfaceCoordinateTM = ...
    computeCoordinateTransformationMatrix...
    (Tx,Ty,Tz,Dx,Dy,Dz,order,refCoordinateTM);

    % coordinate transformation matrix for coordinate after the surface calculations
    switch tiltMode
        case 'DAR'
            % Reference axis for next surfaces starts at current
            % surface vertex and oriented in the current 
            % reference axis
            nextReferenceCoordinateTM = refCoordinateTM;
            nextReferenceCoordinateTM(1:3,4) = surfaceCoordinateTM(1:3,4)-[Dx;Dy;0];                      
        case 'NAX'
            % Reference axis for next surfaces starts at current
            % surface vertex and oriented in the current surfaces
            % local axis 
            nextReferenceCoordinateTM = surfaceCoordinateTM;
        case 'BEN'
            % Apply Tx and Ty again for the new axis
            % Compute Tz to readjust the new axis so that the meridional
            % plane remains meridional after BENd (OpTaLix)
            Tz = acos((cos(Tx)+cos(Ty))/(1+ cos(Tx)*cos(Ty)));
            Dx=0; Dy=0; Dz=0;
%                     order = 'TxTyTzDxDyDz';
            nextReferenceCoordinateTM = computeCoordinateTransformationMatrix...
            (Tx,Ty,Tz,Dx,Dy,Dz,order,surfaceCoordinateTM);
    end
end

