function [ gratingPeriodicity ] = getGratingPeriodicity( surf )
%GETGRATINGPERIODICITY Gives the period of the grating in meter

% Grating period is just the inverse of the grating line densit which is
% usually lines/um
gratingPeriodicity = (1/(surf.GratingLineDensity))*10^-6;

end

