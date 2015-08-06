function [ xy ] = tryFminSearch( )
    %UNTITLED2 Summary of this function goes here
    %   Detailed explanation goes here
    cx = 2.9;
    cy = -1.5;
    [xy,fval,exitflag,output] = fminsearch(@(xy) myfun(xy,cx,cy),[0.5,0.5]);
%     [xy,fval,exitflag,output] = fminunc(@(xy) myfun(xy,cx,cy),[0.5,0.5]);
    
end

function f = myfun(xy,cx,cy)
f = (xy(1)-cx)^2 + (xy(2)-cy)^2;
end