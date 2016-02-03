N = 55;
P = peaks(N);
C = del2(P);

% % Curvature as color
% % Not very interesting
% figure
% surf(P,C); shading interp
% title('surf(P,del2(P))')
% 
% % Z as color. somehow good
% figure
% surf(P,P); shading interp
% title('surf(P,C = (P))')
% 
% % Use true color
% figure
% C(:,:,1) = rand(N);
% C(:,:,2) = rand(N);
% C(:,:,3) = rand(N);
% surf(P,C); shading interp


% Use true color given the valley and peak color and the color shall be
% varied linearly depending on Z
figure
% Brown scale
% valleyColor = [139,69,19]/256; % Saddle brown
% peakColor  = [255,222,173]/256; % navajo white
% Gray scale
valleyColor = [105,105,105]/256; % slate gray
peakColor = [240,255,240]/256; % honeydew

depth = 100;
[grad,im]=colorGradient(peakColor,valleyColor,depth);
stepSize = (max(max(P) - min(min(P))))/depth;
intZ = ceil((P - min(min(P)))/stepSize);
intZ(intZ == 0) = 1;
R = reshape(grad(intZ(:),1),size(intZ));
G = reshape(grad(intZ(:),2),size(intZ));
B = reshape(grad(intZ(:),3),size(intZ));
% grad = permute(grad,[3,2,1]);
% grad3D = cat(4,repmat(grad(:,1,:),))
C = cat(3,R,G,B);
% C(:,:,1) = grad(1,intZ);
% C(:,:,2) = rand(N);
% C(:,:,3) = rand(N);
surf(P,C); shading interp; 