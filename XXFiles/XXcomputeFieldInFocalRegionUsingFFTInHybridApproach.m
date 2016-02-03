function [ complexOutputFieldMulti,XMulti,YMulti ] =...
    computeFieldInFocalRegionUsingFFTInHybridApproach( optSystem,wavLen,fieldPointXY,gridSize,...
    spotPlotRadius, defocus, useApodization)
% computeFieldInFocalRegionUsingFFTInHybridApproach computes the field at 
% image plane (should be near focus) using Hybrid approach = Ray trace to
% exit pupil -> Diffraction with FFT 

% Default inputs
if nargin < 4
    disp(['Error: The plotFFTPointSpreadFunction function needs atleast',...
        'optSystem,wavLen, fieldPointXY and rayGridSize as arguments.']);
    XMulti = [];
    YMulti = [];
    complexOutputFieldMulti = [];
    return
elseif nargin == 4
    % are both in lens unit
    defocus = 0;
    spotPlotRadius = 0.005;           
elseif nargin == 5
    % are both in lens unit
    spotPlotRadius = 0.005;
else

end

% Read apodization parameters of the optical system
% apodType = optSystem.ApodizationType;
% apodParam = optSystem.ApodizationParameters;

%  NB. The X,Y and OPDAtExitPupil will be 4D matrix of dim
% [l,m,nField,nWav]
[ OPDAtExitPupilMulti1, XMulti1,YMulti1,PupilWeightMatrixMulti1] =...
    computeWavefrontAtExitPupil( optSystem,wavLen,fieldPointXY,gridSize, useApodization );

% [ XMulti1,YMulti1,OPDAtExitPupilMulti1,PupilWeightMatrixMulti1,...
%     RMSMulti1,WPVMulti1,ZERMulti1,AmpTransCoeffMulti1,SrehlRatioMuti1 ] = ...
%     computeWavefrontAtExitPupil(optSystem,wavLen,fieldPointXY,gridSize,...
%     zerCoeff,polarized,jonesVec,resultComponent);
nField = size(OPDAtExitPupilMulti1,3);
nWav = size(OPDAtExitPupilMulti1,4);

% % compute pupil apodization no axes handle is given to supress the
% % plot 
% gridSizenew = size(OPDAtExitPupilMulti,1);
% [ X,Y,pupilApodization ] =  optSystem.plotPupilApodization(apodType,apodParam,gridSizenew);


% if dispPlot
% % Clear all childs of plotPanelHandle
% set(get(plotPanelHandle,'Children'),'Visible','off');
% end
% textResult = char('','<<<<<<<<<< FFT PSF >>>>>>>>>>>','');

% Generate a new panel for each field and wavelength combination to display
% the wavefront @ exit pupil in the subplots.
for wavIndex = 1:nWav
    for fieldIndex = 1:nField
%         if dispPlot
%         subplotPanel = uipanel('Parent',plotPanelHandle,...
%             'Units','Normalized',...
%             'Position',[(wavIndex-1)/nWav,(nField-fieldIndex)/nField,...
%             min([1/nWav,1/nField]),min([1/nWav,1/nField])],...
%             'Title',['Field Point XY : [',num2str(fieldPointXY(1,fieldIndex)),',',...
%                 num2str(fieldPointXY(2,fieldIndex)),']',...
%                 ' & Wavelength : ',num2str(wavLen(wavIndex))]);
%         subplotAxes = axes('Parent',subplotPanel,...
%             'Units','Normalized',...
%             'Position',[0.05,0.05,0.9,0.9]);
%         end        
%         if strcmpi(resultComponent,'Ex+Ey+Ez') && polarized
%              X = XMultiEx(:,:,fieldIndex,wavIndex);
%              Y = YMultiEx(:,:,fieldIndex,wavIndex);
%              pupilApodization = PupilWeightMatrixMultiEx(:,:,fieldIndex,wavIndex);
%             
%             OPDAtExitPupilEx = OPDAtExitPupilMultiEx(:,:,fieldIndex,wavIndex);         
%             ampTransCoefficientEx = AmpTransCoeffMultiEx(:,:,fieldIndex,wavIndex);
%             
%             OPDAtExitPupilEy = OPDAtExitPupilMultiEy(:,:,fieldIndex,wavIndex);         
%             ampTransCoefficientEy = AmpTransCoeffMultiEy(:,:,fieldIndex,wavIndex);
%             
%             OPDAtExitPupilEz = OPDAtExitPupilMultiEz(:,:,fieldIndex,wavIndex);         
%             ampTransCoefficientEz = AmpTransCoeffMultiEz(:,:,fieldIndex,wavIndex); 
%             
% %             figure;surf(ampTransCoefficientEx);shading interp
% %             figure;surf(ampTransCoefficientEy);shading interp
% %             figure;surf(ampTransCoefficientEz);shading interp
% %             
% %             figure;surf(OPDAtExitPupilEx);shading interp
% %             figure;surf(OPDAtExitPupilEy);shading interp
% %             figure;surf(OPDAtExitPupilEz);shading interp
%             
%         else
            X = XMulti1(:,:,fieldIndex,wavIndex);
            Y = YMulti1(:,:,fieldIndex,wavIndex);
            pupilApodization = PupilWeightMatrixMulti1(:,:,fieldIndex,wavIndex); 
            
            OPDAtExitPupil = OPDAtExitPupilMulti1(:,:,fieldIndex,wavIndex);         
%             ampTransCoefficient = AmpTransCoeffMulti1(:,:,fieldIndex,wavIndex);
            
%             figure;surf(ampTransCoefficient);shading interp            
%             figure;surf(OPDAtExitPupil);shading interp
          
%         end
        % propagate complex pupil function using scalar diffraction and plot psf
        xp = X(1,:);
        yp = Y(:,1);
        
        % For the spot display
        npx = length(xp);
        npy = npx;
        dus = spotPlotRadius; % size to see the result
        xs = linspace(-dus,dus,npx);
        ys = xs;
        
        % Modify the OPD by appending zeros in the bottom and left
        % Similarly add an additional point in the -ve directions for xp and
        % yp. This is required as the function 'prop_fraun_fft' assumes NxN
        % input field (even N), where the real field is of odd dimension
        % starting from 2 to N and N/2+1 beign its center.
        
%         mod_xp = [2*xp(1)-xp(2),xp];
%         mod_yp = [2*yp(1)-yp(2);yp];
%         mod_xs = [2*xs(1)-xs(2),xs];
%         mod_ys = [2*ys(1)-ys(2),ys];
%         mod_OPDAtExitPupil = [zeros(size(OPDAtExitPupil,1),1),OPDAtExitPupil];
%         mod_OPDAtExitPupil = [mod_OPDAtExitPupil;zeros(1,size(mod_OPDAtExitPupil,2))];

        wl = wavLen(wavIndex)*getWavelengthUnitFactor(optSystem)*10^3; % Wavelength in mm
        
%         if  strcmpi(resultComponent,'Ex+Ey+Ez') && polarized
%             kWEx = (2*pi/(wavLen(wavIndex)*getWavelengthUnitFactor(optSystem)))*...
%                 OPDAtExitPupilEx*getLensUnitFactor(optSystem);
%             efdEx = ampTransCoefficientEx.*sqrt(pupilApodization).*exp(-1i.*kWEx); % Complex pupil fun
%             kWEy = (2*pi/(wavLen(wavIndex)*getWavelengthUnitFactor(optSystem)))*...
%                 OPDAtExitPupilEy*getLensUnitFactor(optSystem);
%             efdEy = ampTransCoefficientEy.*sqrt(pupilApodization).*exp(-1i.*kWEy); % Complex pupil fun
% 
%             kWEz = (2*pi/(wavLen(wavIndex)*getWavelengthUnitFactor(optSystem)))*...
%                 OPDAtExitPupilEz*getLensUnitFactor(optSystem);
%             efdEz = ampTransCoefficientEz.*sqrt(pupilApodization).*exp(-1i.*kWEz); % Complex pupil fun
%            
%             z = -getExitPupilLocation(optSystem);
%             % Add spherical phase correction as the existing diffraction code
%             % assumes the wavefront has curvature = Z of propagation
%             [xpm,ypm] = meshgrid(xp,yp);
%             rpm = sqrt(xpm.^2+ypm.^2);
%             rcurv = z;
%             efdEx = efdEx .* exp(-1i*pi/(wl*z)*(rpm.^2));
%             efdEy = efdEy .* exp(-1i*pi/(wl*z)*(rpm.^2));
%             efdEz = efdEz .* exp(-1i*pi/(wl*z)*(rpm.^2));
%             %  Propagation
%             efdsEx = prop_fraun_fft(xp,yp,efdEx,xs,ys,z,wl);
%             efdsEy = prop_fraun_fft(xp,yp,efdEy,xs,ys,z,wl);
%             efdsEz = prop_fraun_fft(xp,yp,efdEz,xs,ys,z,wl);
%             
%             intEx = abs(efdsEx).^2;
%             intEy = abs(efdsEy).^2;
%             intEz = abs(efdsEz).^2;
%             
%             int = intEx + intEy + intEz;
%         else
            kW = (2*pi/(wavLen(wavIndex)*getWavelengthUnitFactor(optSystem)))*...
                OPDAtExitPupil*getLensUnitFactor(optSystem);
            efd = ampTransCoefficient.*sqrt(pupilApodization).*exp(-1i.*kW); % Complex pupil fun
            z = -getExitPupilLocation(optSystem);
            
            % Add spherical phase correction as the existing diffraction code
            % assumes the wavefront has curvature = Z of propagation
            [xpm,ypm] = meshgrid(xp,yp);
            rpm = sqrt(xpm.^2+ypm.^2);
            rcurv = z;
            efd = efd .* exp(-1i*pi/(wl*rcurv)*(rpm.^2));
            %  Propagation
            efds = prop_fraun_fft(xp,yp,efd,xs,ys,z+defocus,wl);
            
%             int = abs(efds).^2;
%         end
        
%         % Normalize and plot Intensity
%         normalize = 1;        
%         if normalize
%             peakIntensity = max(max(int));
%             int = int./peakIntensity;
%         end
        [xbm,ybm] = meshgrid(xs,ys);
        
%         strehlRatio = SrehlRatioMuti1(fieldIndex,wavIndex);        
%         textResult = char(textResult,...
%             ['Field Point XY : [',num2str(fieldPointXY(1,fieldIndex)),',',...
%             num2str(fieldPointXY(2,fieldIndex)),']'],...
%             ['Wavelength : ',num2str(wavLen(wavIndex))],...
%             ['Srehl Ratio (Approximation of Marechal) : ',num2str(strehlRatio)],'');
        % ['Peak Intensity : ',num2str(peakIntensity)],'');
        
%         if dispPlot
%             %
%             % Plot the PSF
%             surf(subplotAxes,xbm,ybm,int')
%             shading interp
%         end
        
        complexOutputFieldMulti (:,:,fieldIndex,wavIndex) = efds';
        peakIntesityMulti(:,:,fieldIndex,wavIndex) = peakIntensity;
        XMulti (:,:,fieldIndex,wavIndex) = xbm;
        YMulti (:,:,fieldIndex,wavIndex) = ybm;
        %     %
        %     % Plot the 2D cross section in subfigure 2
        %     subplot(1,2,2);
        %     plot(xs,int(:,npy/2+1),'r-'); hold on;
        %     plot(ys,int(npx/2+1,:),'b-'); %hold on;
    end
end
% if dispText
%     set(textHandle,'String',textResult);
% else
%     disp(textResult);
% end
% set(gcf,'Name',['Point Spread Function (PSF)']);
end

