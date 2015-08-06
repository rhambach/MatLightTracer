% function coordTransMatrix =
% tiltAndDecenter(Tx,Ty,Tz,Dx,Dy,Dz,Order,transMatrixBefore)

% Inputs
Tx = -90*pi/180;
Ty = 0;
Tz = 0;
Dx = 0;
Dy = 0;
Dz = 1;
% order = 'TxTyTzDxDyDz';
order = 'DxDyDzTxTyTz';
transMatrixBefore = [1,0,0,0;0,1,0,0;0,0,1,0;0,0,0,1]

% Main function definition
transMatrix = transMatrixBefore;
% take the rotation matrix and decenter vector
rotMatrix = transMatrix(1:3,1:3);
decVector = transMatrix(1:3,4);
for k = 1:2:11
    switch upper(order(k:k+1))
        % transMatrix is a 4x4 matrix, the left upper 3x3 matrix represent
        % rotation matrix from global to local coordinate and the last
        % column gives the decenter of the current coordinates and the last 
        % row is just for maths 
        case 'TX'
            rotMatrix = [1 0 0;0 cos(Tx) sin(Tx);0 -sin(Tx) cos(Tx)]*rotMatrix;
        case 'TY'
            rotMatrix = [cos(Ty) 0 -sin(Ty);0 1 0;sin(Ty) 0 cos(Ty)]*rotMatrix;
        case 'TZ'
            rotMatrix = [cos(Tz) sin(Tz) 0;-sin(Tz) cos(Tz) 0;0 0 1]*rotMatrix;
        
        % decenters are assumed to be in the current local coordinate system
        % the decenter values in local are converted to global using
        % transMatrix' and then added to the current transMatrix.
        % Dz is thickness
        case 'DX'
            decVector =  decVector + rotMatrix'*[Dx;0;0];
        case 'DY'
            decVector =  decVector + rotMatrix'*[0;Dy;0];
        case 'DZ'   
            decVector =  decVector + rotMatrix'*[0;0;Dz];
    end  
end
transMatrixAfter = [[rotMatrix;0 0 0],[decVector;1]]
