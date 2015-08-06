function [ z ] = circ( x, y, D )
%CIRC Summary of this function goes here
%   Detailed explanation goes here

 r = sqrt(x.^2+y.^2);
 z = double(r<D/2);
 z(r==D/2) = 0.5;
end

