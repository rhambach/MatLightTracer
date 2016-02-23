% Test script to test interfernce of gaussian beams using the complex ray
% tracing mechanism

% Output calculation window
Nx = 3*250; Ny = 3*250;
windowSizeX = 15*10^-3; windowSizeY = 15*10^-3;

% Initial simply circularly symetric gaussian beam
centralRayPosition = [0,0,0]';
centralRayDirection =  [0,0,1]';
centralRayWavelength =  1*10^-6;
waistRadiusInX = (1/2)*1*10^-3; %
waistRadiusInY = waistRadiusInX; %
distanceFromWaistInX = 0*10^-3;
distanceFromWaistInY = 0*10^-3;


initialGaussianBeamSet = GaussianBeamSet(centralRayPosition,...
    centralRayDirection,centralRayWavelength,waistRadiusInX,...
    waistRadiusInY,distanceFromWaistInX,distanceFromWaistInY);

[ raleighLengthInX,raleighLengthInY ] = getGaussianBeamRayleighLength(...
    initialGaussianBeamSet );
raleighLength = raleighLengthInX;

propagationDistances = [0,0.5]*centralRayWavelength+raleighLength;

% Trace the gaussian beam using complex ray tracing
[ outputGeneralAstignmaticBeam ] = ...
    FreeSpacePropagator_GaussianBeamSet(initialGaussianBeamSet,...
    propagationDistances);
% Convert the GeneralAstignmaticBeam to harmonic field
cohererntSuperposition = 1;
outputHarmonicFieldSet = convertGenerallyAstigmaticGaussianBeamToHarmonicField(...
    outputGeneralAstignmaticBeam,Nx,Ny,windowSizeX,windowSizeY,cohererntSuperposition);


% % Compute the Ex component and get its cross section
% [Ex,xlin,ylin] = computeEx(outputHarmonicFieldSet);
% ExCrossSectionInX = Ex(ceil(size(Ex,1)/2),:,:);
% lineColor = {'r','m','k','g','y','b'};
% lineStyle = {'-','--','--','-','--','-'};
% 
% figure;
% for kk=1:6
%     hold on
%     % Plot the amplitude and phase of the cross section
%     plot(squeeze(xlin(:,:,kk)),angle(squeeze(ExCrossSectionInX(:,:,kk))),lineColor{kk},'LineStyle',lineStyle{kk});
%     legend('Z = 0','Z = 0.25*Re','Z = 0.5*Re','Z = Re','Z = 2*Re','Z = 10*Re');
%     title('Phase evolution (Cross sectional view)')
% end
% hold off
% 
% figure;
% for kk=1:6
%     hold on
%     % Plot the amplitude and phase of the cross section
%     plot(squeeze(xlin(:,:,kk)),abs(squeeze(ExCrossSectionInX(:,:,kk))/max(max(abs(squeeze(ExCrossSectionInX))))),...
%         'Color',lineColor{kk},'LineStyle',lineStyle{kk});
%     legend('Z = 0','Z = 0.25*Re','Z = 0.5*Re','Z = Re','Z = 2*Re','Z = 10*Re');
%     title('Amplitude evolution (Cross sectional view)')
% end
% hold off
% View the harmonic field
harmonicFieldSetViewer(outputHarmonicFieldSet);
