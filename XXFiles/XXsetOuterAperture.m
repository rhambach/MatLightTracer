function [updatedAperture] = ...
        setOuterAperture( aperture,outerApertureType,outerAperParametersVector )
    %setOuterAperture Sets the outer aperture to a new type and values.

    updatedAperture = aperture;
         % Currently outer aperture types of Circular, Rectangular and
    % Elliptical are supported
    switch lower(outerApertureType)
        case {'circularaperture','floatingcircularaperture'}
            updatedAperture.OuterAperture
            outerApertureUniqueParameters.Diameter = 
            apartRadiusXDrawn = (outerAperParametersVector.Diameter)/2;
            apartRadiusYDrawn = apartRadiusXDrawn;
        case 'ellipticalaperture'
            apartRadiusXDrawn = (outerAperParametersVector.DiameterX)/2;
            apartRadiusYDrawn = (outerAperParametersVector.DiameterY)/2;
        case 'rectangularaperture'
            apartRadiusXDrawn = (outerAperParametersVector.DiameterX)/2;
            apartRadiusYDrawn = (outerAperParametersVector.DiameterY)/2;            
        otherwise
            disp(['Error: Unsupported outer aperture type. Currently outer',...
                ' aperture types of Circular, Rectangular and Elliptical are supported. ']);
    end   
    
    % Now connect to the aperture defintion function and compute the
    % OuterAperture
    apertureType = aperture.Type;
    apertureDefinitionHandle = str2func(apertureType);
    returnFlag = 2;
    apertureParameters = aperture.UniqueParameters;
    [ outerApertureType,outerAperParametersVector] = ...
        apertureDefinitionHandle(returnFlag,apertureParameters);
end

