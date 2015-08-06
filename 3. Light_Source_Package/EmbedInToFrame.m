function [ U_xyTot,xlinTot,ylinTot ] = EmbedInToFrame( U_xy,nBoarderPixel,samplingPoints,samplingDistance )
    %EMBEDINTOFRAME Appends zero pixels around the field
    Nx = samplingPoints(1);
    Ny = samplingPoints(2);
    dx = samplingDistance(1);
    dy = samplingDistance(2);
    
    
    U_xyTot = [zeros(nBoarderPixel,size(U_xy,2));U_xy;zeros(nBoarderPixel,size(U_xy,2))];
    U_xyTot = [zeros(size(U_xyTot,1),nBoarderPixel),U_xyTot,zeros(size(U_xyTot,1),nBoarderPixel)];
    
    xlinTot = [-floor(Nx/2)-nBoarderPixel:floor(Nx/2)+nBoarderPixel]*dx;
    ylinTot = [-floor(Ny/2)-nBoarderPixel:floor(Ny/2)+nBoarderPixel]*dy;
end

