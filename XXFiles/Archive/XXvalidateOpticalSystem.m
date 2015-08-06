function [ validSystem ] = validateOpticalSystem(aodHandles)
	% validateOpticalSystem: Validates all input parameters of the optical system
	% Retuns invalid flag and displays the error on the command window if the inputs
	% of the system are not valid.

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
	global VIS_SURF_DATA;
    global VIS_CONFIG_DATA;
    
    valid = 1;

	%tempStandardData = get(findobj(SurfaceEditor,'Tag','tblStandardData'),'data');
%     hConfig = guidata(findobj('Tag','OpticalSystemConfiguration'));
%     hSurfaceData = guidata(findobj('Tag','SurfaceEditor'));
    hConfig=aodHandles;
    hSurfaceData=aodHandles;
%     hConfig = guidata(OpticalSystemConfiguration('Visible',VIS_CONFIG_DATA));
%     hSurfaceData = guidata(SurfaceEditor('Visible',VIS_SURF_DATA));
    
    tempStandardData = get(hSurfaceData.tblStandardData,'data');
	objThickness = str2num(tempStandardData{1,7});

	tempAngle =get(hConfig.radioAngle,'Value');
	tempObjectHeight =get(hConfig.radioObjectHeight,'Value');
	tempImageHeight =get(hConfig.radioImageHeight,'Value');

	tempSystemApertureType=get(hConfig.popApertureType,'Value');
	tempSystemApertureValue=str2num(get(hConfig.txtApertureValue,'String'));

	% check for validity of input
	% if object is at infinity, object NA is not defined and object height can
	% not be used for field
	if abs(objThickness) > 1000000
		if tempObjectHeight
			msgbox('For objects at infinity, object height can not be used as field lease correct.', 'Invalid Field Point');
			valid = 0;
		elseif tempSystemApertureType==2
			msgbox('For objects at infinity, object space NA can not be used as system aperture. Please correct.', 'Invalid Aperture');
			valid = 0;
		else
			
		end
	else
		
	end
	validSystem = valid;
end

