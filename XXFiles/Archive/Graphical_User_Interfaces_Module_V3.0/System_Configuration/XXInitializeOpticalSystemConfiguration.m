function InitializeOpticalSystemConfiguration()
%initialize Aperture tab
systemApertureTypes = {'Enterance Pupil Diameter','Object Space NA'};
set(findobj('Tag','popApertureType'), 'String', systemApertureTypes,'Value',1.0);
set(findobj('Tag','txtApertureValue'), 'String', '0');

%initialize General tab
set(findobj('Tag','txtLensName'), 'String', 'Lens 1');
set(findobj('Tag','txtAddNote'), 'String', 'Note 1');
lensUnits={'milimeter(mm)','centimeter(cm)','meter(m)'};
wavelengthUnits={'nanometer(nm)','micrometer(um)'};
set(findobj('Tag','popLensUnit'), 'String', lensUnits,'Value',1.0);
set(findobj('Tag','popWavelengthUnit'), 'String', wavelengthUnits,'Value',1.0);

% %initialize Polarization tab
% polInputMethod={'Jones Vector','Field Vector','Stokes Vector','Ellipse'};
% set(findobj('Tag','popPolInputMethod'), 'String', polInputMethod,'Value',1.0);

set(findobj('Tag','lblParam1'), 'String', 'Es (Amp)');
set(findobj('Tag','lblParam2'), 'String', 'Phase S (Deg)');
set(findobj('Tag','lblParam3'), 'String', 'Ep (Amp)');
set(findobj('Tag','lblParam4'), 'String', 'Phase P (Deg)');  
set(findobj('Tag','lblParam5'), 'String', 'Param5'); 
set(findobj('Tag','lblParam6'), 'String', 'Param6'); 
      
set(findobj('Tag','chkPolarizedSystem'), 'Enable', 'On', 'Value',0.0);
set(findobj('Tag','popPolInputMethod'), 'Enable', 'Off');
set(findobj('Tag','txtPolParam1'), 'Enable', 'Off', 'String',0);
set(findobj('Tag','txtPolParam2'), 'Enable', 'Off', 'String',0);
set(findobj('Tag','txtPolParam3'), 'Enable', 'Off', 'String',0);
set(findobj('Tag','txtPolParam4'), 'Enable', 'Off', 'String',0);
set(findobj('Tag','txtPolParam5'), 'Enable', 'Off', 'String',0);
set(findobj('Tag','txtPolParam6'), 'Enable', 'Off', 'String',0);

%initialize Wavelength tab
predefinedWavelength={'FdC(Visible)','F''eC''(Visible)','F','F''','d','e','C','C''','HeNe'};
set(findobj('Tag','popPredefinedWavlens'), 'String', predefinedWavelength,'Value',1.0);
set(findobj('Tag','popPrimaryWavlenIndex'), 'String', '1','Value',1.0);

set(findobj('Tag','chkUseWav','-and','String','1'),'Value',1.0);
set(findobj('Tag','txtWavelen1'), 'String', '0.55');
set(findobj('Tag','txtWWav1'), 'String', '1');
set(findobj('Tag','txtTotalWavelengthsSelected'), 'String', '1');

set(findobj('Tag','chkUseWav','-and','String','1'), 'Enable', 'On');
set(findobj('Tag','chkUseWav','-and','String','2'), 'Enable', 'On');
set(findobj('Tag','chkUseWav','-and','String','3'), 'Enable', 'Off');
set(findobj('Tag','chkUseWav','-and','String','4'), 'Enable', 'Off');
set(findobj('Tag','chkUseWav','-and','String','5'), 'Enable', 'Off');
set(findobj('Tag','chkUseWav','-and','String','6'), 'Enable', 'Off');
set(findobj('Tag','chkUseWav','-and','String','7'), 'Enable', 'Off');
set(findobj('Tag','chkUseWav','-and','String','8'), 'Enable', 'Off');
set(findobj('Tag','chkUseWav','-and','String','9'), 'Enable', 'Off');


set(findobj('Tag','txtWavelen1'), 'Enable', 'On');
set(findobj('Tag','txtWavelen2'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen3'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen4'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen5'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen6'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen7'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen8'), 'Enable', 'Off');
set(findobj('Tag','txtWavelen9'), 'Enable', 'Off');

set(findobj('Tag','txtWWav1'), 'Enable', 'On');
set(findobj('Tag','txtWWav2'), 'Enable', 'Off');
set(findobj('Tag','txtWWav3'), 'Enable', 'Off');
set(findobj('Tag','txtWWav4'), 'Enable', 'Off');
set(findobj('Tag','txtWWav5'), 'Enable', 'Off');
set(findobj('Tag','txtWWav6'), 'Enable', 'Off');
set(findobj('Tag','txtWWav7'), 'Enable', 'Off');
set(findobj('Tag','txtWWav8'), 'Enable', 'Off');
set(findobj('Tag','txtWWav9'), 'Enable', 'Off');

%initialize Field points tab
set(findobj('Tag','radioAngle'),'Value',1.0);

set(findobj('Tag','chkUseFld1'),'Value',1.0);
set(findobj('Tag','txtX1'), 'String', '0');
set(findobj('Tag','txtY1'), 'String', '0');
set(findobj('Tag','txtWFld1'), 'String', '1');
set(findobj('Tag','txtTotalFieldPointsSelected'), 'String', '1');

set(findobj('Tag','chkUseFld','-and','String','1'), 'Enable', 'On');
set(findobj('Tag','chkUseFld','-and','String','2'), 'Enable', 'On');
set(findobj('Tag','chkUseFld','-and','String','3'), 'Enable', 'Off');
set(findobj('Tag','chkUseFld','-and','String','4'), 'Enable', 'Off');
set(findobj('Tag','chkUseFld','-and','String','5'), 'Enable', 'Off');
set(findobj('Tag','chkUseFld','-and','String','6'), 'Enable', 'Off');
set(findobj('Tag','chkUseFld','-and','String','7'), 'Enable', 'Off');
set(findobj('Tag','chkUseFld','-and','String','8'), 'Enable', 'Off');
set(findobj('Tag','chkUseFld','-and','String','9'), 'Enable', 'Off');

set(findobj('Tag','txtX1'), 'Enable', 'On');
set(findobj('Tag','txtX2'), 'Enable', 'Off');
set(findobj('Tag','txtX3'), 'Enable', 'Off');
set(findobj('Tag','txtX4'), 'Enable', 'Off');
set(findobj('Tag','txtX5'), 'Enable', 'Off');
set(findobj('Tag','txtX6'), 'Enable', 'Off');
set(findobj('Tag','txtX7'), 'Enable', 'Off');
set(findobj('Tag','txtX8'), 'Enable', 'Off');
set(findobj('Tag','txtX9'), 'Enable', 'Off');

set(findobj('Tag','txtY1'), 'Enable', 'On');
set(findobj('Tag','txtY2'), 'Enable', 'Off');
set(findobj('Tag','txtY3'), 'Enable', 'Off');
set(findobj('Tag','txtY4'), 'Enable', 'Off');
set(findobj('Tag','txtY5'), 'Enable', 'Off');
set(findobj('Tag','txtY6'), 'Enable', 'Off');
set(findobj('Tag','txtY7'), 'Enable', 'Off');
set(findobj('Tag','txtY8'), 'Enable', 'Off');
set(findobj('Tag','txtY9'), 'Enable', 'Off');

set(findobj('Tag','txtWFld1'), 'Enable', 'On');
set(findobj('Tag','txtWFld2'), 'Enable', 'Off');
set(findobj('Tag','txtWFld3'), 'Enable', 'Off');
set(findobj('Tag','txtWFld4'), 'Enable', 'Off');
set(findobj('Tag','txtWFld5'), 'Enable', 'Off');
set(findobj('Tag','txtWFld6'), 'Enable', 'Off');
set(findobj('Tag','txtWFld7'), 'Enable', 'Off');
set(findobj('Tag','txtWFld8'), 'Enable', 'Off');
set(findobj('Tag','txtWFld9'), 'Enable', 'Off');
end

