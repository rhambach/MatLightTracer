 function displaySystemConfiguration(optSystem,dispAperture,...
     dispGeneral,dispWavelength,dispField)
  % displays system configuration data to the command window
  % Inputs: Flags indicating which data to display

  if nargin == 1
     dispAperture = 1;
     dispGeneral  = 1;
     dispWavelength = 1;
     dispField = 1;
  elseif nargin == 2
     dispGeneral  = 1;
     dispWavelength = 1;
     dispField = 1; 
  elseif nargin == 3
     dispWavelength = 1;
     dispField = 1;
  elseif nargin == 4
     dispField = 1;
  elseif nargin == 5

  end
  fprintf('************************************************************\n');
  fprintf('Optical System Configuration Data\n');
  fprintf('************************************************************\n');
  if dispAperture
     fprintf('\n<<<<<<<<< Aperture Data >>>>>>>>>>>\n');
     [name,abbrev] = getSupportedSystemApertureTypes(optSystem.SystemApertureType);
     fprintf('  Aperture Type  : %s\n', name);
     fprintf('  Aperture Value : %d\n', optSystem.SystemApertureValue);
  end
  if dispGeneral
     fprintf('\n<<<<<<<<<< Genral Data >>>>>>>>>>>\n');
     fprintf('  Lens Name      : %s\n', optSystem.LensName);
     fprintf('  Lens Note      : %s\n', optSystem.LensNote);
     [name,abbrev,fact] = getSupportedWavelengthUnits(optSystem.WavelengthUnit);
     fprintf('  Wavelength Unit: %s\n', name);
     [name,abbrev,fact] = getSupportedLensUnits(optSystem.LensUnit);
     fprintf('  Lens Unit      : %s\n', name);
 end
 if dispWavelength
     num_wav=size(optSystem.WavelengthMatrix,1);
     fprintf('\n<<<<<<<<<<<<<< Wavelength Data >>>>>>>>>>>>>>\n');
     if (num_wav == 1)
       fprintf('  Wavelength     : %g\n', optSystem.WavelengthMatrix(1,1));
     else
       fprintf('  Total Number of Wavelength : %d\n', num_wav);
       fprintf('  Primary Wavelength Index   : %d\n', optSystem.PrimaryWavelengthIndex);
       disp(array2table(optSystem.WavelengthMatrix,'VariableNames',{'wavelength','weight'}));
     end
 end
 if dispField
     num_field = size(optSystem.FieldPointMatrix,1);
     fprintf('\n<<<<<<<<<<<<<< Field Point Data >>>>>>>>>>>>>>>\n');
     if (num_field == 1)
       fprintf('  Field Point    : (%g, %g)\n', optSystem.FieldPointMatrix(1,1:2).');
     else
       fprintf('  Total Number of Field Points : %d\n', num_field);
       disp(array2table(optSystem.FieldPointMatrix,'VariableNames',{'x','y','weight'}));
     end
 end
 end
