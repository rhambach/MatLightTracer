function [ U_xyTot] = EmbedInToFrame( U_xy,nBoarderPixel)
    %EMBEDINTOFRAME Appends zero pixels around the field
    % NB: nBoarderPixel = [Nx,Ny] = [N dim 2, N dim 1]
    U_xyTot = [zeros(size(U_xy,1),nBoarderPixel(1)),U_xy,...
        zeros(size(U_xy,1),nBoarderPixel(1))];
    U_xyTot = [zeros(nBoarderPixel(2),size(U_xyTot,2));U_xyTot;...
        zeros(nBoarderPixel(2),size(U_xyTot,2))];
end

