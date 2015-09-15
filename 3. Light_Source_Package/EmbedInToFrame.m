function [ U_xyTot] = EmbedInToFrame( U_xy,nBoarderPixel)
    %EMBEDINTOFRAME Appends zero pixels around the field

    U_xyTot = [zeros(nBoarderPixel(1),size(U_xy,2));U_xy;...
        zeros(nBoarderPixel(1),size(U_xy,2))];
    U_xyTot = [zeros(size(U_xyTot,1),nBoarderPixel(2)),U_xyTot,...
        zeros(size(U_xyTot,1),nBoarderPixel(2))];
end

