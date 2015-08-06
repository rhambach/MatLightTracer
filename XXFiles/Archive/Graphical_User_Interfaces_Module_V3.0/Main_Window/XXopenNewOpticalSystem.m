function [ opened ] = openNewOpticalSystem()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global OPTICAL_SYSTEM;
global VIS_SURF_DATA;
global VIS_CONFIG_DATA;

OPTICAL_SYSTEM = OpticalSystem;
SurfaceEditor('Visible','On'); 
VIS_SURF_DATA = 'On';
OpticalSystemConfiguration('Visible','Off'); 
VIS_CONFIG_DATA = 'Off';

%delete(SurfaceEditor)
InitializeSurfaceEditor();
%delete(OpticalSystemConfiguration)
InitializeOpticalSystemConfiguration();
% 
% set(SurfaceEditor,'Visible','On');
% set(OpticalSystemConfiguration,'Visible','Off');
opened = 1;
end

